package com.bylz.quantumCloud.education.controller;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.wechat.WeChatUtils;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;


/**
 * QCode Controller
 */
@Controller
@RequestMapping("/")
public class EduController extends BaseController {


    @Autowired
    private UserVideoService uservideoservice;


    @Autowired
    private UserExamService userexamservice;


    @Autowired
    private ExamQuestionSetService examqusetionsetservice;


    @Autowired
    private QcodeUserService qcodeuserservice;


    @Autowired
    private UpdateUserScoreService updateUserScoreService;


    @Autowired
    private VideoInfoService videoInfoService;

    @Autowired
    private ReadBookService readBookService;

    /**
     * 首页重定向
     *
     * @return 2017-7-20 JT
     * @author songhaozhang
     */
    @RequestMapping(value = "/")
    public String homePage() {

        return "redirect:/EDU/index.html";
    }


    /**
     * 教育首页
     *
     * @return 2017-7-20 JT
     * @author songhaozhang
     */
    @RequestMapping(value = "EDU/index.html")
    public String login(ModelMap model, HttpServletRequest request) {
        String forward = request.getParameter("forward");
        if (forward != null && !"".equals(forward)) {
            model.put("forward", forward);
        }
        model.put("weChatLogin", WeChatUtils.getStartURLToGetCode());
        return "tutorial/index";
    }

    /**
     * 查询用户视频情况
     * return vid,examid
     *
     * @author songhaozhang
     * @since 2019-1-9
     */
    @RequestMapping(value = "education/getvideoinfo.json")
    @ResponseBody
    public ResponseData getvideoinfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            //获取視頻userid           
            String userid = (String) map.get("userid");
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectuservideo");
            filter.put("userid", userid);
            //获取任务类型
            ArrayList<UserVideo> uservideo = new ArrayList<UserVideo>();
            uservideo = uservideoservice.findList(filter).getReturnObj();

