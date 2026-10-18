package com.qst.finance.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.finance.common.BizException;
import com.qst.finance.mapper.CodeLibrMapper;
import com.qst.finance.mapper.CodeMapperMapper;
import com.qst.finance.mapper.MessageInfoMapper;
import com.qst.finance.mapper.ModeMapper;
import com.qst.finance.mapper.ReportNameMapper;
import com.qst.finance.mapper.ReportPropertyMapper;
import com.qst.finance.model.CodeLibr;
import com.qst.finance.model.CodeMapper;
import com.qst.finance.model.MessageInfo;
import com.qst.finance.model.Mode;
import com.qst.finance.model.ReportName;
import com.qst.finance.model.ReportProperty;
import com.qst.finance.service.ModelService;
import com.qst.finance.service.support.ValueProviderHelper;
import com.qst.finance.util.ExpressionEvaluator;

@Service
public class ModelServiceImpl implements ModelService {

    @Autowired
    private ReportNameMapper reportNameMapper;

    @Autowired
    private ReportPropertyMapper reportPropertyMapper;

    @Autowired
    private CodeLibrMapper codeLibrMapper;

    @Autowired
    private CodeMapperMapper codeMapperMapper;

    @Autowired
    private ModeMapper modeMapper;

    @Autowired
    private MessageInfoMapper messageInfoMapper;

    @Autowired
    private ValueProviderHelper valueProviderHelper;

    @Override
    public List<ReportName> reportNames() {
        return reportNameMapper.selectAll();
    }

    @Override
    public void saveReportName(ReportName reportName) {
        if (StringUtils.isBlank(reportName.getReportCode()) || StringUtils.isBlank(reportName.getReportName())) {
            throw new BizException("报表编码与名称不能为空");
        }
        if (StringUtils.isBlank(reportName.getMapMode())) {
            reportName.setMapMode("WIDE");
        }
        if (reportName.getId() == null) {
            reportNameMapper.insert(reportName);
        } else {
            reportNameMapper.update(reportName);
        }
    }

    @Override
    public void deleteReportName(Long id) {
        reportNameMapper.deleteById(id);
    }

    @Override
    public List<ReportProperty> properties(String reportType) {
        if (StringUtils.isBlank(reportType)) {
            return reportPropertyMapper.selectAll();
        }
        return reportPropertyMapper.selectByReportType(reportType);
    }

    @Override
    public void saveProperty(ReportProperty property) {
        if (StringUtils.isBlank(property.getReportType()) || StringUtils.isBlank(property.getColumnCode())) {
            throw new BizException("报表类型与目标字段不能为空");
        }
        if (property.getIsKey() == null) {
            property.setIsKey(0);
        }
        if (property.getIsActive() == null) {
            property.setIsActive(1);
        }
        if (property.getId() == null) {
            reportPropertyMapper.insert(property);
        } else {
            reportPropertyMapper.update(property);
        }
    }

    @Override
    public void deleteProperty(Long id) {
        reportPropertyMapper.deleteById(id);
    }

    @Override
    public List<CodeLibr> codeLibres(String reportType) {
        if (StringUtils.isBlank(reportType)) {
            return codeLibrMapper.selectAll();
        }
        return codeLibrMapper.selectByReportType(reportType);
    }

    @Override
    public void saveCodeLibr(CodeLibr codeLibr) {
        if (StringUtils.isBlank(codeLibr.getCode()) || StringUtils.isBlank(codeLibr.getCodeName())) {
            throw new BizException("编码与编码名称不能为空");
        }
        if (codeLibr.getIsActive() == null) {
            codeLibr.setIsActive(1);
        }
        if (codeLibr.getId() == null) {
            codeLibrMapper.insert(codeLibr);
        } else {
            codeLibrMapper.update(codeLibr);
        }
    }

    @Override
    public void deleteCodeLibr(Long id) {
        codeLibrMapper.deleteById(id);
    }

