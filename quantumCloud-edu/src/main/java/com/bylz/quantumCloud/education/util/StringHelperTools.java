package com.bylz.quantumCloud.education.util;

import org.apache.commons.lang3.StringUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.*;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Random;
import java.util.UUID;


/**
 * 功能、用途、现存BUG: 帮助实现一些通用的字符串处理
 *
 * @author
 * @version 1.0.0
 * @since 1.0.0
 */
public class StringHelperTools extends StringUtils {

    /**
     * null值转换
     *
     * @param args
     * @return 返回转换后数组
     */
    public static Object[] null2String(Object args[]) {
        for (int i = 0; i < args.length; i++) {
            if (args[i] == null || "null".equals(args[i])) {
                args[i] = "";
            }
        }
        return args;
    }

    /**
     * NULL字符串转换，参数对象为null时，返回空字符串
     *
     * @param o 转换原对象
     * @return 字符串
     */
    public static String null2Empty(Object o) {
        if (o == null) {
            return "";
        }
        return o.toString().trim();
    }

    /**
     * NULL或空字符串转换，参数对象为null或空时，返回默认值
     *
     * @param o   转换原对象
     * @param res 默认值
     * @return 字符串
     */
    public static String nvlHtml(Object o, String res) {
        if (o == null || o.toString().trim().equals("")) {
            return res;
        }
        return o.toString().trim();
    }

    /**
     * 字符串替换。如果不需要用正则表达式请用此方法； 否则用String.replaceAll(String regex, String replacement)
     *
     * @param text 需要被处理的字符串
     * @param from 需要被替换掉的字符串
     * @param to   被替换成的字符串
     * @return 被替换后的字符串
     * @see String#replaceAll(String, String)
     */
    public static String replace(String text, String from, String to) {
        if (text == null || from == null || to == null) {
            return null;
        }
        StringBuffer newText = new StringBuffer(text.length() * 2);
        int pos1 = 0;
        int pos2 = text.indexOf(from);
        while (pos2 >= 0) {
            newText.append(text.substring(pos1, pos2)).append(to);
            pos1 = pos2 + from.length();
            pos2 = text.indexOf(from, pos1);
        }
        newText.append(text.substring(pos1, text.length()));
        return newText.toString();
    }

    /**
     * 替换回车为br
     *
     * @param text 原文本
     * @return 替换后文本
     */
    public static String replaceLineFeedCode(String text) {
        return replace(text, "\n", "<br>\n");
    }