            data.setSuccess(true);
            data.setObj(uservideo);
            return data;
        } catch (Exception e) {
            logger.error("error:education/getvideoinfo.json" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 查询视频情况
     * return vid,examid
     *
     * @author songhaozhang
     * @since 2019-4-19
     */
    @RequestMapping(value = "education/videoinfo.json")
    @ResponseBody
    public ResponseData videoinfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            QcodeUser user = AppContextHolder.getCurrentUser();
            QueryFilter filter = new QueryFilter();
            if (user != null) {
                filter.put("userId", user.getId());
                filter.put("userid", user.getId());
            }

            filter.setStatementKey("selectuservideo");
            List<UserVideo> userVideoList = uservideoservice.findList(filter).getReturnObj();//用户视频列表

            filter.setStatementKey("selectuservideoinfo");
            List<LinkedHashMap> list = videoInfoService.findList(filter).getReturnObj();//所有视频
            filter.setStatementKey("selectuserexam");
            List<UserExam> userExamList = userexamservice.findList(filter).getReturnObj();//用户答题情况列表
            filter.setStatementKey("getNotStdVideo");
            List<LinkedHashMap> notStdVideoList = videoInfoService.findList(filter).getReturnObj();//用户未学习的视频（未看视频且没有答题）
            filter.setStatementKey("getNotExamVideo");
            List<LinkedHashMap> notExamVideoList = videoInfoService.findList(filter).getReturnObj();//没有题目的视频
            filter.setStatementKey("hasExamNotDoVideo");
            List<LinkedHashMap> hasExamNotDoVideoList = videoInfoService.findList(filter).getReturnObj();//有题目的视频但没有做题目的视频列表
            List<LinkedHashMap> finishList = new ArrayList<>();//看完视频的视频列表
            List<LinkedHashMap> startUnfinishedList = new ArrayList<>();//看过但未看完的视频列表
            List<UserExam> examFinishList = new ArrayList<>();//所有回答对且回答完的题目列表
            List<UserExam> examNoFinishList = new ArrayList<>();//未回答对或未回答完的题目
            List<LinkedHashMap> stdFinishList = new ArrayList<>();//已学完视频列表
            List<LinkedHashMap> stdNotFinishList = new ArrayList<>();//学习中视频列表

            System.out.println("--------------------所有回答对且回答完的题目------------------------");

            //所有回答对且回答完的题目
            for (UserExam userExam : userExamList) {
                String status = userExam.getStatus();
                String t = status;
                int allQuestion = t.replace("1", "").lastIndexOf("|") + 1;//共有多少题目
                String[] allAnswer = status.split("\\|");
                if (allAnswer.length != allQuestion) {
                    examNoFinishList.add(userExam);
                    continue;
                } else {
                    for (int i = 0; i < allAnswer.length; i++) {
                        if ("0".equals(allAnswer[i])) {
                            examNoFinishList.add(userExam);
                            break;
                        }

                        examFinishList.add(userExam);
                        break;
                    }

                }
            }

            System.out.println("--------------------处理看完和未看完的视频------------------------");

            //处理看完和未看完的视频
            for (UserVideo userVideo : userVideoList) {
                int addScoreFlag = userVideo.getAddscore();
                String userVid = String.valueOf(userVideo.getVid());
                for (Map map : list) {
                    String vid = map.get("vid").toString();
                    if (userVid.equals(vid)) {
                        if (addScoreFlag == 1) {
                            map.put("myTime", userVideo.getProgress());
                            finishList.add((LinkedHashMap) map);
                            break;
                        } else {
                            map.put("myTime", userVideo.getProgress());
                            startUnfinishedList.add((LinkedHashMap) map);
                            break;
                        }

                    }
                }
            }

            System.out.println("--------------------看完的视频------------------------");

            //看完的视频
            for (Map map : finishList) {
                String vid = map.get("vid").toString();
                //做完题目看完视频（有题目的视频）----已学完
                for (UserExam userExam : examFinishList) {
                    StringBuffer evid = new StringBuffer();
                    evid.append(userExam.getBlockid());
                    evid.append(userExam.getExamid());
                    String examVid = evid.toString();
                    if (vid.equals(examVid)) {
                        map.put("stdStatus", 1);
                        stdFinishList.add((LinkedHashMap) map);
                        break;
                    }
                }



                //看完视频(无题目的视频) ----已学完
                for (Map notExamMap : notExamVideoList) {
                    String notExamVid = notExamMap.get("vid").toString();
                    if (vid.equals(notExamVid)) {
                        map.put("stdStatus", 1);
                        stdFinishList.add((LinkedHashMap) map);
                        break;
                    }
                }


            }

            //未学习
            for (Map map : notStdVideoList) {
                map.put("stdStatus", -1);
            }

            System.out.println("--------------------學習中視頻------------------------");

            //學習中視頻
            stdNotFinishList = new ArrayList<>(list);

            for(Map stdFinishMap : stdFinishList) {
                String finishVid = stdFinishMap.get("vid").toString();
                for(Map map : list) {
                    String vid = map.get("vid").toString();
                    if(vid.equals(finishVid)) {
                        stdNotFinishList.remove(map);
                        break;
                    }
                }
            }


            for(Map notStdMap : notStdVideoList) {
                String notStdVid = notStdMap.get("vid").toString();
                for(Map map : list) {
                    String vid = map.get("vid").toString();
                    if(vid.equals(notStdVid)) {
                        stdNotFinishList.remove(map);
                        break;
                    }
                }
            }


            System.out.println("--------------------处理學習中視頻------------------------");
            for (Map map : stdNotFinishList) {
                map.put("stdStatus",0);
                String[] videoTimes = map.get("videoTime").toString().split(":");
                String myTime = map.get("myTime") == null?null:map.get("myTime").toString();
                if(StringUtils.isBlank(myTime)) {
                    map.put("stdScale",0);
                    continue;
                }
                String[] myTimes = map.get("myTime").toString().split(":");
                double allTime = Integer.parseInt(videoTimes[0]) * 3600 + Integer.parseInt(videoTimes[1]) * 60 + Integer.parseInt(videoTimes[2]);
                double my = Integer.parseInt(myTimes[0]) * 3600 + Integer.parseInt(myTimes[1]) * 60 + Integer.parseInt(myTimes[2]);
                double stdScale = (my / allTime) * 100;
                map.put("stdScale", stdScale);

            }

            System.out.println("--------------------处理完學習中視頻------------------------");
            list.clear();
            list.addAll(stdFinishList);
            list.addAll(notStdVideoList);
            list.addAll(stdNotFinishList);
            data.setObj(list);
            return data;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error:education/videoinfo.json" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 个人中心
     */
    @RequestMapping(value = "EDU/personal.html")
    public String personal() {
        return "tutorial/personal";
    }

    /**
     * 学习页面获取
     */
    @RequestMapping(value = "EDU/quantumLearning.html")
    public String Learning() {
        return "tutorial/quantumLearning";
    }

    /**
     * 分享页面获取
     */
    @RequestMapping(value = "EDU/Share/Wechat/{req}")
    public String share(ModelMap model, HttpServletRequest request, @PathVariable("req") String req) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId", req);
        filter.setStatementKey("getBonusInfo");
        UserBonusVo userBonusVo = qcodeuserservice.findOne(filter).getReturnObj();
        if (userBonusVo == null) {
            model.put("studytime", 0);
        } else {
            model.put("studytime", userBonusVo.getStdTime());
        }
        filter.setStatementKey("selectList");
        filter.put("id", req);
        QcodeUser qcodeuser = new QcodeUser();
        qcodeuser = qcodeuserservice.findOne(filter).getReturnObj();
        model.put("USER_INFO", qcodeuser);

        filter.setStatementKey("selectlevel");
        model.put("level", qcodeuserservice.findOne(filter).getReturnObj());

        return "tutorial/shareVideo";
    }

    /**
     * 分享页面获取
     */
    @RequestMapping(value = "EDU/Share/Bonus/{userId}")
    public String shareBonus(ModelMap model, HttpServletRequest request, @PathVariable("userId") String userId) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId", userId);
        filter.setStatementKey("getBonusInfo");
        UserBonusVo userBonusVo = qcodeuserservice.findOne(filter).getReturnObj();
        int bonusNum = 0;
        if (userBonusVo != null) {
            bonusNum = userBonusVo.getBadge1() + userBonusVo.getBadge2() + userBonusVo.getBadge3() + userBonusVo.getBadge4() + userBonusVo.getBadge5();
        }
        filter.put("id", userId);
        filter.setStatementKey("selectList");
        QcodeUser user = qcodeuserservice.findOne(filter).getReturnObj();
        if (user != null) {
            model.put("userName", user.getName());
        } else {
            model.put("userName", "游客");
        }
        model.put("bonusNum", bonusNum);


        return "tutorial/bonusShare";
    }


    /**
     * dashboard页面获取
     */
    @RequestMapping(value = "EDU/dashboard.html")
    public String dashboard() {
        return "tutorial/dashboard";
    }

    /**
     * 编程大赛页面获取
     */
    @RequestMapping(value = "EDU/competition.html")
    public String competition(Model model) {
        return "tutorial/competition";
    }

    /**
     * 编程大赛报名页面获取
     */
    @RequestMapping(value = "EDU/signUp.html")
    public String signUp(Model model) {
        QcodeUser user = AppContextHolder.getCurrentUser();
        if (user != null && null != user.getEmail()) {
            model.addAttribute("email", user.getEmail());
        }
        return "tutorial/signUp";
    }

    /**
     * 视频播放页面获取
     */
    @RequestMapping(value = "EDU/video.html")
    public String Video() {
        return "tutorial/quantumVideo";
    }

    /**
     * 教程页面获取
     */
    @RequestMapping(value = "EDU/library.html")
    public String library() {
        return "quantumCloud/library";
    }

    /**
     * 推荐阅读
     */
    @RequestMapping(value = "EDU/Reading.html")
    public String Reading(Model model) {
        QueryFilter filter = new QueryFilter();
        filter.put("type", "0");
        List<ReadBook> bookList = readBookService.findList(filter).getReturnObj();
        for (ReadBook readBook : bookList) {
            String author = readBook.getAuthor();
            List<String> authorList = Arrays.asList(author.split(","));
            readBook.setAuthorList(authorList);
        }
        model.addAttribute("bookList", bookList);
        return "quantumCloud/Reading";
    }


    /**
     * 推荐阅读
     */
    @RequestMapping(value = "EDU/Reading.json")
    @ResponseBody
    public ResponseData Reading(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        QueryFilter filter = new QueryFilter(request);
        List<ReadBook> bookList = readBookService.findList(filter).getReturnObj();
        for (ReadBook readBook : bookList) {
            String author = readBook.getAuthor();
            List<String> authorList = Arrays.asList(author.split(","));
            readBook.setAuthorList(authorList);
        }
        data.setObj(bookList);
        return data;
    }


    /**
     * 增加用户视频情况
     * return data success
     *
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "education/updvideoinfo.json")
    @ResponseBody
    public ResponseData updvideoinfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            //获取視頻userid           
            Long userid = Long.valueOf((String) map.get("userid"));
            int id = Integer.parseInt((String) map.get("id"));
            int hasSignIn = updateUserScoreService.hasSignIn(userid, 1);//有无签到记录

            //添加学习时间
            if (hasSignIn == 0) {//如果有签到记录，即学习时间已经加了一天，逻辑跳过。没有记录，判断是否有学习记录，有，逻辑跳过，没有，插入记录，添加学习时间
                int hasStd = updateUserScoreService.hasSignIn(userid, 2);
                if (hasStd == 0) {
                    updateUserScoreService.saveBrowseDetail(userid, 2);
                    UserBonusVo userBonusVo = updateUserScoreService.getUserBonusInfo(userid);
                    if (userBonusVo == null) {
                        updateUserScoreService.insertSignInfo(userid);
                    } else {
                        updateUserScoreService.updSignInfo(userid);
                    }
                }
            }

            //获取视频是否加分标记,0代表不增加，1增加
            boolean addscoreflag = Boolean.valueOf((String) map.get("addscoreflag"));
            String title = (String) map.get("title");
            String progress = (String) map.get("progress");
            QueryFilter filter = new QueryFilter();
            filter.put("vid", id);
            filter.put("userid", userid);
            filter.setStatementKey("selectvideo");
            //获取任务类型
            UserVideo uv = uservideoservice.findOne(filter).getReturnObj();
            QcodeUser qcodeuser = AppContextHolder.getCurrentUser();
            //无相关记录，需要插入新纪录
            if (uv == null || uv.getUserid() == 0) {
                UserVideo userVideo = new UserVideo();
                userVideo.setVid(id);
                userVideo.setUserid(userid);
                userVideo.setTitle(title);
                userVideo.setProgress(progress);
                logger.debug("userVideo." + userVideo.getProgress());
                Result r = uservideoservice.save(userVideo);
                if (r.isSuccess()) {
                    //看完视频增加分数
                    if (addscoreflag) {
                        QueryFilter updatescore = new QueryFilter();
                        updatescore.setStatementKey("updscore");
                        updatescore.put("score", 10);
                        updatescore.put("userid", userid);
                        if (!qcodeuserservice.update(updatescore).isSuccess()) {
                            logger.error("插入数据失败");
                            data.setMessage(getMessage("INSERT USER VIDEO INFO FAIL"));
                            return data;
                        } else {
                            QueryFilter upv = new QueryFilter();
                            upv.put("vid", id);
                            upv.put("userid", userid);
                            upv.put("addscore", 1);
                            upv.setStatementKey("UpdUserVideo");
                            uservideoservice.update(upv);
                            String memo = "video-addscore-save-" + id;
                            logger.info(memo);
                            ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeuser, 10, 0, memo);
                            QueryFilter filter1 = new QueryFilter(scoreDetailVo);
                            filter1.setStatementKey("addScoreDetails");
                            Result rs = updateUserScoreService.save(filter1);
                            if (!rs.isSuccess()) {
                                data.setSuccess(false);
                                return data;
                            }
                            logger.info("save score detail score is{}", 10);
                            qcodeuser.setScore(qcodeuser.getScore() + 10);
                        }

                    }
                    AppContextHolder.getSession().setAttribute("USER_INFO", qcodeuser);
                    data.setSuccess(true);
                    return data;
                } else {
                    logger.error("插入数据失败");
                    data.setSuccess(false);
                    data.setMessage(getMessage("INSERT USER VIDEO INFO FAIL"));
                    return data;
                }
            } else {
                //有相关记录，更新数据库
                UserVideo userVideo = new UserVideo();
                userVideo.setVid(id);
                userVideo.setUserid(userid);
                userVideo.setTitle(title);
                userVideo.setProgress(progress);
                logger.debug("userVideo." + userVideo.getProgress());
                QueryFilter update = new QueryFilter();
                update.put("userid", userVideo.getUserid());
                update.put("title", userVideo.getTitle());
                update.put("vid", id);
                update.put("progress", progress);
                update.setStatementKey("UpdUserVideo");
                Result result = uservideoservice.update(update);
                if (result.isSuccess()) {
                    //看完视频增加分数
                    if (addscoreflag) {
                        if (uv.getAddscore() == 0) {
                            QueryFilter updatescore = new QueryFilter();
                            updatescore.setStatementKey("updscore");
                            updatescore.put("score", 10);
                            updatescore.put("userid", userVideo.getUserid());
                            Result result1 = qcodeuserservice.update(updatescore);
                            //更新addscore状态
                            QueryFilter upv = new QueryFilter();
                            upv.put("vid", id);
                            upv.put("userid", userid);
                            upv.put("addscore", 1);
                            upv.setStatementKey("UpdUserVideo");
                            uservideoservice.update(upv);
                            if (!result1.isSuccess()) {
                                logger.error("更新数据失败");
                                data.setMessage(getMessage("UPDATE USER VIDEO INFO FAIL"));
                                return data;
                            } else {
                                //记录加分流水
                                String memo = "video-addscore-save-" + id;
                                logger.info(memo);
                                ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeuser, 10, 0, memo);
                                QueryFilter filter1 = new QueryFilter(scoreDetailVo);
                                filter1.setStatementKey("addScoreDetails");
                                Result rs = updateUserScoreService.save(filter1);
                                if (!rs.isSuccess()) {
                                    data.setSuccess(false);
                                    return data;
                                }
                                logger.info("save score detail score is{}", 10);
                                qcodeuser.setScore(qcodeuser.getScore() + 10);
                            }
                        }
                    }
                    AppContextHolder.getSession().setAttribute("USER_INFO", qcodeuser);
                    data.setSuccess(true);
                    return data;
                } else {
                    logger.error("更新数据失败");
                    data.setSuccess(false);
                    data.setMessage(getMessage("UPDATE USER VIDEO INFO FAIL"));
                    return data;
                }

            }

        } catch (Exception e) {
            logger.error("error:education/updvideoinfo.json " + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 更新用户考试与试题情况
     * return vid,examid
     *
     * @param
     * @since 2018-1-9
     */
    @RequestMapping(value = "education/updexaminfo.json")
    @ResponseBody
    public ResponseData updexaminfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            //获取視頻userid           
            int examid = Integer.parseInt((String) map.get("examid"));
            Long userid = Long.valueOf((String) map.get("userid"));

            int hasSignIn = updateUserScoreService.hasSignIn(userid, 1);//有无签到记录

            //添加学习时间
            if (hasSignIn == 0) {//如果有签到记录，即学习时间已经加了一天，逻辑跳过。没有记录，判断是否有学习记录，有，逻辑跳过，没有，插入记录，添加学习时间
                int hasStd = updateUserScoreService.hasSignIn(userid, 2);
                if (hasStd == 0) {
                    updateUserScoreService.saveBrowseDetail(userid, 2);
                    UserBonusVo userBonusVo = updateUserScoreService.getUserBonusInfo(userid);
                    if (userBonusVo == null) {
                        updateUserScoreService.insertSignInfo(userid);
                    } else {
                        updateUserScoreService.updSignInfo(userid);
                    }
                }
            }


            boolean addscoreflag = Boolean.valueOf((String) map.get("addscoreflag"));
            String status = (String) map.get("status");
            int blockid = Integer.parseInt((String) map.get("blockid"));
            //查询该记录是否存在
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectexamexist");
            filter.put("userid", userid);
            filter.put("examid", examid);
            filter.put("blockid", blockid);
            //获取任务类型
            UserExam ue = userexamservice.findOne(filter).getReturnObj();
            System.out.println(ue.getUserid().toString());
            QcodeUser qcodeuser = AppContextHolder.getCurrentUser();
            //无相关记录，需要插入新纪录
            if (ue.getUserid().toString().isEmpty() || ue.getUserid().toString().equals("0")) {
                QueryFilter upduexam = new QueryFilter();
                System.out.println("record is null");
                upduexam.put("examid", examid);
                upduexam.put("userid", userid);
                upduexam.put("status", status);
                upduexam.put("blockid", blockid);
                UserExam ue2 = new UserExam();
                ue2.setExamid(examid);
                ue2.setStatus(status);
                ue2.setUserid(userid);
                ue2.setBlockid(blockid);
                Result result = userexamservice.save(upduexam);
                if (result.isSuccess()) {
                    //判读是否增加分数,不相等增加分数
                    if (addscoreflag) {
                        int score = compare(status, "");
                        QueryFilter updatescore = new QueryFilter();
                        updatescore.setStatementKey("updscore");
                        updatescore.put("score", score * 20);
                        updatescore.put("userid", qcodeuser.getId());
                        qcodeuserservice.update(updatescore);
                        String memo = "examuppdate-save-" + examid;
                        logger.info(memo);
                        ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeuser, score * 20, 0, memo);
                        //分數为0，不记录流水
                        if (score * 20 != 0) {
                            QueryFilter filter1 = new QueryFilter(scoreDetailVo);
                            filter1.setStatementKey("addScoreDetails");
                            Result rs = updateUserScoreService.save(filter1);
                            if (!rs.isSuccess()) {
                                data.setSuccess(false);
                                return data;
                            }

                        }
                        logger.info("save score detail score is{}", score * 20);
                        qcodeuser.setScore(qcodeuser.getScore() + score * 20);
                        data.setObj(score * 20);
                    }

                    AppContextHolder.getSession().setAttribute("USER_INFO", qcodeuser);
                    return data;
                } else {
                    logger.error("更新数据失败");
                    data.setSuccess(false);
                    data.setMessage(getMessage("UPDATE USER VIDEO INFO FAIL"));
                    return data;
                }

            } else {
                //有相关记录，更新数据库
                QueryFilter upduexam = new QueryFilter();
                upduexam.put("examid", examid);
                upduexam.put("userid", userid);
                upduexam.put("status", status);
                upduexam.put("blockid", blockid);
                upduexam.setStatementKey("UpdUserExam");
                Result result = userexamservice.update(upduexam);
                if (result.isSuccess()) {
                    if (addscoreflag) {

                        QueryFilter updatescore = new QueryFilter();
                        updatescore.setStatementKey("updscore");
                        int score = compare(status, ue.getStatus());
                        updatescore.setStatementKey("updscore");
                        updatescore.put("score", score * 20);
                        updatescore.put("userid", qcodeuser.getId());
                        qcodeuserservice.update(updatescore);
                        String memo = "examuppdate-" + examid;
                        logger.info(memo);
                        ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeuser, score * 20, 0, memo);
                        if (score * 20 != 0) {
                            QueryFilter filter1 = new QueryFilter(scoreDetailVo);
                            filter1.setStatementKey("addScoreDetails");
                            Result rs = updateUserScoreService.save(filter1);
                            if (!rs.isSuccess()) {
                                data.setMessage("save score detail is false");
                                data.setSuccess(false);
                                return data;

                            }
                        }
                        logger.info("save score detail score is{}", score * 20);
                        qcodeuser.setScore(qcodeuser.getScore() + score * 20);
                        data.setObj(score * 20);
                    }
                    AppContextHolder.getSession().setAttribute("USER_INFO", qcodeuser);
                    data.setSuccess(true);
                    return data;
                } else {
                    logger.error("更新数据失败");
                    data.setSuccess(false);
                    data.setMessage(getMessage("UPDATE USER VIDEO INFO FAIL"));
                    return data;
                }

            }
        } catch (Exception e) {
            logger.error("error:education/updexaminfo.json" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 获取问题
     * request : questionid , blockid , examid
     *
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "education/examinfo.json")
    @ResponseBody
    public ResponseData examinfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            //获取参数           
            int examid = Integer.parseInt((String) map.get("examid"));
            int questionid = Integer.parseInt((String) map.get("questionid"));
            int blockid = Integer.parseInt((String) map.get("blockid"));
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectQuestion");
            filter.put("questionid", questionid);
            filter.put("examid", examid);
            filter.put("blockid", blockid);
            data.setSuccess(true);
            data.setObj(examqusetionsetservice.findOne(filter).getReturnObj());
            return data;
        } catch (Exception e) {
            logger.error("接口（api/QCode/queryTask.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 获取问题
     * request : questionid , blockid , examid
     *
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "education/allexaminfo.json")
    @ResponseBody
    public ResponseData allexaminfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            //获取参数                	
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectAllQuestion");
            ArrayList<ExamQuestionSet> eqs = new ArrayList<ExamQuestionSet>();
            eqs = examqusetionsetservice.findList(filter).getReturnObj();
            System.out.println(eqs.get(0).getBlockid() + " " + eqs.get(0).getQuestionid());
            data.setObj(examqusetionsetservice.findList(filter).getReturnObj());
            data.setSuccess(true);
            return data;
        } catch (Exception e) {
            logger.error("education/allexaminfo.json" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("service false"));
            return data;
        }
    }


    /**
     * 获取问题
     * request : questionid , blockid , examid
     *
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "education/uexaminfobyid.json")
    @ResponseBody
    public ResponseData uexaminfobyid(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            //获取参数 
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("uexambyid");
            int userid = Integer.parseInt((String) map.get("userid"));
            int examid = Integer.parseInt((String) map.get("examid"));
            int blockid = Integer.parseInt((String) map.get("blockid"));
            filter.put("userid", userid);
            filter.put("examid", examid);
            filter.put("blockid", blockid);
            UserExam a = new UserExam();
            a = userexamservice.findOne(filter).getReturnObj();

            boolean unlock = false;
            if (a != null) {
                unlock = unlock(a.getStatus());
            }
            data.setObj(unlock);
            data.setSuccess(true);
            return data;
        } catch (Exception e) {
            logger.error("education/uexaminfobyid.json" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("service false"));
            return data;
        }
    }


    /**
     * 获取用户答题情况
     * request : questionid , blockid , examid
     *
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "education/userexaminfo.json")
    @ResponseBody
    public ResponseData userexaminfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            //获取参数           
            int userid = Integer.parseInt((String) map.get("userid"));
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectuserexam");
            filter.put("userid", userid);
            data.setSuccess(true);
            ArrayList<UserExam> a = new ArrayList<UserExam>();
            data.setObj(userexamservice.findList(filter).getReturnObj());
            return data;
        } catch (Exception e) {
            logger.error("接口（api/QCode/queryTask.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 获取答案
     * request : questionid , blockid , examid
     *
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "education/examAnswerInfo.json")
    @ResponseBody
    public ResponseData examAnswerInfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            //获取参数           
            int examid = Integer.parseInt(map.get("examid").toString());
            int questionid = Integer.parseInt((String) map.get("questionid"));
            int blockid = Integer.parseInt((String) map.get("blockid"));
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectAnswer");
            filter.put("questionid", questionid);
            filter.put("examid", examid);
            filter.put("blockid", blockid);
            //获取题目
            data.setObj(examqusetionsetservice.findOne(filter).getReturnObj());
            data.setSuccess(true);
            return data;
        } catch (Exception e) {
            logger.error("接口（education/examanswerinfo.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 获取http请求参数
     *
     * @since 2018-1-9
     */
    private Map getParams(HttpServletRequest request) throws Exception {
        Enumeration<String> parameterNames = request.getParameterNames();
        Map map = null;
        if (parameterNames.hasMoreElements()) {//Content-Type:application/x-www-form-urlencoded
            map = new HashMap<String, Object>();
            while (parameterNames.hasMoreElements()) {
                String parameterName = (String) parameterNames.nextElement();
                map.put(parameterName, request.getParameter(parameterName));
            }
            return map;
        }

        StringBuilder sb = new StringBuilder();// 非Content-Type:application/x-www-form-urlencoded的处理
        InputStream is = getRequest().getInputStream();
        BufferedInputStream bis = new BufferedInputStream(is);
        byte[] buffer = new byte[1024];
        int read = 0;
        while ((read = bis.read(buffer)) != -1) {
            sb.append(new String(buffer, 0, read, "UTF-8"));
        }

        if (sb != null && !"".equals(sb + "")) {
            try {
                map = JSONObject.parseObject(sb.toString(), Map.class);
            } catch (com.alibaba.fastjson.JSONException e) { //在异常中对taskTyp=xxx&qprog=xxxx&typ=xxx&repeat=xxx&token=xxxx这种数据的处理
                String sbStr = URLDecoder.decode(sb.toString());
                StringBuffer sbStringBuffer = new StringBuffer();
                sbStringBuffer.append("{\"")
                        .append(sbStr.toString().trim().replaceAll("&", "\",\"").replaceAll("=", "\":\""))
                        .append("\"}");
                map = JSONObject.parseObject(sbStringBuffer.toString(), Map.class);
            }
        }
        return map;
    }


    private int compare(String news, String olds) {
        //status为0时错误，1位正确题目
        String n[] = news.split("\\|");
        String o[];
        if (olds.equals("") || olds == null) {
            o = new String[n.length];
            for (int i = 0; i < o.length; i++) {
                o[i] = String.valueOf(0);
            }
        } else {
            o = olds.split("\\|");
            for (int i = 0; i < o.length; i++) {
                if (o[i].equals(" ") || o[i].equals("")) {
                    o[i] = String.valueOf(0);
                    System.out.println("null");
                    System.out.println("o[i]" + o[i]);
                }
            }
        }
        //若为空或0，数组内各元素为0
        if (o.length == 0) {
            o = new String[n.length];
            for (int i = 0; i < o.length; i++) {
                o[i] = String.valueOf(0);
            }
        }

        System.out.println("length");
        //遍历新增字符串
        for (int i = 0; i < n.length; i++) {
            if (n[i].equals(" ") || n[i].equals("")) {

                System.out.println("null");
                n[i] = String.valueOf(0);

            }
        }

        int length = (n.length >= n.length) ? n.length : o.length;
        int r = 0;
        for (int a = 0; a < length; a++) {
            r += (Integer.parseInt(n[a]) - Integer.parseInt(o[a]) <= 0) ? 0 : 1;
        }
        return r;

    }


    /**
     * 判断用户答题状态判断，全为1可以解锁
     *
     * @author songhaozhang
     * @since 2019.3.21
     **/
    private boolean unlock(String status) {
        String s[] = status.split("\\|");
        boolean a = true;
        for (int i = 0; i < s.length; i++) {
            if (!s[i].equals("1")) {
                return a = false;
            }
        }
        return a;
    }

    /**
     * 欢迎来到量子的世界页面获取
     */
    @RequestMapping(value = "QCode/brief/welcome.html")
    public String welcome() {
        return "quantumCloud/welcome";
    }

    /**
     * 量子世界页面获取
     */
    @RequestMapping(value = "QCode/brief/world.html")
    public String world() {
        return "quantumCloud/world";
    }

    /**
     * 量子力学页面获取
     */
    @RequestMapping(value = "QCode/brief/mechanics.html")
    public String mechanics() {
        return "quantumCloud/mechanics";
    }

    /**
     * 量子计算原理页面获取
     */
    @RequestMapping(value = "QCode/brief/theory.html")
    public String theory() {
        return "quantumCloud/theory";
    }

    /**
     * 量子算法页面获取
     */
    @RequestMapping(value = "QCode/brief/algorithm.html")
    public String algorithm() {
        return "quantumCloud/algorithm";
    }


    /**
     * 量子算法页面获取
     */
    @RequestMapping(value = "QCode/brief/{page}.html")
    public String briefuniveral(@PathVariable("page") String page) {
        return "webview/" + page;
    }


    /**
     * 欢迎来到量子的世界页面获取
     */
    @RequestMapping(value = "QCode/webview/welcome.html")
    public String welcomeM() {
        return "webview/welcome";
    }

    /**
     * 量子世界页面获取
     */
    @RequestMapping(value = "QCode/webview/world.html")
    public String worldM() {
        return "webview/world";
    }

    /**
     * 量子力学页面获取
     */
    @RequestMapping(value = "QCode/webview/mechanics.html")
    public String mechanicsM() {
        return "webview/mechanics";
    }

    /**
     * 量子计算原理页面获取
     */
    @RequestMapping(value = "QCode/webview/theory.html")
    public String theoryM() {
        return "webview/theory";
    }

    /**
     * 量子算法页面获取
     */
    @RequestMapping(value = "QCode/webview/algorithm.html")
    public String algorithmM() {
        return "webview/algorithm";
    }

    /**
     * 量子算法页面获取
     */
    @RequestMapping(value = "EDU/HShare.html")
    public String HonorShare() {
        return "tutorial/HonorShare";
    }


    private static ScoreDetailVo getScoreDetail(QcodeUser qcodeUser, int addScore, int minusScore, String detail) {
        ScoreDetailVo scoreDetailVo = new ScoreDetailVo();
        scoreDetailVo.setDetail(detail);
        scoreDetailVo.setMinusScore(minusScore);
        scoreDetailVo.setAddScore(addScore);
        scoreDetailVo.setUserId(qcodeUser.getId());
        scoreDetailVo.setUserName(qcodeUser.getName());
        return scoreDetailVo;
    }


    /**
     * 下载视频
     *
     * @param response
     * @param httpUrl  视频地址
     * @return
     */
    @RequestMapping("/EDU/downloadVideo.json")
    @ResponseBody
    public boolean downloadVideo(HttpServletResponse response, String httpUrl) {
        int byteRead;
        URL url = null;
        response.reset();// 清空输出流
        try {
            if (httpUrl.contains("?video")) {
                int at = httpUrl.indexOf("?video");
                httpUrl = httpUrl.substring(0, at);
            }
            url = new URL(httpUrl);
        } catch (MalformedURLException e) {
            e.printStackTrace();
            return false;
        }
        try {
            //2.获取链接
            URLConnection conn = url.openConnection();
            //3.输入流
            InputStream inStream = conn.getInputStream();

            String fileName = url.getFile();
            fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
            response.setContentType("application/octet-stream;charset=utf-8");
            response.setHeader("Content-disposition", "attachment;filename=" + new String(fileName.getBytes("UTF-8"), "ISO8859-1"));

            //3.写入文件
            OutputStream fs = response.getOutputStream();

            byte[] buffer = new byte[1024];
            while ((byteRead = inStream.read(buffer)) != -1) {
                fs.write(buffer, 0, byteRead);
            }
            inStream.close();
            fs.close();
            return true;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

    }


    /**
     * 创建API KEY
     *
     * @since 2018-1-9
     */
    @RequestMapping(value = "QCode/createKey.json")
    @ResponseBody
    public ResponseData createKey(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        QcodeUser user = AppContextHolder.getCurrentUser();
        String isRepeat = request.getParameter("isRepeat");//是否重新生成 ：0：否、1：是
        if (user != null) {
            if (user.getApiKey() != null && !"".equals(user.getApiKey()) && !"1".equals(isRepeat)) {
                data.setObj(user.getApiKey());
            } else {
                String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
                user.setApiKey(apiKey);
                Result result = qcodeuserservice.update(user);
                if (result.isSuccess()) {
                    data.setObj(apiKey);
                } else {
                    data.setSuccess(false);
                }
            }
        } else {
            data.setSuccess(false);
        }
        return data;
    }


    /**
     * 课程精选
     *
     * @author songhaozhang
     * @since 2018-4-22
     */
    @RequestMapping(value = "education/qualitycourse.json")
    @ResponseBody
    public ResponseData qualitycourse(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("qualityclass");
            //获取题目
            data.setObj(videoInfoService.findList(filter).getReturnObj());
            data.setSuccess(true);
            return data;
        } catch (Exception e) {
            logger.error("接口（education/qualitycourse.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 课程精选
     *
     * @author songhaozhang
     * @since 2018-4-22
     */
    @RequestMapping(value = "education/getcatalog.json")
    @ResponseBody
    public ResponseData qualitycatalog(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {

            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectcatalog");
            //获取题目
            data.setObj(videoInfoService.findList(filter).getReturnObj());
            data.setSuccess(true);
            return data;
        } catch (Exception e) {
            logger.error("接口（education/examanswerinfo.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }

}
