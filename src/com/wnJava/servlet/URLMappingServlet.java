package com.wnJava.servlet;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 用于URL地址的转换
 * http://www.testFW.com/system/mainpage/12/sd -> {base}/system.do?fun=mainpage&p1=12&p2=sd
 * @author Kalor
 * @time 2012-12-18
 */
public final class URLMappingServlet extends HttpServlet {

	private final static Log log = LogFactory.getLog(URLMappingServlet.class);	
	
	public final static String CURRENT_URI = "current_uri";	//{index}
	public final static String REQUEST_URI = "request_uri";	//{/index}
	private final static char URL_SEPERATOR = '/';
	
	@Override
	@SuppressWarnings("unchecked")
	public void init() throws ServletException {
		 
	}

	/**
	 * 执行页面映射过程
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void perform(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		StringBuilder show_page = new StringBuilder();
		String prefix = "";//req.getServletPath().substring(1);
		String spath = req.getRequestURI();	
		req.setAttribute(REQUEST_URI, spath);
		req.setAttribute(CURRENT_URI, prefix);
		//解析URL地址
		String[] s_result = spath.substring(1).split(String.valueOf(URL_SEPERATOR));
		show_page.append(prefix);
		
		String showPage = getShowPage(s_result,show_page);
		if(log.isDebugEnabled())
			log.debug("request_uri="+spath+",servlet_path="+req.getServletPath()+",realURL="+show_page);
		//执行真实的页面
		RequestDispatcher rd = getServletContext().getRequestDispatcher(show_page.toString());
		rd.forward(req, res);	
	}

	private String getShowPage(String[] s_result,StringBuilder show_page) {
		
		if(s_result.length<3){
			return "/system.do?fun=error";
		}
		else{
			show_page.append("/"+s_result[1]+".do?fun="+s_result[2]);
			int param_idx = 1;
			for(int i=3;i<s_result.length;i++){
				show_page.append('&');
				show_page.append('p');
				show_page.append((param_idx++));
				show_page.append('=');
				show_page.append(s_result[i]);
			}
		}
		return show_page.toString();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		perform(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		perform(req, resp);
	}

}
