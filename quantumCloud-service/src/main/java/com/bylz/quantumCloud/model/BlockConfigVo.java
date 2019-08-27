package com.bylz.quantumCloud.model;

import java.io.Serializable;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/6
 */
public class BlockConfigVo implements Serializable {

    private static final long serialVersionUID = 5166668269734631109L;

    private Long blockId;//版块id

    private String name;//版块名称

    private String brief;//版块简介

    private String cataLog;//所属分类

    private String img;//版块图片

    private int type;//版块类型

    private String url;//版块URL

    public Long getBlockId() {
        return blockId;
    }

    public void setBlockId(Long blockId) {
        this.blockId = blockId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getCataLog() {
        return cataLog;
    }

    public void setCataLog(String cataLog) {
        this.cataLog = cataLog;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
