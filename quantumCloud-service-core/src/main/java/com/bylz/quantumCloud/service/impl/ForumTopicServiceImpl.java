/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import com.bylz.quantumCloud.model.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bylz.quantumCloud.service.ForumTopicService;
import com.bylz.quantumCloud.utils.DateUtils;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * 论坛主题实现类
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月19日
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ForumTopicServiceImpl extends BaseServiceImpl<ForumTopicVo, Long> implements ForumTopicService {

    @Autowired

    @Override
    public String getNamespace() {
        return ForumTopicVo.class.getSimpleName();
    }

    /**
     * 根据id获取论坛详情
     *
     * @param forumTopicParam 论坛参数
     * @return 论坛详情
     */
    @Override
    public ForumTopicVo getCommunityById(ForumTopicVo forumTopicParam,String ip) {
        QueryFilter filter = new QueryFilter();
        filter.put("id", forumTopicParam.getId());
        filter.put("ip",ip);
        if(forumTopicParam.getUserId() != 0) {
            filter.put("userId",forumTopicParam.getUserId());
        }
        //filter.put("userId", forumTopicParam.getUserId());
        ForumTopicVo forumTopicVo = this.findOne(filter).getReturnObj();
        String newReplyTime = null;
        if(forumTopicVo == null || forumTopicVo.getNewReplyTime() == null) {
            newReplyTime = "没有回复";
        }else {
            newReplyTime = DateUtils.calculateTime(forumTopicVo
                    .getNewReplyTime());
        }
        forumTopicVo.setNewReplyTime(newReplyTime);
        filter.setStatementKey("getBrowseDetail");
        int haveBrowse = this.findOne(filter).getReturnObj();//查询今天有无浏览记录
        if(haveBrowse == 0) {
            filter.setStatementKey("saveBrowseDetail");
            filter.put("type",3);
            filter.put("forumTopicId",forumTopicParam.getId());
            this.save(filter);
            filter.setStatementKey("updBrowseCount");
            this.update(filter);
        }
        return forumTopicVo;
    }

    /**
     * 添加论坛回复
     *
     * @param forumReplyVo 论坛回复参数
     * @return 成功数
     */
    @Transactional
    @Override
    public int addForumReply(ForumReplyVo forumReplyVo) {
        QueryFilter filter = new QueryFilter(forumReplyVo);
        filter.setStatementKey("addForumReply");
        //添加一条回复
        return this.save(filter).getReturnObj();
    }

    /**
     * 论坛主题审核
     *
     * @param forumTopicVo 论坛主题参数
     * @return 成功数
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int updTopicAudit(ForumTopicVo forumTopicVo) {
        QueryFilter filter = new QueryFilter(forumTopicVo);
        filter.setStatementKey("updTopicAudit");
        //修改论坛主题
        this.update(filter);
        updDicFlagById(filter,forumTopicVo);
        return 1;
    }

    /**
     * 获取论坛详情
     *
     * @param forumTopicParam 论坛主题参数
     * @return 论坛详情
     */
    @Override
    public ForumTopicVo forumTopicdetail(ForumTopicVo forumTopicParam) {
        QueryFilter filter = new QueryFilter();
        filter.put("id", forumTopicParam.getId());
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 获取回复详情集合
     *
     * @return 回复详情集合
     */
    @Override
    public Pagination forumReplyList(QueryFilter filter) {
        filter.setStatementKey("findReplyList");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 批量审核回复
     *
     * @param filter 通用参数
     * @return 成功数
     */
    @Override
    public int replyAuditAll(QueryFilter filter) {

        return this.update(filter).getReturnObj();
    }

    /**
     * 论坛主题赞、踩一下
     *
     * @param filter 通用参数
     * @return 成功数
     */
    @Transactional
    @Override
    public int updForumTopicLike(QueryFilter filter) {
        filter.setStatementKey("updForumTopicLike");
        //插入赞踩
        this.update(filter);
        filter.setStatementKey("saveForumTopicLike");
        this.save(filter);
        filter.setStatementKey("updTopicAudit");
        //修改论坛主题
        return this.update(filter).getReturnObj();
    }

    /**
     * 回复赞、踩一下
     *
     * @param filter 通用参数
     * @return 成功数
     */
    @Transactional
    @Override
    public int updReplyLike(QueryFilter filter) {
        filter.setStatementKey("updForumTopicLike");
        //插入赞踩
        this.update(filter);
        filter.setStatementKey("saveForumTopicLike");
        this.save(filter);
        filter.setStatementKey("updateReply");
        return this.update(filter).getReturnObj();
    }

    /**
     * 论坛收藏修改
     *
     * @param filter 通用参数
     * @return 成功数
     */
    @Override
    public int updCollect(QueryFilter filter) {
        filter.setStatementKey("updCollect");
        //修改收藏
        this.update(filter);
        filter.setStatementKey("saveCollect");
        //保存收藏
        return this.save(filter).getReturnObj();
    }
    /**
     * 删除回复
     * @param filter 通用参数
     * @return 成功数
     */
    @Override
    @Transactional
    public int delReply(QueryFilter filter) {
        filter.setStatementKey("delReply");
        if (Integer.parseInt(this.delete(filter).getReturnObj().toString())>0){
            filter.put("nextId","1");
            this.delete(filter).getReturnObj();
        }
        return 1;
    }

    /**
     * 批量删除回复
     * @param filter
     * @return
     */
    @Override
    @Transactional
    public int delBatchReply(QueryFilter filter) {
        filter.setStatementKey("delBatchReply");
        return this.delete(filter).getReturnObj();
    }

    /**
     * 添加/删除关注
     * @param filter
     * @return
     */
    @Override
    public int addOrDelFocus(QueryFilter filter) {
        if("1".equals(filter.get("flag"))) {//添加关注
            filter.setStatementKey("addFocus");
            return this.save(filter).getReturnObj();
        }else {//删除关注
            filter.setStatementKey("delFocus");
            return this.delete(filter).getReturnObj();
        }
    }

    /**
     * 插入不在线时数据记录表
     * @param filter
     * @return
     */
    public int addNotOnlineData(QueryFilter filter) {
        filter.setStatementKey("addNotOnlineData");
        return this.save(filter).getReturnObj();
    }

    /**
     * 保存标签
     * @param list
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveLable(List<ForumLableVo> list) {
        QueryFilter filter = new QueryFilter();
        filter.put("lableList",list);
        filter.setStatementKey("quotesCount");
        this.update(filter);
        filter.setStatementKey("saveLable");
        return this.save(filter).getReturnObj();
    }

    /**
     * 获得全部标签
     *
     * @param filter
     * @return
     */
    @Override
    public List<ForumLableVo> getAllLabel(QueryFilter filter) {
        filter.setStatementKey("getAllLabel");
        return this.findList(filter).getReturnObj();
    }

    /**
     * 获取全部标签数量（条件无deflag）
     *
     * @param filter
     * @return
     */
    @Override
    public int getAllLabelNoFlag(QueryFilter filter) {
        filter.setStatementKey("getAllLabelNoFlag");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 查询不在线时被关注，收藏等的数量
     * @param filter
     * @return
     */
    @Override
    public int getNotOnlineCount(QueryFilter filter) {
        filter.setStatementKey("getNotOnlineCount");
        return this.findOne(filter).getReturnObj();
    }


    /**
     * 分享统计
     * @param filter 通用参数
     * @return 成功数
     */
    @Override
    public int sharStatistics(QueryFilter filter) {
        filter.setStatementKey("updTopicAudit");
        //统计个数加一
        return this.update(filter).getReturnObj();
    }

    /**
     * 查询发帖人信息
     * @param filter
     * @return
     */
    @Override
    public Map queryUser(QueryFilter filter) {
        filter.setStatementKey("queryForumUser");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 删除通知表中不在线信息
     * @param filter
     * @return
     */
    @Override
    public int delNoticMessage(QueryFilter filter) {
        filter.setStatementKey("delNoticMessage");
        return this.delete(filter).getReturnObj();
    }

    /**
     * 查询达人热帖
     * @param filter
     * @return
     */
    @Override
    public List<ForumTopicVo> queryHot(QueryFilter filter) {
        filter.setStatementKey("queryHot");
        return this.findList(filter).getReturnObj();
    }

    @Override
    public int getMaxForumId() {
        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("getMaxForumId");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 举报帖子和评论
     * @param filter 通用参数
     * @return 返回成功数
     */
    @Override
    public int reportTopicReply(QueryFilter filter) {
        filter.setStatementKey("reportTopicReply");
        return this.save(filter).getReturnObj();
    }

    /**
     * 分页查询父级评论
     * @param filter
     * @return 分页集合
     */
    @Override
    public Pagination getParentReply(QueryFilter filter) {
        filter.setStatementKey("getParentReply");
        String [] pIds = filter.get("pIds").toString().split(",");
        filter.put("pIds",pIds);
        return this.findPager(filter).getReturnObj();
    }


    /**
     * 论坛主题批量审核
     *
     * @param filter
     * @return 成功数
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void updTopicBatchAudit(QueryFilter filter) {
        filter.setStatementKey("updTopicBatchAudit");
        //修改论坛主题
        this.update(filter).getReturnObj();
        updDicFlagById(filter,null);
    }

    /**
     * 论坛主题批量删除
     *
     * @param filter
     * @return 成功数
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void delTopicBatchAudit(QueryFilter filter) {
        filter.put("isDel","1");
        updDicFlagById(filter,null);
        //修改论坛主题
        filter.setStatementKey("delTopicBatchAudit");
        this.update(filter).getReturnObj();
    }

    /**
     * 保存反馈意见
     * @param filter
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveFeedback(QueryFilter filter,MultipartFile[] files) {
        String id = UUID.randomUUID().toString().replace("-", "");
        filter.put("id",id);
        filter.setStatementKey("saveFeedback");
        this.save(filter);
        try {
//            List<RelationFileVo> list = new ArrayList<>();
//            for(int i =0;i<files.length;i++) {
//                RelationFileVo relationFileVo = new RelationFileVo();
//                MultipartFile file = files[i];
//                relationFileVo.setFileId(UUID.randomUUID().toString().replace("-", ""));
//                relationFileVo.setRelationId(id);
//                relationFileVo.setBt(file.getBytes());
//                relationFileVo.setFileName(file.getOriginalFilename());
//                relationFileVo.setFileSize(file.getSize());
//                list.add(relationFileVo);
//            }
//            filter.put("fileList",list);
            if(files.length > 0 && files[0].getSize() > 0) {
                MultipartFile file = files[0];
                filter.put("fileId",UUID.randomUUID().toString().replace("-", ""));
                filter.put("bt",file.getBytes());
                filter.put("fileSize",file.getSize());
                filter.put("fileName",file.getOriginalFilename());
                filter.put("relationId",id);
                filter.setStatementKey("saveFeedbackFile");
                this.save(filter);
            }

            return 1;

        } catch (IOException e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return 0;
        }
    }

    /**
     * 获得所有反馈意见
     * @param filter
     * @return
     */
    @Override
    public Pagination getForumFeedBackList(QueryFilter filter) {
        filter.setStatementKey("getForumFeedBackList");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 获取反馈建议详情
     *
     * @param filter
     * @return
     */
    @Override
    public FeedBackVo getFeedbackDetails(QueryFilter filter) {
        filter.setStatementKey("getForumFeedBackList");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 获得文件
     *
     * @param filter
     * @return
     */
    @Override
    public RelationFileVo getFileById(QueryFilter filter) {
        filter.setStatementKey("getFileById");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 查询板块
     */
    @Override
    public Pagination getAllBelonged(QueryFilter filter) {
        filter.setStatementKey("getAllBelonged");
//        filter.put("dicName","Block");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 获得版块有成为版主可能的用户
     * @param filter
     * @return
     */
    @Override
    public Pagination getModerator(QueryFilter filter) {
        filter.setStatementKey("getModerator");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 设置版主
     *
     * @param filter
     * @return
     */
    @Override
    public int setModerator(QueryFilter filter) {
        filter.setStatementKey("delModerator");
        this.delete(filter);
        filter.setStatementKey("setSaveModerator");
        return this.save(filter).getReturnObj();
    }

    /**
     * 查看版主
     *
     * @param filter
     * @return
     */
    @Override
    public Pagination viewModerator(QueryFilter filter) {
        filter.setStatementKey("viewModerator");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 设置置顶
     *
     * @param filter
     * @return
     */
    @Override
    public int setTop(QueryFilter filter) {
        filter.setStatementKey("setTop");
        return this.update(filter).getReturnObj();
    }

    /**
     * 删除帖子
     *
     * @param filter
     */
    @Override
    public void delForum(QueryFilter filter) {
        filter.setStatementKey("delForum");
        this.delete(filter);//删除帖子
    }

    /**
     * 查询字典表中有无字典内容
     *
     * @param filter
     * @return
     */
    @Override
    public Map<String,Object> haseDicContent(QueryFilter filter) {
        filter.setStatementKey("haseDicContent");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 查询字典表中此人添加标签个数
     *
     * @param filter
     * @return
     */
    @Override
    public int dicContentCount(QueryFilter filter) {
        filter.setStatementKey("dicContentCount");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 将标签添加进字典表
     *
     * @param filter
     * @return
     */
    @Override
    public int insertLable(QueryFilter filter) {
        filter.setStatementKey("insertLable");
        return this.save(filter).getReturnObj();
    }

    /**
     * 查询最大字典值
     *
     * @param filter
     * @return
     */
    @Override
    public int getMaxDicContent(QueryFilter filter) {
        filter.setStatementKey("getMaxDicContent");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 查询未审核帖子主题
     */
    @Override
    public List<String> noAuditForum() {
        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("noAuditForum");
        return this.findList(filter).getReturnObj();
    }

    /**
     * 查询评论未审核数量及其所对应帖子
     *
     * @param filter
     * @return
     */
    @Override
    public List<ForumTopicVo> noAuditReply(QueryFilter filter) {
        filter.setStatementKey("noAuditReply");
        return this.findList(filter).getReturnObj();
    }

    /**
     * 修改标签标识
     * @param forumTopicVo
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updDicFlagById(QueryFilter filter,ForumTopicVo forumTopicVo) {
        //查询论坛帖子标签id
        if(filter.get("ids") == null) {//单个审核
            filter.put("ids",new long[]{forumTopicVo.getId()});
        }
        filter.setStatementKey("getDicFlagByFID");
        List<String> list = this.findList(filter).getReturnObj();
        filter.put("list",list);
        if(!CollectionUtils.isEmpty(list)) {
            if(filter.get("isDel") != null) {//删除
                filter.setStatementKey("delDicFlag");
                this.delete(filter);
            }else {
                filter.setStatementKey("updDicFlag");
                //修改字典表中标签标识
                this.update(filter);
            }
        }
    }

    /**
     * 获取是否审核
     *
     * @param filter
     */
    @Override
    public List<String> getIsApproval(QueryFilter filter) {
        filter.setStatementKey("getIsApproval");
        return this.findList(filter).getReturnObj();
    }
}
