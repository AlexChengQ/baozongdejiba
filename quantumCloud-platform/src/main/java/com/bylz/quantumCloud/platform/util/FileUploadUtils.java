package com.bylz.quantumCloud.platform.util;

import java.io.*;
import java.util.Date;

import com.bylz.quantumCloud.model.QcodeUser;
import org.apache.shiro.codec.Base64;

import com.bylz.quantumCloud.platform.core.AppContextHolder;
import com.bylz.quantumCloud.platform.util.DateUtils.DateStyle;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

/**
 * 文件上传公用类
 * */
public class FileUploadUtils {

	/**
	 * 替换html中的base64图片数据为实际图片
	 * 
	 * @param ImgStr
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public static String saveBase64Img(String ImgStr, String filePath,Long userId) {

		String ext = ImgStr.substring(ImgStr.indexOf("/") + 1,ImgStr.indexOf(";"));// 图片后缀
		String base64ImgData = ImgStr.substring(ImgStr.indexOf(",") + 1);// 图片数据
		if ("jpeg".equalsIgnoreCase(ext)) {// data:image/jpeg;base64,base64编码的jpeg图片数据
			ext = "jpg";
		} else if ("x-icon".equalsIgnoreCase(ext)) {// data:image/x-icon;base64,base64编码的icon图片数据
			ext = "ico";
		}
		try {
			File file = new File(filePath);
			if (!file.exists() && !file.isDirectory()) {
				// 如果文件夹不存在则创建
				file.mkdirs();
			}
			filePath += "/"+userId+ DateUtils.formatDatetime(new Date(),DateStyle.YYYYMMDDHHMMSSSSS);
			filePath = filePath + "." + ext;
			convertBase64DataToImage(base64ImgData, filePath);// 转成文件
		} catch (IOException e) {
			e.printStackTrace();
		}

		return filePathSub(filePath);
	}

	/**
	 * 把base64图片数据转为本地图片
	 * @param base64ImgData
	 * @param filePath
	 * @throws IOException
	 */
	private static void convertBase64DataToImage(String base64ImgData,
			String filePath) throws IOException {
		byte[] bs = Base64.decode(base64ImgData);
		FileOutputStream os = new FileOutputStream(filePath);
		os.write(bs);
		os.close();
	}

	/**
	 * 截取图片存储的路径
	 * 
	 * @param filePath
	 * */
	private static String filePathSub(String filePath) {
		if(("//" + filePath).contains(AppContextHolder.getFileSavePath())){
			filePath = ("//" + filePath).substring(AppContextHolder.getFileSavePath().length() + 1);
		}
		
		int firstIndex = filePath.indexOf("/");
		String filePathSub = filePath.substring(firstIndex + 1);
		return filePathSub;
	}


	/**
	 * 根据图片地址转换为base64编码字符串
	 * @param imgFile
	 * @return
	 */
	public static String getImageStr(String imgFile) {
		InputStream inputStream = null;
		byte[] data = null;
		try {
			inputStream = new FileInputStream(imgFile);
			data = new byte[inputStream.available()];
			inputStream.read(data);
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 加密
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);
	}

	/**
	 * 删除上次上传的图片
	 * @param oldFacePath
	 */
	public static void delPreImg(String oldFacePath) {
		File file1 = new File(oldFacePath);
		if(file1.exists()) {
			file1.delete();
		}
	}


	/**
	 * 普通方式上传图片
	 */
	public static String uploadPic(MultipartFile file) {
		QcodeUser userInfor = AppContextHolder.getCurrentUser();
		String finalFilePath = "";
		if(file != null && !file.isEmpty()) {
			String fileName = file.getOriginalFilename();
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String filePath = AppContextHolder.getFileSavePath()+"headFile";
			finalFilePath = filePath + "/"+userInfor.getId()+ DateUtils.formatDatetime(new Date(), DateUtils.DateStyle.YYYYMMDDHHMMSSSSS)+ext;
			try {
				File fileMdk = new File(filePath);
				if (!fileMdk.exists() && !fileMdk.isDirectory()) {
					// 如果文件夹不存在则创建
					fileMdk.mkdirs();
				}

				file.transferTo(new File(finalFilePath));
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
		return filePathSub(finalFilePath);
	}
}
