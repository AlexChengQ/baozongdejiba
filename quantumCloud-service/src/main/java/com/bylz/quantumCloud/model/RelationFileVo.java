package com.bylz.quantumCloud.model;

import java.io.Serializable;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/7/14
 */
public class RelationFileVo implements Serializable {
    private static final long serialVersionUID = 1034982255924352285L;
    private String fileId;//id
    private String relationId;//关联id
    private byte[] bt;//文件流
    private String fileName;//文件名
    private Long fileSize;//文件大小


    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public String getRelationId() {
        return relationId;
    }

    public void setRelationId(String relationId) {
        this.relationId = relationId;
    }

    public byte[] getBt() {
        return bt;
    }

    public void setBt(byte[] bt) {
        this.bt = bt;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }
}
