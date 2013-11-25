package com.wnJava.servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.DiaryReplyBO;
import com.wnJava.bo.LeaveMsgBO;
import com.wnJava.bo.LoverInfoBO;
import com.wnJava.bo.TimeNodeBO;
import com.wnJava.bo.UserBO;
import com.wnJava.bo.UserInfoBO;
import com.wnJava.service.DiaryService;
import com.wnJava.service.LoverService;
import com.wnJava.service.UserService;
import com.wnJava.util.DateUtil;
import com.wnJava.util.EncryptUtil;
import com.wnJava.util.UserUtil;
import com.wnJava.vo.LoveRoadVO;
import com.wnJava.vo.LoverHolidayVO;

/**
 * LoverTime处理类
 * 
 * @author Kalor
 * 
 */
@Component
public class LoverTimeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(LoverTimeServlet.class);

	private LoverService loverService;

	public LoverService getLoverService() {
		return loverService;
	}

	public void setLoverService(LoverService loverService) {
		this.loverService = loverService;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html;charset=utf-8");
		String fun = (String) req.getParameter("fun");
		String pjax = (String) req.getParameter("pjax");
		if ("saveLoverInfo".equals(fun)) {
			saveLoverInfo(req, resp);
		} else if ("saveMemmory".equals(fun)) {
			saveMemmory(req, resp);
		} else if ("uploadImg".equals(fun)) {
			uploadImg(req, resp);
		}else {
			if ((pjax == null || !pjax.equals("true")) && !("index_").contains(fun)) {
				fun = "index";
			}
			String targetpath = "";
			if ("index".equals(fun)) {
				targetpath = showLoverTime(req, resp);
			} else if ("setLoverInfo".equals(fun)) {
				targetpath = "/jsp/loverTime/loverInfoHtml.jsp";
			} else if ("addMemmory".equals (fun)) {
				targetpath = "/jsp/loverTime/addMemmoryHtml.jsp";
			} else if ("addPoint".equals(fun)) {
				targetpath = "/jsp/loverTime/addPointHtml.jsp";
			}
			req.setAttribute("fun", fun);
			RequestDispatcher rd = req.getRequestDispatcher(targetpath);
			rd.forward(req, resp);
		}
	}
	
	

	/**
	 * 显示loverTime
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws ParseException
	 */
	private String showLoverTime(HttpServletRequest req,
			HttpServletResponse resp) {
		// 获取爱情之路的vo
		LoveRoadVO loveRoad = loverService.getLoveRoadInfo(req, resp);
		// 获取节日提醒list,取前5个
		LoverInfoBO bo = loverService.getLoverInfo(req, resp);
		List<LoverHolidayVO> holidayList = DateUtil.getLoveHoliday(bo);
		// 获取爱情时间线
		List<TimeNodeBO> nodes = loverService.getTimeNodes();
		
		req.setAttribute("LoveRoad", loveRoad);
		req.setAttribute("nodes", nodes);
		req.setAttribute("holidayList", holidayList);

		return "/jsp/loverTime/index.jsp";
	}

	/**
	 * 上传图片
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws Exception 
	 * @throws IOException
	 */
	private void uploadImg(HttpServletRequest req, HttpServletResponse resp) {
		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();

			ServletFileUpload upload = new ServletFileUpload(factory);
			List list = null;
			list = upload.parseRequest(req);
			Iterator it = list.iterator();
			String filename = "";
			String photoPath = "";
			while (it.hasNext()) {
				FileItem item = (FileItem) it.next();// 每一个item就代表一个表单输出项
				if(item.getName()==null) {
					continue;
				}	
				// 按照时间生成图片名称
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				String mDateTime = formatter.format(cal.getTime());
				filename = mDateTime+".jpg";

				// 得到上传文件要写入的目录
				String path = this.getServletContext().getRealPath("/img/lover/photo");
				// 根据目录和文件创建输出流
				photoPath = path + filename;
				FileOutputStream out1 = new FileOutputStream(photoPath);

				InputStream in = item.getInputStream();
				byte buffer[] = new byte[1024];
				int len = 0;
				while ((len = in.read(buffer)) > 0) {
					out1.write(buffer, 0, len);
				}
				in.close();
				out1.close();
			}
			
			String nodeId = req.getParameter("p1");
			String result = loverService.uploadImg(nodeId,"/img/lover/photo"+filename);
			
			resp.sendRedirect("http://www.wnjava.com/action/lovertime/index"); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	/**
	 * 保存爱人信息
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 */
	private void saveLoverInfo(HttpServletRequest req, HttpServletResponse resp) {
		PrintWriter out;
		try {
			out = resp.getWriter();
			String result = loverService.saveLoverInfo(req, resp);
			out.print(result);
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	/**
	 * 保存记忆节点
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * @throws IOException
	 */
	private void saveMemmory(HttpServletRequest req, HttpServletResponse resp) {
		PrintWriter out;
		try {
			out = resp.getWriter();
			String result = loverService.saveMemmory(req, resp);
			out.print(result);
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
