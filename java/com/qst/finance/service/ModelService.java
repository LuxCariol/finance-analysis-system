package com.qst.finance.service;

import java.math.BigDecimal;
import java.util.List;

import com.qst.finance.model.CodeLibr;
import com.qst.finance.model.CodeMapper;
import com.qst.finance.model.MessageInfo;
import com.qst.finance.model.Mode;
import com.qst.finance.model.ReportName;
import com.qst.finance.model.ReportProperty;

/**
 * 模型管理服务(取值配置 / 编码映射 / 编码字典 / 算法配置 / 资讯管理)
 */
public interface ModelService {

    List<ReportName> reportNames();

    void saveReportName(ReportName reportName);

    void deleteReportName(Long id);

    List<ReportProperty> properties(String reportType);

    void saveProperty(ReportProperty property);

    void deleteProperty(Long id);

    List<CodeLibr> codeLibres(String reportType);

    void saveCodeLibr(CodeLibr codeLibr);

    void deleteCodeLibr(Long id);

    List<CodeMapper> codeMappers(String reportType);

    void saveCodeMapper(CodeMapper codeMapper);

    void deleteCodeMapper(Long id);

    List<Mode> modes(String modeType);

    void saveMode(Mode mode);

    void deleteMode(Long id);

    /** 算法表达式试算(算法配置页面) */
    BigDecimal testExpression(String expression, Long orgId, String kjyearMonth);

    List<MessageInfo> news();

    void saveNews(MessageInfo info);

    void deleteNews(Long id);
}
