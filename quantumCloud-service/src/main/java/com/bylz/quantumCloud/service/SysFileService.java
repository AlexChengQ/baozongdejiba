package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.SysFile;
import com.likegene.framework.core.BaseService;

/**
 * 文件 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
public interface SysFileService extends BaseService<SysFile, Long>{
	/**删除管理图片*/
	String DEL_REF_PIC= "delRefPic";
}
