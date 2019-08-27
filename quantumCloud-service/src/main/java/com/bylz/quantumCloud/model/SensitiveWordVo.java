package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/5/7
 */
public class SensitiveWordVo implements Serializable{
    private static final long serialVersionUID = -4240294199970459655L;

    private long id;

    private String sensitiveWord;

    private Date addTime;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSensitiveWord() {
        return sensitiveWord;
    }

    public void setSensitiveWord(String sensitiveWord) {
        this.sensitiveWord = sensitiveWord;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }
}
