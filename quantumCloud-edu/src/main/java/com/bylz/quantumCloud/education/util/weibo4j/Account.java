package com.bylz.quantumCloud.education.util.weibo4j;


import com.bylz.quantumCloud.education.util.weibo4j.model.WeiboException;
import com.bylz.quantumCloud.education.util.weibo4j.org.json.JSONObject;
import com.bylz.quantumCloud.education.util.weibo4j.util.WeiboConfig;

import java.util.List;
import java.util.Map;

public class Account extends Weibo {

	private static final long serialVersionUID = 3816005087976772682L;

	public Account(String access_token) {
		this.access_token = access_token;
	}

	/**
	 * OAuth授权之后，获取授权用户的UID
	 * 
	 * @return uid
	 * @throws WeiboException
	 *             when Weibo service or network is unavailable
	 * @version weibo4j-V2 1.0.1
	 * @see http://open.weibo.com/wiki/2/account/get_uid
	 * @since JDK 1.5
	 */
	public JSONObject getUid() throws WeiboException {
		return client.get(
				WeiboConfig.getValue("baseURL") + "account/get_uid.json",
				access_token).asJSONObject();
	}

}
