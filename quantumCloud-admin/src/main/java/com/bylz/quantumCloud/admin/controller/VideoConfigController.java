package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.admin.util.ExpiryMap;
import com.bylz.quantumCloud.admin.util.FileUploadUtils;
import com.bylz.quantumCloud.admin.util.FtpUtils;
import com.bylz.quantumCloud.admin.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.bylz.quantumCloud.service.ExamQuestionSetService;
import com.bylz.quantumCloud.service.VideoInfoService;
import com.jcraft.jsch.SftpException;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.util.SettingUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/6
 */
@Controller
@RequestMapping("/videoConfig")
public class VideoConfigController {

    @Autowired
    private VideoInfoService videoInfoService;

    @RequestMapping("/index.html")
    public String getIndex(Model model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",videoInfoService.findPager(filter).getReturnObj());
        model.addAttribute("limit",request.getParameter("limit") == null?10:request.getParameter("limit"));
        return "/videoConfig/index";
    }

    @RequestMapping("/add.html")
    public String addAppPush(Model model) {
        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("selectcatalog");
        List<Map> list = videoInfoService.findList(filter).getReturnObj();
        model.addAttribute("blockList",list);
        return "/videoConfig/add";
    }

    @RequestMapping("/update.html")
    public String updateAppPush(Model model,HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        Map map = videoInfoService.findOne(filter).getReturnObj();
        filter.setStatementKey("selectcatalog");
        List<Map> list = videoInfoService.findList(filter).getReturnObj();
        model.addAttribute("blockList",list);
        model.addAttribute("entity",map);
        return "/videoConfig/update";
    }

    @RequestMapping("/getVid.json")
    @ResponseBody
    public int getVid(String block) {
        QueryFilter filter = new QueryFilter();
        filter.put("block",block);
        int maxVid = videoInfoService.getMaxVid(filter);
        int vid = 0;
        if(maxVid == 0) {
            vid = Integer.parseInt(block + "1");
        } else {
            String maxVidStr = maxVid+"";
            String trimStr = (Integer.parseInt(maxVidStr.substring(block.length(),maxVidStr.length()))+1)+"";
            vid = Integer.parseInt(block+trimStr);
        }
        return vid;
    }


    @RequestMapping("/save.json")
    @ResponseBody
    public ResponseData saveAppPush(VideoInfoVo videoInfoVo) {
        ResponseData data = new ResponseData(true);

        try {
            videoInfoService.save(videoInfoVo);
            data.setMessage("保存成功");
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("保存失败");
            return data;
        }

        return data;
    }

    @RequestMapping("/updVideo.json")
    @ResponseBody
    public ResponseData updAppPush(VideoInfoVo videoInfoVo) {
        ResponseData data = new ResponseData(true);

        try {
            videoInfoService.update(videoInfoVo);
            data.setMessage("修改成功");
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("保存失败");
            return data;
        }

        return data;
    }


    /**
     * 上传视频
     * @param request
     * @return
     */
    @RequestMapping("/uploadVideo.json")
    @ResponseBody
    public void updloadVideo(HttpServletRequest request) {
        try {
            Map map = GetParmFromRequestUtils.getParams(request);

            String chunk = map.get("chunk") == null?null:map.get("chunk").toString();
            String guid  = map.get("guid").toString();

            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            final Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

            for (MultipartFile multipartFile : fileMap.values()) {
                try {
                    FileUploadUtils.uploadChunkFile(chunk,multipartFile,guid);
                }catch (Exception e) {
                    e.printStackTrace();
                }

            }


        }catch (Exception e) {
            e.printStackTrace();
        }


    }


