package com.bylz.quantumCloud.platform.controller;

import com.bylz.quantumCloud.model.FocusUserVo;
import com.bylz.quantumCloud.model.ForumUserVo;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.platform.core.AppContextHolder;
import com.bylz.quantumCloud.platform.util.FileUploadUtils;
import com.bylz.quantumCloud.platform.util.SensitiveWordUtil;
import com.bylz.quantumCloud.service.ForumUserService;
import com.bylz.quantumCloud.service.SensitiveWordService;
import com.likegene.framework.core.QueryFilter;
import freemarker.core.Expression;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Set;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/6/22
 */
@Controller
@RequestMapping("/platform/forumuser")
public class ForumUserController extends BaseController  {

    private static final org.slf4j.Logger LOGGER       = LoggerFactory.getLogger(Expression.class);
    @Autowired
    private ForumUserService forumUserService;

    @Autowired
    private SensitiveWordService sensitiveWordService;

    /**
     * 进入论坛用户设置页
     * @param model
     * @return
     */
    @RequestMapping("/getForumUser.html")
    public String getForumUser(Model model) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        model.addAttribute("forumUser",forumUserService.getForumUser(userInfor.getId()));
        model.addAttribute("constellation",forumUserService.getSelectValue());
        return "forum/user";
    }

    /**
     * 论坛通知界面
     */
    @RequestMapping("/getForumInform.html")
    public String getForumInform(Model model) {
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        //查询未读信息
        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("queryNoticCount");
        filter.put("userId",userInfor.getId());
        model.addAttribute("noticCount",forumUserService.findOne(filter).getReturnObj());
        model.addAttribute("userId",userInfor.getId());
        return "forum/inform";
    }

    @RequestMapping("/updForumUser.json")
    @ResponseBody
    public String saveForumUser(ForumUserVo forumUserVo, MultipartFile multipartFile) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        //将图片上传至服务器
        if(multipartFile != null) {
            String realPath = FileUploadUtils.uploadPic(multipartFile);
            forumUserVo.setFace(realPath);
        }

        try {
            forumUserVo.setId(userInfor.getId());
            if(StringUtils.isBlank(forumUserVo.getBirthday())) {
                forumUserVo.setBirthday(null);
            }

            if(StringUtils.isBlank(forumUserVo.getEmail())) {
                return "{'success':false,'message':'邮箱不能为空'}";
            }

            Set<String> set = sensitiveWordService.getSensitiveWordList(new QueryFilter());
            SensitiveWordUtil sensitiveWordUtil = new SensitiveWordUtil(set);
            forumUserVo.setName(sensitiveWordUtil.replaceSensitiveWord(forumUserVo.getName(),"*"));
            forumUserVo.setAutograph(sensitiveWordUtil.replaceSensitiveWord(forumUserVo.getAutograph(),"*"));
            forumUserService.updateForumUser(forumUserVo);
            if(StringUtils.isNotBlank(forumUserVo.getOldFace()) && StringUtils.isNotBlank(forumUserVo.getFace())) {
                String relativePath = AppContextHolder.getFileSavePath()+forumUserVo.getOldFace();
                FileUploadUtils.delPreImg(relativePath);
            }
            return "{'success':true,'message':'保存成功'}";
        }catch (Exception e) {
            e.printStackTrace();
            LOGGER.error(e.getMessage());
            return "{'success':false,'message':'保存失败'}";
        }

    }

}
