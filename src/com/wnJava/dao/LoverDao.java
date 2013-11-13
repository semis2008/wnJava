package com.wnJava.dao;

import com.wnJava.bo.LoverInfoBO;

/**
 * lovertime的dao操作类
 * @author Administrator
 *
 */
public interface LoverDao {
	
	/**
	 * 保存爱人信息
	 * @param bo
	 * @return
	 */
	int insertLoverInfo(Long userId,String name,String gender,String birthday,String meetTime);  
	
	/**
	 * 更新爱人信息
	 * @param bo
	 * @return
	 */
	int updateLoverInfo(Long userId,String name,String gender,String birthday,String meetTime);

	/**
	 * 查询lover信息
	 * @param userid
	 * @return
	 */
	LoverInfoBO queryLoverInfo(Long userid); 
}
