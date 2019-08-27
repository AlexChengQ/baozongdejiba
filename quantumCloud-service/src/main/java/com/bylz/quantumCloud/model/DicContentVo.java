package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:字典内容
 * @since 2018/8/7
 */
public class DicContentVo implements Serializable {
    private static final long serialVersionUID = -5755313923499713724L;
    private long id;//id
    private long dicId;//字典id
    private String dicContent;//字典内容
    private String dicDesc;//字典描述
    private Date addTime;//创建时间
    private long addUserId;//创建人
    private long updUserId;//修改人
    private String deflag;//是否有效，0：无效，1：有效
    private String dicFlag;//字典内容对应id

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getDicId() {
        return dicId;
    }

    public void setDicId(long dicId) {
        this.dicId = dicId;
    }

    public String getDicContent() {
        return dicContent;
    }

    public void setDicContent(String dicContent) {
        this.dicContent = dicContent;
    }

    public String getDicDesc() {
        return dicDesc;
    }

    public void setDicDesc(String dicDesc) {
        this.dicDesc = dicDesc;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public long getAddUserId() {
        return addUserId;
    }

    public void setAddUserId(long addUserId) {
        this.addUserId = addUserId;
    }

    public long getUpdUserId() {
        return updUserId;
    }

    public void setUpdUserId(long updUserId) {
        this.updUserId = updUserId;
    }

    public String getDeflag() {
        return deflag;
    }

    public void setDeflag(String deflag) {
        this.deflag = deflag;
    }

    public String getDicFlag() {
        return dicFlag;
    }

    public void setDicFlag(String dicFlag) {
        this.dicFlag = dicFlag;
    }
}
