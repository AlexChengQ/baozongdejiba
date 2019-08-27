package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.PlatformBlockVo;
import com.bylz.quantumCloud.service.PlatformBlockService;
import com.likegene.framework.core.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/17
 */
@Service
public class PlatformBlockServiceImpl extends BaseServiceImpl<PlatformBlockVo,Integer> implements PlatformBlockService {
    @Override
    public String getNamespace() {
        return PlatformBlockVo.class.getSimpleName();
    }
}
