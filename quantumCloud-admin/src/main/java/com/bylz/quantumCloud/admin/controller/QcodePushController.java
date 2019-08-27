/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.admin.controller;

import java.io.*;
import java.util.*;

import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.web.servlet.ShiroHttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.admin.util.TemplateSendEmail;
import com.bylz.quantumCloud.model.QcodePushVo;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.QcodePushService;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.likegene.framework.core.formvalidator.FormValidatorManager;

import freemarker.template.TemplateException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * 批量推送消息Controller
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月03日
 */
@Controller
@RequestMapping("/QcodePush")
public class QcodePushController extends BaseController {

    /**
     * 批量推送消息Service
     */
    @Autowired
    private QcodePushService qcodePushService;

    /**
     * 邮件service
     */
    @Autowired
    private TemplateSendEmail templateEmail;

    @Autowired
    private QcodeUserService qcodeUserService;

    public static final int MAX_CNT = 1;

    private static Map<String,Object> mailStatusAll = new HashMap<String,Object>();

    private static Map<String,Object> mailStatus = new HashMap<String,Object>();

    static {
        mailStatus.put("invalid",new ArrayList<QcodeUser>());
        mailStatus.put("validUnsent",new ArrayList<QcodeUser>());
        mailStatus.put("failedCount",0);
        mailStatus.put("successCount",0);
        mailStatus.put("allCount",0);
        mailStatus.put("status","complete");
    }
    /**
     * 批量推送消息列表
     */
    @RequestMapping(value = "/index.html")
    public String index(ModelMap model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey(QcodePushService.SELECT_INDEX_LIST);
        filter.put("order", "qp.`create_time` DESC");
        model.put("pager", qcodePushService.findPager(filter).getReturnObj());
        model.put("mailStatus",mailStatusAll);
        return "/qCodePush/index";
    }

    /**
     * 展示添加页面
     */
    @RequestMapping(value = "/add.html")
    public String add() {
        return "/qCodePush/add";
    }