    /**
     * 替换\t为4个html空格
     *
     * @param text 原文本
     * @return 替换后文本
     */
    public static String replaceTab24Space(String text) {
        return replace(text, "\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
    }

    /**
     * 对html标签或特殊字符串编码
     *
     * @param html html代码
     * @return String 替换后代码
     */
    public static String replaceQuotes(String html) {

        html = replace(html, "\"", "&quot;");

        return html;
    }

    /**
     * 对html标签或特殊字符串编码
     *
     * @param html html代码
     * @return String 替换后代码
     */
    public static String replaceAllQuotes(String html) {

        html = replace(html, "\"", "&quot;");
        html = replace(html, "\'", "&apos;");

        return html;
    }

    /**
     * 对html中js中引用的字符（比如alert中）转换 单引号
     *
     * @param html html代码
     * @return String 替换后代码
     */
    public static String replaceJsApostrophe(String html) {

        html = replace(html, "'", "\\'");

        return html;
    }

    /**
     * 对html中js中引用的字符（比如alert中）转换 单引号
     *
     * @param html html代码
     * @return String 替换后代码
     */
    public static String replaceJsQuote(String html) {

        html = replace(html, "\"", "\\\"");

        return html;
    }

    /**
     * 检查是否为数字。可以包含小数点，但是小数点个数不能多于一个； 可以包含负号，但是不能只有负号而没有其他数字； 不允许包含逗号
     *
     * @param s 被检查的字符串
     * @return true 表示是数字, false 表示不是数字
     */
    public static boolean isNumber(String s) {
        boolean pointFirst = true;

        int i = 0;
        if (s == null || s.length() < 1) {
            return false;
        }

        boolean negative = false;

        if (s.charAt(0) == '-') {
            i++;
            negative = true;
        }

        while (i < s.length()) {
            if (!Character.isDigit(s.charAt(i))) {
                if ('.' == s.charAt(i) && pointFirst) {
                    pointFirst = false;
                } else {
                    return false;
                }
            }
            i++;
        }

        if (negative && (i == 1)) {
            return false;
        }

        return true;
    }

    /**
     * 检查是否为整数。可以为负整数，但是不能只有负号而没有其他数字
     *
     * @param s 被检查的字符串
     * @return true 表示是整数, false 表示不是整数
     */
    public static boolean isInteger(String s) {
        int i = 0;
        if (s == null || s.trim().length() < 1) {
            return false;
        }

        boolean negative = false;

        if (s.charAt(0) == '-') {
            i++;
            negative = true;
        }

        while (i < s.length()) {
            if (!Character.isDigit(s.charAt(i))) {
                return false;
            }
            i++;
        }
        if (negative && (i == 1)) {
            return false;
        }

        return true;
    }

    /**
     * 判断字符串是否为null或者trim后长度小于1
     *
     * @param arg 要被判断的字符串
     * @return true 为null或者trim后长度小于1
     */
    public static boolean isEmpty(String arg) {
        return arg == null || arg.trim().length() < 1;
    }

    /**
     * 查找字符串
     *
     * @param strSource 原始字符串
     * @param strFrom   开始字符串
     * @param strTo     结束字符串
     * @return 字符串
     */
    public static String find(String strSource, String strFrom, String strTo) {
        String strDest = "";
        int intFromIndex = strSource.indexOf(strFrom) + strFrom.length();
        int intToIndex = strSource.indexOf(strTo);
        if (intFromIndex < intToIndex) {
            strDest = strSource.substring(intFromIndex, intToIndex);
        }
        return strDest;
    }

    /**
     * 对html标签或特殊字符串编码
     *
     * @param html html代码
     * @return String 替换后代码
     */
    public static String encodeHtml(String html) {

        if (isEmpty(html)) {
            return html;
        }

        html = replace(html, "&", "&amp;");
        html = replace(html, "<", "&lt;");
        html = replace(html, ">", "&gt;");
        html = replace(html, "\n", "<br>");
        html = replace(html, "\"", "&quot;");

        return html;
    }

    public static String getChinese(String s) {
        try {
            return new String(s.getBytes("gb2312"), "iso-8859-1");
        } catch (UnsupportedEncodingException e) {
            return s;
        }
    }

    /**
     * 对字符串作MD5加密处理
     *
     * @param inStr 需要被处理的字符串
     * @return 被处理后的字符串，被转换为16进制表示的字符串
     * @throws NoSuchAlgorithmException
     */
    public static String md5(String inStr) {
        StringBuffer sb = new StringBuffer();
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(inStr.getBytes("UTF-8"));
            byte[] r = md.digest();

            for (int i = 0; i < r.length; i++) {
                byte b = r[i];
                sb.append(Character.forDigit((b >> 4 & 0x0F), 16));
                sb.append(Character.forDigit((b & 0x0F), 16));
            }
        } catch (Exception e) {
            // 忽略异常
        }
        return sb.toString();
    }

