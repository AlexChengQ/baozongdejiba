package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.model.QcodeThirdLogin;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeThirdLoginService;

/**
 * 第三方登录 Service
 * @author houdongdong
 * @since  2018-02-26
 * 
 */
@Component
public class QcodeThirdLoginServiceImpl extends BaseServiceImpl<QcodeThirdLogin, Long> implements QcodeThirdLoginService{

	public String getNamespace()
    {
        return QcodeThirdLogin.class.getSimpleName();
    }

	@Override
	public boolean updateUserIdByAppId(String appId, long userId) {
		QueryFilter filter = new QueryFilter();
		filter.put("appId",appId);
		filter.put("userId", userId);
		filter.setStatementKey(QcodeThirdLoginService.UPDATE_USERID_BY_APPID);
		Result result = this.update(filter);
		if (result.isSuccess()) {
			return true;
		}
		return false;
	}

	@Override
	public boolean hasBindThird(QueryFilter filter) {
		filter.setStatementKey("getHasBingThird");
		return this.findOne(filter).getReturnObj()==null?false:true;
	}

	@Override
	public boolean isExistingThirdAppAccount(String appId, Integer appType) {
			QueryFilter filter = new QueryFilter();
			filter.put("appId",appId);
			filter.put("appType", appType);
			QcodeThirdLogin qcodeThirdLogin = this.findOne(filter).getReturnObj();
			if (qcodeThirdLogin != null && qcodeThirdLogin.getUserId() !=null && !"".equals(qcodeThirdLogin.getUserId())) {
				return true;
			}
			return false;
	}

	@Override
	public boolean isbinded(String email, Integer appType) {
		QueryFilter filter = new QueryFilter();
		filter.put("userName",email);
		filter.put("appType", appType);
		filter.setStatementKey(QcodeThirdLoginService.SELECT_BY_APPID);
		QcodeUser qcodeUser  = this.findOne(filter).getReturnObj();
		if (qcodeUser != null ) {
			return true;
		}
		return false;
	}

}
