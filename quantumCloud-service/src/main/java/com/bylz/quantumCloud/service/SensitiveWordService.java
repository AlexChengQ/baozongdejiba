package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.SensitiveWordVo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;

import java.util.List;
import java.util.Set;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/5/7
 */
public interface SensitiveWordService extends BaseService<SensitiveWordVo,Long> {

    Set<String> getSensitiveWordList(QueryFilter filter);
}
