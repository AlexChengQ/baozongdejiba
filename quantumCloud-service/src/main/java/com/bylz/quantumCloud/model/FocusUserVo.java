package com.bylz.quantumCloud.model;

import java.io.Serializable;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:关注人
 * @since 2018/6/23
 */
public class FocusUserVo implements Serializable {
    private static final long serialVersionUID = 8191287615646958774L;
    private Long id;//id
    private Long focusUserId;//被关注人id
    private Long userId;//关注人id
    private String focusDate;//关注时间
    private String nickName;//昵称
    private String autograph;//签名
    private String face;//头像


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getFocusUserId() {
        return focusUserId;
    }

    public void setFocusUserId(Long focusUserId) {
        this.focusUserId = focusUserId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getFocusDate() {
        return focusDate;
    }

    public void setFocusDate(String focusDate) {
        this.focusDate = focusDate;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getAutograph() {
        return autograph;
    }

    public void setAutograph(String autograph) {
        this.autograph = autograph;
    }

    public String getFace() {
        return face;
    }

    public void setFace(String face) {
        this.face = face;
    }
}
