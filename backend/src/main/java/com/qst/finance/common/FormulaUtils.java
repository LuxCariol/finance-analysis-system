package com.qst.finance.common;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

public final class FormulaUtils {
    private FormulaUtils() {
    }

    public static double div(double numerator, double denominator) {
        if (Math.abs(denominator) < 0.0000001D) {
            return 0D;
        }
        return numerator / denominator;
    }

    public static double round(double value, int scale) {
        return BigDecimal.valueOf(value).setScale(scale, RoundingMode.HALF_UP).doubleValue();
    }

    public static double percent(double value) {
        return round(value * 100D, 2);
    }

    public static double growth(double current, double previous) {
        return Math.abs(previous) < 0.0000001D ? 0D : (current - previous) / Math.abs(previous);
    }

    public static List<Double> linearTrend(List<Double> values, int periods) {
        List<Double> result = new ArrayList<Double>();
        int n = values.size();
        if (n == 0) {
            for (int i = 0; i < periods; i++) {
                result.add(0D);
            }
            return result;
        }
        double sumX = 0D;
        double sumY = 0D;
        double sumXY = 0D;
        double sumXX = 0D;
        for (int i = 0; i < n; i++) {
            double x = i + 1;
            double y = values.get(i);
            sumX += x;
            sumY += y;
            sumXY += x * y;
            sumXX += x * x;
        }
        double denominator = n * sumXX - sumX * sumX;
        double slope = Math.abs(denominator) < 0.0000001D ? 0D : (n * sumXY - sumX * sumY) / denominator;
        double intercept = (sumY - slope * sumX) / n;
        for (int i = 0; i < periods; i++) {
            double predicted = intercept + slope * (n + i + 1);
            result.add(predicted);
        }
        return result;
    }

    public static double irr(List<Double> flows) {
        double low = -0.99D;
        double high = 10D;
        double npvLow = npv(flows, low);
        double npvHigh = npv(flows, high);
        if (npvLow * npvHigh > 0) {
            return 0D;
        }
        for (int i = 0; i < 200; i++) {
            double mid = (low + high) / 2D;
            double npvMid = npv(flows, mid);
            if (Math.abs(npvMid) < 0.0001D) {
                return mid;
            }
            if (npvMid * npvLow <= 0) {
                high = mid;
            } else {
                low = mid;
                npvLow = npvMid;
            }
        }
        return (low + high) / 2D;
    }

    public static double npv(List<Double> flows, double rate) {
        double result = 0D;
        for (int i = 0; i < flows.size(); i++) {
            result += flows.get(i) / Math.pow(1D + rate, i);
        }
        return result;
    }

    public static int paybackPeriod(List<Double> flows) {
        double cumulative = 0D;
        for (int i = 0; i < flows.size(); i++) {
            cumulative += flows.get(i);
            if (i > 0 && cumulative >= 0) {
                return i;
            }
        }
        return -1;
    }
}
