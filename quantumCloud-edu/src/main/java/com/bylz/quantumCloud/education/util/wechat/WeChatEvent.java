package com.bylz.quantumCloud.education.util.wechat;

public class WeChatEvent {
	/**消息类型，event*/
	public final static String MSGTYPE_EVENT = "event";
	
	
	/**事件类型，subscribe*/
	public final static String EVENT_SUBSCRIBE = "subscribe";
	public final static String EVENT_SCAN = "SCAN";
	
	
	
	/** 开发者微信号 */
	private String toUserName;
	/** 发送方帐号（一个OpenID） */
	private String fromUserName;
	/** 消息创建时间 */
	private String createTime;
	/** 消息类型 */
	private String msgType;
	/** 事件类型 */
	private String event;
	/** 事件KEY值，与自定义菜单接口中KEY值对应 */
	private String eventKey;
	/** 二维码的ticket，可用来换取二维码图片 */
	private String ticket;
	/** 地理位置纬度 */
	private Double latitude;
	/** 地理位置经度 */
	private Double longitude;
	/** 地理位置精度 */
	private String precision;
	/***/
	private int msgId; // 64位整型

	public String getToUserName() {
		return toUserName;
	}

	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}

	public String getFromUserName() {
		return fromUserName;
	}

	public void setFromUserName(String fromUserName) {
		this.fromUserName = fromUserName;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}

	public String getEvent() {
		return event;
	}

	public void setEvent(String event) {
		this.event = event;
	}

	public String getEventKey() {
		return eventKey;
	}

	public void setEventKey(String eventKey) {
		this.eventKey = eventKey;
	}

	public String getTicket() {
		return ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public String getPrecision() {
		return precision;
	}

	public void setPrecision(String precision) {
		this.precision = precision;
	}

	public int getMsgId() {
		return msgId;
	}

	public void setMsgId(int msgId) {
		this.msgId = msgId;
	}

}
