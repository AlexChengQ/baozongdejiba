package com.bylz.quantumCloud.education.controller;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.core.UpdateUserScore;
import com.bylz.quantumCloud.education.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.model.EduStatisticsVo;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.ScoreDetailVo;
import com.bylz.quantumCloud.model.UserBonusVo;
import com.bylz.quantumCloud.service.EduStatisticsService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.service.UpdateUserScoreService;
import com.likegene.framework.core.QueryFilter;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:改变积分类
 * @since 2019/3/11
 */
@Controller
@RequestMapping("/UpdateUserScore")
public class UpdateUserScoreController {

    @Autowired
    private UpdateUserScoreService updateUserScoreService;

    @Autowired
    private QcodeUserService qcodeUserService;

    @Autowired
    private EduStatisticsService eduStatisticsService;

    /**
     * 兑换勋章
     * @param type
     * @return
     */
    @RequestMapping("/exchangeMedal.json")
    public ResponseData exchangeMedal(int type) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        int deductionScore = updateUserScoreService.updateUserScoreByBonus(type);
        if(qcodeUser.getScore() < Math.abs(deductionScore)) {
            return new ResponseData.ResponseDataWarpper(false,"积分不够");
        }else {
            qcodeUserService.updscore(deductionScore,qcodeUser.getId());//修改用户分数
            ResponseData data = UpdateUserScore.minuserscore(qcodeUser,deductionScore,"兑换勋章扣除积分");
            if(data.isSuccess()) {
                //修改或添加勋章表数据
                int success = updateUserScoreService.exchangeMedal(type,qcodeUser.getId(),Math.abs(deductionScore));
                qcodeUser = qcodeUserService.getQcodeUser(qcodeUser);
                qcodeUser.setSignIn(1);
                //更改session信息
                AppContextHolder.getSession().setAttribute(AppContextHolder.USER_INFO,qcodeUser);
                return data.SUCCESS_NO_DATA;
            }
        }
        return ResponseData.FAILED_NO_DATA;
    }


    /**
     * 合成勋章
     * @return
     */
    @RequestMapping("/compoundBonus.json")
    @ResponseBody
    public ResponseData compoundBonus() {
        QcodeUser user = AppContextHolder.getCurrentUser();
        boolean success = updateUserScoreService.compoundBonus(user.getId());
        if(success) {
            return ResponseData.SUCCESS_NO_DATA;
        }else {
            return ResponseData.FAILED_NO_DATA;
        }
    }


    /**
     * 签到
     * @return
     */
    @RequestMapping("/signIn.json")
    @ResponseBody
    @Transactional
    public ResponseData signIn() {
        QcodeUser user = AppContextHolder.getCurrentUser();
        //查询有无签到
        int hasSignIn = updateUserScoreService.hasSignIn(user.getId(),1);
        if(hasSignIn > 0) {
            ResponseData responseData = new ResponseData(false,"今日已签到");
            user.setSignIn(hasSignIn);
            return responseData;
        }
        ResponseData responseData = UpdateUserScore.adduserscore(user,10,"签到获得积分");
        if(responseData.isSuccess()) {
            updateUserScoreService.saveBrowseDetail(user.getId(),1);
            int hasStd = updateUserScoreService.hasSignIn(user.getId(),2);
            if(hasStd == 0) {
                UserBonusVo userBonusVo = updateUserScoreService.getUserBonusInfo(user.getId());
                if(userBonusVo != null) {
                    updateUserScoreService.updSignInfo(user.getId());
                }else {
                    updateUserScoreService.insertSignInfo(user.getId());
                }
            }
            user.setSignIn(1);
            user.setScore(user.getScore()+10);
            AppContextHolder.getSession().setAttribute("USER_INFO",user);

            EduStatisticsVo eduStatisticsVo = eduStatisticsService.findOne(new QueryFilter()).getReturnObj();
            if(eduStatisticsVo != null) {
                eduStatisticsVo.setSignInCount(eduStatisticsVo.getSignInCount()+1);
                eduStatisticsService.update(eduStatisticsVo);
            }else {
                QueryFilter filter = new QueryFilter();
                filter.put("signInCount",1);
                filter.setStatementKey("addEduStatistics1");
                eduStatisticsService.save(filter);
            }


            return responseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }


    @RequestMapping("/addScoreByShare.json")
    @ResponseBody
    public ResponseData addScoreByShare(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor == null) {
            data.setSuccess(false);
            data.setMessage("key_does_not_exist");
            return data;
        }

        if (StringUtils.isBlank((String) request.getParameter("type"))) {
            data.setSuccess(false);
            data.setMessage("LACK_OF_NECESSARY_PARAMETERS");
            return data;
        }

        if(!"10".equals((String) request.getParameter("type")) && !"11".equals((String) request.getParameter("type"))) {
            data.setSuccess(false);
            data.setMessage("参数错误");
            return data;
        }

        String type = (String) request.getParameter("type");

        int count = updateUserScoreService.hasSignIn(userInfor.getId(),Integer.parseInt(type));//根据用户id和type查询用户分享次数

        int addScore = 0;
        String shareType = "";
        if("11".equals(type) && count > 2) {
            data.setSuccess(false);
            data.setMessage("超过分享次数，不予加分");
            return data;
        }


        if("10".equals(type)) {
            addScore = 10;
            shareType = "分享课程获得积分";

        }else if("11".equals(type)) {
            addScore = 50;
            shareType = "分享APP获得积分";
        }

        data = UpdateUserScore.adduserscore(userInfor,addScore,shareType);
        if(data.isSuccess()) {
            updateUserScoreService.saveBrowseDetail(userInfor.getId(),Integer.parseInt(type));
            return data;
        }
        userInfor.setScore(userInfor.getScore()+addScore);
        AppContextHolder.getSession().setAttribute(AppContextHolder.USER_INFO,userInfor);
        return data;
    }


    @RequestMapping("/saveVideoDetail.json")
    @ResponseBody
    public void saveVideoDetail(HttpServletRequest request) {
        String userIp = getIpAddress(request);
        String type = request.getParameter("type");
        String vid = request.getParameter("vid");
        QueryFilter filter = new QueryFilter();
        filter.put("ip",userIp);
        filter.put("type",type);
        filter.put("vid",vid);
        filter.setStatementKey("saveVideoStatis");
        updateUserScoreService.save(filter);
        if("1".equals(type)) {
            EduStatisticsVo eduStatisticsVo = eduStatisticsService.findOne(new QueryFilter()).getReturnObj();
            if(eduStatisticsVo != null) {
                eduStatisticsVo.setViewVideoCount(eduStatisticsVo.getViewVideoCount()+1);
                eduStatisticsService.update(eduStatisticsVo);
            }else {
                filter.clear();
                filter.put("viewVideoCount",1);
                filter.setStatementKey("addEduStatistics1");
                eduStatisticsService.save(filter);
            }
        }
    }


    public static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip.contains(",")) {
            return ip.split(",")[0];
        } else {
            return ip;
        }
    }
}
