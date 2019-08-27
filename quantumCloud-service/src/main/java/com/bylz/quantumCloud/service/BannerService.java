package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.AppBanner;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.Result;

import java.util.Map;

/**
 * @author SonghaoZhang
 * @version 1.0
 * @Description:字典接口
 * @since 2018/8/6
 */
public interface BannerService extends BaseService<AppBanner, Long>{

	Result save(AppBanner userVideo);
}
