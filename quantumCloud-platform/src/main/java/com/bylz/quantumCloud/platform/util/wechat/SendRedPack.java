package com.bylz.quantumCloud.platform.util.wechat;

/**
 * 现金红包实体类
 * 
 * @ClassName: SendRedPack
 * @Description: TODO
 * @author houdongodng
 * @date 2018/1/28
 *
 */
public class SendRedPack {
	/** 商品促销*/
	public final  static  String SCENE_ID_PRODUCT_1 = "PRODUCT_1";
	/** 抽奖*/
	public final  static  String SCENE_ID_PRODUCT_2 = "PRODUCT_2";
	/** 虚拟物品兑奖*/
	public final  static  String SCENE_ID_PRODUCT_3 = "PRODUCT_3";
	/** 企业内部福利*/
	public final  static  String SCENE_ID_PRODUCT_4 = "PRODUCT_4";
	/**渠道分润*/
	public final  static  String SCENE_ID_PRODUCT_5 = "PRODUCT_5";
	/**保险回馈*/
	public final  static  String SCENE_ID_PRODUCT_6 = "PRODUCT_6";
	/**彩票派奖*/
	public final  static  String SCENE_ID_PRODUCT_7 = "PRODUCT_7";
	/** 税务刮奖*/
	public final  static  String SCENE_ID_PRODUCT_8 = "PRODUCT_8";

    private String nonce_str;// 随机字符串 不长于32位
    private String sign;// 签名 不长于32位
    private String mch_billno;// 商户订单号 （每个订单号必须唯一。取值范围：0~9，a~z，A~Z） 不长于28位
    private String mch_id;// 商户号   不长于32位
    private String wxappid;// 公众账号   不长于32位
    private String send_name;// 商户名称    不长于32位
    private String re_openid;// 用户    不长于32位
    private int total_amount;// 付款金额 单位：分
    private int total_num;// 红包发放总人数
    private String wishing;// 红包祝福语    不长于128位
    private String client_ip;// Ip地址    不长于15位
    private String act_name;// 活动名称    不长于32位
    private String remark;// 备注    不长于256位
    private String scene_id;// 场景id    String(32) 发放红包使用场景，红包金额大于200时必传
    private String risk_info;// 活动信息   String(128)
    private String consume_mch_id;// 资金授权商户号  String(32)  资金授权商户号    服务商替特约商户发放时使用
    
    
    public String getNonce_str() {
        return nonce_str;
    }
    public void setNonce_str(String nonce_str) {
        this.nonce_str = nonce_str;
    }
    public String getSign() {
        return sign;
    }
    public void setSign(String sign) {
        this.sign = sign;
    }
    public String getMch_billno() {
        return mch_billno;
    }
    public void setMch_billno(String mch_billno) {
        this.mch_billno = mch_billno;
    }
    public String getMch_id() {
        return mch_id;
    }
    public void setMch_id(String mch_id) {
        this.mch_id = mch_id;
    }
    public String getWxappid() {
        return wxappid;
    }
    public void setWxappid(String wxappid) {
        this.wxappid = wxappid;
    }
    public String getSend_name() {
        return send_name;
    }
    public void setSend_name(String send_name) {
        this.send_name = send_name;
    }
    public String getRe_openid() {
        return re_openid;
    }
    public void setRe_openid(String re_openid) {
        this.re_openid = re_openid;
    }
    public int getTotal_amount() {
        return total_amount;
    }
    public void setTotal_amount(int total_amount) {
        this.total_amount = total_amount;
    }
    public int getTotal_num() {
        return total_num;
    }
    public void setTotal_num(int total_num) {
        this.total_num = total_num;
    }
    public String getWishing() {
        return wishing;
    }
    public void setWishing(String wishing) {
        this.wishing = wishing;
    }
    public String getClient_ip() {
        return client_ip;
    }
    public void setClient_ip(String client_ip) {
        this.client_ip = client_ip;
    }
    public String getAct_name() {
        return act_name;
    }
    public void setAct_name(String act_name) {
        this.act_name = act_name;
    }
    public String getRemark() {
        return remark;
    }
    public void setRemark(String remark) {
        this.remark = remark;
    }
	public String getScene_id() {
		return scene_id;
	}
	public void setScene_id(String scene_id) {
		this.scene_id = scene_id;
	}
	public String getRisk_info() {
		return risk_info;
	}
	public void setRisk_info(String risk_info) {
		this.risk_info = risk_info;
	}
	public String getConsume_mch_id() {
		return consume_mch_id;
	}
	public void setConsume_mch_id(String consume_mch_id) {
		this.consume_mch_id = consume_mch_id;
	}
}
