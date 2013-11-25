package com.wnJava.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wnJava.bo.LoverInfoBO;
import com.wnJava.bo.TimeNodeBO;
import com.wnJava.vo.LoveRoadVO;

/**
 * lovertime业务处理类
 * @author Administrator
 *
 */
public interface LoverService {
	
	
	/**
	 * 获取时间线节点
	 * @return
	 */
	List<TimeNodeBO> getTimeNodes();
	
	/**
	 * 保存爱人信息
	 * @param req
	 * @param resp
	 * @return 
	 */
	String saveLoverInfo(HttpServletRequest req, HttpServletResponse resp);
	/**
	 * 保存记忆节点
	 * @param req
	 * @param resp
	 * @return 
	 */
	String saveMemmory(HttpServletRequest req, HttpServletResponse resp);
	
	/**
	 * 保存图片
	 * @param req
	 * @param resp
	 * @return
	 */
	String uploadImg(String nodeId, String fileName);
	
	
	/**
	 * 获取爱情之路信息vo.依据登录人获取，默认显示wn
	 * @param req
	 * @param resp
	 * @return
	 */
	LoveRoadVO getLoveRoadInfo(HttpServletRequest req, HttpServletResponse resp);
	

	/**
	 * 获取爱人信息bo.依据登录人获取，默认显示wn
	 * @param req
	 * @param resp
	 * @return
	 */
	LoverInfoBO getLoverInfo(HttpServletRequest req, HttpServletResponse resp);
}
