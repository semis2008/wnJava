package com.wnJava.dao.impl;

import java.util.List;
import java.util.Map;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.LeaveMsgBO;
import com.wnJava.bo.UserBO;
import com.wnJava.bo.UserInfoBO;
import com.wnJava.dao.UserDao;
import com.wnJava.dao.template.DbUtilsTemplate;
import com.wnJava.util.ConstantsUtil;

/**
 * 用户数据操作接口实现类
 * 
 * @author Kalor
 * @time 2012-12-17
 */
public class UserDaoImpl implements UserDao {
	private DbUtilsTemplate dbUtilsTemplate;

	public void setDbUtilsTemplate(DbUtilsTemplate dbUtilsTemplate) {
		this.dbUtilsTemplate = dbUtilsTemplate;
	}

	@Override
	public int insertUser(String email, String name, String pass) {
		String sql = "insert into user (email,name,password,reg_time,photo,user_level) values (?,?,?,now(),?,1)";
		Object[] param = { email, name, pass, ConstantsUtil.DEFAULT_HEAD_PHOTO};
		return dbUtilsTemplate.update(sql, param);
	}

	@Override
	public UserBO queryUserByEmail(String email) {
		String sql = "select * from user where email = ?";
		return dbUtilsTemplate.findFirst(UserBO.class, sql, email);
	}

	@Override
	public UserBO queryUser(String email, String pass) {
		String sql = "select * from user where email = ? and password = ?";
		Object[] param = { email, pass };
		return dbUtilsTemplate.findFirst(UserBO.class, sql, param);
	}

	@Override
	public int updateLoginTime(String email) {
		String sql = "update user set logon_time = now() where email = ?";
		return dbUtilsTemplate.update(sql, email);
	}

	@Override
	public UserBO queryUserByID(String id) {
		String sql = "select * from user where id = ?";
		return dbUtilsTemplate.findFirst(UserBO.class, sql, id);
	}

	@Override
	public int insertLeaveMsg(String email, String name, String msg,
			String type, Long visitedUserId, Long userId, String userPhoto) {
		String sql = "insert into leavemsg (email,name,msg,leave_time,visited_user_id,user_id,user_photo,type) values (?,?,?,now(),?,?,?,?)";
		Object[] param = { email, name, msg, visitedUserId,userId, userPhoto, type };
		return dbUtilsTemplate.update(sql, param);
	}

	@Override
	public int insertLeaveMsg(String email, String name, String msg,
			String type, Long visitedUserId, String userPhoto) {
		String sql = "insert into leavemsg (email,name,msg,leave_time,visited_user_id,user_photo,type) values (?,?,?,now(),?,?,?)";
		Object[] param = { email, name, msg, visitedUserId, userPhoto, type };
		return dbUtilsTemplate.update(sql, param);
	}

	@Override
	public UserInfoBO queryUserInfoByUserID(Long userId) {
		String sql = "select * from user_info info where info.user_id = ?";
		return dbUtilsTemplate.findFirst(UserInfoBO.class, sql, userId);
	}

	@Override
	public int updateUserInfo(Long user_id, String rel_name, String gender,
			String homeProvince, String birthday, String hobby,
			String contactStr, String publicStr) {
		String sql = "update user_info set rel_name = ?,gender = ?,birthday = ?,home_province = ?,hobby = ?,contact = ?,public_info = ? where user_id = ?";
		Object[] param = { rel_name, gender, birthday, homeProvince, hobby,
				contactStr, publicStr, user_id };
		return dbUtilsTemplate.update(sql, param);
	}

	@Override
	public int updateUserName(String name, Long userid) {
		String sql = "update user set name = ? where id = ?";
		Object[] param = { name, userid };
		return dbUtilsTemplate.update(sql, param);
	}

	@Override
	public int queryTotalLeaveMsgCount() {
		String sql = "select count(*) totalNum from leavemsg where 1=1";
		Map<String,Object> result = dbUtilsTemplate.findFirst(sql,null);
		return Integer.parseInt((Long)result.get("totalNum")+"");
	}

	@Override
	public List<LeaveMsgBO> queryAllLeaveMsgList(int start, int num) {
		String sql = "select * from leavemsg where 1=1 order by leave_time desc limit ?,?";
		Object[] param = {start,num};
		return dbUtilsTemplate.find(LeaveMsgBO.class, sql, param);
		
	}

	@Override
	public int insertUserInfo(Long user_id, String rel_name, String gender,
			String homeProvince, String birthday, String hobby,
			String contactStr, String publicStr) {
		String sql = "insert into user_info (user_id,rel_name,gender,birthday,home_province,hobby,contact,public_info) values (?,?,?,?,?,?,?,?)";
		Object[] param = { user_id, rel_name, gender, birthday, homeProvince,
				hobby, contactStr, publicStr };
		return dbUtilsTemplate.update(sql, param);
	}

	@Override
	public boolean updatePhoto(String photoPath, Long userId) {
		String sql = "update user set photo = ? where id = ?";
		Object[] param = {photoPath,userId};
		int result = dbUtilsTemplate.update(sql, param);
		if(result<1) {
			return false;
		}else {
			return true;
		}
	}

	@Override
	public List<LeaveMsgBO> queryUserLeaveMsg(Long userId, int start, int end) {
		String sql = "select * from leavemsg where visited_user_id = ? order by leave_time desc limit ?,?";
		Object[] param = {userId,start,end};
		return dbUtilsTemplate.find(LeaveMsgBO.class, sql, param);
	}

	@Override
	public List<LeaveMsgBO> queryLeaveMsg(int start, int end) {
		String sql = "select * from leavemsg where 1=1 order by leave_time desc limit ?,?";
		Object[] param = {start,end};
		return dbUtilsTemplate.find(LeaveMsgBO.class, sql, param);
	}

	@Override
	public List<UserBO> queryUsers() {
		String sql = "select * from user where 1=1 order by reg_time asc";
		return dbUtilsTemplate.find(UserBO.class, sql, null);
	}

	@Override
	public List<UserBO> queryUsersOrderByLoginTime(int num) {
		String sql = "select * from user where 1=1 order by logon_time desc limit 0,?";
		return dbUtilsTemplate.find(UserBO.class, sql, num);
	}

	@Override
	public List<UserBO> queryLatestRegUser(int start, int end) {
		String sql = "select * from user where 1=1 order by reg_time desc limit ?,?";
		Object[] param = {start,end};
		return dbUtilsTemplate.find(UserBO.class, sql, param);
	}
	
}
