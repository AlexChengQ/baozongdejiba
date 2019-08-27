package com.bylz.quantumCloud.education.core;


import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.ScoreDetailVo;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.service.UpdateUserScoreService;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.ContextLoader;

import javax.servlet.http.HttpServletRequest;

/**
 * @author songhaozhang
 * @version 1.0
 * @Description:�޸Ļ���ͬʱ��ӻ�����ˮ
 * @since 2019/3/18
 */
@Transactional(rollbackFor = Exception.class)
public class UpdateUserScore {
    private static UpdateUserScoreService updateUserScoreService = (UpdateUserScoreService) ContextLoader.getCurrentWebApplicationContext().getBean("updateUserScoreService");
    private static QcodeUserService qcodeUserService = (QcodeUserService) ContextLoader.getCurrentWebApplicationContext().getBean("qcodeUserService");
    /**
     * @param qcodeUser,String memo,addScore �û���Ϣ,��ˮԭ�򣬻���
     * @author songhaozhang
     * @return data scoreDetailVo
     */
    public static ResponseData adduserscore(QcodeUser qcodeUser,int addScore,String memo ) {
    	ResponseData data = new ResponseData(true);
    	System.out.println("UpdateUserScore");
        QueryFilter updatescore = new QueryFilter();
        updatescore.put("userid", qcodeUser.getId());
        updatescore.setStatementKey("updscore");
        updatescore.put("score", addScore);
        //�޸Ļ���
    	Result result = qcodeUserService.update(updatescore);
    	if(result.isSuccess()) {
    		System.out.println("qcodeUserService success");
    		ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeUser,addScore,0,memo);
    		QueryFilter filter = new QueryFilter(scoreDetailVo);
    		filter.setStatementKey("addScoreDetails");
    		System.out.println("addScoreDetails");
    		System.out.println("updateUserScoreService");
    		//��ӻ�����ϸ
    		Result rs=updateUserScoreService.save(filter);
    		if(rs.isSuccess()) {
    			data.setMessage(true);
    			data.setObj(scoreDetailVo.getAddScore());
    			return data;
    		}else {
    			System.out.println("save score detail is false");
    			data.setMessage("save score detail is false");
    			data.setSuccess(false);
    			return data;
    		}
    	}else {
    		System.out.println("update qcodeuser false! check your param!");
    		data.setMessage("update qcodeuser false! check your param!");
			data.setSuccess(false);
			return data;
    	}
    	
    	

    }

    /**
     * @param qcodeUser,String memo,minusScore
     * @author songhaozhang
     * @return data scoreDetailVo
     */
    public static ResponseData minuserscore(QcodeUser qcodeUser,int minusScore,String memo ) {
    	ResponseData data = new ResponseData(true);    	
        QueryFilter updatescore = new QueryFilter();
        updatescore.setStatementKey("updscore");
        updatescore.put("score", minusScore);
    	Result result = qcodeUserService.update(updatescore);
    	if(result.isSuccess()) {
    		ScoreDetailVo scoreDetailVo = getScoreDetail(qcodeUser,0,minusScore,memo);
    		QueryFilter filter = new QueryFilter(scoreDetailVo);
    		filter.setStatementKey("addScoreDetails");
    		Result rs=updateUserScoreService.save(filter);
    		if(rs.isSuccess()) {		
    			data.setObj(scoreDetailVo.getMinusScore());
    			data.setMessage(true);
    			return data;
    		}else {
    			data.setMessage("save score detail is false");
    			data.setSuccess(false);
    			return data;
    		}
    	}else {
    		data.setMessage("update qcodeuser false! check your param!");
			data.setSuccess(false);
			return data;
    	}
    }
    

    
    private static ScoreDetailVo getScoreDetail(QcodeUser qcodeUser,int addScore,int minusScore,String detail) {
        ScoreDetailVo scoreDetailVo = new ScoreDetailVo();
        scoreDetailVo.setDetail(detail);
        scoreDetailVo.setMinusScore(minusScore);
        scoreDetailVo.setAddScore(addScore);
        scoreDetailVo.setUserId(qcodeUser.getId());
        scoreDetailVo.setUserName(qcodeUser.getName());
        return scoreDetailVo;
    }

}