    /**
     * 保存及发送邮件
     */
    @Transactional(propagation = Propagation.REQUIRED)
    @RequestMapping(value = "/save.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData save(@ModelAttribute("entity") QcodePushVo entity, HttpServletRequest request) {
        Map<String, Object> errors = FormValidatorManager.validate("saveQcodePushConfig", request);
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        if (null == fileMap) {
            return new ResponseData(false, "请选择上传文件");
        }
        try {
            for (MultipartFile multipartFile : fileMap.values()) {

                // 文件全名
                String realFileName = multipartFile.getOriginalFilename();

                // 文件后缀
                String suffix = realFileName.substring(realFileName.lastIndexOf("."));
                entity.setContent(realFileName);
                // 获取文件保存路径
                String filePath = QcodePushController.class.getResource("/templates").getPath()+realFileName;
                byte[] fileByte = new byte[0];
                fileByte = multipartFile.getBytes();
                FileUtils.writeByteArrayToFile(new File(filePath), fileByte);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            if (errors.size() != 0) {
                return new ResponseData(false, errors.keySet().toString());
            }
            //获取当前登陆用户
            SysUser sysUser = AppContextHolder.getCurrentUser();
            entity.setUserId(sysUser.getId());
            Result result = qcodePushService.save(entity);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            } else {
                return ResponseData.SUCCESS_NO_DATA;
            }
        } catch (DuplicateKeyException e) {
            Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")) {
                result.addErrormsg("id  重复");
            }
            return ResponseData.FAILED_NO_DATA;
        } catch (Exception e) {
            return ResponseData.FAILED_NO_DATA;
        }

    }
    @RequestMapping(value = "/edit.html")
    public String edit(Long id, HttpServletRequest request, HttpServletResponse response) {
        QueryFilter filter = new QueryFilter();
        filter.put("id", id);
        request.setAttribute("entity", qcodePushService.findOne(filter).getReturnObj());
        return "/qCodePush/edit";
    }

    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData update(ModelMap model, @ModelAttribute("entity") QcodePushVo entity,
            HttpServletRequest request, HttpServletResponse response) {
        try{
            Map<String,Object> errors = FormValidatorManager.validate("saveQcodePushConfig", request);
            if (errors.size() != 0)
            {
                return new ResponseData(false, errors.keySet().toString());
            }
            Result result = qcodePushService.update(entity);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            }
        }catch(DuplicateKeyException e){
            Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")){
                result.addErrormsg("id  重复");
            }
            return new ResponseData(false, result.getErrormsg());
        } catch(Exception e)
        {
            return new ResponseData(false, e.getMessage());
        }
        return ResponseData.SUCCESS_NO_DATA;
    }
    /**
     * 保存及发送邮件
     */
    @RequestMapping(value = "/sendPushMail.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData sendPushMail(Long id,String email,String isShow, HttpServletRequest request) {
            QueryFilter filter = new QueryFilter();
            filter.put("id", id);
            final QcodePushVo entity = qcodePushService.findOne(filter).getReturnObj();
            String[] emails;
            final InternetAddress[] to;
            if (isShow.equals("1")){
                emails = email.split(",");
                to=new InternetAddress[emails.length];
                for (int i = 0; i <emails.length ; i++) {
                    try {
                        to[i] = new InternetAddress(emails[i]);
                    } catch (AddressException e) {
                        e.printStackTrace();
                    }
                }
            }else {
                  /*查询所有的邮箱*/
                filter.clear();
                filter.setStatementKey("findEmails");
                List<QcodePushVo> list = qcodePushService.findList(filter).getReturnObj();
                to=new InternetAddress[list.size()];
                for (int i = 0; i <list.size() ; i++) {
                    try {
                        to[i] = new InternetAddress( list.get(i).getEmail());
                    } catch (AddressException e) {
                        e.printStackTrace();
                    }
                }
            }
            //开启线程
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        int emailCnt = to.length;//数组数量
                        int formIndex = 0;
                        int toIndex = 0;//结束下标
                        while (emailCnt>toIndex) {
                            toIndex = emailCnt > (toIndex+ MAX_CNT) ? (toIndex+ MAX_CNT): emailCnt;
                            InternetAddress[] newData = Arrays.copyOfRange(to, formIndex, toIndex);
                            formIndex = toIndex;
                            try {
                                templateEmail.sendPushMail(entity, newData);
                            } catch (SendFailedException e) {
                                System.out.println(Arrays.toString(e.getInvalidAddresses()));
                                System.out.println(Arrays.toString(e.getValidUnsentAddresses()));
                                e.printStackTrace();
                            } catch (MessagingException e) {
                                e.printStackTrace();
                            } catch (IOException e) {
                                e.printStackTrace();
                            } catch (TemplateException e) {
                                e.printStackTrace();
                            }
                            try {
                                Thread.sleep(40000);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }).start();
            return ResponseData.SUCCESS_NO_DATA;
    }


    @RequestMapping("/sendHtmlMail.json")
    @ResponseBody
    public ResponseData readXls(final QcodePushVo qcodePushVo) throws IOException {
        final List<QcodeUser> list = qcodeUserService.getAllUserEmail(new QueryFilter());
//        InputStream is = new FileInputStream("C:\\Users\\QuantumBYLZ061901\\Desktop\\tt.xlsx");
//        XSSFWorkbook excel = new XSSFWorkbook(is);
//        final List<QcodeUser> ulist = new ArrayList<QcodeUser>();
//
//        // 循环工作表Sheet
//        for (int numSheet = 0; numSheet < excel.getNumberOfSheets(); numSheet++) {
//            Sheet sheet = excel.getSheetAt(numSheet);
//            if (sheet == null)
//                continue;
//            // 循环行Row
//            for (int rowNum = 0; rowNum <= sheet.getLastRowNum(); rowNum++) {
//                QcodeUser qcodeUser = new QcodeUser();
//                Row row = sheet.getRow(rowNum);
//                if (row == null)
//                    continue;
//                int firstCellIndex = row.getFirstCellNum();
//                int lastCellIndex = row.getLastCellNum();
//                for (int cIndex = firstCellIndex; cIndex < lastCellIndex; cIndex++) {   //遍历列
//                    Cell cell = row.getCell(cIndex);
//                    if (cell != null) {
//                       if(cIndex == 0) {
//                           qcodeUser.setName(cell.toString());
//                       }else {
//                           qcodeUser.setEmail(cell.toString());
//                       }
//                    }
//                }
//                ulist.add(qcodeUser);
//            }
//        }
//        final List<QcodeUser> list = ulist;
        mailStatus.put("allCount",list.size());
        mailStatus.put("invalid",new ArrayList<QcodeUser>());
        mailStatus.put("validUnsent",new ArrayList<QcodeUser>());
        mailStatus.put("failedCount",0);
        mailStatus.put("successCount",0);
        mailStatus.put("error","");
        new Thread(new Runnable() {
            @Override
            public void run() {
                int count = 0;
                for(QcodeUser qcodeUser:list) {
                    try {
                        System.out.println("---------------开始发送第"+(count+1)+"邮件----------------");
                        mailStatus.put("status","running");
                        mailStatus = templateEmail.sendSingleTemplateMail1Newsletter(qcodeUser,qcodePushVo.getContent(),qcodePushVo.getTitle(),mailStatus);
                        if(mailStatus.get("error") != null && mailStatus.get("error") != "") {
                            List<QcodeUser> userList = list.subList(count,list.size());
                            mailStatus.put("validUnsent",userList);
                            mailStatus.put("failedCount",userList.size());
                            mailStatus.put("status","failSend");
                            break;
                        }
                        mailStatus.put("status","running");
                        System.out.println("----------------第"+(count+1)+"次邮件发送成功----------------------------");
                        Thread.sleep(40000);
                    } catch (IOException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    } catch (TemplateException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    } catch (InterruptedException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    }
                    count++;
                }

                if(!"failSend".equals(mailStatus.get("status").toString())) {
                    mailStatus.put("status","complete");
                }

            }
        }).start();

        if("failSend".equals(mailStatus.get("status").toString())) {
            mailStatus.put("status","complete");
        }
        mailStatusAll.put(qcodePushVo.getId().toString(),mailStatus);
        ResponseData obj = new ResponseData(true,"发送完成");
        obj.setObj(mailStatus);
        return obj;
    }


    /**
     * 邮件详情页面
     */
    @RequestMapping(value = "/detail.html")
    public String detail(Long id, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter();
        filter.put("id", id);
        request.setAttribute("entity", qcodePushService.findOne(filter).getReturnObj());
        return "/qCodePush/detail";
    }
    /**
     * 预览
     */
    @RequestMapping(value = "/preview.html")
    public String preview(Long id, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter();
        filter.put("id", id);
        request.setAttribute("qcodePushVo", qcodePushService.findOne(filter).getReturnObj());
        return "/qCodePush/pushEmail";
    }

    /**
     * 查询邮件状态
     * @return
     */
    @RequestMapping("/queryStatus.json")
    @ResponseBody
    public Map<String,Object> getMailStatus() {
        return (Map<String, Object>) mailStatusAll;
    }


    /**
     * 获取邮件状态
     * @param modelMap
     * @param id
     * @param flag
     * @return
     */
    @RequestMapping("/getFailedMail.html")
    public String getFailedMail(ModelMap modelMap,String id,String flag) {
        modelMap.put("failedList",mailStatusAll.get(id));
        modelMap.put("flag",flag);
        QueryFilter filter = new QueryFilter();
        filter.put("id",id);
        modelMap.put("qcodePushVo",qcodePushService.findOne(filter).getReturnObj());
        return "/qCodePush/failedMail";
    }


    /**
     * 重新发送失败的邮件
     * @param qcodePushVo
     * @return
     */
    @RequestMapping("/sendMailAgain.json")
    @ResponseBody
    public ResponseData sendMailAgain(final QcodePushVo qcodePushVo) {
        Map<String,Object> map = (Map<String,Object>)mailStatusAll.get(qcodePushVo.getId().toString());
        final List<QcodeUser> list = (List<QcodeUser>)map.get("validUnsent");
        mailStatus.put("invalid",new ArrayList<QcodeUser>());
        mailStatus.put("validUnsent",new ArrayList<QcodeUser>());
        mailStatus.put("failedCount",0);
        mailStatus.put("successCount",0);
        mailStatus.put("error","");
        mailStatus.put("allCount",list.size());
        new Thread(new Runnable() {
            @Override
            public void run() {
                int count = 0;
                for(QcodeUser qcodeUser:list) {
                    try {
                        System.out.println("---------------开始发送第"+count+"邮件----------------");
                        mailStatus = templateEmail.sendSingleTemplateMail1Newsletter(qcodeUser,qcodePushVo.getContent(),qcodePushVo.getTitle(),mailStatus);
                        mailStatusAll.put(qcodePushVo.getId().toString(),mailStatus);
                        if(mailStatus.get("error") != null && mailStatus.get("error") != "") {
                            List<QcodeUser> userList = list.subList(count,list.size());
                            mailStatus.put("validUnsent",userList);
                            mailStatus.put("failedCount",userList.size());
                            mailStatus.put("status","failSend");
                            break;
                        }
                        mailStatus.put("status","running");
                        System.out.println("----------------第"+(count+1)+"次邮件发送成功----------------------------");
                        Thread.sleep(40000);
                    } catch (IOException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    } catch (TemplateException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    } catch (InterruptedException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    }
                    count++;
                }

                if(!"failSend".equals(mailStatus.get("status").toString())) {
                    mailStatus.put("status","complete");
                }
            }
        }).start();


        ResponseData obj = new ResponseData(true,"发送完成");
        obj.setObj(mailStatus);
        return obj;
    }


    /**
     * 选择EXCEL文件发送邮件
     * @param qcodePushVo
     * @param request
     * @return
     */
    @RequestMapping("/readXlsxSendMail.json")
    @ResponseBody
    public ResponseData readXlsSendMail(final QcodePushVo qcodePushVo,HttpServletRequest request) {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        XSSFWorkbook wb = null;
        List<QcodeUser> list = new ArrayList<QcodeUser>();
        if (null == fileMap) {
            return new ResponseData(false, "请选择上传文件");
        }
        try {
            for (MultipartFile multipartFile : fileMap.values()) {
                InputStream in = multipartFile.getInputStream();
                wb = new XSSFWorkbook(in);
                for (int numSheet = 0; numSheet < wb.getNumberOfSheets(); numSheet++) {
                    Sheet sheet = wb.getSheetAt(numSheet);
                    if (sheet == null)
                        continue;
                    // 循环行Row
                    for (int rowNum = 0; rowNum <= sheet.getLastRowNum(); rowNum++) {
                        QcodeUser qcodeUser = new QcodeUser();
                        Row row = sheet.getRow(rowNum);
                        if (row == null)
                            continue;
                        int firstCellIndex = row.getFirstCellNum();
                        int lastCellIndex = row.getLastCellNum();
                        for (int cIndex = firstCellIndex; cIndex < lastCellIndex; cIndex++) {   //遍历列
                            Cell cell = row.getCell(cIndex);
                            if (cell != null) {
                                if(cIndex == 0) {
                                    qcodeUser.setName(cell.toString());
                                }else {
                                    qcodeUser.setEmail(cell.toString());
                                }
                            }
                        }
                        list.add(qcodeUser);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        final List<QcodeUser> ulist = list;

        mailStatus.put("allCount",list.size());
        mailStatus.put("invalid",new ArrayList<QcodeUser>());
        mailStatus.put("validUnsent",new ArrayList<QcodeUser>());
        mailStatus.put("failedCount",0);
        mailStatus.put("successCount",0);
        mailStatus.put("error","");
        new Thread(new Runnable() {
            @Override
            public void run() {
                int count = 0;
                for(QcodeUser qcodeUser:ulist) {
                    try {
                        System.out.println("---------------开始发送第"+(count+1)+"邮件----------------");
                        mailStatus.put("status","running");
                        mailStatus = templateEmail.sendSingleTemplateMail1Newsletter(qcodeUser,qcodePushVo.getContent(),qcodePushVo.getTitle(),mailStatus);
                        if(mailStatus.get("error") != null && mailStatus.get("error") != "") {
                            List<QcodeUser> userList = ulist.subList(count,ulist.size());
                            mailStatus.put("validUnsent",userList);
                            mailStatus.put("failedCount",userList.size());
                            mailStatus.put("status","failSend");
                            break;
                        }
                        mailStatus.put("status","running");
                        System.out.println("----------------第"+(count+1)+"次邮件发送成功----------------------------");
                        Thread.sleep(40000);
                    } catch (IOException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    } catch (TemplateException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    } catch (InterruptedException e) {
                        System.out.println("----------------第"+(count+1)+"次邮件发送失败，失败原因："+e.getMessage()+"----------------------------");
                        e.printStackTrace();
                    }
                    count++;
                }

                if(!"failSend".equals(mailStatus.get("status").toString())) {
                    mailStatus.put("status","complete");
                }
            }
        }).start();


        mailStatusAll.put(qcodePushVo.getId().toString(),mailStatus);
        return ResponseData.SUCCESS_NO_DATA;
    }

}
