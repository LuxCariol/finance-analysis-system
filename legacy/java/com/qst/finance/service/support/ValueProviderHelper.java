package com.qst.finance.service.support;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.qst.finance.common.Constants;
import com.qst.finance.mapper.ReportResultMapper;
import com.qst.finance.model.ReportResult;
import com.qst.finance.util.ExpressionEvaluator;

/**
 * 算法取值辅助类: 从数据仓库结果表装载某月全部编码值，供算法表达式引擎使用。
 *
 * 取值规则:
 *   {A013}      -> 按照该编码所在报表的默认取数类型取值(资产负债默认期末, 利润/现金流量默认本期)
 *   {A013@NC}   -> 指定取数类型取值(年初/期末/本期/上期)
 */
@Component
public class ValueProviderHelper {

    @Autowired
    private ReportResultMapper reportResultMapper;

    /**
     * 装载某会计年月的全部编码值
     */
    public Map<String, BigDecimal> loadValues(Long orgId, String kjyearMonth) {
        List<ReportResult> list = reportResultMapper.selectByMonth(orgId, kjyearMonth, null, null);
        Map<String, BigDecimal> values = new HashMap<String, BigDecimal>();
        for (ReportResult result : list) {
            if (result.getResultValue() == null || result.getCode() == null) {
                continue;
            }
            String type = result.getValueType() == null ? Constants.VALUE_QM : result.getValueType();
            values.put(result.getCode() + "@" + type, result.getResultValue());
            if (type.equals(defaultType(result.getReportType()))) {
                values.put(result.getCode(), result.getResultValue());
            }
        }
        return values;
    }

    /**
     * 报表默认取数类型
     */
    public String defaultType(String reportType) {
        if (Constants.REPORT_BALANCE.equals(reportType)) {
            return Constants.VALUE_QM;
        }
        return Constants.VALUE_BJ;
    }

    public ExpressionEvaluator.ValueProvider provider(final Map<String, BigDecimal> values) {
        return new ExpressionEvaluator.ValueProvider() {
            @Override
            public BigDecimal get(String code, String valueType) {
                String key = (valueType == null || valueType.isEmpty()) ? code : code + "@" + valueType;
                BigDecimal value = values.get(key);
                if (value == null && valueType == null) {
                    value = values.get(code + "@" + Constants.VALUE_QM);
                }
                return value == null ? BigDecimal.ZERO : value;
            }
        };
    }

    /**
     * 计算表达式
     */
    public BigDecimal eval(String expression, Map<String, BigDecimal> values) {
        return ExpressionEvaluator.eval(expression, provider(values));
    }
}
