package com.qst.finance.model;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

/**
 * t_message_info 资讯表
 */
@Data
public class MessageInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String title;
    private String content;
    private String infoType;
    private String publishUser;
    private Date publishTime;
    private Integer status;
    private Integer readCount;
}
