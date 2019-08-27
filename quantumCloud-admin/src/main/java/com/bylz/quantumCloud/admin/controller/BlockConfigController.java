package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.admin.util.FileUploadUtils;
import com.bylz.quantumCloud.admin.util.FtpUtils;
import com.bylz.quantumCloud.admin.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.model.BlockConfigVo;
import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.bylz.quantumCloud.service.BlockConfigService;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.util.SettingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/6
 */
@Controller
@RequestMapping("/blockConfig")
public class BlockConfigController {

    @Autowired
    private BlockConfigService blockConfigService;

    @RequestMapping("/index.html")
    public String getIndex(Model model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",blockConfigService.findPager(filter).getReturnObj());
        return "/blockConfig/index";
    }

    @RequestMapping("/add.html")
    public String addAppPush() {
        return "/blockConfig/add";
    }

    @RequestMapping("/update.html")
    public String updateAppPush(Model model,HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        BlockConfigVo blockConfigVo = blockConfigService.findOne(filter).getReturnObj();
        model.addAttribute("entity",blockConfigVo);
        return "/blockConfig/update";
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public ResponseData saveAppPush(BlockConfigVo blockConfigVo) {
        ResponseData data = new ResponseData(true);

        try {
            String blockName = blockConfigVo.getCataLog();
            String blockPath = SettingUtil.getSetting("blockvideosavepath",String.class)+"/" + blockName;
            String block360pPath = SettingUtil.getSetting("blockvideo360savepath",String.class)+"/" + blockName;
            FtpUtils.createDir(block360pPath);
            FtpUtils.createDir(blockPath);
            blockConfigService.save(blockConfigVo);
            data.setMessage("保存成功");
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("保存失败");
            return data;
        }

        return data;
    }

    @RequestMapping("/updBlock.json")
    @ResponseBody
    public ResponseData updAppPush(BlockConfigVo blockConfigVo) {
        ResponseData data = new ResponseData(true);

        try {
            blockConfigService.update(blockConfigVo);
            data.setMessage("修改成功");
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("修改失败");
            return data;
        }

        return data;
    }


    @RequestMapping("/uploadImg.json")
    @ResponseBody
    public ResponseData updloadImg(HttpServletRequest request) {

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

            String realPath = "";
            for (MultipartFile multipartFile : fileMap.values()) {
                realPath = FileUploadUtils.uploadPic(multipartFile,"blcokImg");
                realPath = SettingUtil.getSetting("project.server.url",String.class) + "/files/" + realPath;
            }

            data.setObj(realPath);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }


    }


    @RequestMapping("/delBlock.json")
    @ResponseBody
    public ResponseData delBlock(long block,String cataLog) {
        ResponseData data = new ResponseData(true);

        try {
            List<VideoInfoVo> list = blockConfigService.getVideoList(block);
            if(!list.isEmpty()) {
                data.setMessage("版块下存在视频，无法删除");
                data.setSuccess(false);
                return data;
            }

            List<ExamQuestionSet> examList = blockConfigService.getExamList(block);
            if(!examList.isEmpty()) {
                data.setMessage("版块下存在试题，无法删除");
                data.setSuccess(false);
                return data;
            }

            blockConfigService.delete(block);
            String blockPath = SettingUtil.getSetting("blockvideosavepath",String.class)+"/" + cataLog;
            String block360pPath = SettingUtil.getSetting("blockvideo360savepath",String.class)+"/" + cataLog;
            FtpUtils.deleteDir(blockPath);
            FtpUtils.deleteDir(block360pPath);
            data.setMessage("删除成功");
            return data;
        }catch (Exception e) {
            data.setMessage("删除出错");
            data.setSuccess(false);
            return data;
        }

    }


    @RequestMapping("/getVideo.json")
    @ResponseBody
    public List<VideoInfoVo> getVideo(long block) {
        List<VideoInfoVo> list = blockConfigService.getVideoList(block);
        return list;
    }


    @RequestMapping("/getExam.json")
    @ResponseBody
    public List<ExamQuestionSet> getExam(long block) {
        List<ExamQuestionSet> examList = blockConfigService.getExamList(block);
        return examList;
    }

    @RequestMapping("/getHaveBlockName.json")
    @ResponseBody
    public int getHaveBlockName(String name) {
        int count = blockConfigService.getHaveBlockName(name);
        return count;
    }
}
