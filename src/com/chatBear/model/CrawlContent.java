package com.chatBear.model;

import com.chatBear.enums.ContentState;

/**
 * 爬取所需的内容
 * @author kalor
 *
 */
public class CrawlContent {
	//内容所属网站
	private String siteName;
	//处理后的内容
	private String content;
	//状态
	private ContentState state;
	
	
	
	
	
	
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public ContentState getState() {
		return state;
	}
	public void setState(ContentState state) {
		this.state = state;
	}
	
}
