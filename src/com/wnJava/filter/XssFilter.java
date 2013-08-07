package com.wnJava.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class XssFilter implements Filter {
	FilterConfig filterConfig = null;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	public void destroy() {
		this.filterConfig = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest request1 = (HttpServletRequest) request;
		String targetURL = request1.getRequestURI();
		String ignoreUrl = filterConfig.getInitParameter("ignoreUrl");
		boolean ignore = false;
		if (ignoreUrl.contains(targetURL)) {
			ignore = true;
		}

		chain.doFilter(new XssHttpServletRequestWrapper(
				(HttpServletRequest) request, ignore), response);

	}
}
