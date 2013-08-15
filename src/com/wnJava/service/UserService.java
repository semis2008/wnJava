package com.wnJava.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wnJava.bo.LeaveMsgBO;
import com.wnJava.bo.UserBO;
import com.wnJava.bo.UserInfoBO;

/**
 * 用户业务处理接口
 * @author Kalor
 * @time 2012-12-17
 */
public interface UserService {
	
	/**
	 * 注册
	 * @param email 注册邮箱
	 * @param pass 密码
	 * @return 注册结果
	 */
	boolean regist(String email,String name,String pass);
	
	/**
	 * 验证邮箱是否存在
	 * @param email
	 * @return 邮箱存在，返回true;邮箱不存在，返回false
	 */
	boolean verifyEmail(String email);
	
	/**
	 * 用户登录。验证帐号密码、更新登录信息（login_time和session）
	 * @param req
	 * @param resp
	 * @return 密码错误，返回pass_error;登录失败，返回system_error;登录成功，返回success
	 */
	String userLogin(HttpServletRequest req, HttpServletResponse resp);
	
	/**
	 * 依据用户id查询用户信息
	 * @param id 用户id
	 * @return 用户实体类
	 */
	UserBO getUserByID(String id);
	
	/**
	 * 用户留言
	 * @param req
	 * @param resp
	 * @return 留言成功，返回success,留言失败，返回system_error
	 */
	boolean leaveMsg(HttpServletRequest req, HttpServletResponse resp);
	
	/**
	 * 获取活跃用户
	 * @param num 数目
	 * @return
	 */
	List<UserBO> getActiveUsers(int num);
	/**
	 * 更新用户详细信息
	 * @param req
	 * @param resp
	 * @return
	 */
	boolean updateInfo(HttpServletRequest req, HttpServletResponse resp);
	
	/**
	 * 依据用户id获取用户详细信息
	 * @param userId 用户id
	 * @return
	 */
	UserInfoBO getUserInfoByID(String userId);
	
	/**
	 * 更新头像
	 * @param id 头像信息
	 * @param userId 用户id 
	 * @return 更新失败返回fail,否则返回更新后photo路径
	 */
	String updatePhoto(String id, Long userId);
	
	/**
	 * 获取系统前几条留言
	 * 
	 * @param num 数目
	 * @return
	 */
	List<LeaveMsgBO> getLeaveMsg(int num);
	
	/**
	 * 获取系统留言列表
	 * 
	 * @return
	 */
	List<LeaveMsgBO> getLeaveMsgList(HttpServletRequest req, HttpServletResponse resp);
	
	/**
	 * 获取给用户的留言
	 * @param userId
	 * @return
	 */
	List<LeaveMsgBO> getUserLeaveMsg(Long userId);
	
	/**
	 * 获取系统所有用户
	 * @return
	 */
	List<UserBO> getUsers();
	
}
