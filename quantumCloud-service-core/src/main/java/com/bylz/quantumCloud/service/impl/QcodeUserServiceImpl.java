package com.bylz.quantumCloud.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.bylz.quantumCloud.model.TutorialReviewVo;
import com.bylz.quantumCloud.model.UserBonusVo;
import com.bylz.quantumCloud.model.UserVideo;
import com.likegene.framework.core.QueryFilter;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * 客户信息表 Service
 * @author liuxiantao
 * @since  2017-07-22
 * 
 */
@Component
@Transactional(rollbackFor = Exception.class)
public class QcodeUserServiceImpl extends BaseServiceImpl<QcodeUser, Long> implements QcodeUserService{

	public String getNamespace()
    {
        return QcodeUser.class.getSimpleName();
    }

	@Override
	public QcodeUser createQcodeUser(String email,String name) {
		//数据库中存在项目账户
//		QueryFilter filter = new QueryFilter();
//		filter.put("emial", email );
//		QcodeUser qcodeUser =  this.findOne(filter).getReturnObj();
//		if(qcodeUser != null){
//			return qcodeUser;
//		}
		
		QcodeUser qcodeUser = new QcodeUser();
		Random random = new Random();
		String randomNum = new StringBuffer().append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).toString();
//		String name = new StringBuffer("U").append(randomNum).toString();
		String encodePassword = new Md5Hash(email).toHex();
		
		qcodeUser.setName(name);
		qcodeUser.setEmail(email);
		qcodeUser.setPwd(encodePassword);
		qcodeUser.setRegisterTime(new Date());
		qcodeUser.setIsDisable(QcodeUser.IS_DISABLE_NO);
		qcodeUser.setDeleted(QcodeUser.DELETED_NO);
		qcodeUser.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
		qcodeUser.setScore(0);
		Result result = this.save(qcodeUser);
		if (!result.isSuccess()) {
			return null;
		}
		QcodeUser	qcodeUserAdd = result.getReturnObj();
		return qcodeUserAdd;
	}

	/**
	 * 查询用户是否版主
	 * @param userId
	 * @return
	 */
	@Override
	public Map<String,Object> isModerator(long userId) {
		QueryFilter filter = new QueryFilter();
		filter.put("userId",userId);
		filter.setStatementKey("isModerator");
		return this.findOne(filter).getReturnObj();
	}

	/**
	 * 签到添加分数
	 * @param score
	 * @param userId
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public int updscore(int score, long userId) {
		QueryFilter filter = new QueryFilter();
		filter.put("userid",userId);
		filter.put("score",score);
		filter.setStatementKey("updscore");
		return this.save(filter).getReturnObj();
	}


	/**
	 * 获得用户信息
	 *
	 * @param qcodeUser@return
	 */
	@Override
	public QcodeUser getQcodeUser(QcodeUser qcodeUser) {
		QueryFilter filter = new QueryFilter();
		filter.put("email",qcodeUser.getEmail());
		filter.setStatementKey("login");
		return this.findOne(filter).getReturnObj();
	}


	/**
	 * 获取用户信息
	 * @param qcodeUser
	 * @param num
	 * @return
	 */
	@Override
	public QcodeUser getQcodeUserInfo(QcodeUser qcodeUser,int num) {
		QueryFilter filter = new QueryFilter();
		filter.put("userId",qcodeUser.getId());
		filter.setStatementKey("getBonusInfo");
		UserBonusVo userBonusVo = this.findOne(filter).getReturnObj();
		if(userBonusVo == null) {
			userBonusVo = new UserBonusVo();
			userBonusVo.setStdTime(0);
		}
		qcodeUser.setUserBonusVo(userBonusVo);
		filter.setStatementKey("getUserStuLogList");
		filter.put("num",num);
		List<UserVideo> userVideoList = this.findList(filter).getReturnObj();
		qcodeUser.setUserVideoList(userVideoList);
		qcodeUser.setUserTitle(getUserTitle(qcodeUser));
		qcodeUser.setStdTime(userBonusVo.getStdTime());
		filter.put("noticeType",1);
		filter.setStatementKey("getNoticeNum");
		int noticeNum = this.findOne(filter).getReturnObj();
		qcodeUser.setNoticeNum(noticeNum);
		return qcodeUser;
	}


	/**
	 * 修改个人信息
	 *
	 * @param user
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public int updUserInfo(QcodeUser user) {
		QueryFilter filter = new QueryFilter(user);
		filter.setStatementKey("updUserInfo");
		return this.update(filter).getReturnObj();
	}

	/**
	 * 修改密码
	 *
	 * @param password
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public int updPassword(String password,long userId) {
		QueryFilter filter = new QueryFilter();
		filter.put("password",new Md5Hash(password).toHex());
		filter.put("userId",userId);
		filter.setStatementKey("updPassword");
		return this.update(filter).getReturnObj();
	}

	/**
	 * 查询user_video和user_exam表中最新数据
	 *
	 * @param userId
	 * @return
	 */
	@Override
	public Map getNewest(long userId) {
		QueryFilter filter = new QueryFilter();
		filter.put("userId",userId);
		filter.setStatementKey("getNewest");
		return this.findOne(filter).getReturnObj();
	}

	/**
	 * 查询我的问题数和勋章数
	 *
	 * @param userId
	 */
	@Override
	public Map<String, Integer> getMyAnwserAndBonusNum(long userId) {
		QueryFilter filter = new QueryFilter();
		filter.put("userId",userId);
		filter.setStatementKey("getAnswerNum");
		return this.findOne(filter).getReturnObj();
	}

	/**
	 * 根据视频id和userid查询最新答题记录
	 *
	 * @param filter
	 */
	@Override
	public Map<String, Object> getNewExam(QueryFilter filter) {
		filter.setStatementKey("getNewExam");
		return this.findOne(filter).getReturnObj();
	}

	/**
	 * 根据视频id和userid查询最新答题记录
	 *
	 * @param filter
	 */
	@Override
	public Map<String, Object> getNewVideo(QueryFilter filter) {
		filter.setStatementKey("getNewVideo");
		return this.findOne(filter).getReturnObj();
	}

	/**
	 * 获得所有用户邮箱
	 *
	 * @return
	 */
	@Override
	public List<QcodeUser> getAllUserEmail(QueryFilter filter) {
		filter.setStatementKey("getAllUserEmail");
		return this.findList(filter).getReturnObj();
	}

	/**
	 * 查询手机号是否存在
	 *
	 * @param filter
	 * @return
	 */
	@Override
	public boolean checkIsExist(QueryFilter filter) {
		filter.setStatementKey("checkIsExist");
		int count = this.findOne(filter).getReturnObj();
		return count > 0 ? false : true;
	}

	//获取用户称号
	private static String getUserTitle(QcodeUser qcodeUser) {
		//TODO 有点low，有空再改
		String userTitle = "";
		int score = qcodeUser.getScore();
		int bonusScore = 0;
		if(qcodeUser.getUserBonusVo() != null) {
			bonusScore = qcodeUser.getUserBonusVo().getScore();
		}

		int allScore = score + bonusScore;
		if(allScore >= 0 && allScore < 50) {
			userTitle = "量子浪客";
		}else if(allScore >= 50 && allScore < 200) {
			userTitle = "量子剑心";
		}else if(allScore >= 200 && allScore < 400) {
			userTitle = "量子名士";
		}else if(allScore >= 400 && allScore < 600) {
			userTitle = "量子大师";
		}else if(allScore >= 600 && allScore < 3000) {
			userTitle = "量子巨匠";
		}else {
			userTitle = "量子传奇";
		}
		return userTitle;
	}
}
