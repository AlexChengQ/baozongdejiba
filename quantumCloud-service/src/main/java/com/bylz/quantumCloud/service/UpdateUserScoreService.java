package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.ScoreDetailVo;
import com.bylz.quantumCloud.model.UserBonusVo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.QueryFilter;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/11
 */
public interface UpdateUserScoreService  extends BaseService<UserBonusVo, Long> {


    /**
     * 兑换勋章所需分数
     * @return
     */
    int updateUserScoreByBonus(int type);

    /**
     * 查询用户今天是否已经签到
     */
    int hasSignIn(long userId,int type);

    /**
     * 添加用户签到
     */
    int saveBrowseDetail(long userId,int type);

    /**
     * 兑换勋章
     * @param type 勋章种类
     * @param userId
     * @return
     */
    int exchangeMedal(int type,long userId,int score);

    /**
     * 合成勋章
     */
    boolean compoundBonus(long userId);

    /**
     * 修改积分明细
     */
    int addScoreDetail(ScoreDetailVo scoreDetailVo);

    /**
     * 查看签到信息
     */
    UserBonusVo getUserBonusInfo(long userId);

    /**
     * 添加签到信息
     */
    int insertSignInfo(long userId);

    /**
     * 修改签到信息
     */
    int updSignInfo(long userId);

}
