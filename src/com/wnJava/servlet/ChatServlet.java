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
 * WN Chat系统处理类
 * @author Kalor
 *
 */
@Component
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(ChatServlet.class);
	 
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
		if ("test".equals(fun)) {
			targetpath = "/jsp/chat/index.jsp";
		}else if ("comet".equals(fun)) {
			targetpath = "/jsp/chat/helloWorld.jsp";
		}
		
		req.setAttribute("fun", fun);
		RequestDispatcher rd = req.getRequestDispatcher(targetpath);
		rd.forward(req, resp);
	}
}
