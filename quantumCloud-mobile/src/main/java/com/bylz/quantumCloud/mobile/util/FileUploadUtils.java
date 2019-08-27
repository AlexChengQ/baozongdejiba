package com.bylz.quantumCloud.mobile.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import org.apache.shiro.codec.Base64;

import com.bylz.quantumCloud.mobile.core.AppContextHolder;
import com.bylz.quantumCloud.mobile.util.DateUtils.DateStyle;

/**
 * 文件上传公用类
 * */
public class FileUploadUtils {

	/**
	 * 替换html中的base64图片数据为实际图片
	 * 
	 * @param html
	 * @param fileRoot
	 *            本地路径
	 * @param serRoot
	 *            服务器路径
	 * @return
	 * @throws Exception
	 */
	public static String saveBase64Img(String ImgStr, String filePath) {

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
			filePath += File.separator+ DateUtils.formatDatetime(new Date(),DateStyle.YYYYMMDDHHMMSSSSS);
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
		return filePathSub.replace("\\", "/");
	}
	
}
