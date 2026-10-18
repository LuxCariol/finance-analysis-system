package com.qst.finance.util;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.qst.finance.common.BizException;

/**
 * 财务算法表达式解析引擎。
 *
 * 支持语法:
 *   1) 编码取值   : {A013}、{P021}、{P021@SQ}   (@后面为取数类型: NC/QM/BJ/SQ)
 *   2) 四则运算   : + - * / ( )
 *   3) 比较运算   : > >= < <= == !=   (返回 1/0)
 *   4) 内置函数   : SUM AVG MIN MAX ABS ROUND SQRT IF SAFEDIV
 *
 * 说明: 该引擎是"配置化算法模型"的核心，算法直接维护在 t_mode.calc_expression 中，
 *       业务人员修改算法无需改动代码。
 */
public final class ExpressionEvaluator {

    /** 编码取值提供者 */
    public interface ValueProvider {
        BigDecimal get(String code, String valueType);
    }

    private static final Pattern REF_PATTERN = Pattern.compile("\\{\\s*([A-Za-z0-9_.\\-]+)\\s*(?:@\\s*([A-Za-z]+)\\s*)?\\}");
    private static final MathContext MC = new MathContext(16, RoundingMode.HALF_UP);

    private final String expr;
    private final ValueProvider provider;
    private int pos;

    private ExpressionEvaluator(String expr, ValueProvider provider) {
        this.expr = expr;
        this.provider = provider;
    }

    public static BigDecimal eval(String expression, ValueProvider provider) {
        if (expression == null || expression.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }
        ExpressionEvaluator evaluator = new ExpressionEvaluator(expression, provider);
        BigDecimal value = evaluator.parseComparison();
        evaluator.skipSpace();
        if (evaluator.pos < expression.length()) {
            throw new BizException("算法表达式无法解析: " + expression.substring(evaluator.pos));
        }
        return value;
    }

    /**
     * 语法校验(算法配置保存前调用):
     * 将编码引用与业务函数(LINEAR)替换为 0 后进行试算，验证运算符、括号与函数是否合法。
     */
    public static void validate(String expression) {
        if (expression == null || expression.trim().isEmpty()) {
            throw new BizException("算法表达式不能为空");
        }
        String test = expression.replaceAll("(?i)LINEAR\\s*\\(\\s*\\{[^}]*\\}\\s*\\)", "0");
        ValueProvider zeroProvider = new ValueProvider() {
            @Override
            public BigDecimal get(String code, String valueType) {
                return BigDecimal.ZERO;
            }
        };
        eval(test, zeroProvider);
    }

    /** 提取表达式中引用的所有编码 */
    public static Set<String> references(String expression) {
        Set<String> codes = new LinkedHashSet<String>();
        if (expression == null) {
            return codes;
        }
        Matcher matcher = REF_PATTERN.matcher(expression);
        while (matcher.find()) {
            codes.add(matcher.group(1));
        }
        return codes;
    }

    /** 提取表达式中的函数名(如 LINEAR 由业务层处理) */
    public static List<String> functions(String expression) {
        List<String> list = new ArrayList<String>();
        if (expression == null) {
            return list;
        }
        Matcher matcher = Pattern.compile("([A-Za-z_][A-Za-z0-9_]*)\\s*\\(").matcher(expression);
        while (matcher.find()) {
            list.add(matcher.group(1).toUpperCase());
        }
        return list;
    }

    /** 解析形如 LINEAR({P021}) 或 LINEAR({P021@SQ}) 的引用 */
    public static String[] parseSingleRef(String expression) {
        Matcher matcher = REF_PATTERN.matcher(expression == null ? "" : expression);
        if (matcher.find()) {
            return new String[]{matcher.group(1), matcher.group(2)};
        }
        return null;
    }

    // ------------------------------------------------------------------ 递归下降

    private BigDecimal parseComparison() {
        BigDecimal left = parseAddSub();
        skipSpace();
        String op = readCompareOperator();
        if (op == null) {
            return left;
        }
        BigDecimal right = parseAddSub();
        int cmp = left.compareTo(right);
        boolean result;
        if (">".equals(op)) {
            result = cmp > 0;
        } else if (">=".equals(op)) {
            result = cmp >= 0;
        } else if ("<".equals(op)) {
            result = cmp < 0;
        } else if ("<=".equals(op)) {
            result = cmp <= 0;
        } else if ("==".equals(op)) {
            result = cmp == 0;
        } else {
            result = cmp != 0;
        }
        return result ? BigDecimal.ONE : BigDecimal.ZERO;
    }

    private String readCompareOperator() {
        String[] ops = new String[]{">=", "<=", "==", "!=", ">", "<"};
        for (String op : ops) {
            if (expr.startsWith(op, pos)) {
                pos += op.length();
                return op;
            }
        }
        return null;
    }

    private BigDecimal parseAddSub() {
        BigDecimal value = parseMulDiv();
        while (true) {
            skipSpace();
            if (pos < expr.length() && (expr.charAt(pos) == '+' || expr.charAt(pos) == '-')) {
                char op = expr.charAt(pos++);
                BigDecimal right = parseMulDiv();
                value = op == '+' ? value.add(right) : value.subtract(right);
            } else {
                return value;
            }
        }
    }

    private BigDecimal parseMulDiv() {
        BigDecimal value = parseUnary();
        while (true) {
            skipSpace();
            if (pos < expr.length() && (expr.charAt(pos) == '*' || expr.charAt(pos) == '/')) {
                char op = expr.charAt(pos++);
                BigDecimal right = parseUnary();
                if (op == '*') {
                    value = value.multiply(right);
                } else {
                    value = right.signum() == 0 ? BigDecimal.ZERO : value.divide(right, MC);
                }
            } else {
                return value;
            }
        }
    }

