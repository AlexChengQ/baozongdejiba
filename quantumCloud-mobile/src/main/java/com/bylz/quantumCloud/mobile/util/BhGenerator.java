package com.bylz.quantumCloud.mobile.util;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.TimeZone;

public class BhGenerator {

	/**
	 * 产生普通编号时所使用的流水号，由getBh()函数调用
	 */
	public static int serialNumber = 0;
	
	/**
	 * 产生普通编号同步线程使用，由getBh()函数调用
	 */
	private static final Object synObj = new Object();
	
	/**
	 * @FunName: getBh
	 * @Description : 产生18位编号
	 * @return String： 返回当前自动生成的编号；
	 */
	public static String getBh() {
		long temp;
		synchronized (synObj) {
			temp = serialNumber++;
			if (serialNumber == 1000) {// 流水号从0-999循环
				serialNumber = 0;
			}
		}
		return getYearMonthDayString() + getNumberFormat(3).format(temp);
	}
		
	/**
	 * 获取6位随机数字
	 * @return
	 */
	public static int getRandom6Int() {
		int RandomInt=(int)(Math.random()*899999)+100000; 
		  //int i= new java.util.Random().nextInt(900)+100;也可以
		return RandomInt;
	}	
		
	
	/**
	 * 获取随机数（字母+数字）
	 * @param count  指定长度
	 * @return
	 */
	public static String getRandomA1(int count) {
	    Random ran = new Random();//用来生成随机数
	    String stringChar = "";//用来存储字母
	    String[] alphabet = {"A","B","C","D","E","F","G","H"
	            ,"I","J","K","L","M","N","O","P","Q","R","S"
	            ,"T","U","V","W","X","Y","Z","1","2","3","4"
	            ,"5","6","7","8","9","0"};//存放大写字母
	    
	    for(int j = 0; j < count; j++){ //字母
            stringChar = stringChar + alphabet[ran.nextInt(36)];
        }
	    
//	    String stringInt = "";//用来存储数字
//	    for(int i = 0 ; i < 100; i++){
//            stringInt = stringInt + ""+ran.nextInt(10);
//        }
	    
		return stringChar;
	}
  
	
	/**
	 * @FunName: getCurrentTimeString
	 * @Description : 获取当前时间字符串，精确到毫秒，其中年2位、月2位、日2位、时2位、分2 位、秒2位、毫秒3位
	 * @return String： 返回当前时间字符串；
	 */
	public static String getCurrentTimeString() {

		NumberFormat formatter2 = getNumberFormat(2);
		NumberFormat formatter3 = getNumberFormat(3);
		NumberFormat formatter4 = getNumberFormat(4);

		Calendar Cld = Calendar.getInstance(TimeZone
				.getTimeZone("Asia/Beijing"));
		StringBuffer sb = new StringBuffer();

		sb.append(formatter2.format(Cld.get(Calendar.YEAR)));
		sb.append(formatter2.format(Cld.get(Calendar.MONTH) + 1));
		sb.append(formatter2.format(Cld.get(Calendar.DATE)));
		sb.append(formatter2.format(Cld.get(Calendar.HOUR_OF_DAY)));
		sb.append(formatter2.format(Cld.get(Calendar.MINUTE)));
		sb.append(formatter2.format(Cld.get(Calendar.SECOND)));
		sb.append(formatter3.format(Cld.get(Calendar.MILLISECOND)));

		return sb.toString();
	}
	public static String getYearMonthDayString(){
		NumberFormat formatter2 = getNumberFormat(2);
		Calendar Cld = Calendar.getInstance(TimeZone
				.getTimeZone("Asia/Beijing"));
		StringBuffer sb = new StringBuffer();
		sb.append(formatter2.format(Cld.get(Calendar.YEAR)));
		sb.append(formatter2.format(Cld.get(Calendar.MONTH) + 1));
		sb.append(formatter2.format(Cld.get(Calendar.DATE)));
		sb.append(formatter2.format(Cld.get(Calendar.HOUR_OF_DAY)));
		return sb.toString();
	}

	/**
	 * @FunName: getNumberFormat
	 * @Description : 获取指定位数为bit的数字格式器
	 * @param bit
	 *            ： 指定的位数
	 * @return NumberFormat： 返回数字格式器；
	 */
	public static NumberFormat getNumberFormat(int bit) {
		NumberFormat formatter = NumberFormat.getNumberInstance();
		formatter.setMinimumIntegerDigits(bit);
		formatter.setMaximumIntegerDigits(bit);
		formatter.setGroupingUsed(false);
		return formatter;
	}
	
	/**
	 * 获取批次，值为每周周一的年月日
	 * 批次获取的时间格式为yyyyMMdd
	 * @return
	 */
	public static String getPc(){
		SimpleDateFormat format=new SimpleDateFormat("yyyyMMdd");
		Calendar c = Calendar.getInstance();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		
		Date date = c.getTime();
		
		return format.format(date);
	}
	
	/**
	 * 获取批次，值为当前周前一周周一的年月日
	 * 批次时间格式为yyyyMMdd
	 * @return
	 */
	public static String getPreviousPc(){
		Calendar c = Calendar.getInstance();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		c.add(Calendar.WEEK_OF_MONTH, -1);
		
		Date date = c.getTime();
		
		SimpleDateFormat format=new SimpleDateFormat("yyyyMMdd");
		return format.format(date);
	}
	
	public static void main(String[] args){
		System.out.println(getBh());
		System.out.println(getPc());
		System.out.println(getPreviousPc());
	}
}
