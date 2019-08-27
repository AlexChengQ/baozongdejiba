package com.bylz.quantumCloud.education.api;
import com.bylz.quantumCloud.education.controller.BaseController;
import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.core.UpdateUserScore;
import com.bylz.quantumCloud.education.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.model.EduStatisticsVo;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.UserBonusVo;
import com.bylz.quantumCloud.service.EduStatisticsService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.service.UpdateUserScoreService;
import com.likegene.framework.core.QueryFilter;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:改变积分类
 * @since 2019/3/11
 */
@Controller
@RequestMapping("/api/UpdateUserScore")
public class UpdateUserScoreApiController extends BaseController {

    @Autowired
    private UpdateUserScoreService updateUserScoreService;

    @Autowired
    private QcodeUserService qcodeUserService;

    @Autowired
    private EduStatisticsService eduStatisticsService;

    /**
     * 兑换勋章
     * @return
     */
    @RequestMapping("/exchangeMedal.json")
    @ResponseBody
    public ResponseData exchangeMedal(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }


            if(map.get("type") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            int medal = Integer.parseInt(map.get("type").toString());

            if(!"1".equals(map.get("type").toString())) {
                medal = Integer.parseInt(map.get("type").toString()) - 1;

            }


            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());
            filter.put("medal",medal);
            filter.setStatementKey("getBonusInfo");
            UserBonusVo userBonusVo = updateUserScoreService.findOne(filter).getReturnObj();
            if(userBonusVo == null && !"1".equals(map.get("type").toString())) {
                data.setSuccess(false);
                data.setMessage("请先兑换前一个勋章");
                return data;
            }

            if(userBonusVo != null) {
                Method[] m = userBonusVo.getClass().getMethods();
                for(int i = 0;i < m.length;i++){
                    if(("getBadge"+map.get("type").toString()).toLowerCase().equals(m[i].getName().toLowerCase())){
                        int num = (int)m[i].invoke(userBonusVo);
                        if(num > 0) {
                            data.setMessage("每次只能兑换一个勋章");
                            data.setSuccess(false);
                            return data;
                        }
                        break;
                    }
                }
            }


            int deductionScore = updateUserScoreService.updateUserScoreByBonus(Integer.parseInt(map.get("type").toString()));
            if(userInfor.getScore() < Math.abs(deductionScore)) {
                data.setSuccess(false);
                data.setMessage("积分不够");
                return data;
            }else {
                qcodeUserService.updscore(deductionScore,userInfor.getId());//修改用户分数
                data = UpdateUserScore.minuserscore(userInfor,deductionScore,"兑换勋章扣除积分");
                if(data.isSuccess()) {
                    //修改或添加勋章表数据
                    int success = updateUserScoreService.exchangeMedal(Integer.parseInt(map.get("type").toString()),userInfor.getId(),Math.abs(deductionScore));
                    userInfor = qcodeUserService.getQcodeUser(userInfor);
                    userInfor.setSignIn(1);
                    //更改session信息
                    AppContextHolder.getSession().setAttribute(AppContextHolder.USER_INFO,userInfor);
                    return data;
                }
            }
            data.setSuccess(false);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            e.printStackTrace();
            return data;
        }

    }


    /**
     * 合成勋章
     * @return
     */
    @RequestMapping("/compoundBonus.json")
    @ResponseBody
    public ResponseData compoundBonus(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            boolean success = updateUserScoreService.compoundBonus(userInfor.getId());
            if(success) {
                return data;
            }else {
                data.setSuccess(false);
                return data;
            }

        }catch (Exception e) {
            data.setSuccess(false);
            e.printStackTrace();
            return data;
        }

    }


    /**
     * 签到
     * @return
     */
    @RequestMapping("/signIn.json")
    @ResponseBody
    public ResponseData signIn(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            //查询有无签到
            int hasSignIn = updateUserScoreService.hasSignIn(userInfor.getId(),1);
            if(hasSignIn > 0) {
                userInfor.setSignIn(1);
                data.setMessage("今日已签到");
                data.setSuccess(false);
                userInfor.setSignIn(hasSignIn);
                return data;
            }
            data = UpdateUserScore.adduserscore(userInfor,10,"签到获得积分");
            if(data.isSuccess()) {
                updateUserScoreService.saveBrowseDetail(userInfor.getId(),1);
                int hasStd = updateUserScoreService.hasSignIn(userInfor.getId(),2);
                if(hasStd == 0) {
                    UserBonusVo userBonusVo = updateUserScoreService.getUserBonusInfo(userInfor.getId());
                    if(userBonusVo != null) {
                        updateUserScoreService.updSignInfo(userInfor.getId());
                    }else {
                        updateUserScoreService.insertSignInfo(userInfor.getId());
                    }
                }
                userInfor.setSignIn(1);
                userInfor.setScore(userInfor.getScore()+10);
                AppContextHolder.getSession().setAttribute("USER_INFO",userInfor);

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

                return data;
            }

            return data;
        }catch (Exception e) {
            data.setSuccess(false);
            e.printStackTrace();
            return data;
        }
    }


    @RequestMapping("/getScoreTurnover.json")
    @ResponseBody
    public ResponseData getScoreTurnover(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage("LACK_OF_NECESSARY_PARAMETERS");
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(StringUtils.isBlank((String)map.get("type"))) {
                data.setSuccess(false);
                data.setMessage("LACK_OF_NECESSARY_PARAMETERS");
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());
            filter.put("type",map.get("type"));
            filter.setStatementKey("getScoreDetail");
            List<Map<String,Object>> list = updateUserScoreService.findList(filter).getReturnObj();
            data.setObj(list);

            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }
    }


    @RequestMapping("/addScoreByShare.json")
    @ResponseBody
    public ResponseData addScoreByShare(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage("LACK_OF_NECESSARY_PARAMETERS");
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if (StringUtils.isBlank((String) map.get("type"))) {
                data.setSuccess(false);
                data.setMessage("LACK_OF_NECESSARY_PARAMETERS");
                return data;
            }

            if(!"10".equals((String) map.get("type")) && !"11".equals((String) map.get("type"))) {
                data.setSuccess(false);
                data.setMessage("参数错误");
                return data;
            }

            String type = (String) map.get("type");

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

            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }
    }
}
