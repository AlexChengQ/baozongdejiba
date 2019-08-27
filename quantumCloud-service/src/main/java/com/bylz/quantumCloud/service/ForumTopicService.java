/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service;

import java.util.List;
import java.util.Map;

import com.bylz.quantumCloud.model.*;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.springframework.web.multipart.MultipartFile;

/**
 * 论坛主题Service
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月19日
 */
public interface ForumTopicService extends BaseService<ForumTopicVo, Long> {

    /**
     * 根据id获取论坛详情
     *
     * @param forumTopicParam 论坛参数
     * @return 论坛详情
     */
    ForumTopicVo getCommunityById(ForumTopicVo forumTopicParam,String ip);

    /**
     * 添加论坛回复
     *
     * @param forumReplyVo 论坛回复参数
     * @return 成功数
     */
    int addForumReply(ForumReplyVo forumReplyVo);

    /**
     * 论坛主题审核
     * @param forumTopicVo 论坛主题参数
     * @return 成功数
     */
    int updTopicAudit(ForumTopicVo forumTopicVo);

    /**
     * 获取论坛详情
     * @param forumTopicParam 论坛主题参数
     * @return 论坛详情
     */
    ForumTopicVo forumTopicdetail(ForumTopicVo forumTopicParam);

    /**
     * 获取回复详情集合
     * @param filter
     * @return  回复详情集合
     */
    Pagination forumReplyList(QueryFilter filter);

    /**
     * 批量审核回复
     * @param filter  通用参数
     * @return 成功数
     */
    int replyAuditAll(QueryFilter filter);

    /**
     * 论坛主题赞、踩一下
     * @param filter  通用参数
     * @return 成功数
     */
    int updForumTopicLike(QueryFilter filter);

    /**
     * 回复赞、踩一下
     * @param filter 通用参数
     * @return  成功数
     */
    int updReplyLike(QueryFilter filter);

    /**
     * 论坛收藏修改
     * @param filter 通用参数
     * @return 成功数
     */
    int updCollect(QueryFilter filter);

    /**
     * 删除回复
     * @param filter 通用参数
     * @return 成功数
     */
    int delReply(QueryFilter filter);

    /**
     * 批量删除回复
     * @param filter
     * @return
     */
    int delBatchReply(QueryFilter filter);

    /**
     * 添加/删除关注
     * @param filter
     * @return
     */
    int addOrDelFocus(QueryFilter filter);

    /**
     * 保存标签
     * @param list
     * @return
     */
    int saveLable(List<ForumLableVo> list);

    /**
     * 获得全部标签（deflag为1的）
     * @param filter
     * @return
     */
    List<ForumLableVo> getAllLabel(QueryFilter filter);

    /**
     * 获取全部标签数量（条件无deflag）
     * @param filter
     * @return
     */
    int getAllLabelNoFlag(QueryFilter filter);

    /**
     * 查询不在线时被关注，收藏等的数量
     * @param filter
     * @return
     */
    int getNotOnlineCount(QueryFilter filter);

    int addNotOnlineData(QueryFilter filter);

    /**
     * 分享统计
     * @param queryFilter 通用参数
     * @return 成功数
     */
    int sharStatistics(QueryFilter queryFilter);

    /**
     * 查询发帖人信息
     * @param filter
     * @return
     */
    Map queryUser(QueryFilter filter);

    /**
     * 删除通知表中不在线信息
     */
    int delNoticMessage(QueryFilter filter);

    /**
     * 查询达人热帖
     * @param filter
     * @return
     */
    List<ForumTopicVo> queryHot(QueryFilter filter);

    /**
     * 获取最大帖子Id
     */
    int getMaxForumId();

    /**
     * 举报帖子和评论
     * @param filter 通用参数
     * @return 返回成功数
     */
    int reportTopicReply(QueryFilter filter);

    /**
     * 分页查询父级评论
     * @param filter
     * @return 分页集合
     */
    Pagination getParentReply(QueryFilter filter);

    /**
     * 论坛批量审核
     * @param filter
     * @return
     */
    void updTopicBatchAudit(QueryFilter filter);

    /**
     * 批量删除主题
     * @param filter
     * @return
     */
    void delTopicBatchAudit(QueryFilter filter);

    /**
     * 保存反馈意见
     * @param filter
     * @return
     */
    int saveFeedback(QueryFilter filter, MultipartFile[] files);

    /**
     * 获取所有反馈意见
     * @param filter
     * @return
     */
    Pagination getForumFeedBackList(QueryFilter filter);

    /**
     * 获取反馈建议详情
     * @param filter
     * @return
     */
    FeedBackVo getFeedbackDetails(QueryFilter filter);

    /**
     * 获得文件
     * @param filter
     * @return
     */
    RelationFileVo getFileById(QueryFilter filter);

    /**
     * 查询板块
     */
    Pagination getAllBelonged(QueryFilter filter);

    /**
     * 查询可能成为版主的用户
     * @param filter
     * @return
     */
    Pagination getModerator(QueryFilter filter);

    /**
     * 设置版主
     * @param filter
     * @return
     */
    int setModerator(QueryFilter filter);

    /**
     * 查看版主
     * @param filter
     * @return
     */
    Pagination viewModerator(QueryFilter filter);

    /**
     * 设置置顶
     * @param filter
     * @return
     */
    int setTop(QueryFilter filter);

    /**
     * 删除帖子
     * @param filter
     */
    void delForum(QueryFilter filter);

    /**
     * 查询字典表中有无字典内容
     * @param filter
     * @return
     */
    Map<String,Object> haseDicContent(QueryFilter filter);

    /**
     * 查询字典表中此人添加标签个数
     * @param filter
     * @return
     */
    int dicContentCount(QueryFilter filter);

    /**
     * 将标签添加进字典表
     * @param filter
     * @return
     */
    int insertLable(QueryFilter filter);

    /**
     * 查询最大字典值
     * @param filter
     * @return
     */
    int getMaxDicContent(QueryFilter filter);

    /**
     * 查询未审核帖子主题
     */
    List<String> noAuditForum();

    /**
     * 查询评论未审核数量及其所对应帖子
     * @param filter
     * @return
     */
    List<ForumTopicVo> noAuditReply(QueryFilter filter);

    /**
     * 获取是否审核
     */
    List<String> getIsApproval(QueryFilter filter);

}
