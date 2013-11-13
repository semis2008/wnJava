package com.wnJava.dao.impl;

import com.wnJava.bo.LoverInfoBO;
import com.wnJava.dao.LoverDao;
import com.wnJava.dao.template.DbUtilsTemplate;

public class LoverDaoImpl implements LoverDao {
	private DbUtilsTemplate dbUtilsTemplate;

	
	public DbUtilsTemplate getDbUtilsTemplate() {
		return dbUtilsTemplate;
	}


	public void setDbUtilsTemplate(DbUtilsTemplate dbUtilsTemplate) {
		this.dbUtilsTemplate = dbUtilsTemplate;
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
