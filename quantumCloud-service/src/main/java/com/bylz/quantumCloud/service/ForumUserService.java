package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.DicValueVo;
import com.bylz.quantumCloud.model.FocusUserVo;
import com.bylz.quantumCloud.model.ForumUserVo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.QueryFilter;

import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:论坛用户Service
 * @since 2018/6/21
 */
public interface ForumUserService extends BaseService<ForumUserVo, Long> {

    /**
     * 根据登录用户查询论坛用户
     * @param userId
     * @return
     */
    ForumUserVo getForumUser(Long userId);

    /**
     * 修改论坛用户
     * @param forumUserVo
     * @return
     */
    int updateForumUser(ForumUserVo forumUserVo);

    /**
     * 查询星座
     * @param
     * @return
     */
    List<DicValueVo> getSelectValue();

    /**
     * 查询论坛用户粉丝等数量
     * @return
     */
    ForumUserVo getForUserDetails();

}
