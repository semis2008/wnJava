package com.wnJava.dao;

import java.util.List;

import com.wnJava.bo.LoverInfoBO;
import com.wnJava.bo.TimeNodeBO;

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
	 * 更新记忆节点图片信息
	 * @param id
	 * @param photo
	 * @return
	 */
	String updateTimeNodeImg(String id,String photo);
	
	/**
	 * 查询时间线节点
	 * @return
	 */
	List<TimeNodeBO> queryTimeNodes();
	/**
	 * 插入新记忆
	 * @param name
	 * @param des
	 * @param pos
	 * @param weather
	 * @param dress
	 * @param mood
	 * @param time
	 * @return
	 */
	int insertMemmory(String name,String des,String pos,String weather,String dress,String mood,String time);
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
