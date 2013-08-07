package com.chatBear.model;

import java.util.List;

import com.chatBear.enums.SiteState;
import com.chatBear.enums.SiteType;

/**
 * 爬取的站点信息
 * @author kalor
 */
public class CrawlSite extends CrawHtml{
	//网站标识
	private String id;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	//网站名称
	private String name;
	//网站起始页面
	private CrawlPage indexPage;
	//网站当前爬取到的url
	private String currentUrl;
	//网站类型（分页/单页）
	private SiteType type;
	//该站点需要爬取的所有url
	private List<String> urls;
	//爬取的结果
	private List<CrawlPage> resultPages;
	//总页数
	private int totalPage;
	//分页url格式，其中@替换为页码
	private String pageUrl;
	//截取内容的开始字符
	private String subContentStart;
	//截取内容的结束字符
	private String subContentEnd;
	//处理后的内容集
	private List<CrawlContent> contents;
	//状态
	private SiteState state;
	
	
	
	
	 
	public String getSubContentStart() {
		return subContentStart;
	}
	public void setSubContentStart(String subContentStart) {
		this.subContentStart = subContentStart;
	}
	public String getSubContentEnd() {
		return subContentEnd;
	}
	public void setSubContentEnd(String subContentEnd) {
		this.subContentEnd = subContentEnd;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public String getPageUrl() {
		return pageUrl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}
	public SiteType getType() {
		return type;
	}
	public List<CrawlContent> getContents() {
		return contents;
	}
	public void setContents(List<CrawlContent> contents) {
		this.contents = contents;
	}
	public void setType(SiteType type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public List<CrawlPage> getResultPages() {
		return resultPages;
	}
	public void setResultPages(List<CrawlPage> resultPages) {
		this.resultPages = resultPages;
	}
	public void setName(String name) {
		this.name = name;
	}
	public CrawlPage getIndexPage() {
		return indexPage;
	}
	public void setIndexPage(CrawlPage indexPage) {
		this.indexPage = indexPage;
	}
	public String getCurrentUrl() {
		return currentUrl;
	}
	public void setCurrentUrl(String currentUrl) {
		this.currentUrl = currentUrl;
	}
	public List<String> getUrls() {
		return urls;
	}
	public void setUrls(List<String> urls) {
		this.urls = urls;
	}
	public SiteState getState() {
		return state;
	}
	public void setState(SiteState state) {
		this.state = state;
	}
	 
}
