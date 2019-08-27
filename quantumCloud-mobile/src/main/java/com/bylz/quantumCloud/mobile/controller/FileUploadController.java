package com.bylz.quantumCloud.mobile.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.likegene.framework.util.SettingUtil;
import com.bylz.quantumCloud.mobile.core.AppContextHolder;
import com.bylz.quantumCloud.mobile.util.DateUtils;
import com.bylz.quantumCloud.mobile.util.DateUtils.DateStyle;
import com.bylz.quantumCloud.mobile.util.FileUploadUtils;
import com.bylz.quantumCloud.model.SysFile;

/**
 * 文件上传controller
 * 
 * @author GuoJun
 * @since 2017-07-11
 */
@Controller
@RequestMapping("/uploadFile")
public class FileUploadController extends BaseController {

    private final static String FILE_NAME = "fileName";
    
    private final static String SRC = "src";
    
    private final static String FILE_PATH = "filePath";
    
    private final static String DEFAULT_FOLDER = "uploadFile";
    
    
    
    /**
     * 图片上传
     * 
     * @Desc
     * @author JT
     * @date 2017-09-11
     */
    @RequestMapping(value = "/saveImg.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData saveImg(HttpServletRequest request) {
        try {
        	String folder = request.getParameter("folder");
        	String imgCode = request.getParameter("imgCode");
    		String curPath = folder + File.separator + DateUtils.formatDatetime(new Date(), DateStyle.YYYY_MM_DD) ;
    		String imgPath = AppContextHolder.getFileSavePath() + curPath ;
      	    String filePathSub  = FileUploadUtils.saveBase64Img(imgCode,imgPath);
            ResponseData response = new ResponseData(true);
            response.setObj(filePathSub);
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }
    
    
    
    
    /**
     * 图片上传
     * 
     * @Desc
     * @author GuoJun
     * @date 2017-07-11
     */
    @RequestMapping(value = "/uploadImg.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData uploadImg(HttpServletRequest request) {
        String folder = request.getParameter("folder");
        if (StringUtils.isBlank(folder)) {
            folder = DEFAULT_FOLDER;
        }
        try {
            // 获取上传文件
            MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
            //List<MultipartFile> mfList = multipartRequest.getFiles("imgFile");
            Iterator<String> iterator = mhsr.getFileNames();
            if (iterator == null || !iterator.hasNext()) {
                return new ResponseData(false, "请选择上传文件");
            }
            List<Map<String, String>> messageList = new ArrayList<Map<String,String>>();
            while (iterator.hasNext()) {
                MultipartFile imgFile = mhsr.getFile(iterator.next().toString());
                if (imgFile.getSize() > SysFile.PIC_SIZE) {
                    return new ResponseData(false, "图片超过限制大小(" + (SysFile.PIC_SIZE / 1024 / 1024) + "MB)");
                }
                // 文件全名
                String originalFilename = imgFile.getOriginalFilename();
                // 文件后缀
                String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                // 获取不重复文件名
                String fileName = DateUtils.formatDatetime(new Date(), DateStyle.YYYYMMDDHHMMSSSSS) + ext.toLowerCase();
                // 获取文件保存路径
                String filePath = AppContextHolder.getFileSavePath() + folder + "/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYY_MM_DD) + "/" + fileName;
                File newFile = new File(filePath);
                if (!newFile.getParentFile().exists()) {
                    newFile.getParentFile().mkdirs();
                }
                byte[] fileByte = imgFile.getBytes();
                FileUtils.writeByteArrayToFile(new File(filePath), fileByte);

                Map<String, String> map = new HashMap<String, String>();
                map.put(FILE_NAME, originalFilename);
                map.put(SRC, folder + "/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYY_MM_DD) + "/" + fileName);
                //2017-11-09 11:43 去掉不用属性by GuoJun
                map.put("path", SettingUtil.getSetting("files.contextpath", String.class) + folder + "/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYY_MM_DD) + "/" + fileName);
                messageList.add(map);
            }
            ResponseData response = new ResponseData(true);
            response.setObj(messageList);
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }

}
