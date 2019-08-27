package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:论坛用户VO
 * @since 2018/6/21
 */
public class ForumUserVo implements Serializable {

    private static final long serialVersionUID = -1378025823148112523L;

    /*id*/
    private long id;

    /*论坛用户头像*/
    private String face;

    /*论坛用户昵称*/
    private String name;

    /*性别,1：保密，2：男，3：女*/
    private String sex;

    /*性别名称*/
    private String sexName;

    /*绑定电话*/
    private String tel;

    /*星座（1-12按星座顺序）*/
    private String constellation;

    /*星座名字*/
    private String constellationName;

    /*邮箱*/
    private String email;

    /*签名*/
    private String autograph;

    /*生日*/
    private String birthday;

    /*图片base64码*/
    private String faceBase64;

    /*上一次上传图片*/
    private String oldFace;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFace() {
        return face;
    }

    public void setFace(String face) {
        this.face = face;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getConstellation() {
        return constellation;
    }

    public void setConstellation(String constellation) {
        this.constellation = constellation;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAutograph() {
        return autograph;
    }

    public void setAutograph(String autograph) {
        this.autograph = autograph;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getSexName() {
        return sexName;
    }

    public void setSexName(String sexName) {
        this.sexName = sexName;
    }

    public String getConstellationName() {
        return constellationName;
    }

    public void setConstellationName(String constellationName) {
        this.constellationName = constellationName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFaceBase64() {
        return faceBase64;
    }

    public void setFaceBase64(String faceBase64) {
        this.faceBase64 = faceBase64;
    }

    public String getOldFace() {
        return oldFace;
    }

    public void setOldFace(String oldFace) {
        this.oldFace = oldFace;
    }
}
