package com.wnJava.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.DiaryReplyBO;
import com.wnJava.bo.LeaveMsgBO;
import com.wnJava.bo.LoverInfoBO;
import com.wnJava.bo.UserBO;
import com.wnJava.bo.UserInfoBO;
import com.wnJava.service.DiaryService;
import com.wnJava.service.LoverService;
import com.wnJava.service.UserService;
import com.wnJava.util.DateUtil;
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
		} else {
			if ((pjax == null || !pjax.equals("true")) && !fun.equals("index")) {
				fun = "index";
			}
			String targetpath = "";
			if ("index".equals(fun)) {
				targetpath = showLoverTime(req, resp);
			} else if ("setLoverInfo".equals(fun)) {
				targetpath = "/jsp/loverTime/loverInfoHtml.jsp";
			} else if ("addMemmory".equals(fun)) {
				targetpath = "/jsp/loverTime/addMemmoryHtml.jsp";
			} else if ("addPoint".equals(fun)) {
				targetpath = "/jsp/loverTime/addPointHtml.jsp";
			} else if ("showTimeLine".equals(fun)) {
				targetpath = "/jsp/loverTime/timeLineHtml.jsp";
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

		req.setAttribute("LoveRoad", loveRoad);
		req.setAttribute("holidayList", holidayList);

		return "/jsp/loverTime/index.jsp";
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
}
