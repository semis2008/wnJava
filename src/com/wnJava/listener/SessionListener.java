package com.wnJava.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * session监听器
 * 
 * @author Kalor
 * @time 2012-11-14
 */
public class SessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent httpsessionevent) {
		System.out.println("session被创建了");
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent httpsessionevent) {
		System.out.println("session被摧毁了");
	}

}
