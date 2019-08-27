package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.*;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/8
 */
public interface TutorialReviewService extends BaseService<TutorialReviewVo, Long> {

    /**
     * 获取回复详情集合
     * @param filter
     * @return  回复详情集合
     */
    Pagination forumReplyList(QueryFilter filter);

    /**
     * 添加论坛回复
     *
     * @param tutorialReviewVo 论坛回复参数
     * @return 成功数
     */
    int addForumReply(TutorialReviewVo tutorialReviewVo);

    /**
     * 分页查询父级评论
     * @param filter
     * @return 分页集合
     */
    Pagination getParentReply(QueryFilter filter);

    /**
     * 添加观看次数
     */
    VideoInfoVo addReadCount(long videoId);

    /**
     * 获取我的问题或回复
     * @param userId
     * @param flag 1：问题，2回复
     * @return
     */
    List<TutorialReviewVo> askAndanswer(long userId, String flag);


    /**
     * 查看观看次数
     */
//    VideoInfoVo getReadCount(long videoId);

    /**
     * 根据视频Id，回复id查询当前回复所在页码
     */
    int getPagerNumById(QueryFilter filter);

    /**
     * 保存反馈意见
     * @param filter
     * @return
     */
    int saveFeedback(QueryFilter filter, MultipartFile[] files);

    /**
     * 保存反馈意见
     * @param filter
     * @return
     */
    int saveFeedbackApi(QueryFilter filter);


    /**
     * 收藏
     * @param filter
     * @return
     */
    int saveCollect(QueryFilter filter);

    /**
     * 分页查询我的收藏
     * @param filter
     * @return
     */
    Pagination selectCollectList(QueryFilter filter);

    /**
     * 不分页查询
     * @param filter
     * @return
     */
    List<CollectVo> collectList(QueryFilter filter);

    /**
     * 根据用户id查询有无看过视频
     * @param filter
     * @return
     */
    UserVideo getUserVideo(QueryFilter filter);

    /**
     * 根据用户id查询有无答题
     * @param filter
     * @return
     */
    UserExam getUserExam(QueryFilter filter);

    int saveCertificate(QueryFilter filter,String[] examIdArrays,List<UserExam> list);

    /**
     * 举报评论
     * @param filter 通用参数
     * @return 返回成功数
     */
    int reportTopicReply(QueryFilter filter);
}
