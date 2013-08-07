package com.wnJava.bo;

import java.util.Date;

/**
 * 用户基本信息实体类
 * 
 * @author Kalor
 * @time 2012-12-17 at 下午05:00:40
 */
public class UserBO {
	private Long id;
	private String name;
	private String email;
	private String password;
	private Date reg_time;
	private Date logon_time;
	private String photo;
	private String user_level;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getReg_time() {
		return reg_time;
	}

	public void setReg_time(Date reg_time) {
		this.reg_time = reg_time;
	}
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Date getLogon_time() {
		return logon_time;
	}

	public void setLogon_time(Date logon_time) {
		this.logon_time = logon_time;
	}

	public String getUser_level() {
		return user_level;
	}

	public void setUser_level(String user_level) {
		this.user_level = user_level;
	}

}
