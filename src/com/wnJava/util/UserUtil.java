package com.wnJava.util;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wnJava.bo.UserBO;
import com.wnJava.bo.UserInfoBO;

/**
 * 用户工具类--session相关
 * @author kalor
 * @time 2013-1-15 at 下午03:39:13
 */
public class UserUtil {
	/**
	 * 检查用户是否登陆
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean checkLogin(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserBO user = (UserBO) session.getAttribute("loginUser");
		if (user != null && !"".equals(user.getEmail())) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 获取session中保存的验证码
	 * @param request
	 * @return
	 */
	public static String getRandCode(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return (String) session.getAttribute("randCode");
	}
	
	/**
	 * 添加登录用户session信息
	 * @param request
	 * @param bo
	 * @return
	 */
	public static boolean addLoginUserSession(HttpServletRequest request,UserBO bo) {
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", bo);
		return true;
	}
	 
	/**
	 * 用户登录状态下获取用户对象,通过session
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static UserBO getLoginUser(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserBO user = (UserBO) session.getAttribute("loginUser");
		return user;
	}

	/**
	 * 添加被访问用户session信息
	 * @param request
	 * @param bo
	 * @return
	 */
	public static boolean addVisitedUserSession(HttpServletRequest request,UserBO bo) {
		HttpSession session = request.getSession();
		session.setAttribute("visitedUser", bo);
		return true;
	}
	 
	/**
	 * 获取被访问用户对象,通过session
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static UserBO getVisitedUser(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserBO user = (UserBO) session.getAttribute("visitedUser");
		if(user==null) {
			user = buildAdminUser(); 
		}
		return user;
	}
	 
	private static UserBO buildAdminUser() {
		UserBO user = new UserBO();
		user.setId(1l);
		user.setEmail("semis2008@126.com");
		user.setName("偷懒的熊");
		user.setUser_level("3");
		user.setPhoto("/img/head/default/anime/5.jpg");
		return user;
	}
	
	/**
	 * 用户手动退出
	 * 
	 * @param request
	 * @param response
	 */
	public static void quit(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserBO user = (UserBO) session.getAttribute("loginUser");
		if (user != null && !"".equals(user.getEmail())) {
			session.removeAttribute("loginUser");
		}
	}
	
	/**
	 * 依据用户level代码获取相应的级别信息
	 * @param user_level
	 * @return
	 */
	public static String getUserLevelMsg(String user_level){
		if(user_level == null) {
			return "非法者";
		}
		if("1".equals(user_level)) {
			return "注册会员";
		}else if("2".equals(user_level)) {
			return "管理员";
		}else if("3".equals(user_level)) {
			return "创始人";
		}
		return "非法者";
	}
}
