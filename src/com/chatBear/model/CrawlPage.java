package com.chatBear.model;

import com.chatBear.enums.PageState;

/**
 * 爬取的单页面信息
 * @author kalor
 */
public class CrawlPage extends CrawHtml{
	//所属网站名称
	private String siteName;
	//网站url
	private String url;
	//头信息
	private String head;
	//内容
	private String content;
	//状态
	private PageState state;
	
	
	
	
	
	
	
	
	
	
	
	
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public PageState getState() {
		return state;
	}
	public void setState(PageState state) {
		this.state = state;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
