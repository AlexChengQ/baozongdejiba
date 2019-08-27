package com.bylz.quantumCloud.service;

import com.likegene.framework.core.BaseService;
import com.bylz.quantumCloud.model.QcodeThirdLogin;
import com.likegene.framework.core.QueryFilter;

/**
 * 第三方登录 Service
 * @author houdongdong
 * @since  2018-02-26
 * 
 */
public interface QcodeThirdLoginService extends BaseService<QcodeThirdLogin, Long>{
	String SELECT_BY_APPID = "selectByAppId";
	String UPDATE_USERID_BY_APPID = "updateUserIdByAppId";
	
	/**
	 * 指定第三方账号是否存在，且已绑定量子云账户
	 * @param appId 第三方应用appId
	 * @param appType 第三方登录类型(如1:qq、2:微信、3:微博)
	 * @return 存在且已绑定返回true
	 * */
	public boolean isExistingThirdAppAccount(String appId ,Integer appType);
	/**
	 * 指定量子云账户账号是否已经与指定第三方应用账户绑定
	 * @param email 量子云账户账号
	 * @param appType 第三方登录类型(如1:qq、2:微信、3:微博)
	 * @return 存在且已绑定返回true
	 * */
	public boolean isbinded(String email ,Integer appType);
	
	public boolean updateUserIdByAppId(String appId ,long userId);

	public boolean hasBindThird(QueryFilter filter);
}
