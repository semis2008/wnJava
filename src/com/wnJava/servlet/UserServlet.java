package com.wnJava.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.LeaveMsgBO;
import com.wnJava.bo.UserBO;
import com.wnJava.service.UserService;
import com.wnJava.util.StringUtil;
import com.wnJava.util.UserUtil;

/**
 * 用户相关处理类
 * 
 * @author Kalor
 * @time 2012-12-14
 */
@Component
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(UserServlet.class);
	private UserService userService;

	public void setUserService(UserService service) {
		this.userService = service;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html;charset=utf-8");
		String fun = (String) req.getParameter("fun");
		if ("regist".equals(fun)) {
			userRegist(req, resp);
		} else if ("login".equals(fun)) {
			userLogin(req, resp);
		} else if ("findpass".equals(fun)) {
			userRegist(req, resp);
		} else if ("userquit".equals(fun)) {
			userQuit(req, resp);
		} else if ("leavemsg".equals(fun)) {
			leaveMsg(req, resp);
		} else if ("leaveMsgList".equals(fun)) {
			showLeaveMsgList(req, resp);
		} else if ("refreshLeaveMsg".equals(fun)) {
			refreshLeaveMsg(req, resp);
		} else if ("updateinfo".equals(fun)) {
			updateInfo(req, resp);
		} else if ("updatephoto".equals(fun)) {
			updatePhoto(req, resp);
		}
	}
	
	/**
	 * 用户注册
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 */
	private void userRegist(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String email = req.getParameter("email");
		String pass = req.getParameter("pass");
		String name = req.getParameter("name");
		String randImg = req.getParameter("randImg");
		String msg = "";
		/*
		 * 验证邮箱是否已经被注册
		 */
		boolean email_result = userService.verifyEmail(email);
		if (email_result) {
			msg = "email_error";
			out.print(msg);
			out.flush();
			out.close();
			return;
		}

		/*
		 * 判断验证码
		 */
		String randCode = UserUtil.getRandCode(req);
		if(randCode==null||!randCode.equals(randImg)) {
			msg = "randCode_error";
			out.print(msg);
			out.flush();
			out.close();
			return;
		}
		
		/*
		 * 注册
		 */
		boolean regist_result = userService.regist(email, name, pass);
		if (regist_result) {
			msg = "success";
		} else {
			msg = "system_error";
		}

		out.print(msg);
		out.flush();
		out.close();
	}

	/**
	 * 用户登录
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 */
	private void userLogin(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String email = req.getParameter("email");
		String pass = req.getParameter("pass");
		String msg = "";
		/*
		 * 验证邮箱是否存在
		 */
		boolean email_result = userService.verifyEmail(email);
		if (!email_result) {
			msg = "email_error";
			out.print(msg);
			out.flush();
			out.close();
			return;
		}

		/*
		 * 登录
		 */
		pass = StringUtil.passEncrypt(pass);
		msg = userService.userLogin(req, resp);

		out.print(msg);
		out.flush();
		out.close();
	}
	
	/**
	 * 刷新首页留言（左侧）
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 * @throws ServletException 
	 */
	private void refreshLeaveMsg(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		//获取留言
		List<LeaveMsgBO> leaveMsgs = userService.getLeaveMsg(4);
		req.setAttribute("leaveMsgs", leaveMsgs);
		RequestDispatcher rd = req.getRequestDispatcher("/jsp/leaveMsgHtml.jsp");
		rd.forward(req, resp);
	}
	
	/**
	 * 显示留言列表
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 * @throws ServletException 
	 */
	private void showLeaveMsgList(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		List<LeaveMsgBO> diaries =new ArrayList<LeaveMsgBO>();
		diaries = userService.getLeaveMsgList(req,resp);
		req.setAttribute("leaveMsgs", diaries);
		RequestDispatcher rd = req.getRequestDispatcher("/jsp/leaveMsgListHtml.jsp");
		rd.forward(req, resp);
	}
	
	
	/**
	 * 用户退出
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 */
	private void userQuit(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String msg = "success";
		UserUtil.quit(req, resp);
		out.print(msg);
		out.flush();
		out.close();
	}
	
	/**
	 * 用户留言
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 */
	private void leaveMsg(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String msg = "";
		req.setCharacterEncoding("utf-8");
		boolean result = userService.leaveMsg(req,resp);
		if(result) {
			msg = "success";
		}else {
			msg = "system_error";
		}
		out.print(msg);
		out.flush();
		out.close();
	}
	
	/**
	 * 更新用户详细信息
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 * @throws ServletException 
	 */
	private void updateInfo(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		boolean result = userService.updateInfo(req,resp);
		if(!result) {
			RequestDispatcher rd = req.getRequestDispatcher("/jsp/error.jsp");
			rd.forward(req, resp);
		}
	}
	
	/**
	 * 更新头像
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 */
	private void updatePhoto(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String msg = "";
		String id = req.getParameter("id");
		UserBO user = UserUtil.getLoginUser(req, resp);
		msg = userService.updatePhoto(id,user.getId());
		out.print(msg);
		out.flush();
		out.close();
	}
}
