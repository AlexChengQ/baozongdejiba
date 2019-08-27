package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.MatchSignUpVo;
import com.bylz.quantumCloud.service.MatchSignUpService;
import com.likegene.framework.core.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/19
 */
@Service
public class MatchSignUpServiceImpl extends BaseServiceImpl<MatchSignUpVo,Long> implements MatchSignUpService {
    @Override
    public String getNamespace() {
        return MatchSignUpVo.class.getSimpleName();
    }
}
