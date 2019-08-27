package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.admin.util.FileUploadUtils;
import com.bylz.quantumCloud.admin.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.model.PlatformBlockVo;
import com.bylz.quantumCloud.service.PlatformBlockService;
import com.likegene.framework.core.QueryFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/17
 */
@Controller
@RequestMapping("/platformBlock")
public class PlatformBlockController extends BaseController {

    @Autowired
    private PlatformBlockService platformBlockService;

    @RequestMapping("/index.html")
    public String gotoIndex(HttpServletRequest request, Model model) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",platformBlockService.findPager(filter).getReturnObj());
        return "/platformBlock/index";
    }


    @RequestMapping("/add.html")
    public String add() {
        return "/platformBlock/add";
    }


    @RequestMapping("/upd.html")
    public String upd(HttpServletRequest request,Model model) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("entity",platformBlockService.findOne(filter).getReturnObj());
        return "/platformBlock/upd";
    }

    @RequestMapping("/addData.json")
    @ResponseBody
    public ResponseData addData(PlatformBlockVo platformBlockVo) {
        ResponseData data = new ResponseData(true);
        try {
            platformBlockService.save(platformBlockVo);
            data.setMessage("保存成功");
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage("保存出错");
            return data;
        }
    }


    @RequestMapping("/updData.json")
    @ResponseBody
    public ResponseData updData(PlatformBlockVo platformBlockVo) {
        ResponseData data = new ResponseData(true);
        try {
            platformBlockService.update(platformBlockVo);
            data.setMessage("修改成功");
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setMessage("修改出错");
            data.setSuccess(false);
            return data;
        }
    }


    @RequestMapping("/delData.json")
    @ResponseBody
    public ResponseData delData(int id) {
        ResponseData data = new ResponseData(true);
        try {
            platformBlockService.delete(id);
            data.setMessage("删除成功");
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setMessage("删除出错");
            data.setSuccess(false);
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

            String image = "";
            for (MultipartFile multipartFile : fileMap.values()) {
                image = FileUploadUtils.uploadPic(multipartFile,"platformBlock");
            }


            data.setObj(image);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }


    }

}
