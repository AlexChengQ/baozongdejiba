package com.bylz.quantumCloud.admin.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.admin.util.FaceFileUtils;
import com.bylz.quantumCloud.model.SysFile;

/**
 * 用于文件上传controller
 * 
 * @author JT
 * @since 2017-04-19
 */
@Controller
@RequestMapping("/uploadFile")
public class FileUploadController extends BaseController {
    
    /**
     * 图片上传
     * 
     * @Desc
     * @author JT
     * @date 2017-4-19
     */
    @RequestMapping(value = "/uploadImg.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData uploadImg(HttpServletRequest request) {

        try {
            //上传图片文件夹
            String pathPrefix = request.getParameter("folder");
            
            if (null == pathPrefix || "".equals(pathPrefix)) {
                pathPrefix = "uploadFile";
            }
            List<Map<String, String>> list = new ArrayList<Map<String, String>>();
            // 获取上传文件
            // MultipartHttpServletRequest multipartRequest =
            // (MultipartHttpServletRequest) request;
            // MultipartFile imgFile = multipartRequest.getFile("imgFile");
            // 获取上传文件
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
            if (null == fileMap) {
                return new ResponseData(false, "请选择上传文件");
            }
            for (MultipartFile multipartFile : fileMap.values()) {

                // 文件全名
                String realFileName = multipartFile.getOriginalFilename();

                // 文件后缀
                String suffix = realFileName.substring(realFileName.lastIndexOf("."));

                // 获取不重复文件名
                String fileName = UUID.randomUUID().toString() + suffix;
                // 获取文件保存路径
                String filePath = fullPath(pathPrefix, fileName);
                byte[] fileByte = multipartFile.getBytes();
                FileUtils.writeByteArrayToFile(new File(filePath), fileByte);
                String src =  fileName;
                Map<String, String> map = new HashMap<String, String>();
                map.put("fileName", realFileName);
                map.put("src", pathPrefix + "/" + src);
                map.put("filePath", filePath);
                list.add(map);
            }
            ResponseData response = new ResponseData(true);
            response.setObj(list);
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }
    /**
     * 获得文件完整路径
     * @param pathPrefix
     * @param fileName
     * @return
     */
    private String fullPath(String pathPrefix,String fileName) {
        String basePath = AppContextHolder.getFileSavePath();
        if (basePath.endsWith("\\") || basePath.endsWith("/")) {
            return basePath + pathPrefix + File.separator  + fileName;
        } else {
            return basePath + File.separator + pathPrefix + File.separator + fileName;
        }
    }
    
    /**
     * 图片剪裁
     * 
     * @Desc
     * @author JT
     * @date 2017-4-19
     */
    @RequestMapping(value = "/uploadCutImg.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData uploadCutImg(HttpServletRequest request) {

        try {
            String cutPic = request.getParameter("cutPic");
            String x = request.getParameter("x1");
            String y = request.getParameter("y1");
            String w = request.getParameter("w");
            String h = request.getParameter("h");
            String path = AppContextHolder.getFileSavePath()+cutPic;
            path=path.replaceAll("/","\\\\");
            //图片裁剪
            FaceFileUtils.imgCut(path,Integer.parseInt(x),Integer.parseInt(y),Integer.parseInt(w),Integer.parseInt(h));
            ResponseData response = new ResponseData(true);
            response.setObj(cutPic);
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }
    
    /**
     * 图片删除
     * 
     * @Desc
     * @author JT
     * @date 2017-4-19
     */
    @RequestMapping(value = "/delImg.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData delImg(HttpServletRequest request) {
    	
        try {
        	ResponseData response = new ResponseData(true);
        	
            String picPath = request.getParameter("picPath");
            String delPic1 = AppContextHolder.getRealPath()+picPath;
            File file1 = new File(delPic1.replaceAll("/","\\\\"));
            if(file1.isFile() && file1.exists()){
                Boolean succeedDelete = file1.delete();
                if(!succeedDelete){
                	return new ResponseData(false,"删除文件失败");
                }
            }                 

            String delPic2 = AppContextHolder.getRealPath()+picPath;
            File file2 = new File(delPic2.replaceAll("/","\\\\").replaceAll(SysFile.CUTFOLDER,SysFile.CUTFOLDER));
            if(file2.isFile() && file2.exists()){
                Boolean succeedDelete = file2.delete();
                if(!succeedDelete){
                	return new ResponseData(false,"删除文件失败");
                }
            }  
            
            response.setObj("删除成功");
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }    
}
