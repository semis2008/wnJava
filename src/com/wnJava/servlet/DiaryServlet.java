package com.wnJava.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.UserBO;
import com.wnJava.service.DiaryService;
import com.wnJava.util.UserUtil;

/**
 * 日志相关处理类
 * 
 * @author kalor
 * @time 2013-1-24 at 下午04:11:17
 */
@Component
public class DiaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(DiaryServlet.class);
	private DiaryService diaryService;

	public void setDiaryService(DiaryService diaryService) {
		this.diaryService = diaryService;
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
		if ("newdiary".equals(fun)) {
			newDiary(req, resp);
		} else if ("newreply".equals(fun)) {
			newReply(req, resp);
		} else if ("delete".equals(fun)) {
			deleteDiary(req, resp);
		} else if ("getdiaryinfo".equals(fun)) {
			getDiaryInfo(req, resp);
		} else if ("editdiary".equals(fun)) {
			editDiary(req, resp);
		} else if ("changetopdiary".equals(fun)) {
			changeTopDiary(req, resp);
		}
	}

	/**
	 * 发布日志
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void newDiary(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String result = diaryService.newDiary(req, resp);
		out.print(result);
		out.flush();
		out.close();
	}

	/**
	 * 删除日志
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void deleteDiary(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		int result = diaryService.deleteDiary(req, resp);
		String msg = "";
		if (result < 1) {
			msg = "fail";
		} else {
			msg = result + "";
		}
		out.print(msg);
		out.flush();
		out.close();
	}

	/**
	 * 更换推荐日志
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void changeTopDiary(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		String nowId = req.getParameter("id");
		// 获取热门日志
		DiaryBO  topDiary = diaryService.getTopDiaryExcept(nowId);

		req.setAttribute("topDiary", topDiary);
		RequestDispatcher rd = req
				.getRequestDispatcher("/jsp/topDiaryHtml.jsp");
		try {
			rd.forward(req, resp);
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 编辑日志
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void editDiary(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String result = diaryService.editDiary(req, resp);
		out.print(result);
		out.flush();
		out.close();
	}

	/**
	 * 获取日志信息
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void getDiaryInfo(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String diaryid = req.getParameter("diaryid");
		DiaryBO bo = diaryService.getDiaryByID(diaryid);
		JSONObject json = null;
		if (bo != null) {
			json = JSONObject.fromObject(bo);
		}
		out.print(json);
		out.flush();
		out.close();
	}

	/**
	 * 新建回复
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void newReply(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		String type = req.getParameter("type");
		int result = 0;
		if ("user".equals(type)) {
			result = diaryService.newUserReply(req, resp);
		} else if ("guest".equals(type)) {
			result = diaryService.newGuestReply(req, resp);
		}
		String msg = "";
		if (result < 1) {
			msg = "fail";
		} else {
			msg = "success";
		}
		out.print(msg);
		out.flush();
		out.close();
	}

}
