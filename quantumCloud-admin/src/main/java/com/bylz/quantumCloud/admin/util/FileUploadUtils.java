package com.bylz.quantumCloud.admin.util;

import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.model.QcodeUser;
import com.likegene.framework.util.SettingUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import java.io.*;
import java.util.Date;

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
			filePath += "/"+userId+ DateUtils.formatDatetime(new Date(), DateUtils.DateStyle.YYYYMMDDHHMMSSSSS);
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
	 * 普通方式上传文件
	 */
	public static String uploadPic(MultipartFile file,String name) {
		String finalFilePath = "";
		String fileName = "";
		if(file != null && !file.isEmpty()) {
			fileName = file.getOriginalFilename();
			String filePath = AppContextHolder.getBlockSavePath()+name;
			finalFilePath = filePath + "/"+fileName;
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


	/**
	 * 普通方式上传文件
	 */
	public static String uploadPicForExam(MultipartFile file,String name) {
		String finalFilePath = "";
		String fileName = "";
		if(file != null && !file.isEmpty()) {
			fileName = file.getOriginalFilename();
			String filePath = AppContextHolder.getBlockSavePath()+name;
			finalFilePath = filePath + "/"+fileName;
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
		return finalFilePath;
	}


	/**
	 * 普通方式上传文件
	 */
	public static void uploadChunkFile(String chunk,MultipartFile file,String name) {
		String finalFilePath = "";
		if(file != null && !file.isEmpty()) {
			String filePath = AppContextHolder.getBlockSavePath()+name;
			if(StringUtils.isNotBlank(chunk)) {
				finalFilePath = filePath + "/"+chunk;
			}else {
				finalFilePath = filePath + "/" +file.getOriginalFilename();
			}

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
	}

	//文件合并
	public static void mergeFile(String guid,int chunks,String fileName) throws IOException {

		String filePath = AppContextHolder.getBlockSavePath()+guid;
		/**
		 * 进行文件合并
		 */
		File file = new File(filePath);
		/**
		 * 判断分片数量是否正确
		 */
		if(file.list().length != chunks){
			return;
		}

		/**
		 * 进行文件合并
		 */
		File newFile = new File(filePath + "/" + fileName);
		FileOutputStream outputStream = new FileOutputStream(newFile, true);//文件追加写入

		byte[] byt = new byte[10*1024*1024];
		int len;
		FileInputStream temp = null;//分片文件
		for(int i = 0 ; i<chunks ; i++){
			temp = new FileInputStream(new File(filePath+"/"+i));
			while((len = temp.read(byt))!=-1){
				outputStream.write(byt, 0, len);
			}
		}

		/**
		 * 当所有追加写入都写完  才可以关闭流
		 */
		outputStream.close();
		temp.close();
	}

	//删除临时文件
	public static void delFileTemp(String guid) {
		String realPath = AppContextHolder.getBlockSavePath() + "/" + guid;
		delAllFile(realPath);
		File file = new File(realPath);
		file.delete();
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
				boolean result = temp.delete();
				int tryCount = 0;
				while (!result && tryCount++ < 10) {
					System.gc(); // 回收资源
					result = temp.delete();
				}
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i]);//先删除文件夹里面的文件
				flag = true;
			}
		}
		return flag;
	}
}
