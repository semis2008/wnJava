package com.chatBear.spider;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;

import com.chatBear.comet.GetMsgAjax;
import com.chatBear.comet.MsgFactory;
import com.chatBear.model.CrawlContent;
import com.chatBear.model.CrawlSite;
import com.wnJava.util.ConstantsUtil;
import com.wnJava.util.XMLUtil;

/**
 * 自动爬取servlet
 * 
 * @author kalor
 * 
 */
public class AutoCrawl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(AutoCrawl.class);

	ServletContext sc;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		sc = config.getServletContext();
		String path = sc.getRealPath("/")+ConstantsUtil.SITE_INFO_XML;
		// 应用启动之后，一分钟以后开始爬取。每隔4小时爬取网站信息存放到MsgFactory里
		Timer timer = new Timer();
		timer.schedule(new CrawlTask(path), 60 * 1000,4 * 60 * 60 * 1000);
	}
}

/**
 * 一次爬取任务
 * 
 * @author kalor
 * 
 */
class CrawlTask extends TimerTask {
	String path = "";
	CrawlTask(String path) {
		super();
		this.path = path;
	}
	public void run() {
		XMLUtil.setConfPath(path);
		List<CrawlSite> sites = XMLUtil.getInstance().sites;
		//清空现有msg
		Map<String,List<CrawlContent>> contentPool = new HashMap<String,List<CrawlContent>>();
		GetMsgAjax.setContentPool(contentPool);
		
		CrawlSite resultSite = new CrawlSite();
		MsgFactory.getInstance();
		for (CrawlSite site : sites) {
			SiteCrawl crawl = new SiteCrawl();
			resultSite = crawl.getContentFromSite(crawl.doCrawlSite(site));
			MsgFactory.addSiteMsg(resultSite);
		}
	}
}