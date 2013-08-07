package com.wnJava.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * servlet测试类
 * @author Kalor
 *
 */
public class TestServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

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
		if("showMsgAjax".equals(fun)) {
			showMsgAjax(req,resp);
		}else if("testFancyBox".equals(fun)) {
			req.setAttribute("fun", fun);
			RequestDispatcher rd = req.getRequestDispatcher("/demo/fancybox/index.jsp");
			rd.forward(req, resp);
		}else if("testTip".equals(fun)) {
			req.setAttribute("fun", fun);
			RequestDispatcher rd = req.getRequestDispatcher("/demo/atooltip/demos.jsp");
			rd.forward(req, resp);
		}
		
	}
	
	/**
	 * @throws IOException 
	 * 
	 */
	private void showMsgAjax(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		PrintWriter out = resp.getWriter();
		out.println("servlet的处理结果");
		out.flush();
		out.close();
	}
}
