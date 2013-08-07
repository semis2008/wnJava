package com.wnJava.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * <code>{@link XssHttpServletRequestWrapper}</code>
 *
 * TODO : document me
 *
 * @author Administrator
 */
public class XssHttpServletRequestWrapper extends HttpServletRequestWrapper {
	HttpServletRequest orgRequest = null;
	private boolean ignore;
	
	public XssHttpServletRequestWrapper(HttpServletRequest request,boolean ignore) {
		super(request);
		this.ignore = ignore;
		orgRequest = request;
	}

	/**
	* 覆盖getParameter方法，将参数名和参数值都做xss过滤。<br/>
	* 如果需要获得原始的值，则通过super.getParameterValues(name)来获取<br/>
	* getParameterNames,getParameterValues和getParameterMap也可能需要覆盖
	*/
	@Override
	public String getParameter(String name) {
		if(!ignore) {
			String value = super.getParameter(xssEncode(name));
			if (value != null) {
				value = xssEncode(value);
			}
			return value;
		}
		return super.getParameter(name);
	}

	/**
	* 覆盖getHeader方法，将参数名和参数值都做xss过滤。<br/>
	* 如果需要获得原始的值，则通过super.getHeaders(name)来获取<br/>
	* getHeaderNames 也可能需要覆盖
	*/
	@Override
	public String getHeader(String name) {
		if(!ignore) {
			String value = super.getHeader(xssEncode(name));
			if (value != null) {
				value = xssEncode(value);
			}
			return value;
		}
		return super.getHeader(name);
	}

	/**
	* 将容易引起xss漏洞的半角字符直接替换成全角字符
	*
	* @param s
	* @return
	*/
	private static String xssEncode(String s) {
		if (s == null || "".equals(s)) {
			return s;
		}
		StringBuilder sb = new StringBuilder(s.length() + 16);
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			switch (c) {
			case '>':
				sb.append('＞');//全角大于号
				break;
			case '<':
				sb.append('＜');//全角小于号
				break;
			case '\'':
				sb.append('‘');//全角单引号
				break;
			case '\"':
				sb.append('“');//全角双引号
				break;
			case '&':
				sb.append('＆');//全角
				break;
			case '\\':
				sb.append('＼');//全角斜线
				break;
			case '#':
				sb.append('＃');//全角井号
				break;
			default:
				sb.append(c);
				break;
			}
		}
		return sb.toString();
	}

	/**
	* 获取最原始的request
	*
	* @return
	*/
	public HttpServletRequest getOrgRequest() {
		return orgRequest;
	}

	/**
	* 获取最原始的request的静态方法
	*
	* @return
	*/
	public static HttpServletRequest getOrgRequest(HttpServletRequest req) {
		if (req instanceof XssHttpServletRequestWrapper) {
			return ((XssHttpServletRequestWrapper) req).getOrgRequest();
		}

		return req;
	}

}