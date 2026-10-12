package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.qst.finance.model.ImportLog;

/**
 * 导入日志 Mapper (t_import_log)
 */
public interface ImportLogMapper {

    @Select("SELECT * FROM t_import_log ORDER BY start_time DESC, id DESC")
    List<ImportLog> selectAll();

    @Insert("INSERT INTO t_import_log (batch_id, report_type, report_name, file_name, total_rows, success_rows, fail_rows,"
            + " status, message, imp_user, start_time, end_time)"
            + " VALUES (#{batchId}, #{reportType}, #{reportName}, #{fileName}, #{totalRows}, #{successRows}, #{failRows},"
            + " #{status}, #{message}, #{impUser}, #{startTime}, #{endTime})")
    int insert(ImportLog log);
}
