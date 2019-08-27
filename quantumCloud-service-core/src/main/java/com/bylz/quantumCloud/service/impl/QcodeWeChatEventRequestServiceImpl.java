package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.QcodeWeChatEventRequestService;
import com.bylz.quantumCloud.model.QcodeWeChatEventRequest;

/**
 * 微信事件请求表 Service
 * @author houdongdong
 * @since  2018-01-31
 * 
 */
@Component
public class QcodeWeChatEventRequestServiceImpl extends BaseServiceImpl<QcodeWeChatEventRequest, Integer> implements QcodeWeChatEventRequestService{

	public String getNamespace()
    {
        return QcodeWeChatEventRequest.class.getSimpleName();
    }
}