    /**
     * 将传入的价格加人民币符号（￥）和千分撇（,）
     *
     * @param strPrice 价格字符串
     * @return 处理后字符串
     */
    public static String addRMBQFP(String strPrice) {
        strPrice = null2Empty(strPrice).trim();
        // 负数标志
        String flag = "no";
        if (!"".equals(strPrice)) {
            if ("-".equals(strPrice.substring(0, 1))) {
                strPrice = strPrice.substring(1);
                flag = "yes";
            }
            int pointIndex = strPrice.indexOf('.');
            String strPriceZ = "";
            String strPriceX = "";
            if (pointIndex > 0) {
                strPriceZ = strPrice.substring(0, pointIndex);
                strPriceX = strPrice.substring(pointIndex);
            } else {
                strPriceZ = strPrice;
                strPriceX = "";
            }

            if (strPriceZ.length() >= 4) {
                int qfpNum = (strPriceZ.length() - (strPriceZ.length() % 3)) / 3;
                String tempPrice = "";
                for (int i = 0; i < qfpNum; i++) {
                    tempPrice = "," + strPriceZ.substring(strPriceZ.length() - (i + 1) * 3,
                                    strPriceZ.length() - i * 3) + tempPrice;
                }
                if (strPriceZ.length() % 3 == 0) {
                    tempPrice = tempPrice.trim().substring(1);
                } else {
                    tempPrice = strPriceZ.substring(0, strPriceZ.length() % 3) + tempPrice;
                }
                if ("yes".equals(flag)) {
                    strPrice = "¥-" + tempPrice + strPriceX;
                } else {
                    strPrice = "¥" + tempPrice + strPriceX;
                }
            } else {
                if (!"".equals(strPrice) && !".".equals(strPrice)) {
                    if ("yes".equals(flag)) {
                        strPrice = "¥-" + strPrice;
                    } else {
                        strPrice = "¥" + strPrice;
                    }
                }
            }
        }
        return strPrice;
    }

    /**
     * 把字符串转换成合适的SQL查询语言,适用于 like
     *
     * @param str 转换的字符串 - 可以为null
     * @return String 返回转换后新的SQL文字符串，如果字符串为null就返回null 将用户传入的检索条件中的特殊字符进行转义 <br/>
     * 将 ' 转换 \' <br/>
     * 将 " 转换 \" <br/>
     * 将 % 转换 \% <br/>
     * 用法 " like '"+name+"'" 改写为 " like '"+CmnUtFunc.escapeSql(name)+"'"
     */
    public static String escapeSql(String str) {
        if (str == null || str.equals("")) {
            return str;
        } else {
            StringBuffer buf = new StringBuffer();
            for (int i = 0; i < str.length(); i++) {
                char c = str.charAt(i);
                switch (c) {
                    // 将 ' 转换为 ''
                    case '\'':
                        buf.append("''");
                        break;
                    // 将 " 转换为 \"
                    case '\"':
                        buf.append("\\\"");
                        break;
                    // 将 % 转换为 \%
                    case '%':
                        buf.append("\\%");
                        break;
                    // 将 $ 转换为 \$
                    case '$':
                        buf.append("\\$");
                        break;
                    // 将 \ 转换为 \\
                    case '\\':
                        buf.append("\\\\");
                        break;
                    default:
                        buf.append(c);
                        break;
                }
            }
            return buf.toString();
        }
    }

    /**
     * 把doc格式的字符串转换为html格式,但是对table保持原样
     *
     * @param sourceStr
     * @return targetStr
     */
    public static String getTargetStr(String sourceStr) {
        StringBuffer buf = new StringBuffer();
        int tabSIndex = sourceStr.indexOf("<table>");
        int tabEIndex = sourceStr.indexOf("</table>");
        if (tabSIndex == -1 || tabEIndex == -1) {
            return sourceStr;
        }
        String headStr = sourceStr.substring(0, tabSIndex);
        headStr = headStr.replaceAll("\r\n", "<br>");
        String middleStr = sourceStr.substring(tabSIndex + 1, tabEIndex);
        String endStr = sourceStr.substring(tabEIndex + 1, sourceStr.length() - 1);
        buf.append(headStr);
        buf.append(middleStr);
        if (endStr.indexOf("<table>") != -1) {
            buf.append(getTargetStr(endStr));
        }
        return buf.toString();
    }

