package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 客户信息表
 *
 * @author JT
 * @since 2017-07-25
 */
public class QcodeUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 一级用户
     */
    public static final int QCODEUSER_LEVEL_1 = 1;

    /**
     * 二级用户
     */
    public static final int QCODEUSER_LEVEL_2 = 2;

    /**
     * 三级用户
     */
    public static final int QCODEUSER_LEVEL_3 = 3;

    /**
     * 是否禁用 0:否
     */
    public static final int IS_DISABLE_NO = 0;

    /**
     * 是否禁用 1:是
     */
    public static final int IS_DISABLE_YES = 1;

    /**
     * 删除状态 0:未删除
     */
    public static final int DELETED_NO = 0;

    /**
     * 删除状态 1:已删除
     */
    public static final int DELETED_YES = 1;

    /**
     * 客户代码
     */
    private Long id;

    /**
     * 姓名
     */
    private String name;

    /**
     * email
     */
    private String email;

    /**
     * 密码
     */
    private String pwd;

    /**
     * 机构
     */
    private String orgName;

    /**
     * 用户等级(1,2,3)
     */
    private Integer level;

    /**
     * 注册时间
     */
    private Date registerTime;

    /**
     * 是否禁用(0:否,1:是)
     */
    private Integer isDisable;

    /**
     * 删除状态(0.未删除;1.已删除)
     */
    private Integer deleted;

    /**
     * 头像
     */
    private String face;

    /**
     * API KEY
     */
    private String apiKey;

    /**
     * token
     */
    private String token;

    /*是否为老用户 0、否，1、是*/
    private String isOldUser;

    private String isModerator;//是否版主0：不是，1：是
    private String belonged;//所属模块
    /*教育系统分数显示*/
    private int score;

    private UserBonusVo userBonusVo;//用户勋章信息

    private List<UserVideo> userVideoList;

    private Date loginTime;//登录时间

    private long stdTime;//学习时长

    private String userTitle;//称号

    private String oldFace;//旧头像

    private int signIn;

    //证书可否兑换
    private List<Map<String,Object>> certificateMap;

    private boolean canConvertCertificate;

    private boolean bindingWeiXin;

    private boolean bindingQQ;

    private boolean bindingPhone;

    private boolean bindingWeiBo;

    private int noticeNum;

    private String tel;

    private int allStdTime;//总学习时间

    private int todayStdTime;//今日学习时间
    /**
     * 客户代码
     */
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 姓名
     */
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    /**
     * email
     */
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * 密码
     */
    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    /**
     * 机构
     */
    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    /**
     * 注册时间
     */
    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    /**
     * 是否禁用(0:否,1:是)
     */
    public Integer getIsDisable() {
        return isDisable;
    }

    public void setIsDisable(Integer isDisable) {
        this.isDisable = isDisable;
    }

    /**
     * 删除状态(0.未删除;1.已删除)
     */
    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    /**
     * 头像
     */
    public String getFace() {
        return face;
    }

    public void setFace(String face) {
        this.face = face;
    }

    /**
     * 用户等级
     */
    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    /**
     * API KEY
     */
    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    /**
     * token
     */
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getIsOldUser() {
        return isOldUser;
    }

    public void setIsOldUser(String isOldUser) {
        this.isOldUser = isOldUser;
    }

    public String getIsModerator() {
        return isModerator;
    }

    public void setIsModerator(String isModerator) {
        this.isModerator = isModerator;
    }

    public String getBelonged() {
        return belonged;
    }

    public void setBelonged(String belonged) {
        this.belonged = belonged;
    }

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

    public UserBonusVo getUserBonusVo() {
        return userBonusVo;
    }

    public void setUserBonusVo(UserBonusVo userBonusVo) {
        this.userBonusVo = userBonusVo;
    }

    public List<UserVideo> getUserVideoList() {
        return userVideoList;
    }

    public void setUserVideoList(List<UserVideo> userVideoList) {
        this.userVideoList = userVideoList;
    }

    public Date getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Date loginTime) {
        this.loginTime = loginTime;
    }

    public long getStdTime() {
        return stdTime;
    }

    public void setStdTime(long stdTime) {
        this.stdTime = stdTime;
    }

    public String getUserTitle() {
        return userTitle;
    }

    public void setUserTitle(String userTitle) {
        this.userTitle = userTitle;
    }

    public String getOldFace() {
        return oldFace;
    }

    public void setOldFace(String oldFace) {
        this.oldFace = oldFace;
    }

    public int getSignIn() {
        return signIn;
    }

    public void setSignIn(int signIn) {
        this.signIn = signIn;
    }

    public List<Map<String, Object>> getCertificateMap() {
        return certificateMap;
    }

    public void setCertificateMap(List<Map<String, Object>> certificateMap) {
        this.certificateMap = certificateMap;
    }

    public boolean isCanConvertCertificate() {
        return canConvertCertificate;
    }

    public void setCanConvertCertificate(boolean canConvertCertificate) {
        this.canConvertCertificate = canConvertCertificate;
    }

    public boolean isBindingWeiXin() {
        return bindingWeiXin;
    }

    public void setBindingWeiXin(boolean bindingWeiXin) {
        this.bindingWeiXin = bindingWeiXin;
    }

    public boolean isBindingQQ() {
        return bindingQQ;
    }

    public void setBindingQQ(boolean bindingQQ) {
        this.bindingQQ = bindingQQ;
    }

    public boolean isBindingPhone() {
        return bindingPhone;
    }

    public void setBindingPhone(boolean bindingPhone) {
        this.bindingPhone = bindingPhone;
    }

    public int getNoticeNum() {
        return noticeNum;
    }

    public void setNoticeNum(int noticeNum) {
        this.noticeNum = noticeNum;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public boolean isBindingWeiBo() {
        return bindingWeiBo;
    }

    public void setBindingWeiBo(boolean bindingWeiBo) {
        this.bindingWeiBo = bindingWeiBo;
    }

    public int getAllStdTime() {
        return allStdTime;
    }

    public void setAllStdTime(int allStdTime) {
        this.allStdTime = allStdTime;
    }

    public int getTodayStdTime() {
        return todayStdTime;
    }

    public void setTodayStdTime(int todayStdTime) {
        this.todayStdTime = todayStdTime;
    }
}