    @Override
    public List<CodeMapper> codeMappers(String reportType) {
        List<CodeMapper> list = codeMapperMapper.selectAll();
        List<CodeMapper> result = new ArrayList<CodeMapper>();
        for (CodeMapper mapper : list) {
            CodeLibr libr = codeLibrMapper.selectByCode(mapper.getCode());
            mapper.setCodeName(libr == null ? mapper.getCode() : libr.getCodeName());
            if (StringUtils.isBlank(reportType) || reportType.equals(mapper.getReportType())) {
                result.add(mapper);
            }
        }
        return result;
    }

    @Override
    public void saveCodeMapper(CodeMapper codeMapper) {
        if (StringUtils.isBlank(codeMapper.getSourceTable()) || StringUtils.isBlank(codeMapper.getSourceColumn())
                || StringUtils.isBlank(codeMapper.getCode())) {
            throw new BizException("来源表、来源字段与目标编码不能为空");
        }
        if (StringUtils.isBlank(codeMapper.getMapType())) {
            codeMapper.setMapType("COLUMN");
        }
        if ("EXPRESSION".equals(codeMapper.getMapType()) && StringUtils.isBlank(codeMapper.getCalcExpression())) {
            throw new BizException("表达式类型的映射必须配置计算表达式");
        }
        if (codeMapper.getIsActive() == null) {
            codeMapper.setIsActive(1);
        }
        if (codeMapper.getId() == null) {
            codeMapperMapper.insert(codeMapper);
        } else {
            codeMapperMapper.update(codeMapper);
        }
    }

    @Override
    public void deleteCodeMapper(Long id) {
        codeMapperMapper.deleteById(id);
    }

    @Override
    public List<Mode> modes(String modeType) {
        if (StringUtils.isBlank(modeType)) {
            return modeMapper.selectAll();
        }
        return modeMapper.selectByType(modeType);
    }

    @Override
    public void saveMode(Mode mode) {
        if (StringUtils.isBlank(mode.getModeCode()) || StringUtils.isBlank(mode.getModeName())) {
            throw new BizException("算法编码与算法名称不能为空");
        }
        if (StringUtils.isBlank(mode.getCalcExpression())) {
            throw new BizException("算法表达式不能为空");
        }
        // 校验表达式语法(取值使用 0 占位，仅校验语法与函数是否支持)
        ExpressionEvaluator.validate(mode.getCalcExpression());
        if (StringUtils.isBlank(mode.getModeType())) {
            mode.setModeType("RATIO");
        }
        if (StringUtils.isBlank(mode.getWarnMode())) {
            mode.setWarnMode("none");
        }
        if (mode.getIsActive() == null) {
            mode.setIsActive(1);
        }
        if (mode.getId() == null) {
            modeMapper.insert(mode);
        } else {
            modeMapper.update(mode);
        }
    }

    @Override
    public void deleteMode(Long id) {
        modeMapper.deleteById(id);
    }

    @Override
    public BigDecimal testExpression(String expression, Long orgId, String kjyearMonth) {
        if (StringUtils.isBlank(expression)) {
            throw new BizException("算法表达式不能为空");
        }
        return valueProviderHelper.eval(expression, valueProviderHelper.loadValues(orgId, kjyearMonth));
    }

    @Override
    public List<MessageInfo> news() {
        return messageInfoMapper.selectAll();
    }

    @Override
    public void saveNews(MessageInfo info) {
        if (StringUtils.isBlank(info.getTitle())) {
            throw new BizException("资讯标题不能为空");
        }
        if (info.getId() == null) {
            info.setPublishTime(new Date());
            if (info.getStatus() == null) {
                info.setStatus(1);
            }
            if (info.getReadCount() == null) {
                info.setReadCount(0);
            }
            messageInfoMapper.insert(info);
        } else {
            messageInfoMapper.update(info);
        }
    }

    @Override
    public void deleteNews(Long id) {
        messageInfoMapper.deleteById(id);
    }
}
