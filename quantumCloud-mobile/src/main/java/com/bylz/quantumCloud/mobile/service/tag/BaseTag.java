package com.bylz.quantumCloud.mobile.service.tag;

import java.io.IOException;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import freemarker.core.Environment;
import freemarker.template.SimpleHash;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

/**
 * 
 * Description of the class
 *
 * @author            JT
 * @version           1.0
 * @since             2016-8-28
 */
public abstract class BaseTag implements TemplateDirectiveModel{

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
	    String var = params.get("var").toString();
	    String method = params.get("method").toString();
		if (StringUtils.isBlank(method)) {
            env.getOut().write(this.getClass()+"方法名method不能为空");
            return;
        }
		if (StringUtils.isBlank(var)) {
		    env.getOut().write(this.getClass()+"变量名var不能为空");
		    return;
		}
		SimpleHash result = new SimpleHash();
		
		process(method, params, var, result, loopVars);
		
		if (body != null) {
            try {
                body.render(env.getOut());
            } catch (TemplateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
		env.setVariable(var, result);
	}
	
	public abstract void process(String method, Map params, String var, SimpleHash result,TemplateModel[] loopVars);
	

}
