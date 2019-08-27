package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.admin.util.FileUploadUtils;
import com.bylz.quantumCloud.admin.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.model.ReadBook;
import com.bylz.quantumCloud.service.ReadBookService;
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
import java.util.HashMap;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/15
 */
@Controller
@RequestMapping("/readBook")
public class ReadBookController extends BaseController {

    @Autowired
    private ReadBookService readBookService;


    @RequestMapping("/index.html")
    public String recommendReadIndex(HttpServletRequest request, Model model) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",readBookService.findPager(filter).getReturnObj());
        return "readBook/index";
    }

    @RequestMapping("/add.html")
    public String addReadBook() {
        return "readBook/add";
    }


    @RequestMapping("/saveReadBook.json")
    @ResponseBody
    public ResponseData saveReadBook(ReadBook readBook) {
        ResponseData data = new ResponseData(true);
        try {
            readBookService.save(readBook);
            data.setMessage("保存成功");
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setMessage("保存出错");
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
                image = FileUploadUtils.uploadPic(multipartFile,"readBook");
            }


            data.setObj(image);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }


    }

    @RequestMapping("/detail.html")
    public String detail(HttpServletRequest request,Model model) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("entity",readBookService.findOne(filter).getReturnObj());
        return "/readBook/upd";
    }

    @RequestMapping("/updData.json")
    @ResponseBody
    public ResponseData updData(ReadBook readBook,String oldFace) {
        ResponseData data = new ResponseData(true);

        if(!oldFace.equals(readBook.getImage())) {
            FileUploadUtils.delPreImg(AppContextHolder.getFileSavePath()+oldFace);
        }

        try {
            readBookService.update(readBook);
            data.setMessage("修改成功");
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage("修改出错");
            return data;
        }
    }


    @RequestMapping("/delReadBook.json")
    @ResponseBody
    public ResponseData delReadBook(int id) {
        ResponseData data = new ResponseData(true);

        try {
            readBookService.delete(id);
            data.setMessage("保存成功");
        }catch (Exception e) {
            e.printStackTrace();
            data.setMessage("保存出错");
            data.setSuccess(false);
            return data;
        }

        return data;
    }

}
