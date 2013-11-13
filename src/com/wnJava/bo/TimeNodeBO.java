package com.wnJava.bo;

import java.util.Date;

/**
 * 时间节点bo
 * @author Administrator
 *
 */
public class TimeNodeBO {
	private Long id;
	private String name;
	private String description;
	private String position;
	private String weather;
	private String dress;
	private Date time;
	private String photoIds;
	private String mood;
	public String getMood() {
		return mood;
	}
	public void setMood(String mood) {
		this.mood = mood;
	}
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getWeather() {
		return weather;
	}
	public void setWeather(String weather) {
		this.weather = weather;
	}
	public String getDress() {
		return dress;
	}
	public void setDress(String dress) {
		this.dress = dress;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getPhotoIds() {
		return photoIds;
	}
	public void setPhotoIds(String photoIds) {
		this.photoIds = photoIds;
	}
}
