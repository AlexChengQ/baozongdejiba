package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.TutorialReviewVo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.QueryFilter;

import java.util.List;
import java.util.Map;

/**
 * 客户信息表 Service
 * @author liuxiantao
 * @since  2017-07-22
 * 
 */
public interface QcodeUserService extends BaseService<QcodeUser, Long>{
	
	/**创建qcodeUser
	 * @param email
	 * @param name
	 * @return QcodeUser
	 * @author houdondong
	 * */
	public QcodeUser createQcodeUser(String email,String name) ;

	/**
	 * 查询是否版主
	 * @param userId
	 * @return
	 */
	Map<String,Object> isModerator(long userId);


	/**
	 * 修改积分
	 * @param score
	 * @param userId
	 * @return
	 */
	int updscore(int score,long userId);


	/**
	 * 获得用户信息
	 * @param
	 * @param
	 * @return
	 */
	QcodeUser getQcodeUser(QcodeUser qcodeUser);

	/**
	 * 用户信息
	 * @param qcodeUser
	 * @param num
	 * @return
	 */
	QcodeUser getQcodeUserInfo(QcodeUser qcodeUser,int num);


	/**
	 * 修改个人信息
	 * @param user
	 * @return
	 */
	int updUserInfo(QcodeUser user);

	/**
	 * 修改密码
	 */
	int updPassword(String password,long id);

	/**
	 * 查询user_video和user_exam表中最新数据
	 * @param userId
	 * @return
	 */
	Map<String,Object> getNewest(long userId);

	/**
	 * 查询我的问题数和勋章数
	 */
	Map<String,Integer> getMyAnwserAndBonusNum(long userId);

	/**
	 * 根据视频id和userid查询最新答题记录
	 */
	Map<String,Object> getNewExam(QueryFilter filter);

	/**
	 * 根据视频id和userid查询最新答题记录
	 */
	Map<String,Object> getNewVideo(QueryFilter filter);


	/**
	 * 获得所有用户邮箱
	 * @return
	 */
	List<QcodeUser> getAllUserEmail(QueryFilter filter);

	/**
	 * 查询手机号是否存在
	 * @param filter
	 * @return
	 */
	boolean checkIsExist(QueryFilter filter);
}
