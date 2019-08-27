package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.SysFileService;
import com.bylz.quantumCloud.model.SysFile;

/**
 * 文件 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
@Component
public class SysFileServiceImpl extends BaseServiceImpl<SysFile, Long> implements SysFileService{

	public String getNamespace()
    {
        return SysFile.class.getSimpleName();
    }
}
