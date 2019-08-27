package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.AppBanner;
import com.bylz.quantumCloud.model.DicValueVo;
import com.bylz.quantumCloud.service.BannerService;
import com.bylz.quantumCloud.service.DicService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/8/6
 */
@Service
public class AppBannerImpl extends BaseServiceImpl<AppBanner, Long> implements BannerService{


    @Override
    public String getNamespace() {
        return AppBanner.class.getSimpleName();
    }
}
