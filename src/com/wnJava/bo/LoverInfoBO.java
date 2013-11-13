package com.wnJava.bo;

import java.util.Date;

/**
 * 爱人信息BO
 * @author Kalor
 *
 */
public class LoverInfoBO {
	private Long id;
	private Long userId;
	private String name;
	private Integer gender;
	private Date birthday;
	private Date meetTime;
	private Date loveTime;
	private Date marriageTime;
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
	public Integer getGender() {
		return gender;
	}
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public Date getMeetTime() {
		return meetTime;
	}
	public void setMeetTime(Date meetTime) {
		this.meetTime = meetTime;
	}
	public Date getLoveTime() {
		return loveTime;
	}
	public void setLoveTime(Date loveTime) {
		this.loveTime = loveTime;
	}
	public Date getMarriageTime() {
		return marriageTime;
	}
	public void setMarriageTime(Date marriageTime) {
		this.marriageTime = marriageTime;
	}
}
