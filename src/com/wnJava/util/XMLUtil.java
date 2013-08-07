package com.wnJava.util;

import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import com.chatBear.enums.PageState;
import com.chatBear.enums.SiteState;
import com.chatBear.enums.SiteType;
import com.chatBear.model.CrawlPage;
import com.chatBear.model.CrawlSite;

/**
 * XML处理类，本类单独针对siteInfo.xml进行解析
 * @author kalor
 * @time 2013-3-21 at 上午11:21:00
 */
public class XMLUtil {
	public static XMLUtil xmlUtil;
	public List<CrawlSite> sites;
	private static String confPath = "";

	public static String getConfPath() {
		return confPath;
	}

	public static void setConfPath(String confPath) {
		XMLUtil.confPath = confPath;
	}

	@SuppressWarnings("unchecked")
	private XMLUtil() {
		sites = new ArrayList<CrawlSite>();
		SAXReader saxReader = new SAXReader();
		saxReader.setEncoding("UTF-8");
		Document document = null;
		try {
			document = saxReader.read(confPath);
		} catch (DocumentException e1) {
			System.out.println("读取配置文件出错");
			e1.printStackTrace();
			return;
		}
		try {

			Element rootElt = document.getRootElement(); // 获取根节点
			Iterator<Element> iter = rootElt.elementIterator();

			while (iter.hasNext()) {
				Element recordEle = (Element) iter.next();
				Iterator<Element> iterInner = recordEle.elementIterator();
				Map<String,String> temp = new HashMap<String, String>();
				while (iterInner.hasNext()) {
					Element recordS = (Element) iterInner.next();
					System.out.println(recordS.getName() + "...."
							+ recordS.getText());
					temp.put(recordS.getName(), recordS.getText());
				}
				
				CrawlSite site = new CrawlSite();
				site.setId(temp.get("id"));
				site.setName(temp.get("name"));
				site.setUnicode(temp.get("unicode"));
				site.setTotalPage(Integer.parseInt(temp.get("total-page")));
				site.setPageUrl(temp.get("page-url"));
				site.setSubContentStart(temp.get("sub-content-start"));
				site.setSubContentEnd(temp.get("sub-content-end"));
				site.setType(temp.get("type").equals("1")?SiteType.SINGLE_PAGE:SiteType.MUTI_PAGE);
				site.setState(SiteState.NOT_START);
				CrawlPage page = new CrawlPage();
				page.setSiteName(site.getName());
				page.setState(PageState.NOT_START);
				page.setUnicode(site.getUnicode());
				page.setUrl(temp.get("url"));
				site.setIndexPage(page);
				
				sites.add(site);
			}
		} catch (Exception e) {
			System.out.println("解析配置文件出错");
			e.printStackTrace();
			return;
		}
	}

	public static XMLUtil getInstance() {
		if (xmlUtil == null) {
			xmlUtil = new XMLUtil();
		}
		return xmlUtil;
	}

	/**
	 * 刷新配置文件（设置配置文件实例为空）
	 */
	public static void refresh() {
		xmlUtil = null;
	}

	public static void main(String[] args) {
		XMLUtil.getInstance();
		
	}

	/**
	 * 设置配置文件中的值
	 * 
	 * @param element
	 *            节点
	 * @param attribute
	 *            参数内容
	 * @return
	 */
	public static boolean setParameter(String element, String attribute) {
		boolean returnValue = false;
		try {
			SAXReader saxReader = new SAXReader();
			Document document = saxReader.read(confPath);
			saxReader.setEncoding("UTF-8");
			/** 先用xpath查找对象 */

			Element rootElm = document.getRootElement();
			List<?> nodes = rootElm.elements(element);
			for (Iterator<?> it = nodes.iterator(); it.hasNext();) {
				Element elm = (Element) it.next();
				elm.setText(attribute);
			}
			try {
				/** 将document中的内容写入文件中 */
				OutputFormat format = OutputFormat.createPrettyPrint();
				format.setEncoding("utf-8");
				FileOutputStream fileWriter = new FileOutputStream(confPath);
				XMLWriter writer = new XMLWriter(fileWriter, format);
				writer.write(document);
				writer.close();
				/** 执行成功,需返回true */
				returnValue = true;
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return returnValue;
	}
	
}
