package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.service.ForumBrowseTaskService;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:删除浏览表中所有浏览记录
 * @since 2018/6/26
 */
public class ForumBrowseTask {

    @Autowired
    private ForumBrowseTaskService forumBrowseTaskService;

    /**
     * 删除今天浏览记录
     * @return
     */
    public int delForumBrowse() {
        return forumBrowseTaskService.delBrowseToday();
    }
}
