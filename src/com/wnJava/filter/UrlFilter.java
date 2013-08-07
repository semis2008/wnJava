package com.wnJava.filter;

import java.io.IOException;

import org.apache.log4j.Logger;

import com.wnJava.util.ConstantsUtil;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 过滤不合法的访问路径
 * 
 * @author Kalor
 * @time 2012-12-14
 * 
 */
public class UrlFilter implements Filter {
	private static Logger logger = Logger.getLogger(UrlFilter.class);

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		/**
		 * 1,doFilter的第一个参数为ServletRequest对象。此对象给过滤器提供了对进入的信息（包括 　
		 * 表单数据、cookie和HTTP请求头）的完全访问。第二个参数为ServletResponse，通常在简单的过 　
		 * 滤器中忽略此参数。最后一个参数为FilterChain，此参数用来调用servlet或JSP页。
		 */
		HttpServletRequest request = (HttpServletRequest) arg0;
		/**
		 * 如果处理HTTP请求，并且需要访问诸如getHeader或getCookies等在ServletRequest中 　
		 * 无法得到的方法，就要把此request对象构造成HttpServletRequest
		 */
		HttpServletResponse response = (HttpServletResponse) arg1;

		String targetURL = request.getRequestURI(); // 取得根目录所对应的绝对路径:
		logger.info("开始过滤URL:" + targetURL);

		// 本系统网站访问路径均通过Servlet进行，所有直接访问文件的路径均不合法
		if (targetURL.contains(".jsp") || targetURL.contains(".htm")
				|| targetURL.contains(".html")) {
			response.sendRedirect(ConstantsUtil.FW_DOMAIN
					+ "/system.do?fun=error");
			logger.error("URL路径不合法！Url:" + targetURL);
			return;
		}
		// 加入filter链继续向下执行
		logger.info("URL路径合法！");
		arg2.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
