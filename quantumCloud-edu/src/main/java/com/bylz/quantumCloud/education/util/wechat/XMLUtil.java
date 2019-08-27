package com.bylz.quantumCloud.education.util.wechat;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.Writer;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONObject;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.naming.NoNameCoder;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;
import com.thoughtworks.xstream.io.xml.XppDriver;

/**
 * XML工具包 XMLUtil
 * 
 * @author houdongdong
 * @version 1.0.0
 *
 */
@Component
public class XMLUtil {
	
	
	/**
     * 解析微信发来的请求（XML）
     * 
     * @param request
     * @return Map
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static Map<Object,Object> parseXml(HttpServletRequest request) throws Exception {
        // 将解析结果存储在HashMap中
        Map<Object,Object> map = new HashMap<Object,Object>();
 
        // 从request中取得输入流
        InputStream inputStream = request.getInputStream();
        // 读取输入流
        SAXReader reader = new SAXReader();
        Document document = reader.read(inputStream);
        // 得到xml根元素
        Element root = document.getRootElement();
        // 得到根元素的所有子节点
        List<Element> elementList = root.elements();
 
        // 遍历所有子节点
        for (Element e : elementList)
            map.put(e.getName(), e.getText());
 
        // 释放资源
        inputStream.close();
        inputStream = null;
 
        return map;
    }
	
	  /**
     * 获取http请求参数
     *
     * @param request
     * @return
     * @throws Exception
     * @author lvliang
     * @since 2018-1-9
     */
    public static Map<String ,Object> getParams(HttpServletRequest request) throws Exception{
    	Enumeration<String> parameterNames = request.getParameterNames();
    	Map<String ,Object> map = null;
    	if (parameterNames.hasMoreElements()) {//Content-Type:application/x-www-form-urlencoded
    		map = new HashMap<String ,Object>();
    		while (parameterNames.hasMoreElements()) {
				String parameterName = (String) parameterNames.nextElement();
				map.put(parameterName, request.getParameter(parameterName));
			}
    		return map;
		}
    	
		StringBuilder sb = new StringBuilder();// 非Content-Type:application/x-www-form-urlencoded的处理
		InputStream is = request.getInputStream();
		BufferedInputStream bis = new BufferedInputStream(is);
		byte[] buffer = new byte[1024];
		int read = 0;
		while ((read = bis.read(buffer)) != -1) {
			sb.append(new String(buffer, 0, read, "UTF-8"));
		}
		
		if(sb!=null && !"".equals(sb+"")){
			try {
				map = JSONObject.parseObject(sb.toString(), Map.class);
			} catch (com.alibaba.fastjson.JSONException e) { //在异常中对taskTyp=xxx&qprog=xxxx&typ=xxx&repeat=xxx&token=xxxx这种数据的处理
				String sbStr = URLDecoder.decode(sb.toString());
				StringBuffer sbStringBuffer =new StringBuffer() ;
				sbStringBuffer.append("{\"").append(sbStr.toString().trim().replaceAll("&", "\",\"").replaceAll("=", "\":\"")).append("\"}");
				map = JSONObject.parseObject(sbStringBuffer.toString(), Map.class);
			}
		}
		is.close();
		return map;
    }
	

	/**
	 * 解析字符串（XML）
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> parseXml(String msg) throws Exception {
		// ResultObj obj = new ResultObj();
		// 将解析结果存储在HashMap中
		Map<String, String> map = new HashMap<String, String>();
		// 从request中取得输入流
		InputStream inputStream = new ByteArrayInputStream(msg.getBytes("UTF-8"));
		// 读取输入流
		SAXReader reader = new SAXReader();
		Document document = reader.read(inputStream);
		// 得到xml根元素
		Element root = document.getRootElement();
		// 得到根元素的所有子节点
		List<Element> elementList = root.elements();
		// 遍历所有子节点
		for (Element e : elementList) {
			map.put(e.getName(), e.getText());
		}
		// 释放资源
		inputStream.close();
		inputStream = null;
		return map;
	}

	
	/**  
     * Map 转 XML  
     * @param map  
     * @return  
     */  
    public static byte[] callMapToXML(Map map) {  
//        System.out.println("将Map转成Xml, Map：" + map.toString());  
        StringBuffer sb = new StringBuffer();  
//        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");  
        sb.append("<xml>");  
        mapToXMLTest2(map, sb);  
        sb.append("</xml>");  
//        System.out.println("将Map转成Xml, Xml：" + sb.toString());  
        try {  
            return sb.toString().getBytes("UTF-8");  
        } catch (Exception e) {  
            System.out.println(e);  
        }  
        return null;  
    }  
  
    private static void mapToXMLTest2(Map map, StringBuffer sb) {  
        Set set = map.keySet();  
        for (Iterator it = set.iterator(); it.hasNext();) {  
            String key = (String) it.next();  
            Object value = map.get(key);  
            if (null == value)  
                value = "";  
            if (value.getClass().getName().equals("java.util.ArrayList")) {  
                ArrayList list = (ArrayList) map.get(key);  
                sb.append("<" + key + ">");  
                for (int i = 0; i < list.size(); i++) {  
                    HashMap hm = (HashMap) list.get(i);  
                    mapToXMLTest2(hm, sb);  
                }  
                sb.append("</" + key + ">");  
  
            } else {  
                if (value instanceof HashMap) {  
                    sb.append("<" + key + ">");  
                    mapToXMLTest2((HashMap) value, sb);  
                    sb.append("</" + key + ">");  
                } else {  
                	sb.append("<" + key + ">");  
                	sb.append("<![CDATA[" );  
                    sb.append( value );  
                    sb.append("]]>" );  
                    sb.append("</" + key + ">");  
                }  
  
            }  
  
        }  
    }  
	
	
	/**
	 * 扩展xstream，使其支持CDATA块
	 */
	private XStream xstream = new XStream(new XppDriver(new NoNameCoder()) {

		@Override
		public HierarchicalStreamWriter createWriter(Writer out) {
			return new PrettyPrintWriter(out) {
				// 对所有xml节点的转换都增加CDATA标记
				boolean cdata = true;

				@Override
				@SuppressWarnings("rawtypes")
				public void startNode(String name, Class clazz) {
					super.startNode(name, clazz);
				}

				@Override
				public String encodeNode(String name) {
					return name;
				}

				@Override
				protected void writeText(QuickWriter writer, String text) {
					if (cdata) {
						writer.write("<![CDATA[");
						writer.write(text);
						writer.write("]]>");
					} else {
						writer.write(text);
					}
				}
			};
		}
	});

	private XStream inclueUnderlineXstream = new XStream(new DomDriver(null, new XmlFriendlyNameCoder("_-", "_")));

	public XStream getXstreamInclueUnderline() {
		return inclueUnderlineXstream;
	}

	public XStream xstream() {
		return xstream;
	}

}
