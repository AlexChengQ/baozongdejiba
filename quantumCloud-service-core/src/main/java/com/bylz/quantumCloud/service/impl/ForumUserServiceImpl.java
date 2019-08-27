package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.DicValueVo;
import com.bylz.quantumCloud.model.FocusUserVo;
import com.bylz.quantumCloud.model.ForumUserVo;
import com.bylz.quantumCloud.service.ForumUserService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/6/21
 */
@Transactional(rollbackFor = Exception.class)
@Service
public class ForumUserServiceImpl extends BaseServiceImpl<ForumUserVo, Long> implements ForumUserService {
    /**
     * 根据登录用户查询论坛用户详情
     * @param userId
     * @return
     */
    @Override
    public ForumUserVo getForumUser(Long userId) {
        QueryFilter queryFilter = new QueryFilter();
        queryFilter.put("userId",userId);
        queryFilter.setStatementKey("getForumUser");
        return this.findOne(queryFilter).getReturnObj();
    }

    /**
     * 添加或修改论坛用户
     * @param forumUserVo
     * @return
     */
    @Override
    public int updateForumUser(ForumUserVo forumUserVo) {
        QueryFilter queryFilter = new QueryFilter(forumUserVo);
        queryFilter.setStatementKey("updForumUser");
        return this.update(queryFilter).getReturnObj();
    }

    /**
     * 查询星座下拉
     * @return
     */
    @Override
    public List<DicValueVo> getSelectValue() {
        QueryFilter queryFilter = new QueryFilter();
        queryFilter.setStatementKey("getSelectVal");
        return this.findList(queryFilter).getReturnObj();
    }

    /**
     * 查询论坛用户粉丝等数量
     * @return
     */
    @Override
    public ForumUserVo getForUserDetails() {
        return null;
    }

    @Override
    public String getNamespace() {
        return ForumUserVo.class.getSimpleName();
    }


}
