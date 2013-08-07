package com.chatBear.comet;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.chatBear.model.CrawlContent;

/**
 * WN Chat系统处理类
 * 
 * @author Kalor
 * 
 */
@Component
public class GetMsgAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(GetMsgAjax.class);
	private static Map<String,List<CrawlContent>> contentPool = new HashMap<String,List<CrawlContent>>();
	
	public static Map<String, List<CrawlContent>> getContentPool() {
		return contentPool;
	}

	public static void setContentPool(Map<String, List<CrawlContent>> contentPool) {
		GetMsgAjax.contentPool = contentPool;
	}

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		logger.info("初始化了一个示例："+this.getClass().getName());
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
	
	
	
	
	private List<CrawlContent> contents = null;
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1)
			throws ServletException, IOException {
		
		super.service(arg0, arg1);
	}




	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		String msg = "";
		
		
		resp.setContentType("text/html;charset=utf-8");
		String msgId = req.getParameter("id");
		Integer count = Integer.parseInt(req.getParameter("count"));
		if(contentPool.containsKey(msgId)) {
			contents = contentPool.get(msgId);
		}else{
			contents =  MsgFactory.getSiteMsg(msgId).getContents();
			contentPool.put(msgId, contents);
		}
		String isEnd = "false";
		if(contents.size()-1<count) {
			//内容发布完毕，循环
			count = 1;
			isEnd = "true";
		} 
		
		msg = contents.get(count).getContent() +"- -"+ contents.get(count).getSiteName();
		
		//转化为json
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();
		  Map<String, String> par_map = new HashMap<String, String>();
		  par_map.put("msg", msg);
		  par_map.put("isEnd", isEnd);
		  list.add(par_map);
		  JSONArray jsonObject = JSONArray.fromObject(list);
		
		try {
			int time = (int) (Math.random() * 8000) + 3000;
			Thread.sleep(time);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		out.write(jsonObject.toString());
		out.flush();
		out.close();
	}
	
	
	/**
	  * List深度clone
	  * @param src
	  * @return
	  */
	 public static ArrayList<Object> copyList(ArrayList<Object> src){   
	  ArrayList<Object> list = null;
	  try{
	   ByteArrayOutputStream byteout = new ByteArrayOutputStream();   
	         ObjectOutputStream out = new ObjectOutputStream(byteout);   
	         out.writeObject(src);
	         ByteArrayInputStream bytein = new ByteArrayInputStream(byteout.toByteArray());   
	         ObjectInputStream in =new ObjectInputStream(bytein);   
	         list = (ArrayList<Object>)in.readObject();
	        }catch(Exception e){
	         System.out.println("cache copy error !");
	         e.printStackTrace();
	        }
	        return list;   
	    }
}
