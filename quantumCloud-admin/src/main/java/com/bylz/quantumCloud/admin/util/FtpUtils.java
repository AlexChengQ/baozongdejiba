package com.bylz.quantumCloud.admin.util;

import com.jcraft.jsch.*;
import com.likegene.framework.util.SettingUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.Properties;
import java.util.UUID;
import java.util.Vector;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/11
 */
public class FtpUtils {
    private static final Logger logger = LoggerFactory.getLogger(FtpUtils.class);
    /**
     * FTP 登录用户名
     */
    private static String UserName = SettingUtil.getSetting("ftp.username",String.class);
    /**
     * FTP 登录密码
     */
    private static String Password = SettingUtil.getSetting("ftp.password",String.class);
    /**
     * FTP 服务器地址IP地址
     */
    private static String Ip = SettingUtil.getSetting("ftp.ip",String.class);
    /**
     * FTP 端口
     */
    private static String Port = SettingUtil.getSetting("ftp.port",String.class);

    private static ChannelSftp sftp = null;


    public static void getConnect(){
        try {
            JSch jsch = new JSch();

            //获取sshSession  账号-ip-端口
            Session sshSession =jsch.getSession(UserName, Ip,Integer.parseInt(Port));
            //添加密码
            sshSession.setPassword(Password);
            Properties sshConfig = new Properties();
            //严格主机密钥检查
            sshConfig.put("StrictHostKeyChecking", "no");

            sshSession.setConfig(sshConfig);
            //开启sshSession链接
            sshSession.connect();
            //获取sftp通道
            Channel channel = sshSession.openChannel("sftp");
            //开启
            channel.connect();
            sftp = (ChannelSftp) channel;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     *
     * @param uploadFile 上传文件的路径
     * @return 服务器上文件名
     */
    public String upload(String uploadFile,String directory) {
        getConnect();
        File file = null;
        String fileName = null;
        try {
            sftp.cd(directory);
            file = new File(uploadFile);
            //获取随机文件名
            fileName  = UUID.randomUUID().toString() + file.getName().substring(file.getName().length()-5);
            //文件名是 随机数加文件名的后5位
            sftp.put(new FileInputStream(file), fileName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return file == null ? null : fileName;
    }

    /**

     * 将输入流的数据上传到sftp作为文件。文件完整路径=basePath+directory

     * @param sftpFileName  sftp端文件名

     * @param input   输入流

     */

    public static void upload(String path, String sftpFileName,long size, InputStream input,String vid,String definition) throws SftpException{

        createDir(path);
        sftp.put(input, sftpFileName,new MyProgressMonitor(size,vid,definition));  //上传文件
    }



    /**
     * 删除文件
     *
     * @param deleteFile
     *            要删除的文件名字
     */
    public static void delete(String deleteFile,String directory) {
        getConnect();
        try {
            sftp.cd(directory);
            sftp.rm(deleteFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除文件夹
     *
     * @param directory
     *            要删除的文件夹
     */
    public static void deleteDir(String directory) {
        getConnect();
        try {
            sftp.rm(directory + "/*");
            sftp.rmdir(directory);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 列出目录下的文件
     *
     * @param directory
     *            要列出的目录
     * @return
     * @throws SftpException
     */
    public static Vector listFiles(String directory)
            throws SftpException {
        return sftp.ls(directory);
    }

    public static void main(String[] args) throws Exception {
        getConnect();
//        sftp.cd("..");
//        sftp.cd("..");
        createDir("/export/video/test/0.6227589572491341");
//        boolean flag = isDirExist("/export/video/test/0.6227589572491341");
//        System.out.println(flag);
    }

    /**
     * 判断目录是否存在
     */
    public static boolean isDirExist(String directory) {
        boolean isDirExistFlag = false;
        try {
            SftpATTRS sftpATTRS = sftp.lstat(directory);
            isDirExistFlag = true;
            return sftpATTRS.isDir();
        } catch (Exception e) {
            if (e.getMessage().toLowerCase().equals("no such file")) {
                isDirExistFlag = false;
            }
        }
        return isDirExistFlag;
    }


    /**
     * 创建一个文件目录
     */
    public static void createDir(String createpath) {
        getConnect();
        try {
            if (isDirExist(createpath)) {
                sftp.cd(createpath);
                return;
            }
            String pathArry[] = createpath.split("/");
            StringBuffer filePath = new StringBuffer("/");
            for (String path : pathArry) {
                if (path.equals("")) {
                    continue;
                }
                filePath.append(path + "/");
                if (isDirExist(filePath.toString())) {
                    sftp.cd(filePath.toString());
                } else {
                    // 建立目录
                    sftp.mkdir(filePath.toString());
                    // 进入并设置为当前目录
                    sftp.cd(filePath.toString());
                }
            }
            sftp.cd(createpath);
        } catch (SftpException e) {
            e.printStackTrace();
            logger.error("创建目录出错");
        }
    }

    /**
     * 更改文件名
     *
     * @param directory
     *           文件所在目录
     * @param oldFileNm
     *           原文件名
     * @param newFileNm
     *           新文件名
     *
     * @throws Exception
     */
    public static void rename(String directory, String oldFileNm, String newFileNm)
            throws Exception
    {
        getConnect();
        sftp.cd(directory);
        sftp.rename(oldFileNm, newFileNm);
        disconnect();
    }


    /**
     * sftp断开连接
     */
    public static void disconnect() {
        if (sftp != null) {
            if (sftp.isConnected()) {
                sftp.disconnect();
            } else if (sftp.isClosed()) {
                System.out.println("sftp is closed already");
            }
        }
    }
}

