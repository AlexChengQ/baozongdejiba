package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.SensitiveWordVo;
import com.bylz.quantumCloud.service.SensitiveWordService;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/5/7
 */
public class SensitiveWordServiceImpl extends BaseServiceImpl<SensitiveWordVo,Long> implements SensitiveWordService {

    @Override
    public String getNamespace() {
        return SensitiveWordVo.class.getSimpleName();
    }

    @Override
    public Set<String> getSensitiveWordList(QueryFilter filter) {
        filter.setStatementKey("findList");
        List<String> list = this.findList(filter).getReturnObj();
        Set<String> set = new HashSet<String>(list);
        return set;
    }
}
