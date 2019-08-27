package com.bylz.quantumCloud.education.api;

import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.education.controller.BaseController;
import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.*;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.util.*;


/**
 * QCode Controller
 *
 */
@Controller
@RequestMapping("/api/Edu")
public class EduApiController extends BaseController {


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
    private BannerService bannerService;

    @Autowired
    private SysConfigService sysConfigService;

    @Autowired
    private AppPushServie appPushServie;

    @Autowired
    private TutorialReviewService tutorialReviewService;


    /**
     * 根据blockid查询视频情况
     * return vid,examid
     * @author songhaozhang
     * @since 2019-4-19
     */
    @RequestMapping(value = "/education/videoinfoByBlockId.json")
    @ResponseBody
    public ResponseData videoinfoByBlockId(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {

            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            //获取参数
            if(StringUtils.isBlank((String)map.get("blockId"))) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            //获取視頻userid
            QueryFilter filter = new QueryFilter();
            filter.put("blockId",map.get("blockId"));
            //获取任务类型
            filter.setStatementKey("selectuservideoinfoById");
            List<Map<String,Object>> list = videoInfoService.findList(filter).getReturnObj();

            if(list.size() > 0) {
                data.setRequestURI(list.get(0).get("blockimg").toString());
            }

            data.setSuccess(true);
            data.setObj(videoInfoService.findList(filter).getReturnObj());

            return data;
        } catch (Exception e) {
            logger.error("error:education/videoinfo.json" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            data.setObj("");
            return data;
        }
    }


    
    /**
     * 查询视频情况
     * return vid,examid
     * @author songhaozhang
     * @since 2019-4-19
     */
    @RequestMapping(value = "/education/videoinfo.json")
    @ResponseBody
    public ResponseData videoinfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {

            //获取視頻userid
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectuservideo");
            //获取任务类型
            ArrayList<UserVideo> uservideo=new ArrayList<UserVideo>();
            filter.setStatementKey("selectuservideoinfo");
            data.setSuccess(true);
            data.setObj(videoInfoService.findList(filter).getReturnObj());
            return data;
        } catch (Exception e) {
            logger.error("error:education/videoinfo.json" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            data.setObj("");
            return data;
        }
    }



    /**
     * 获取问题
     * request : questionid , blockid , examid
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "/education/examinfo.json")
    @ResponseBody
    public ResponseData examinfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            //获取参数
            if(map.get("examid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("questionid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("blockid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            int examid=Integer.parseInt((String) map.get("examid"));
            int questionid=Integer.parseInt((String) map.get("questionid"));
            int blockid=Integer.parseInt((String) map.get("blockid"));
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
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "/education/allexaminfo.json")
    @ResponseBody
    public ResponseData allexaminfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            //获取参数                	
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectAllQuestion"); 
            ArrayList<ExamQuestionSet> eqs=new ArrayList<ExamQuestionSet>();
            eqs=examqusetionsetservice.findList(filter).getReturnObj();
            System.out.println(eqs.get(0).getBlockid()+" "+eqs.get(0).getQuestionid());
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
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "/education/uexaminfobyid.json")
    @ResponseBody
    public ResponseData uexaminfobyid(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            //获取参数 
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : (String)map.get("token");

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser qcodeUser = GetUserIdByApikey.getUserId(token);

            if(qcodeUser == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("examid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("blockid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("uexambyid"); 
            int userid=qcodeUser.getId().intValue() ;
            int examid=Integer.parseInt((String) map.get("examid"));       
            int blockid=Integer.parseInt((String) map.get("blockid"));
            filter.put("userid", userid);
            filter.put("examid", examid);
            filter.put("blockid", blockid);
            UserExam a=new UserExam();
            a=userexamservice.findOne(filter).getReturnObj();
            
            boolean unlock=false;
            if(a!=null) {
            	unlock=unlock(a.getStatus());
            }
            data.setObj(a);
            data.setMemo(""+unlock);
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
     * 获取答案
     * request : questionid , blockid , examid
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "/education/examAnswerInfo.json")
    @ResponseBody
    public ResponseData examAnswerInfo(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("blockid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("questionid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("examid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            //获取参数           
            int examid=Integer.parseInt( map.get("examid").toString());
            int questionid=Integer.parseInt((String)map.get("questionid"));            
            int blockid=Integer.parseInt((String) map.get("blockid"));
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

    
    private int compare(String news,String olds) {
    	//status为0时错误，1位正确题目
    	String n[]=news.split("\\|");
    	String o[];
    	if(olds.equals("")||olds==null) {
        	o=new String[n.length];
        	for(int i = 0; i < o.length; i++){        		 
        	    o[i] = String.valueOf(0);        	 
        	}
    	}else {
    		o=olds.split("\\|");
        	for(int i = 0; i < o.length; i++){        		 
        	    if(o[i].equals(" ")||o[i].equals("")) {
        	    	o[i] = String.valueOf(0);
        	    	System.out.println("null");
        	    	System.out.println("o[i]"+o[i]);
        	    }        	 
        	}
    	}	
    	//若为空或0，数组内各元素为0
    	if(o.length==0) {
        	o=new String[n.length];
        	for(int i = 0; i < o.length; i++){        		 
        	    o[i] = String.valueOf(0);        	 
        	}
    	}
    	
    	System.out.println("length");
    	//遍历新增字符串
    	for(int i = 0; i < n.length; i++){
    	    if(n[i].equals(" ")||n[i].equals("")) {
        	    
        	    	System.out.println("null");
        	    	n[i] = String.valueOf(0);
        	   
    	    }        	 
    	}
    	
    	int length=(n.length>=n.length) ?n.length:o.length;
    	int r=0;
    	for(int a=0;a<length;a++) {
    		r+=(Integer.parseInt(n[a])-Integer.parseInt(o[a])<=0)?0:1;
    	}
    	return r;
    	
    }

    
    /**
     * 判断用户答题状态判断，全为1可以解锁
     * @author songhaozhang 
     * @since 2019.3.21
     **/
    private boolean unlock(String status) {
    	String s[]=status.split("\\|");
		boolean a=true;
		for(int i=0;i<s.length;i++) {
			if(!s[i].equals("1")) {
				return a=false;
			}
		}	
		return a;
    }
    


    private static ScoreDetailVo getScoreDetail(QcodeUser qcodeUser,int addScore,int minusScore,String detail) {
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
     * @param response
     * @param httpUrl 视频地址
     * @return
     */
    @RequestMapping("/downloadVideo.json")
    @ResponseBody
    public ResponseData downloadVideo(HttpServletResponse response, String httpUrl) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        int byteRead;
        URL url = null;
        response.reset();// 清空输出流
        try {
            if(httpUrl.contains("?video")) {
                int at = httpUrl.indexOf("?video");
                httpUrl = httpUrl.substring(0,at);
            }
            url = new URL(httpUrl);
        } catch (MalformedURLException e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }
        try {
            //2.获取链接
            URLConnection conn = url.openConnection();
            //3.输入流
            InputStream inStream = conn.getInputStream();

            String fileName = url.getFile();
            fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
            response.setContentType("application/octet-stream;charset=utf-8");
            response.setHeader("Content-disposition","attachment;filename="+new String(fileName.getBytes("UTF-8"),"ISO8859-1"));

            //3.写入文件
            OutputStream fs = response.getOutputStream();

            byte[] buffer = new byte[1024];
            while ((byteRead = inStream.read(buffer)) != -1) {
                fs.write(buffer, 0, byteRead);
            }
            inStream.close();
            fs.close();
            return data;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        } catch (IOException e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    
    
    /**
     *首页banner图片及跳转路径 
     *
     **/   
    @RequestMapping("/bannerDetail.json")
    @ResponseBody
    public ResponseData bannerDetail(HttpServletResponse response, String httpUrl) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        
        //获取視頻userid
        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("getBanner");
        data.setSuccess(true);
        data.setObj(bannerService.findList(filter).getReturnObj());
        return data;
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
        data.setObj("");
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
     * @author songhaozhang
     * @since 2018-4-22
     */
    @RequestMapping(value = "/education/qualitycourse.json")
    @ResponseBody
    public ResponseData qualitycourse(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("qualityclass");         
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
    
    
    
    
    /**
     * 课程精选
     * @author songhaozhang
     * @since 2018-4-22
     */
    @RequestMapping(value = "/education/getcatalog.json")
    @ResponseBody
    public ResponseData qualitycatalog(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
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


    /**
     * 查询用户视频情况
     * return vid,examid
     * @author songhaozhang
     * @since 2019-1-9
     */
    @RequestMapping(value = "/education/getvideoinfo.json")
    @ResponseBody
    public ResponseData getvideoinfoApi(HttpServletRequest request) {
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

            QcodeUser qcodeUser = GetUserIdByApikey.getUserId(token);


            if(qcodeUser == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }


            //获取視頻userid
            String userid = qcodeUser.getId().toString();
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectuservideo");
            filter.put("userid",userid);
            //获取任务类型
            ArrayList<UserVideo> uservideo=new ArrayList<UserVideo>();
            uservideo =uservideoservice.findList(filter).getReturnObj();
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
     * 增加用户视频情况
     * return data success
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "/education/updvideoinfo.json")
    @ResponseBody
    public ResponseData updvideoinfoApi(HttpServletRequest request) {
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

            QcodeUser qcodeUser = GetUserIdByApikey.getUserId(token);


            if(qcodeUser == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("title") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("progress") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("id") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }


            //获取視頻userid
            Long userid = qcodeUser.getId();
            int id=Integer.parseInt((String) map.get("id"));

            tutorialReviewService.addReadCount(id);//视频观看次数


            int hasSignIn = updateUserScoreService.hasSignIn(userid,1);//有无签到记录

            //添加学习时间
            if(hasSignIn == 0) {//如果有签到记录，即学习时间已经加了一天，逻辑跳过。没有记录，判断是否有学习记录，有，逻辑跳过，没有，插入记录，添加学习时间
                int hasStd = updateUserScoreService.hasSignIn(userid,2);
                if(hasStd == 0) {
                    updateUserScoreService.saveBrowseDetail(userid,2);
                    UserBonusVo userBonusVo = updateUserScoreService.getUserBonusInfo(userid);
                    if(userBonusVo == null) {
                        updateUserScoreService.insertSignInfo(userid);
                    }else {
                        updateUserScoreService.updSignInfo(userid);
                    }
                }
            }

            //获取视频是否加分标记,0代表不增加，1增加
            boolean addscoreflag=Boolean.valueOf((String) map.get("addscoreflag"));
            String title=(String)map.get("title");
            String progress=(String) map.get("progress");
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectvideo");
            filter.put("vid", id);
            filter.put("userid", userid);
            //获取任务类型
            UserVideo uv =uservideoservice.findOne(filter).getReturnObj();
//            QcodeUser qcodeuser=AppContextHolder.getCurrentUser();
            //无相关记录，需要插入新纪录
            if(uv==null||uv.getUserid()==0) {
                UserVideo userVideo=new UserVideo();
                userVideo.setVid(id);
                userVideo.setUserid(userid);
                userVideo.setTitle(title);
                userVideo.setProgress(progress);
                logger.debug("userVideo."+userVideo.getProgress());
                Result r= uservideoservice.save(userVideo);
                if(r.isSuccess()) {
                    //看完视频增加分数
                    if(addscoreflag) {
                        QueryFilter updatescore = new QueryFilter();
                        updatescore.setStatementKey("updscore");
                        updatescore.put("score", 10);
                        updatescore.put("userid",userid);
                        if(!qcodeuserservice.update(updatescore).isSuccess()) {
                            logger.error("插入数据失败");
                            data.setSuccess(false);
                            data.setMessage(getMessage("INSERT USER VIDEO INFO FAIL"));
                            return data;
                        }else {
                            QueryFilter upv=new QueryFilter();
                            upv.put("vid", id);
                            upv.put("userid", userid);
                            upv.put("addscore", 1);
                            upv.setStatementKey("UpdUserVideo");
                            uservideoservice.update(upv);
                            String memo="video-addscore-save-"+id;
                            logger.info(memo);
                            ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeUser,10,0,memo);
                            QueryFilter filter1 = new QueryFilter(scoreDetailVo);
                            filter1.setStatementKey("addScoreDetails");
                            Result rs=updateUserScoreService.save(filter1);
                            if(!rs.isSuccess()) {
                                data.setSuccess(false);
                                return data;
                            }
                            logger.info("save score detail score is{}",10);
                            qcodeUser.setScore(qcodeUser.getScore()+10);
                        }

                    }
                    AppContextHolder.getSession().setAttribute("USER_INFO",qcodeUser);
                    data.setSuccess(true);
                    return data;
                }else {
                    logger.error("插入数据失败");
                    data.setSuccess(false);
                    data.setMessage(getMessage("INSERT USER VIDEO INFO FAIL"));
                    return data;
                }
            }else {
                //有相关记录，更新数据库
                UserVideo userVideo=new UserVideo();
                userVideo.setVid(id);
                userVideo.setUserid(userid);
                userVideo.setTitle(title);
                userVideo.setProgress(progress);
                logger.debug("userVideo."+userVideo.getProgress());
                QueryFilter update = new QueryFilter();
                update.put("userid",userVideo.getUserid());
                update.put("title", userVideo.getTitle());
                update.put("vid", id);
                update.put("progress", progress);
                update.setStatementKey("UpdUserVideo");
                Result result = uservideoservice.update(update);
                if (result.isSuccess()) {
                    //看完视频增加分数
                    if(addscoreflag) {
                        if(uv.getAddscore()==0) {
                            QueryFilter updatescore = new QueryFilter();
                            updatescore.setStatementKey("updscore");
                            updatescore.put("score", 10);
                            updatescore.put("userid",userVideo.getUserid());
                            Result result1=qcodeuserservice.update(updatescore);
                            //更新addscore状态
                            QueryFilter upv=new QueryFilter();
                            upv.put("vid", id);
                            upv.put("userid", userid);
                            upv.put("addscore", 1);
                            upv.setStatementKey("UpdUserVideo");
                            uservideoservice.update(upv);
                            if(!result1.isSuccess()) {
                                logger.error("更新数据失败");
                                data.setSuccess(false);
                                data.setMessage(getMessage("UPDATE USER VIDEO INFO FAIL"));
                                return data;
                            }else {
                                //记录加分流水
                                String memo="video-addscore-save-"+id;
                                logger.info(memo);
                                ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeUser,10,0,memo);
                                QueryFilter filter1 = new QueryFilter(scoreDetailVo);
                                filter1.setStatementKey("addScoreDetails");
                                Result rs=updateUserScoreService.save(filter1);
                                if(!rs.isSuccess()) {
                                    data.setSuccess(false);
                                    return data;
                                }
                                logger.info("save score detail score is{}",10);
                                qcodeUser.setScore(qcodeUser.getScore()+10);
                            }
                        }
                    }
                    AppContextHolder.getSession().setAttribute("USER_INFO",qcodeUser);
                    data.setSuccess(true);
                    return data;
                }else {
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
     * @param
     * @since 2018-1-9
     */
    @RequestMapping(value = "/education/updexaminfo.json")
    @ResponseBody
    public ResponseData updexaminfoApi(HttpServletRequest request) {
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

            QcodeUser qcodeUser = GetUserIdByApikey.getUserId(token);


            if(qcodeUser == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("examid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("addscoreflag") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("status") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("blockid") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            //获取視頻userid
            int examid=Integer.parseInt((String) map.get("examid"));
            Long userid = qcodeUser.getId();

            int hasSignIn = updateUserScoreService.hasSignIn(userid,1);//有无签到记录

            //添加学习时间
            if(hasSignIn == 0) {//如果有签到记录，即学习时间已经加了一天，逻辑跳过。没有记录，判断是否有学习记录，有，逻辑跳过，没有，插入记录，添加学习时间
                int hasStd = updateUserScoreService.hasSignIn(userid,2);
                if(hasStd == 0) {
                    updateUserScoreService.saveBrowseDetail(userid,2);
                    UserBonusVo userBonusVo = updateUserScoreService.getUserBonusInfo(userid);
                    if(userBonusVo == null) {
                        updateUserScoreService.insertSignInfo(userid);
                    }else {
                        updateUserScoreService.updSignInfo(userid);
                    }
                }
            }


            boolean addscoreflag=Boolean.valueOf((String)map.get("addscoreflag"));
            String status=(String) map.get("status");
            int blockid=Integer.parseInt((String) map.get("blockid"));
            //查询该记录是否存在
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectexamexist");
            filter.put("userid", userid);
            filter.put("examid", examid);
            filter.put("blockid", blockid);
            //获取任务类型
            UserExam ue =userexamservice.findOne(filter).getReturnObj();
            System.out.println(ue.getUserid().toString());
//            QcodeUser qcodeuser=AppContextHolder.getCurrentUser();
            //无相关记录，需要插入新纪录
            if(ue.getUserid().toString().isEmpty()||ue.getUserid().toString().equals("0")) {
                QueryFilter upduexam = new QueryFilter();
                System.out.println("record is null");
                upduexam.put("examid", examid);
                upduexam.put("userid", userid);
                upduexam.put("status", status);
                upduexam.put("blockid", blockid);
                UserExam ue2=new UserExam();
                ue2.setExamid(examid);
                ue2.setStatus(status);
                ue2.setUserid(userid);
                ue2.setBlockid(blockid);
                Result result=userexamservice.save(upduexam);
                if(result.isSuccess()){
                    //判读是否增加分数,不相等增加分数
                    if(addscoreflag) {
                        int score=compare(status,"");
                        QueryFilter updatescore = new QueryFilter();
                        updatescore.setStatementKey("updscore");
                        updatescore.put("score", score*20);
                        updatescore.put("userid", qcodeUser.getId());
                        qcodeuserservice.update(updatescore);
                        String memo="examuppdate-save-"+examid;
                        logger.info(memo);
                        ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeUser,score*20,0,memo);
                        //分數为0，不记录流水
                        if(score*20!=0) {
                            QueryFilter filter1 = new QueryFilter(scoreDetailVo);
                            filter1.setStatementKey("addScoreDetails");
                            Result rs=updateUserScoreService.save(filter1);
                            if(!rs.isSuccess()) {
                                data.setSuccess(false);
                                return data;
                            }

                        }
                        logger.info("save score detail score is{}",score*20);
                        qcodeUser.setScore(qcodeUser.getScore()+score*20);
                        data.setObj(score*20);
                    }

                    AppContextHolder.getSession().setAttribute("USER_INFO",qcodeUser);
                    return data;
                }else {
                    logger.error("更新数据失败");
                    data.setSuccess(false);
                    data.setMessage(getMessage("UPDATE USER VIDEO INFO FAIL"));
                    return data;
                }

            }else {
                //有相关记录，更新数据库
                QueryFilter upduexam = new QueryFilter();
                upduexam.put("examid", examid);
                upduexam.put("userid", userid);
                upduexam.put("status", status);
                upduexam.put("blockid", blockid);
                upduexam.setStatementKey("UpdUserExam");
                Result result = userexamservice.update(upduexam);
                if(result.isSuccess()) {
                    if(addscoreflag) {

                        QueryFilter updatescore = new QueryFilter();
                        updatescore.setStatementKey("updscore");
                        int score=compare(status,ue.getStatus());
                        updatescore.setStatementKey("updscore");
                        updatescore.put("score", score*20);
                        updatescore.put("userid", qcodeUser.getId());
                        qcodeuserservice.update(updatescore);
                        String memo="examuppdate-"+examid;
                        logger.info(memo);
                        ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeUser,score*20,0,memo);
                        if(score*20!=0) {
                            QueryFilter filter1 = new QueryFilter(scoreDetailVo);
                            filter1.setStatementKey("addScoreDetails");
                            Result rs=updateUserScoreService.save(filter1);
                            if(!rs.isSuccess()) {
                                data.setMessage("save score detail is false");
                                data.setSuccess(false);
                                return data;

                            }
                        }
                        logger.info("save score detail score is{}",score*20);
                        qcodeUser.setScore(qcodeUser.getScore()+score*20);
                        data.setObj(score*20);
                    }
                    AppContextHolder.getSession().setAttribute("USER_INFO",qcodeUser);
                    data.setSuccess(true);
                    return data;
                }else {
                    logger.error("更新数据失败");
                    data.setSuccess(false);
                    data.setMessage(getMessage("UPDATE USER VIDEO INFO FAIL"));
                    return data;
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error:education/updexaminfo.json" + e);
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    /**
     * 获取用户答题情况
     * request : questionid , blockid , examid
     * @author songhaozhang
     * @since 2018-1-9
     */
    @RequestMapping(value = "/education/userexaminfo.json")
    @ResponseBody
    public ResponseData userexaminfoApi(HttpServletRequest request) {
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

            QcodeUser qcodeUser = GetUserIdByApikey.getUserId(token);


            if(qcodeUser == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            //获取参数
            int userid = qcodeUser.getId().intValue() ;
            QueryFilter filter = new QueryFilter();
            filter.setStatementKey("selectuserexam");
            filter.put("userid", userid);
            data.setSuccess(true);
            ArrayList<UserExam> a=new ArrayList<UserExam>();
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
     * 根据vid查询视频信息及题目信息
     * @param request
     * @return
     */
    @RequestMapping("/education/getVideoInfoExamInfoByVid.json")
    @ResponseBody
    public ResponseData getVideoInfoExamInfoByVid(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }


            if(StringUtils.isBlank((String)map.get("vid"))) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("vid",map.get("vid"));
            filter.put("userId",userInfor.getId());
            filter.setStatementKey("getVideoInfoExamInfoByVid");
            LinkedHashMap<String,Object> map1 = videoInfoService.findOne(filter).getReturnObj();
            filter.setStatementKey("getExamInfo");
            map1.put("examInfoList",videoInfoService.findList(filter));
            data.setObj(map1);
            return data;


        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }
    }


    @RequestMapping("/getVideoListByKey.json")
    @ResponseBody
    public ResponseData getVideoListByKey(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
	        if (map == null) {
	            data.setSuccess(false);
	            data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
	            return data;
	        }


	        if(StringUtils.isBlank((String)map.get("title"))) {
	            data.setSuccess(false);
	            data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
	            return data;
	        }
	        QueryFilter filter = new QueryFilter();
	        filter.put("title",map.get("title"));
	        data.setObj(videoInfoService.findPager(filter).getReturnObj());
	        return data;
		} catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
		}

    }


    /**
     * 版本更新接口
     */
    @RequestMapping("/updVersion.json")
    @ResponseBody
    public ResponseData updVersion(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(StringUtils.isBlank((String)map.get("version"))) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(StringUtils.isBlank((String)map.get("keyname"))) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("keyname",map.get("keyname"));
            filter.setStart(0);
            filter.setLimit(1);
            filter.put("order","val DESC");
            SysConfig sysConfig = sysConfigService.findOne(filter).getReturnObj();

            String versionAndUrl = sysConfig.getVal();
            String updUrl = versionAndUrl.substring(versionAndUrl.indexOf("|")+1);
            String lastVersion = versionAndUrl.substring(0,versionAndUrl.indexOf("|"));

            String currentVersion = map.get("version").toString();

            boolean forceUpd = false;//强制更新
            boolean needUpd = false;//需要更新

            List<String> list = new ArrayList<String>();
            String updDesc = sysConfig.getDescn();

            if(StringUtils.isNotBlank(updDesc)) {
                String[] desc = updDesc.split("，");
                list = Arrays.asList(desc);
            }


            String[] lv = lastVersion.split("\\.");
            String[] cv = currentVersion.split("\\.");

            if(lastVersion.length() != currentVersion.length()) {
                needUpd = true;
                forceUpd = true;
            }

            if(!lv[0].equals(cv[0])) {
                forceUpd = true;
                needUpd = true;
            }


            if(forceUpd) {
                map.clear();
                map.put("updDesc",list);
                map.put("forceUpd",forceUpd);
                map.put("needUpd",needUpd);
                map.put("lastVersion",lastVersion);
                map.put("updUrl",updUrl);
                data.setObj(map);
                return data;
            }

            for(int i = 1; i < lv.length;i++) {
                if(!lv[i].equals(cv[i])) {
                    needUpd = true;
                    break;
                }
            }

            map.clear();
            map.put("updDesc",list);
            map.put("updDesc",list);
            map.put("forceUpd",forceUpd);
            map.put("needUpd",needUpd);
            map.put("lastVersion",lastVersion);
            map.put("updUrl",updUrl);
            data.setObj(map);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage(getMessage("PROGRAM_EXCEPTION"));
            return data;
        }

    }


    @RequestMapping("/getSysNotice.json")
    @ResponseBody
    public ResponseData getSysNotice(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("isPush","1");
            Pagination pagination = appPushServie.findPager(filter).getReturnObj();
            data.setObj(pagination);
            return data;

        } catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("program failed");
            e.printStackTrace();
            return data;
        }
    }

    @RequestMapping("/saveEquipment.json")
    @ResponseBody
    public ResponseData saveEquipment(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        Map map = null;
        try {
            map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            String equipmentId = request.getParameter("equipmentId") == null?null:request.getParameter("equipmentId").toString();

            if(StringUtils.isBlank(equipmentId)) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }



            QueryFilter filter = new QueryFilter(request);
            filter.put("userId",userInfor.getId());
            filter.setStatementKey("getEquipment");
            List<Map> list = qcodeuserservice.findList(filter).getReturnObj();
            if(list.size() > 0) {
                filter.setStatementKey("delEquipment");
                qcodeuserservice.delete(filter);
            }

            filter.setStatementKey("saveEquipment");
            qcodeuserservice.save(filter);

        } catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage("program failed");
            return data;
        }

        return data;
    }


    @RequestMapping("/delEquipment.json")
    @ResponseBody
    public ResponseData delEquipment(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        Map map = null;
        try {
            map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }


            QueryFilter filter = new QueryFilter(request);
            filter.put("userId",userInfor.getId());
            filter.setStatementKey("delEquipment");
            qcodeuserservice.delete(filter);


        } catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage("program failed");
            return data;
        }

        return data;
    }

}
