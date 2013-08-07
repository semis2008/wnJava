package com.wnJava.bo;

import java.util.Date;

/**
 * 用户详细信息实体类
 * @author kalor
 * @time 2013-1-17 at 下午02:40:59
 */
public class UserInfoBO {
	private Long id;
	private Long user_id;
	private String rel_name;
	private int gender;
	private Date birthday;
	private String home_province;
	private String hobby;
	private String contact;
	private String public_info;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public String getRel_name() {
		return rel_name;
	}
	public void setRel_name(String rel_name) {
		this.rel_name = rel_name;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getHome_province() {
		return home_province;
	}
	public void setHome_province(String home_province) {
		this.home_province = home_province;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getPublic_info() {
		return public_info;
	}
	public void setPublic_info(String public_info) {
		this.public_info = public_info;
	}
}