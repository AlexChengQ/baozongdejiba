package com.bylz.quantumCloud.education.controller;

import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.FileUploadUtils;
import com.bylz.quantumCloud.education.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.model.MatchSignUpVo;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.MatchSignUpService;
import com.likegene.framework.util.SettingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/19
 */
@Controller
@RequestMapping("/matchSignUp")
public class MatchSignUpController extends BaseController {

    @Autowired
    private MatchSignUpService matchSignUpService;



    @RequestMapping("/addData.json")
    @ResponseBody
    public ResponseData addData(MatchSignUpVo matchSignUpVo) {
        ResponseData data = new ResponseData(true);
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();

        if(null == qcodeUser) {
            data.setSuccess(false);
            data.setMessage("请先登录!");
            return data;
        }

        try {
            matchSignUpService.save(matchSignUpVo);
            data.setMessage("保存成功");
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage("program error");
            return data;
        }

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

            String name = "";
            for (MultipartFile multipartFile : fileMap.values()) {
                name = FileUploadUtils.uploadPic(multipartFile,"matchData");
            }


            data.setObj(name);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }


    }

}
