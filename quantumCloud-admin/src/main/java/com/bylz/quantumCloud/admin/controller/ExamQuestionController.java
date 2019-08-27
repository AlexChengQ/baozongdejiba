package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.admin.util.FileUploadUtils;
import com.bylz.quantumCloud.admin.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.model.BlockConfigVo;
import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.bylz.quantumCloud.service.ExamQuestionSetService;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.util.SettingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/18
 */
@RequestMapping("/examConfig")
@Controller
public class ExamQuestionController {

    @Autowired
    private ExamQuestionSetService examQuestionSetService;

    @RequestMapping("/index.html")
    public String getIndex(Model model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",examQuestionSetService.findPager(filter).getReturnObj());
        return "/examConfig/index";
    }

    @RequestMapping("/add.html")
    public String addAppPush(Model model) {
        return "/examConfig/addExam";
    }

    @RequestMapping("/update.html")
    public String updateAppPush(Model model,HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        ExamQuestionSet examQuestionSet = examQuestionSetService.findOne(filter).getReturnObj();
        String content = examQuestionSet.getContent();
        String type = "0";
        List<String> answerArray = null;//答案数组
        String subject = null;//题目
        if(content.contains("**")) {
            type = "1";
        }

        if("0".equals(type)) {//普通模式
            subject = content.split("\\|")[0];
            answerArray = Arrays.asList(Arrays.copyOfRange(content.split("\\|"),1,content.split("\\|").length));
        } else {
            subject = content.split("\\*\\*")[0];
            String ans = content.split("\\*\\*")[1];
            answerArray = Arrays.asList(ans.split("\\#\\#"));
        }
        examQuestionSet.setContent(subject);
        filter.clear();
        filter.put("blockId",examQuestionSet.getBlockid());
        List<VideoInfoVo> videoList = examQuestionSetService.getVideoByBlock(filter);
        model.addAttribute("answerList",answerArray);
        model.addAttribute("videoList",videoList);
        model.addAttribute("entity",examQuestionSet);

        return "/examConfig/update";
    }




    @RequestMapping("/addExam.html")
    public String addExam(Model model,int vid,int block) {
        String vidStr = vid+"";
        String blockStr = block+"";
        int examId = Integer.parseInt(vidStr.substring(blockStr.length(),vidStr.length()));
        model.addAttribute("blockId",block);
        model.addAttribute("examId",examId);
        return "/videoConfig/addExam";
    }


    @RequestMapping("/saveExam.json")
    @ResponseBody
    public ResponseData saveExam(ExamQuestionSet examQuestionSet,int vid) {
        ResponseData data = new ResponseData(true);
        try {
            String vidStr = vid+"";
            String blockStr = examQuestionSet.getBlockid()+"";
            int examId = Integer.parseInt(vidStr.substring(blockStr.length(),vidStr.length()));
            String examIdStr = examId+"";
            examQuestionSet.setExamid(examId);
            QueryFilter filter = new QueryFilter();
            filter.put("blockId",examQuestionSet.getBlockid());
            filter.put("examId",examId);
            filter.setStatementKey("getMaxQuestionId");
            int maxQuestionId = examQuestionSetService.getMaxQuestionId(filter);
            String maxQuestionIdStr = maxQuestionId+"";
            int blockIdLen = blockStr.length();
            int blockPosition = 3-blockIdLen;
            int examIdLen = examIdStr.length();
            int examPosition = 3-examIdLen;
            if(blockPosition > 0) {
                for(int i = 0;i < blockPosition;i++) {
                    blockStr += "0";
                }
            }

            if(examPosition > 0) {
                for(int i =0;i < examPosition;i++) {
                    examIdStr += "0";
                }
            }

            if("0".equals(maxQuestionIdStr)) {
                examQuestionSet.setQuestionid(Integer.parseInt(blockStr+examIdStr+1));
                examQuestionSetService.saveExam(examQuestionSet);
                return data;
            }



            int id = Integer.parseInt(maxQuestionIdStr.substring(6,maxQuestionIdStr.length()))+1;
            String questionId = blockStr+examIdStr+id;
            examQuestionSet.setQuestionid(Integer.parseInt(questionId));
            examQuestionSetService.saveExam(examQuestionSet);
            data.setMessage("保存成功");
            return data;
        }catch (Exception e) {
            data.setMessage("保存出错");
            data.setSuccess(false);
            e.printStackTrace();
            return data;
        }

    }

    @RequestMapping("/getBlock.json")
    @ResponseBody
    public List<BlockConfigVo> getBlock() {
        QueryFilter filter = new QueryFilter();
        List<BlockConfigVo> blockList = examQuestionSetService.getBlock(filter);
        return blockList;
    }

    @RequestMapping("/getVideoByBlock")
    @ResponseBody
    public List<VideoInfoVo> getVideoByBlock(int blockId) {
        QueryFilter filter = new QueryFilter();
        filter.put("blockId",blockId);
        List<VideoInfoVo> list = examQuestionSetService.getVideoByBlock(filter);
        return list;
    }

    @RequestMapping("/deleteExam.json")
    @ResponseBody
    public ResponseData deleteExam(long questionId) {
        ResponseData data = new ResponseData(true);
        try {
            examQuestionSetService.delete(questionId);
            data.setMessage("删除成功");
            return data;
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("删除失败");
            return data;
        }
    }

    @RequestMapping("/updExam.json")
    @ResponseBody
    public ResponseData updExam(ExamQuestionSet examQuestionSet,int vid) {
        ResponseData data = new ResponseData(true);
        try {
//            examQuestionSetService.delete(Long.parseLong(examQuestionSet.getQuestionid()+""));
            String vidStr = vid+"";
            String blockStr = examQuestionSet.getBlockid()+"";
            int examId = Integer.parseInt(vidStr.substring(blockStr.length(),vidStr.length()));
            examQuestionSet.setExamid(examId);
            examQuestionSetService.update(examQuestionSet);
            data.setMessage("修改成功");
            return data;
        }catch (Exception e) {
            data.setMessage("修改出错");
            data.setSuccess(false);
            e.printStackTrace();
            return data;
        }

    }


    @RequestMapping("/updLoadExamPic.json")
    @ResponseBody
    public ResponseData updLoadExamPic(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage("LACK_OF_NECESSARY_PARAMETERS");
                return data;
            }



            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
            if (null == fileMap) {
                return new ResponseData(false, "请选择上传文件");
            }

            String path = "";
            for (MultipartFile multipartFile : fileMap.values()) {
                path += SettingUtil.getSetting("project.server.url",String.class) + "/" + FileUploadUtils.uploadPicForExam(multipartFile,"examquestion");
            }


            data.setObj(path);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }

    }
}
