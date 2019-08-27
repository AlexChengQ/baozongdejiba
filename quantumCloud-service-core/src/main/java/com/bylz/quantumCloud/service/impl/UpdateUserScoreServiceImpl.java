package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.ScoreDetailVo;
import com.bylz.quantumCloud.model.UserBonusVo;
import com.bylz.quantumCloud.service.UpdateUserScoreService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.util.SettingUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/11
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class UpdateUserScoreServiceImpl extends BaseServiceImpl<UserBonusVo, Long> implements UpdateUserScoreService {

    @Override
    public String getNamespace() {
        return UserBonusVo.class.getSimpleName();
    }

    /**
     * 兑换勋章所需分数
     *
     * @return
     */
    @Override
    public int updateUserScoreByBonus(int type) {
        int deductionScore = 0;
        switch (type) {
            case 1:
                deductionScore = -Integer.parseInt(SettingUtil.getSetting("moleculeMedal",String.class));
                break;

            case 2:
                deductionScore = -Integer.parseInt(SettingUtil.getSetting("atomMedal",String.class));
                break;

            case 3:
                deductionScore = -Integer.parseInt(SettingUtil.getSetting("neutronMedal",String.class));
                break;

            case 4:
                deductionScore = -Integer.parseInt(SettingUtil.getSetting("protonMedal",String.class));
                break;

            case 5:
                deductionScore = -Integer.parseInt(SettingUtil.getSetting("quarkMedal",String.class));
                break;
        }
        return deductionScore;
    }

    /**
     * 查询用户今天是否已经签到
     *
     * @param userId
     */
    @Override
    public int hasSignIn(long userId,int type) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.put("type",type);
        filter.setStatementKey("getBrowseDetail");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 添加用户签到
     *
     * @param userId
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveBrowseDetail(long userId,int type) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.put("type",type);
        filter.setStatementKey("saveBrowseDetail");
        return this.save(filter).getReturnObj();
    }

    /**
     * 兑换勋章
     * @param type
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int exchangeMedal(int type,long userId,int score) {
        QueryFilter filter = new QueryFilter();
        String errorParam = "";
        switch (type) {
            case 1:
                filter.put("badge1",1);
                break;

            case 2:
                filter.put("badge2",1);
                break;

            case 3:
                filter.put("badge3",1);
                break;

            case 4:
                filter.put("badge4",1);
                break;

            case 5:
                filter.put("badge5",1);
                break;

            case 6:
                filter.put("badge6",1);
                break;
            default:
                errorParam = "1000";
        }

        filter.put("userId",userId);
        filter.put("score",score);
        if(StringUtils.isNotBlank(errorParam)) {
            return 0;
        }
        filter.setStatementKey("getBonusInfo");
        UserBonusVo userBonusVo = this.findOne(filter).getReturnObj();
        if(userBonusVo != null) {
            filter.setStatementKey("updBonusInfo");
            return this.update(filter).getReturnObj();
        }else {
            filter.setStatementKey("addExchangeBonus");
            return this.save(filter).getReturnObj();
        }
    }

    /**
     * 合成勋章
     */
    @Override
    public boolean compoundBonus(long userId) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.setStatementKey("getBonusInfo");
        UserBonusVo userBonusVo = this.findOne(filter).getReturnObj();
        if(userBonusVo.getBadge1() == 0 || userBonusVo.getBadge2() == 0
                || userBonusVo.getBadge3() == 0 || userBonusVo.getBadge4() == 0
                || userBonusVo.getBadge5() == 0) {
            return false;
        }else {
            filter.setStatementKey("compoundBonus");
            int success = this.update(filter).getReturnObj();
            if(success == 1) {
                return true;
            }
        }
        return false;

    }

    /**
     * 修改积分明细
     *
     * @param
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int addScoreDetail(ScoreDetailVo scoreDetailVo) {
        QueryFilter filter = new QueryFilter(scoreDetailVo);
        filter.setStatementKey("addScoreDetails");
        return this.save(filter).getReturnObj();
    }

    /**
     * 查看勋章信息
     *
     * @param userId
     */
    @Override
    public UserBonusVo getUserBonusInfo(long userId) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.setStatementKey("getBonusInfo");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 添加签到信息
     *
     * @param userId
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int insertSignInfo(long userId) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.setStatementKey("insertSignInfo");
        return this.save(filter).getReturnObj();
    }

    /**
     * 修改签到信息
     *
     * @param userId
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int updSignInfo(long userId) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.setStatementKey("updSignInfo");
        return this.update(filter).getReturnObj();
    }


}
