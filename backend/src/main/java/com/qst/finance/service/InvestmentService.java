package com.qst.finance.service;

import com.qst.finance.common.FormulaUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class InvestmentService {
    public Map<String, Object> calculate(Map<String, Object> input, boolean preview) {
        double initial = number(input, "initialInvestment", 5000000D);
        int years = (int) Math.max(1, Math.min(20, number(input, "projectYears", 5D)));
        double discountRate = number(input, "discountRate", 0.1D);
        double taxRate = number(input, "taxRate", 0.25D);
        double vatRate = number(input, "vatRate", 0.13D);
        double revenue = number(input, "annualRevenue", 8000000D);
        double cost = number(input, "annualCost", 4500000D);
        double loan = number(input, "loanAmount", 2000000D);
        double loanRate = number(input, "loanRate", 0.06D);
        int loanYears = (int) Math.max(1, Math.min(years, number(input, "loanYears", 3D)));
        double salvageRate = number(input, "salvageRate", 0.05D);
        double revenueGrowth = number(input, "revenueGrowth", 0.03D);
        double costGrowth = number(input, "costGrowth", 0.02D);
        double depreciation = initial * (1D - salvageRate) / years;
        List<Double> investmentFlows = new ArrayList<Double>();
        List<Double> fullCapitalFlows = new ArrayList<Double>();
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        investmentFlows.add(-initial);
        fullCapitalFlows.add(-initial + loan);
        double principalBalance = loan;
        double cumulativeInvestment = -initial;
        double cumulativeFull = -initial + loan;
        for (int year = 1; year <= years; year++) {
            double yearRevenue = revenue * Math.pow(1D + revenueGrowth, year - 1);
            double yearCost = cost * Math.pow(1D + costGrowth, year - 1);
            double vat = yearRevenue / (1D + vatRate) * vatRate - yearCost / (1D + vatRate) * vatRate;
            double interest = principalBalance > 0D ? principalBalance * loanRate : 0D;
            double principal = year <= loanYears && loan > 0D ? loan / loanYears : 0D;
            if (principal > principalBalance) {
                principal = principalBalance;
            }
            double profitBeforeTax = yearRevenue - yearCost - depreciation - interest - vat * 0.12D;
            double incomeTax = Math.max(0D, profitBeforeTax * taxRate);
            double netProfit = profitBeforeTax - incomeTax;
            double operatingCash = netProfit + depreciation;
            double salvage = year == years ? initial * salvageRate : 0D;
            double investmentCash = operatingCash + salvage - (year == 1 ? 0D : 0D);
            double loanCash = year == 1 ? loan - principal - interest : -principal - interest;
            double fullCapitalCash = investmentCash + loanCash;
            investmentFlows.add(investmentCash);
            fullCapitalFlows.add(fullCapitalCash);
            cumulativeInvestment += investmentCash;
            cumulativeFull += fullCapitalCash;
            principalBalance -= principal;
            Map<String, Object> row = new LinkedHashMap<String, Object>();
            row.put("year", year);
            row.put("revenue", round(yearRevenue));
            row.put("cost", round(yearCost));
            row.put("vat", round(vat));
            row.put("depreciation", round(depreciation));
            row.put("interest", round(interest));
            row.put("profitBeforeTax", round(profitBeforeTax));
            row.put("incomeTax", round(incomeTax));
            row.put("netProfit", round(netProfit));
            row.put("operatingCash", round(operatingCash));
            row.put("loanInterest", round(interest));
            row.put("loanPrincipal", round(principal));
            row.put("investmentCash", round(investmentCash));
            row.put("fullCapitalCash", round(fullCapitalCash));
            row.put("cumulativeInvestment", round(cumulativeInvestment));
            row.put("cumulativeFullCapital", round(cumulativeFull));
            row.put("loanBalance", round(principalBalance));
            rows.add(row);
        }
        double npvInvestment = FormulaUtils.npv(investmentFlows, discountRate);
        double npvFull = FormulaUtils.npv(fullCapitalFlows, discountRate);
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("preview", preview);
        result.put("input", input);
        result.put("yearly", preview ? rows.subList(0, Math.min(1, rows.size())) : rows);
        result.put("investmentCashFlows", investmentFlows);
        result.put("fullCapitalCashFlows", fullCapitalFlows);
        result.put("npvInvestment", round(npvInvestment));
        result.put("npvFullCapital", round(npvFull));
        result.put("irrInvestment", FormulaUtils.round(FormulaUtils.irr(investmentFlows) * 100D, 2));
        result.put("irrFullCapital", FormulaUtils.round(FormulaUtils.irr(fullCapitalFlows) * 100D, 2));
        result.put("paybackInvestment", FormulaUtils.paybackPeriod(investmentFlows));
        result.put("paybackFullCapital", FormulaUtils.paybackPeriod(fullCapitalFlows));
        result.put("conclusion", conclusion(npvInvestment, FormulaUtils.irr(investmentFlows), discountRate));
        result.put("note", "本测算为简化模型，增值税按价税分离估算，折旧按直线法，未考虑残值处置税费和营运资金垫支。");
        return result;
    }

    private String conclusion(double npv, double irr, double discountRate) {
        if (npv > 0 && irr > discountRate * 100D) {
            return "项目净现值为正且内部收益率高于折现率，具备投资可行性；建议进一步复核销量、价格和回款假设。";
        }
        if (npv > 0) {
            return "项目净现值为正，但内部收益率优势有限，建议优化成本或融资结构后再决策。";
        }
        return "项目净现值为负，当前假设下不建议投资，请调整投资规模、售价或成本参数。";
    }

    private double number(Map<String, Object> input, String key, double defaultValue) {
        Object value = input == null ? null : input.get(key);
        if (value == null) {
            return defaultValue;
        }
        try {
            return Double.parseDouble(String.valueOf(value));
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }

    private double round(double value) {
        return FormulaUtils.round(value, 2);
    }
}
