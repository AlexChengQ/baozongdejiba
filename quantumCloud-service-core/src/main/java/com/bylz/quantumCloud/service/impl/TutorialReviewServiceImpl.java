package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.TutorialReviewService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/8
 */
@Service
public class TutorialReviewServiceImpl extends BaseServiceImpl<TutorialReviewVo, Long> implements TutorialReviewService {

    @Override
    public String getNamespace() {
        return TutorialReviewVo.class.getSimpleName();
    }

    /**
     * 获取回复详情集合
     *
     * @param filter
     * @return 回复详情集合
     */
    @Override
    public Pagination forumReplyList(QueryFilter filter) {
        filter.setStatementKey("findReplyList");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 添加论坛回复
     *
     * @param tutorialReviewVo 论坛回复参数
     * @return 成功数
     */
    @Override
    public int addForumReply(TutorialReviewVo tutorialReviewVo) {
        QueryFilter filter = new QueryFilter(tutorialReviewVo);
        filter.setStatementKey("addTutorialReply");
        //添加一条回复
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
     * 添加观看次数
     */
    @Override
    public VideoInfoVo addReadCount(long videoId) {
        QueryFilter filter = new QueryFilter();
        filter.put("videoId",videoId);
        filter.setStatementKey("getReadCount");
        VideoInfoVo videoInfoVo = this.findOne(filter).getReturnObj();
        if(videoInfoVo != null) {
            filter.setStatementKey("updReadCount");
            this.update(filter).getReturnObj();
        }else {
            filter.setStatementKey("addReadCount");
            this.save(filter).getReturnObj();
        }
        filter.setStatementKey("getReadCount");
        return this.findOne(filter).getReturnObj();
    }

    @Override
    public List<TutorialReviewVo> askAndanswer(long userId, String flag) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.put("flag",flag);
        filter.setStatementKey("askAndanswer");
        return this.findList(filter).getReturnObj();
    }

    /**
     * 根据视频Id，回复id查询当前回复所在页码
     *
     * @param filter
     */
    @Override
    public int getPagerNumById(QueryFilter filter) {
        filter.setStatementKey("getPagerNumById");
        return this.findOne(filter).getReturnObj();
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
        if(files.length != 0 && files[0].getSize() != 0) {
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
                MultipartFile file = files[0];
                filter.put("fileId",UUID.randomUUID().toString().replace("-", ""));
                filter.put("bt",file.getBytes());
                filter.put("fileSize",file.getSize());
                filter.put("fileName",file.getOriginalFilename());
                filter.put("relationId",id);
                filter.setStatementKey("saveFeedbackFile");
                this.save(filter);
                return 1;
            } catch (IOException e) {
                e.printStackTrace();
                logger.error(e.getMessage());
                return 0;
            }
        }
        return 1;
    }


    /**
     * 保存反馈意见
     * @param filter
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveFeedbackApi(QueryFilter filter) {
        String id = UUID.randomUUID().toString().replace("-", "");
        filter.put("id",id);
        filter.setStatementKey("saveFeedback");
        return this.save(filter).getReturnObj();
    }




    /**
     * 收藏
     *
     * @param filter
     * @return
     */
    @Override
    public int saveCollect(QueryFilter filter) {
        if(filter.get("isCollect") == null) {
            filter.setStatementKey("saveCollect");
            return this.save(filter).getReturnObj();
        }else if("1".equals(filter.get("isCollect").toString())) {
            filter.setStatementKey("saveCollect");
            return this.save(filter).getReturnObj();
        }else {
            filter.setStatementKey("delCollect");
            return this.delete(filter).getReturnObj();
        }
    }

    /**
     * 分页查询我的收藏
     *
     * @param filter
     * @return
     */
    @Override
    public Pagination selectCollectList(QueryFilter filter) {
        filter.setStatementKey("selectCollect");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 不分页查询
     *
     * @param filter
     * @return
     */
    @Override
    public List<CollectVo> collectList(QueryFilter filter) {
        filter.setStatementKey("selectCollect");
        return this.findList(filter).getReturnObj();
    }


    /**
     * 根据用户id查询有无看过视频
     *
     * @param filter
     * @return
     */
    @Override
    public UserVideo getUserVideo(QueryFilter filter) {
        filter.setStatementKey("getVideo");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 根据用户id查询有无答题
     *
     * @param filter
     * @return
     */
    @Override
    public UserExam getUserExam(QueryFilter filter) {
        filter.setStatementKey("getEaxm");
        return this.findOne(filter).getReturnObj();
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveCertificate(QueryFilter filter,String[] examIdArrays,List<UserExam> list) {
        Set<String> set = new HashSet<String>();
        boolean can = false;
        for(int i = 0;i < examIdArrays.length;i++) {
            for(int j = 0;j < list.size();j++) {
                int examId = list.get(j).getExamid();
                if(Integer.parseInt(examIdArrays[i]) == examId) {
                    set.add(examId+"");
                }
            }
        }

        if(examIdArrays.length != set.size() ) {
            return 0;
        }

        for(int i = 0; i < examIdArrays.length;i++) {
            if(set.contains(examIdArrays[i])) {
                can = true;
            }else {
                can = false;
                break;
            }
        }

        if(!can) {
            return 0;
        }

        for(UserExam exam:list) {
            String status = exam.getStatus();
            int allQuestion = status.replace("1","").lastIndexOf("|")+1;//共有多少题目
            String[] allAnswer = status.split("\\|");
            if(allAnswer.length != allQuestion) {
                return 0;
            }else {
                int flag = 1;
                for(int i = 0;i < allAnswer.length;i++) {
                    if("0".equals(allAnswer[i])) {
                        flag = 0;
                        break;
                    }
                }

                if(flag == 0) {
                    return 0;
                }
            }
        }
        filter.setStatementKey("saveCertificate");
        return this.save(filter).getReturnObj();
    }

    /**
     * 举报评论
     * @param filter 通用参数
     * @return 返回成功数
     */
    @Override
    public int reportTopicReply(QueryFilter filter) {
        filter.setStatementKey("reportTopicReply");
        return this.save(filter).getReturnObj();
    }
}
