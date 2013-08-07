package com.chatBear.comet;

import java.util.HashMap;
import java.util.Map;

import com.chatBear.model.CrawlSite;

public class MsgFactory {
	private static MsgFactory factory;

	private MsgFactory() {
	}

	public static MsgFactory getInstance() {
		if (factory == null) {
			factory = new MsgFactory();
		}
		return factory;

	}

	private static Map<String,CrawlSite> MsgPool = new HashMap<String, CrawlSite>();
	
	/**
	 * 添加Msg
	 * @param site
	 */
	public static void addSiteMsg(CrawlSite site) {
		if(MsgPool.containsKey(site.getId())){
			MsgPool.remove(site.getId());
		}
		MsgPool.put(site.getId(), site);
	}
	
	/**
	 * 获取Msg
	 * @param id
	 */
	public static CrawlSite getSiteMsg(String id) {
		CrawlSite site = null;
		if(MsgPool.containsKey(id)) {
			site = MsgPool.get(id);
		}
		return site;
	}
	
}