    @RequestMapping("/uploadSuccess.json")
    @ResponseBody
    public ResponseData mergeFile(HttpServletRequest request) throws IOException, SftpException, InterruptedException {
        ResponseData data = new ResponseData(true);
        final String vid = request.getParameter("vid") == null?null:request.getParameter("vid").toString();
        final String type = request.getParameter("videoType") == null?null:request.getParameter("videoType").toString();
        String catalog = request.getParameter("catalog") == null?null:request.getParameter("catalog").toString();
        final String guid = request.getParameter("guid");
        final int chunks = Integer.parseInt(request.getParameter("chunks"));
        final String fileName = request.getParameter("fileName");

        QueryFilter filter = new QueryFilter();
        filter.put("vid",vid);
        filter.put("type",type);
        filter.setStatementKey("getVideoTempByVid");
        Map tempMap = videoInfoService.findOne(filter).getReturnObj();
        if(tempMap != null) {
            String videoType = tempMap.get("type").toString();
            String vname = tempMap.get("videoName").toString();
            String block = tempMap.get("catalog").toString();
            if(type.equals(videoType) && "1".equals(type)) {
                FtpUtils.delete(vname,SettingUtil.getSetting("blockvideo360savepath",String.class)+"/"+block);
            }else if(type.equals(videoType) && "2".equals(type)) {
                FtpUtils.delete(vname,SettingUtil.getSetting("blockvideosavepath",String.class)+"/"+block);
            }
        }

        final String path = AppContextHolder.getBlockSavePath()+guid+"/"+fileName;

        String realPath = "";
        String definitiontTemp = "";
        if("1".equals(type)) {
            realPath = SettingUtil.getSetting("blockvideo360savepath",String.class)+"/" + catalog;
            definitiontTemp = "HD";
        }else {
            realPath = SettingUtil.getSetting("blockvideosavepath",String.class)+"/" + catalog;
            definitiontTemp = "HQ";
        }

        final String definition = definitiontTemp;
        final String filePath = realPath;

        //保存数据库
        filter.put("type",type);
        filter.put("videoName",fileName);
        filter.put("catalog",catalog);
        filter.put("vid",vid);
        filter.setStatementKey("saveVideoTemp");
        videoInfoService.save(filter).getReturnObj();

        data.setObj(catalog+"/"+fileName);


        Thread thread = new Thread(){
            @Override
            public void run() {
                FileInputStream in = null;
                try {
                    if(chunks > 1) {
                        FileUploadUtils.mergeFile(guid,chunks,fileName);
                    }
                    System.out.println("------------------"+guid+"合并完成--------------------");
                    System.out.println("----------------"+guid+"----文件本地路径为："+path+"-------------------------------");
                    in = new FileInputStream(path);
                    System.out.println("--------------"+guid+"--文件大小为：----"+in.available()+"-----------");
                    System.out.println("--------------文件名：--"+fileName+"---开始上传视频服务器-----------------");
                    FtpUtils.upload(filePath,fileName,in.available(),in,vid,definition);
                    System.out.println("----------------上传视频服务器完成---------------------");
                    in.close();
                    System.out.println("------------准备删除临时文件--"+guid+"------------");
                    FileUploadUtils.delFileTemp(guid);
                    System.out.println("--------------"+guid+"-文件删除完毕-------------------");
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        };

        thread.start();
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

            String lectureurl = "";
            String img = "";
            String name = "";
            for (MultipartFile multipartFile : fileMap.values()) {
                String fileName = multipartFile.getOriginalFilename();
                String ext = fileName.substring(fileName.lastIndexOf("."));
                if(".pdf".equals(ext)) {
                    name = "lectureurl";
                    lectureurl = FileUploadUtils.uploadPic(multipartFile,name);
                    lectureurl = SettingUtil.getSetting("project.server.url",String.class) + "/files/" + lectureurl;
                } else {
                    name = "videoImg";
                    img = FileUploadUtils.uploadPic(multipartFile,name);
                    img = SettingUtil.getSetting("project.server.url",String.class) + "/files/" + img;
                }
            }

            Map<String,Object> map1 = new HashMap<>();
            map1.put("lectureurl",lectureurl);
            map1.put("img",img);

            data.setObj(map1);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }


    }


    @RequestMapping("/getExamByVideo.json")
    @ResponseBody
    public List<ExamQuestionSet> getExamByVideo(int vid) {
        List<ExamQuestionSet> list = videoInfoService.getExamByVideo(vid);
        return list;
    }

    @RequestMapping("/deleteVideo.json")
    @ResponseBody
    public ResponseData deleteVideo(long vid) {
        ResponseData data = new ResponseData(true);
        try {
            List<ExamQuestionSet> list = videoInfoService.getExamByVideo(vid);
            if(!list.isEmpty()) {
                data.setSuccess(false);
                data.setMessage("此视频下有题目，不允许删除！");
                return data;
            }

            videoInfoService.delete(vid);
            QueryFilter filter = new QueryFilter();
            filter.put("vid",vid);
            filter.setStatementKey("getVideoTempByVid1");
            List<Map> mapList = videoInfoService.findList(filter).getReturnObj();
            String catalog = mapList.get(0).get("catalog").toString();
            String videoName = mapList.get(0).get("videoName").toString();
            FtpUtils.delete(videoName,SettingUtil.getSetting("blockvideosavepath",String.class)+"/"+catalog);
            FtpUtils.delete(videoName,SettingUtil.getSetting("blockvideo360savepath",String.class)+"/"+catalog);
            data.setMessage("删除成功");
            return data;
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("删除出错");
            return data;
        }
    }


    @RequestMapping("/getHaveVideo.json")
    @ResponseBody
    public int getHaveVideo(String title) {
        int count = videoInfoService.getHaveVideo(title);
        return count;
    }


    @RequestMapping("/changeVideo.json")
    @ResponseBody
    public boolean changeVideo(String catalog,String lastType,String lastPath,String vid) throws Exception  {
        QueryFilter filter = new QueryFilter();
        filter.put("vid",vid);
        filter.setStatementKey("getVideoTempByVid");
        String realPath = "";
        String oldName = "";
        String lastName = lastPath.substring(lastPath.lastIndexOf("/")+1);
        Map map = new HashMap();
        if("1".equals(lastType)) {
            realPath = SettingUtil.getSetting("blockvideosavepath",String.class) + "/" + catalog;
            filter.put("type",2);
            map = videoInfoService.findOne(filter).getReturnObj();

        }else {
            realPath = SettingUtil.getSetting("blockvideo360savepath",String.class) + "/" + catalog;
            filter.put("type",1);
            map = videoInfoService.findOne(filter).getReturnObj();
        }

        if(map != null) {
            oldName = map.get("videoName").toString();
        }

        if(!oldName.equals(lastName)) {
            FtpUtils.rename(realPath,oldName,lastName);
            filter.setStatementKey("updTemp");
            filter.put("videoName",lastName);
            videoInfoService.update(filter);
        }

        return false;
    }


    @RequestMapping("/delUploadVideo.json")
    @ResponseBody
    public void delUploadVideo(final String vid) {
        Thread thread = new Thread(){
            @Override
            public void run() {
                QueryFilter filter = new QueryFilter();
                filter.put("vid",vid);
                filter.setStatementKey("getVideoTempByVid1");
                List<Map> list = videoInfoService.findList(filter).getReturnObj();
                String realPath = "";
                for(Map map : list) {
                    String name = map.get("videoName").toString();
                    if("1".equals(map.get("type"))) {
                        realPath  = SettingUtil.getSetting("blockvideo360savepath",String.class) + "/" + map.get("catalog");
                    }else {
                        realPath = SettingUtil.getSetting("blockvideosavepath",String.class) + "/" + map.get("catalog");
                    }
                    FtpUtils.delete(name,realPath);
                    filter.setStatementKey("delTempVideo");
                    videoInfoService.delete(Long.parseLong(vid));
                }
            }
        };

        thread.start();
    }


    @RequestMapping("/checkVideoHasComplete.json")
    @ResponseBody
    public ResponseData checkVideoHasComplete(String vid) {
        ResponseData data = new ResponseData(true);
        ExpiryMap<String,Object> expiryMap = ExpiryMap.getInstance();
        Map<String,String> map = (Map)expiryMap.get(vid);
        String HDStatus = "";
        String HQStatus = "";
        if(map != null && map.size() > 0) {
            HDStatus = map.get("HD") == null?null:map.get("HD").toString();
            HQStatus = map.get("HQ") == null?null:map.get("HQ").toString();
        }
        if(StringUtils.isNotBlank(HDStatus) && StringUtils.isNotBlank(HQStatus) && "1".equals(HDStatus) && "1".equals(HQStatus)) {
            data.setObj(1);
            expiryMap.remove(vid);
            return data;
        }

        data.setObj(0);
        return data;
    }

}
