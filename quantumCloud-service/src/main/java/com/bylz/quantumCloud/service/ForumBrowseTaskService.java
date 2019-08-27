package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.ForumBrowseVo;
import com.likegene.framework.core.BaseService;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:删除浏览帖子记录
 * @since 2018/6/26
 */
public interface ForumBrowseTaskService extends BaseService<ForumBrowseVo, Long> {

    /**
     * 删除今天浏览记录
     */
    int delBrowseToday();
}
