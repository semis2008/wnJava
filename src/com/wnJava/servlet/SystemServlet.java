package com.wnJava.servlet;

import java.io.IOException;
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
import com.wnJava.bo.DiaryReplyBO;
import com.wnJava.bo.LeaveMsgBO;
import com.wnJava.bo.UserBO;
import com.wnJava.bo.UserInfoBO;
import com.wnJava.service.DiaryService;
import com.wnJava.service.UserService;
import com.wnJava.util.UserUtil;
import com.wnJava.vo.DynamicVO;

/**
 * 系统响应处理类
 * 
 * @author Kalor
 * @time 2012-12-14
 * 
 */
@Component
public class SystemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(SystemServlet.class);
	private UserService userService;
	private DiaryService diaryService;

	public void setDiaryService(DiaryService diaryService) {
		this.diaryService = diaryService;
	}
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
		String targetpath = "";
		if ("error".equals(fun)) {
			targetpath = "/jsp/error.jsp";
		}else if ("404error".equals(fun)) {
			targetpath = "/jsp/error404.jsp";
		}else if ("exception".equals(fun)) {
			targetpath = "/jsp/exception.jsp";
		}else if ("mainpage".equals(fun)) {
			targetpath = showMainPage(req, resp);
		}else if ("diary".equals(fun)) {
			targetpath = showDiary(req, resp);
		}else if ("diarydetail".equals(fun)) {
			targetpath = showDiaryDetail(req, resp);
		}else if ("aboutus".equals(fun)) {
			targetpath = "/jsp/aboutPage.jsp";
		}else if ("index".equals(fun)) {
			targetpath = showIndexPage(req, resp);
		}else if ("shownewdiary".equals(fun)) {
			targetpath = showNewDiary(req, resp);
		}else if ("showeditdiary".equals(fun)) {
			targetpath = showEditDiary(req, resp);
		} 
		UserBO user = UserUtil.getLoginUser(req, resp);
		if(user!=null) {
			//获取用户的日志总数
			String userDiaryNum = diaryService.getUserDiaryNum(String.valueOf(user.getId()));
			req.setAttribute("userDiaryNum", userDiaryNum);
		}
		
		req.setAttribute("fun", fun);
		req.setAttribute("loginUser", user);
		RequestDispatcher rd = req.getRequestDispatcher(targetpath);
		rd.forward(req, resp);
	}
	
	/**
	 * 个人主页业务处理
	 * @param req
	 * @param resp
	 */
	private String showMainPage(HttpServletRequest req, HttpServletResponse resp) {
		String param = req.getParameter("p1");
		UserBO user = new UserBO();
		/*
		 * 默认访问kalor的主页
		 */
		if(param==null) {
			param = "1";
		}
		//查询访问用户基本信息，返回前台
		user = userService.getUserByID(param);
		//将被访问的用户信息放入session
		UserUtil.addVisitedUserSession(req, user);
		//查询访问用户详细信息，返回前台
		UserInfoBO info = userService.getUserInfoByID(param);
		//获取用户的最新日志信息
		//FIXME 最新图册信息需要在开发完图册模块之后再开发
		List<DiaryBO> newDiaryList = diaryService.getUserNewDiaryList(req,resp);
		//获取给该用户的留言 
		List<LeaveMsgBO> leaveMsgList = userService.getLeaveMsgList(req,resp); 
		
		req.setAttribute("leaveMsgList", leaveMsgList);
		req.setAttribute("newDiaryList", newDiaryList);
		req.setAttribute("visitedUser", user);
		req.setAttribute("visitedUserInfo", info);
		return "/jsp/mainPage.jsp";
	}
	
	/**
	 * 显示主页
	 * @param req
	 * @param resp
	 * @return
	 */
	private String showIndexPage(HttpServletRequest req, HttpServletResponse resp) {
		//TODO 主页显示需要继续开发，目前只设计样式
		//获取系统用户最新状态
		DynamicVO dynamicVO = new DynamicVO();
		dynamicVO = userService.getDynamicVOPart2(dynamicVO);
		dynamicVO = diaryService.getDynamicVOPart1(dynamicVO);
		
		
		//获取系统最新发布的日志信息
		List<DiaryBO> diaries = diaryService.getNewDiaryList();
		//获取系统公告
		List<DiaryBO> notices = diaryService.getNotices();
		//获取系统日志总数
		int diaryCount = diaryService.getTotalDiaryCount();
		 	
		//获取系统注册会员列表
		List<UserBO> users = userService.getUsers();
		
		req.setAttribute("dynamics", dynamicVO);
		req.setAttribute("notices", notices);
		req.setAttribute("diaries", diaries);
		req.setAttribute("diaryCount", diaryCount);
		req.setAttribute("users", users);
		return "/jsp/indexPage.jsp";
	}
	
	/**
	 * 日志业务处理
	 * @param req
	 * @param resp
	 */
	private String showDiary(HttpServletRequest req, HttpServletResponse resp) {
		 
		UserBO visitUser = UserUtil.getVisitedUser(req, resp);
		List<DiaryBO> diaries =new ArrayList<DiaryBO>();
//		if(visitUser == null) {
			// 没有指定用户，显示所有日志
			diaries = diaryService.getAllDiaryList(req,resp);
//		}else {
//			diaries = diaryService.getUserDiaryList(req,resp);
//		}
		req.setAttribute("diaries", diaries);
		return "/jsp/diaryPage.jsp";
	}
	
	/**
	 * 显示写日志页面
	 * @param req
	 * @param resp
	 */
	private String showNewDiary(HttpServletRequest req, HttpServletResponse resp) {
		return "/jsp/newDiary.jsp";
	}
	
	/**
	 * 显示编辑日志页面
	 * @param req
	 * @param resp
	 */
	private String showEditDiary(HttpServletRequest req, HttpServletResponse resp) {
		//获取日志信息，代入
		String diaryId = req.getParameter("p1");
		DiaryBO diary = diaryService.getDiaryByID(diaryId);
		req.setAttribute("diary", diary);
		return "/jsp/editDiary.jsp";
	}
	
	/**
	 * 日志详情业务处理
	 * @param req
	 * @param resp
	 */
	private String showDiaryDetail(HttpServletRequest req, HttpServletResponse resp) {
		String param = req.getParameter("p1");
		/*
		 * 参数是日志id,获取日志详情信息
		 */
		//获取日志主要内容
		DiaryBO diary = diaryService.getDiaryByID(param);
		//获取日志回复信息
		List<DiaryReplyBO> replies = diaryService.getDiaryReplyListById(param);
		//更新日志的阅读数
		diaryService.updateDiaryRead(param);
		req.setAttribute("replies", replies);
		req.setAttribute("diary", diary);
		return "/jsp/diaryDetail.jsp";
	}
	
}
