package com.wnJava.servlet;

import java.io.IOException;

import javax.servlet.GenericServlet;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 对servlet进行IOC配置的代理类
 * 
 * @author Administrator
 * 
 */
public class DelegatingServletProxy extends GenericServlet {
	private static final long serialVersionUID = 1L;
	private String targetBean;
	private Servlet proxy;

	@Override
	public void service(ServletRequest req, ServletResponse res)
			throws ServletException, IOException {
		proxy.service(req, res);
	}

	@Override
	public void init() throws ServletException {
		this.targetBean = getServletName();
		getServletBean();
		proxy.init(getServletConfig());
	}

	private void getServletBean() {
		WebApplicationContext wac = WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext());
		this.proxy = (Servlet) wac.getBean(targetBean);
	}

}