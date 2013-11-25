package com.wnJava.dao.impl;

import java.util.List;

import com.wnJava.bo.LoverInfoBO;
import com.wnJava.bo.TimeNodeBO;
import com.wnJava.dao.LoverDao;
import com.wnJava.dao.template.DbUtilsTemplate;
import com.wnJava.util.ConstantsUtil;

public class LoverDaoImpl implements LoverDao {
	private DbUtilsTemplate dbUtilsTemplate;

	
	public DbUtilsTemplate getDbUtilsTemplate() {
		return dbUtilsTemplate;
	}


	public void setDbUtilsTemplate(DbUtilsTemplate dbUtilsTemplate) {
		this.dbUtilsTemplate = dbUtilsTemplate;
	}


	@Override
	public List<TimeNodeBO> queryTimeNodes() {
		String sql = "select * from timeNode where 1=1 order by time desc";
		return dbUtilsTemplate.find(TimeNodeBO.class, sql);
	}


	@Override
	public int insertMemmory(String name, String des, String pos,
			String weather, String dress, String mood, String time) {
		String sql = "insert into timeNode(name,description,position,weather,dress,mood,time,photos) values (?,?,?,?,?,?,?,?)";
		Object[] params = {name,des,pos,weather,dress,mood,time,ConstantsUtil.DEFAULT_LOVER_PHOTO};
		return dbUtilsTemplate.update(sql, params);
	}


	@Override
	public String updateTimeNodeImg(String id, String photo) {
		String sql = "update timeNode set photos = ? where id = ?";
		Object[] params = {photo,id};
		return dbUtilsTemplate.update(sql, params)+"";
	}


	@Override
	public int updateLoverInfo(Long userId,String name, String gender, String birthday,
			String meetTime) {
		String sql = "update loverInfo set name=?,gender=?,birthday=?,meetTime=? where userId = ?";
		Object[] params = {name,gender,birthday,meetTime,userId};
		return dbUtilsTemplate.update(sql, params);
	}


	@Override
	public int insertLoverInfo(Long userId,String name, String gender, String birthday,
			String meetTime) {
		String sql = "insert into loverInfo(userId,name,gender,birthday,meetTime) values (?,?,?,?,?)";
		Object[] params = {userId,name,gender,birthday,meetTime};
		return dbUtilsTemplate.update(sql, params);
		
	}


	@Override
	public LoverInfoBO queryLoverInfo(Long userid) {
		String sql = "select * from loverInfo where userId = ?";
		return dbUtilsTemplate.findFirst(LoverInfoBO.class, sql,userid);
	}

}
