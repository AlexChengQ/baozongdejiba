package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.ForumBrowseVo;
import com.bylz.quantumCloud.service.ForumBrowseTaskService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;
import org.springframework.stereotype.Component;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:删除浏览记录
 * @since 2018/6/26
 */
@Component
public class ForumBrowseTaskServiceImpl  extends BaseServiceImpl<ForumBrowseVo, Long> implements ForumBrowseTaskService {
    @Override
    public int delBrowseToday() {
        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("delBrowse");
        return this.delete(filter).getReturnObj();
    }

    @Override
    public String getNamespace() {
        return ForumBrowseVo.class.getSimpleName();
    }
}