    /**
     * 截取字符串，输入字符串长度大于要截取的长度，则显示“…”
     *
     * @param input
     * @param lettersNum 英文个数 ，一个中文占两个英文
     * @return
     */
    public static String subString2(String input, int lettersNum) {

        if (StringUtils.isEmpty(input)) {
            return "";
        }
        String tmpStr = input.trim();

        if (tmpStr.length() * 2 <= lettersNum) {
            return tmpStr;
        }

        int num = 0;
        String temp = "";
        for (int i = 0; i < tmpStr.length() && num < lettersNum; i++) {
            if (tmpStr.substring(i, i + 1).getBytes().length > 1) {
                num += 2;
                temp = tmpStr.substring(0, i + 1);
            } else {
                num += 1;
                temp = tmpStr.substring(0, i + 1);
            }

        }

        if (temp.length() == tmpStr.length()) {
            return temp;
        } else {
            while (num > lettersNum - 2) {
                int i = temp.length();

                if (temp.substring(i - 1, i).getBytes().length > 1) {
                    num = num - 2;
                } else {
                    num = num - 1;
                }
                temp = temp.substring(0, i - 1);
            }
            temp += "…";
        }

        return temp;

    }

    /**
     * 判断字符串是否是数字
     *
     * @param str
     * @return boolean
     */
    public static boolean isNum(String str) {
        return str.matches("^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$");
    }

    /**
     * 判断list的是否为空
     *
     * @param <T>
     * @param list
     * @return
     */
    public static <T> boolean listNotValue(List<T> list) {
        if (list != null && list.size() > 0) {
            return true;
        }
        return false;
    }

    /**
     * 判断字符串是否在定义的字符串数组中存在，不区分大小写。目标字符串会trim后比较
     *
     * @param stringArray 定义的字符串数组
     * @param source      目标字符串
     * @return 是否包含
     */
    public static boolean containsIgnoreCase(String[] stringArray, String source) {
        if (stringArray == null || stringArray.length == 0 || source == null) {
            return false;
        }
        for (int i = 0; i < stringArray.length; i++) {
            if (stringArray[i].equalsIgnoreCase(source.trim())) {
                return true;
            }
        }
        return false;
    }

    /**
     * unicode 转换成 中文
     *
     * @param theString
     * @return
     */

    public static String decodeUnicode(String theString) {

        char aChar;

        int len = theString.length();

        StringBuffer outBuffer = new StringBuffer(len);
        for (int x = 0; x < len; ) {
            aChar = theString.charAt(x++);
            if (aChar == '\\') {
                aChar = theString.charAt(x++);
                if (aChar == 'u') {
                    int value = 0;
                    for (int i = 0; i < 4; i++) {
                        aChar = theString.charAt(x++);
                        switch (aChar) {
                            case '0':
                            case '1':
                            case '2':
                            case '3':
                            case '4':
                            case '5':
                            case '6':
                            case '7':
                            case '8':
                            case '9':
                                value = (value << 4) + aChar - '0';
                                break;
                            case 'a':
                            case 'b':
                            case 'c':
                            case 'd':
                            case 'e':
                            case 'f':
                                value = (value << 4) + 10 + aChar - 'a';
                                break;
                            case 'A':
                            case 'B':
                            case 'C':
                            case 'D':
                            case 'E':
                            case 'F':
                                value = (value << 4) + 10 + aChar - 'A';
                                break;
                            default:
                                throw new IllegalArgumentException(
                                                "Malformed   \\uxxxx   encoding.");
                        }
                    }
                    outBuffer.append((char) value);
                } else {
                    if (aChar == 't')
                        aChar = '\t';
                    else if (aChar == 'r')
                        aChar = '\r';
                    else if (aChar == 'n')
                        aChar = '\n';
                    else if (aChar == 'f')
                        aChar = '\f';
                    outBuffer.append(aChar);
                }
            } else
                outBuffer.append(aChar);
        }

        return outBuffer.toString();

    }

    /**
     * 获取当前UUID，用做数据关联 新增表结构请使用此ID替换seq
     */
    public static String getUUID() {
        UUID uuid = UUID.randomUUID();
        return (uuid.toString()).replaceAll("-", "");
    }