    private BigDecimal parseUnary() {
        skipSpace();
        if (pos < expr.length() && expr.charAt(pos) == '-') {
            pos++;
            return parseUnary().negate();
        }
        if (pos < expr.length() && expr.charAt(pos) == '+') {
            pos++;
            return parseUnary();
        }
        return parsePrimary();
    }

    private BigDecimal parsePrimary() {
        skipSpace();
        if (pos >= expr.length()) {
            throw new BizException("算法表达式不完整: " + expr);
        }
        char c = expr.charAt(pos);
        if (c == '(') {
            pos++;
            BigDecimal value = parseComparison();
            skipSpace();
            expect(')');
            return value;
        }
        if (c == '{') {
            int end = expr.indexOf('}', pos);
            if (end < 0) {
                throw new BizException("算法表达式编码引用缺少 '}': " + expr);
            }
            String ref = expr.substring(pos + 1, end).trim();
            pos = end + 1;
            String code = ref;
            String valueType = null;
            int at = ref.indexOf('@');
            if (at > 0) {
                code = ref.substring(0, at).trim();
                valueType = ref.substring(at + 1).trim().toUpperCase();
            }
            BigDecimal value = provider == null ? null : provider.get(code, valueType);
            return value == null ? BigDecimal.ZERO : value;
        }
        if (Character.isDigit(c) || c == '.') {
            return parseNumber();
        }
        if (Character.isLetter(c) || c == '_') {
            return parseFunction();
        }
        throw new BizException("算法表达式存在非法字符 '" + c + "': " + expr);
    }

    private BigDecimal parseNumber() {
        int start = pos;
        while (pos < expr.length() && (Character.isDigit(expr.charAt(pos)) || expr.charAt(pos) == '.')) {
            pos++;
        }
        try {
            return new BigDecimal(expr.substring(start, pos));
        } catch (NumberFormatException e) {
            throw new BizException("算法表达式数字格式错误: " + expr.substring(start, pos));
        }
    }

    private BigDecimal parseFunction() {
        int start = pos;
        while (pos < expr.length() && (Character.isLetterOrDigit(expr.charAt(pos)) || expr.charAt(pos) == '_')) {
            pos++;
        }
        String name = expr.substring(start, pos).toUpperCase();
        skipSpace();
        expect('(');
        List<BigDecimal> args = new ArrayList<BigDecimal>();
        skipSpace();
        if (pos < expr.length() && expr.charAt(pos) == ')') {
            pos++;
        } else {
            while (true) {
                args.add(parseComparison());
                skipSpace();
                if (pos < expr.length() && expr.charAt(pos) == ',') {
                    pos++;
                    continue;
                }
                expect(')');
                break;
            }
        }
        return applyFunction(name, args);
    }

    private BigDecimal applyFunction(String name, List<BigDecimal> args) {
        if ("SUM".equals(name)) {
            BigDecimal sum = BigDecimal.ZERO;
            for (BigDecimal a : args) {
                sum = sum.add(a);
            }
            return sum;
        }
        if ("AVG".equals(name)) {
            if (args.isEmpty()) {
                return BigDecimal.ZERO;
            }
            BigDecimal sum = BigDecimal.ZERO;
            for (BigDecimal a : args) {
                sum = sum.add(a);
            }
            return sum.divide(new BigDecimal(args.size()), MC);
        }
        if ("MIN".equals(name)) {
            BigDecimal min = null;
            for (BigDecimal a : args) {
                if (min == null || a.compareTo(min) < 0) {
                    min = a;
                }
            }
            return min == null ? BigDecimal.ZERO : min;
        }
        if ("MAX".equals(name)) {
            BigDecimal max = null;
            for (BigDecimal a : args) {
                if (max == null || a.compareTo(max) > 0) {
                    max = a;
                }
            }
            return max == null ? BigDecimal.ZERO : max;
        }
        if ("ABS".equals(name)) {
            return requireArgs(name, args, 1).abs();
        }
        if ("SQRT".equals(name)) {
            double v = requireArgs(name, args, 1).doubleValue();
            return v <= 0 ? BigDecimal.ZERO : new BigDecimal(Math.sqrt(v), MC);
        }
        if ("ROUND".equals(name)) {
            requireArgs(name, args, 2);
            int scale = args.get(1).intValue();
            return args.get(0).setScale(scale, RoundingMode.HALF_UP);
        }
        if ("IF".equals(name)) {
            requireArgs(name, args, 3);
            return args.get(0).compareTo(BigDecimal.ZERO) != 0 ? args.get(1) : args.get(2);
        }
        if ("SAFEDIV".equals(name)) {
            if (args.size() < 2) {
                throw new BizException("函数 SAFEDIV 需要至少2个参数");
            }
            if (args.get(1).signum() == 0) {
                return args.size() > 2 ? args.get(2) : BigDecimal.ZERO;
            }
            return args.get(0).divide(args.get(1), MC);
        }
        throw new BizException("不支持的算法函数: " + name);
    }

    private BigDecimal requireArgs(String name, List<BigDecimal> args, int size) {
        if (args.size() < size) {
            throw new BizException("函数 " + name + " 需要 " + size + " 个参数");
        }
        return args.get(0);
    }

    private void expect(char c) {
        skipSpace();
        if (pos >= expr.length() || expr.charAt(pos) != c) {
            throw new BizException("算法表达式缺少 '" + c + "': " + expr);
        }
        pos++;
    }

    private void skipSpace() {
        while (pos < expr.length() && Character.isWhitespace(expr.charAt(pos))) {
            pos++;
        }
    }
}
