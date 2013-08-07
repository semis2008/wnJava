package com.wnJava.bo;

import java.util.Date;
 
/**
 * 留言实体类
 * @author kalor
 * @time 2013-1-16 at 下午05:40:06
 */
public class LeaveMsgBO {
	private Long id;
	private String email;
	private String name;
	private String msg;
	private Date leave_time;
	private Long visited_user_id;
	private Long user_id;
	private String user_photo;
	private String type;
	
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public String getUser_photo() {
		return user_photo;
	}
	public void setUser_photo(String user_photo) {
		this.user_photo = user_photo;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public Date getLeave_time() {
		return leave_time;
	}
	public void setLeave_time(Date leave_time) {
		this.leave_time = leave_time;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	} 
	public Long getVisited_user_id() {
		return visited_user_id;
	}
	public void setVisited_user_id(Long visited_user_id) {
		this.visited_user_id = visited_user_id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
}