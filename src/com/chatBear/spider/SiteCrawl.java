package com.chatBear.spider;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

import org.apache.log4j.Logger;

import com.chatBear.enums.ContentState;
import com.chatBear.enums.PageState;
import com.chatBear.enums.SiteState;
import com.chatBear.enums.SiteType;
import com.chatBear.model.CrawlContent;
import com.chatBear.model.CrawlPage;
import com.chatBear.model.CrawlSite;
import com.wnJava.servlet.ChatServlet;
import com.wnJava.util.DateUtil;
import com.wnJava.util.StringUtil;
import com.wnJava.util.XMLUtil;

public class SiteCrawl {
	private static Logger logger = Logger.getLogger(ChatServlet.class);

	/**
	 * 爬取指定的页面
	 * 
	 * @param page
	 */
	private CrawlPage doCrawlPage(CrawlPage page)  throws Exception{
		logger.info("---爬取页面URL：" + page.getUrl() + "--开始时间:"
				+ DateUtil.getTimeNow());

		// 初始化待爬取url
		URL url;
		 
			url = new URL(page.getUrl());

			// 获取链接
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("User-Agent",
					"Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");// IE代理进行下载
			conn.setConnectTimeout(60000);
			conn.setReadTimeout(60000);
			conn.connect();

			// 获得网页返回信息码
			int responseCode = -1;
			responseCode = conn.getResponseCode();
			if (responseCode == -1) {
				logger.error("爬取页面：" + url.toString()
						+ "---出错----：错误信息： connection is failure...");
				conn.disconnect();
				return page;
			}
			logger.info("爬取页面：" + url.toString() + "的response code: "
					+ responseCode);
			if (responseCode >= 400) // 请求失败
			{
				logger.error("爬取页面" + url.toString()
						+ "---请求失败:response code: " + responseCode);
				conn.disconnect();
				return page;
			}

			page.setState(PageState.CRAWLING);
			// 获取网站的头部文件
			Map<String, List<String>> header = conn.getHeaderFields();
			StringBuffer headerStr = new StringBuffer();
			for (String key : header.keySet()) {
				headerStr.append(key + ":" + header.get(key) + "|");
			}
			page.setHead(headerStr.toString());

			// 获取网站内容
			BufferedReader br = new BufferedReader(new InputStreamReader(
					conn.getInputStream(), page.getUnicode()));
			StringBuffer content = new StringBuffer();
			String str = null;
			while ((str = br.readLine()) != null) {
				content.append(str + "\n");
			}
			page.setContent(content.toString());

			// 一次爬取结束
			conn.disconnect();
			page.setState(PageState.CRAWLED);
			logger.info("---爬取页面URL：" + page.getUrl() + "--结束时间:"
					+ DateUtil.getTimeNow());
		 
		return page;
	}

	/**
	 * 爬取指定的网站
	 * 
	 * @return
	 */
	public CrawlSite doCrawlSite(CrawlSite site){
		logger.info("---爬取站点：" + site.getName() + "--开始时间:"
				+ DateUtil.getTimeNow());

		List<CrawlPage> result = new ArrayList();

		try {
		// 多页网站
		if (SiteType.MUTI_PAGE.equals(site.getType())) {
			// 依据首页信息获取分页信息，并初始化urls
			site = initUrlsByPage(site);
			// 依据urls，返回需要遍历的页面
			List<CrawlPage> toCrawlPages = initCrawlPages(site);
			// 遍历页面集合，获取信息后返回
			for (CrawlPage page : toCrawlPages) {
					page = doCrawlPage(page);
				site.setCurrentUrl(page.getUrl());
				result.add(page);
			}
		} else if (SiteType.SINGLE_PAGE.equals(site.getType())) {// 单页网站
			// 获取网站首页内容
			CrawlPage indexPage = doCrawlPage(site.getIndexPage());

			result.add(indexPage);
		}

		site.setResultPages(result);
		logger.info("---爬取站点：" + site.getName() + "--结束时间:"
				+ DateUtil.getTimeNow());
		} catch (Exception e) {
			logger.error("爬取出错，重新爬取！");
			doCrawlSite(site);
			e.printStackTrace();
		}

		return site;
	}

	/**
	 * 依据页面初始化分页Urls--针对页码符合1，2，3...规则的网站
	 * 
	 * @param site
	 * @param page
	 * @return
	 */
	private CrawlSite initUrlsByPage(CrawlSite site) {
		List<String> urls = new ArrayList();
		for (int i = 1; i < site.getTotalPage() + 1; i++) {
			String url = site.getPageUrl().replace("@", i + "");
			urls.add(url);
		}
		site.setUrls(urls);
		return site;
	}

	/**
	 * 依据urls，返回需要遍历的页面
	 * 
	 * @param site
	 * @return
	 */
	private List initCrawlPages(CrawlSite site) {
		List<CrawlPage> result = new ArrayList<CrawlPage>();
		for (String url : site.getUrls()) {
			CrawlPage page = new CrawlPage();
			page.setSiteName(site.getName());
			page.setUnicode(site.getUnicode());
			page.setUrl(url);
			result.add(page);
		}
		return result;
	}

	/**
	 * 从网站爬取的结果页面中获取所需要的内容
	 * 
	 * @param site
	 * @return
	 */
	public CrawlSite getContentFromSite(CrawlSite site) {
		CrawlSite resultSite = site;
		List<CrawlPage> pages = site.getResultPages();
		List<CrawlContent> contents = new ArrayList();
		for (CrawlPage page : pages) {
			// 从html中获取所需的内容
			String pageHtml = page.getContent();
			String start = site.getSubContentStart();
			String end = site.getSubContentEnd();
			String[] part1 = pageHtml.split(start);
			int flag = 0;
			for (String tempStr : part1) {
				// 网页的开始部分去掉
				if (flag == 0) {
					flag++;
					continue;
				}
				String[] part2 = tempStr.split(end);
				String resultContent = part2[0];
				// 爬取的内容和头文件合并，用以产生完整的html元素
				resultContent = start + resultContent;

				// 对抓取到的内容进行处理
				// 1.过滤掉html元素
				// 2.内容过短和过长的去掉
				// 3.过滤掉空白
				resultContent = StringUtil.Html2Text(resultContent).trim();
				if (resultContent.length() < 30 || resultContent.length() > 120) {
					continue;
				}

				CrawlContent content = new CrawlContent();
				content.setContent(resultContent);
				content.setSiteName(site.getName());
				content.setState(ContentState.NOT_PUBLISH);
				contents.add(content);
			}
		}
		resultSite.setContents(contents);
		return resultSite;
	}

	public static void main(String[] args) {
		List<CrawlSite> sites = XMLUtil.getInstance().sites;
		CrawlSite resultSite = new CrawlSite();
		for (CrawlSite site : sites) {
			SiteCrawl crawl = new SiteCrawl();
			try {
				resultSite = crawl.getContentFromSite(crawl.doCrawlSite(site));
			} catch (Exception e) {
				logger.error("爬取出错，需要重新爬取");
				e.printStackTrace();
			}
		}
		logger.info("end");
	}

}