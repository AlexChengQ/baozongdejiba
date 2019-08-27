package com.bylz.quantumCloud.admin.util;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.imageio.ImageIO;


/**
 * 
 * @author JT
 * 
 */
public abstract class FaceFileUtils {

    /** 
     * 截取图片 
     * @param srcImageFile  原图片地址 
     * @param x    截取时的x坐标 
     * @param y    截取时的y坐标 
     * @param desWidth   截取的宽度 
     * @param desHeight   截取的高度 
     */  
    public static void imgCut(String srcImageFile, int x, int y, int desWidth,  
                              int desHeight) {  
        try {  
            Image img;  
            ImageFilter cropFilter;  
            BufferedImage bi = ImageIO.read(new File(srcImageFile));  
            int srcWidth = bi.getWidth();  
            int srcHeight = bi.getHeight();  
            if (srcWidth >= desWidth && srcHeight >= desHeight) {  
                Image image = bi.getScaledInstance(srcWidth, srcHeight,Image.SCALE_DEFAULT);  
                cropFilter = new CropImageFilter(x, y, desWidth, desHeight);  
                img = Toolkit.getDefaultToolkit().createImage(  
                        new FilteredImageSource(image.getSource(), cropFilter));  
                BufferedImage tag = new BufferedImage(desWidth, desHeight,  
                        BufferedImage.TYPE_INT_RGB);  
                Graphics g = tag.getGraphics();  
                g.drawImage(img, 0, 0, null);  
                g.dispose();  
                //输出文件  
                ImageIO.write(tag, "JPEG", new File(srcImageFile));  
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
    
    /**
     * 复制旧文件夹文件到新文件夹
     * @param strPatientImageOldPath
     * @param strPatientImageNewPath
     * @2017-10-21下午1:06:00
     * @JT
     */
    public static void copyFolder(String strPatientImageOldPath,String strPatientImageNewPath)   
    {  
        File fOldFolder = new File(strPatientImageOldPath);//旧文件夹  
        try   
        {  
            File fNewFolder = new File(strPatientImageNewPath);//新文件夹  
            if (!fNewFolder.exists())   
            {  
                fNewFolder.mkdirs();//不存在就创建一个文件夹  
            }  
            File [] arrFiles = fOldFolder.listFiles();//获取旧文件夹里面所有的文件  
            for (int i = 0; i < arrFiles.length; i++)   
            {  
                //从原来的路径拷贝到现在的路径，拷贝一个文件  
                if (!arrFiles[i].isDirectory())   
                {  
                    copyFile(strPatientImageOldPath+"/"+arrFiles[i].getName(), strPatientImageNewPath+"/"+arrFiles[i].getName());  
                }  
            }  
        }   
        catch (Exception e)   
        {  
            // TODO: handle exception  
        }
        }
    
    /**
     * 单个文件复制
     * @param strOldpath
     * @param strNewPath
     * @2017-10-21下午1:06:46
     * @JT
     */
    public static void copyFile(String strOldpath,String strNewPath)  
    {  
        try   
        {  
      
            File fOldFile = new File(strOldpath);  
            if (fOldFile.exists())   
            {  
                int byteread = 0;  
                InputStream inputStream = new FileInputStream(fOldFile);  
                FileOutputStream fileOutputStream = new FileOutputStream(strNewPath);  
                byte[] buffer = new byte[1444];   
                while ( (byteread = inputStream.read(buffer)) != -1)   
                {   
                    fileOutputStream.write(buffer, 0, byteread);//三个参数，第一个参数是写的内容，  
                    //第二个参数是从什么地方开始写，第三个参数是需要写的大小  
                }   
                inputStream.close();  
                fileOutputStream.close();  
            }  
        }  
        catch (FileNotFoundException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        } catch (IOException e) {  
            // TODO Auto-generated catch block  
            System.out.println("复制单个文件出错");  
            e.printStackTrace();  
        }  
    }
    
  //删除文件夹
  //param folderPath 文件夹完整绝对路径

       public static void delFolder(String folderPath) {
       try {
          delAllFile(folderPath); //删除完里面所有内容
          String filePath = folderPath;
          filePath = filePath.toString();
          java.io.File myFilePath = new java.io.File(filePath);
          myFilePath.delete(); //删除空文件夹
       } catch (Exception e) {
         e.printStackTrace(); 
       }
  }

  //删除指定文件夹下所有文件
  //param path 文件夹完整绝对路径
     public static boolean delAllFile(String path) {
         boolean flag = false;
         File file = new File(path);
         if (!file.exists()) {
           return flag;
         }
         if (!file.isDirectory()) {
           return flag;
         }
         String[] tempList = file.list();
         File temp = null;
         for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
               temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
               temp.delete();
            }
            if (temp.isDirectory()) {
               delAllFile(path + "/" + tempList[i]);//先删除文件夹里面的文件
               delFolder(path + "/" + tempList[i]);//再删除空文件夹
               flag = true;
            }
         }
         return flag;
       }
}