    /**
     * 生成随机密码
     *
     * @param pwd_len 生成的密码的总长度
     * @return 密码的字符串
     */
    public static String genRandomNum(int pwd_len) {
        // 35是因为数组是从0开始的，26个字母+10个数字
        final int maxNum = 36;
        int i; // 生成的随机数
        int count = 0; // 生成的密码的长度
        char[] str = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
                        'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3',
                        '4', '5', '6', '7', '8', '9'};

        StringBuffer pwd = new StringBuffer(pwd_len);
        Random r = new Random();
        while (count < pwd_len) {
            // 生成随机数，取绝对值，防止生成负数，

            i = Math.abs(r.nextInt(maxNum)); // 生成的数最大为36-1

            if (i >= 0 && i < str.length) {
                pwd.append(str[i]);
                count++;
            }
        }

        return pwd.toString();
    }

    /**
     * 获取整数随机数
     *
     * @param count
     * @return
     * @since 2015年7月20日
     */
    public static String getNumberRandom(int count) {
        StringBuffer sb = new StringBuffer();
        String str = "0123456789";
        Random r = new Random();
        for (int i = 0; i < count; i++) {
            int num = r.nextInt(str.length());
            sb.append(str.charAt(num));
            str = str.replace(String.valueOf((str.charAt(num))), "");
        }
        return sb.toString();
    }

    public static void appendSignPara(StringBuilder buf, String key, String value) {
        if (!isEmpty(value)) {
            buf.append(key).append('=').append(value).append('&');
        }
    }

    public static void appendUrlPara(StringBuilder buf, String key, String value) {
        if (!isEmpty(value)) {
            try {
                buf.append(key).append('=').append(URLEncoder.encode(value, "utf-8")).append('&');
            } catch (UnsupportedEncodingException var4) {
                var4.printStackTrace();
            }
        }
    }

    /**
     * 获取随机数
     *
     * @param len
     * @return
     * @since 2015年7月14日
     */
    public static String getRandom(int len) {
        return getUUID().substring(0, len);
    }


    /**
     * 输入流转化为字符串
     *
     * @param is
     * @return
     */
    public static String convertStreamToString(InputStream is) {

        InputStreamReader isr = null;
        BufferedReader reader = null;
        StringBuilder sb = new StringBuilder();
        String line = null;

        try {
            //将输入流编码统一为UTF-8,解决乱码问题
            isr = new InputStreamReader(is, Charset.forName("UTF-8"));
            reader = new BufferedReader(isr);
            while ((line = reader.readLine()) != null) {

                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (isr != null) {
                try {
                    isr.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            try {

                if (is != null) {
                    is.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                is = null;
            }
        }
        return sb.toString();
    }

    /**
     * 把一个xml字符串转换为一个对象
     *
     * @param objXml
     * @param objClass
     * @return
     * @throws Exception
     */
    public static Object generateObj(String objXml, Class<?> objClass) throws Exception {

        //创建一个对象
        Object obj = objClass.newInstance();
        //解析xml
        InputStream inputStream = new ByteArrayInputStream(objXml.getBytes("UTF-8"));
        SAXReader reader = new SAXReader();
        Document document = reader.read(inputStream);
        Element rootElement = document.getRootElement();
        //给对象赋值
        Field[] fieldArray = objClass.getDeclaredFields();
        if(fieldArray!=null && fieldArray.length>0){

            String fieldName = null;
            Class<?> fieldType = null;
            Object fieldVal = null;
            Element fieldElement = null;
            for(Field field : fieldArray){

                fieldName = field.getName();
                fieldType = field.getType();
                fieldElement = rootElement.element(fieldName);
                if(fieldElement!=null){

                    //1.字符串
                    fieldVal = fieldElement.getTextTrim();
                    //2.长整型
                    if(fieldType==Long.class){
                        fieldVal = new Long((String)fieldVal);
                    }
                    objClass.getMethod("set" + fieldName.substring(0,1).toUpperCase() + fieldName.substring(1),new Class[]{fieldType})
                                    .invoke(obj,new Object[]{fieldVal});
                }

            }
        }
        return obj;
    }

}
