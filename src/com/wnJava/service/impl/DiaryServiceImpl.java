package com.wnJava.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.DiaryReplyBO;
import com.wnJava.bo.UserBO;
import com.wnJava.dao.DiaryDao;
import com.wnJava.service.DiaryService;
import com.wnJava.util.UserUtil;

/**
 * 日志业务处理接口实现类
 * 
 * @author kalor
 * @time 2013-1-24 at 下午04:14:37
 */
public class DiaryServiceImpl implements DiaryService {

	private DiaryDao diaryDao;

	public void setDiaryDao(DiaryDao diaryDao) {
		this.diaryDao = diaryDao;
	}

	@Override
	public String newDiary(HttpServletRequest req, HttpServletResponse resp) {
		String title = req.getParameter("title");
		String tags = req.getParameter("tags");
		String diaryContent = req.getParameter("diaryContent");
		// 数据库长度为16777215，空余70万字符用作文字
		if (diaryContent.length() > 1600 * 1000) {
			return "imgError";
		}

		UserBO user = UserUtil.getLoginUser(req, resp);
		if (!"".equals(tags.trim())) {
			tags = tags.replace(" ", "_");
		}
		return diaryDao.insertDiary(title, tags, diaryContent, user.getId(),
				user.getName());
	}

	@Override
	public String editDiary(HttpServletRequest req, HttpServletResponse resp) {
		String diaryid = req.getParameter("id");
		String title = req.getParameter("title");
		String diaryContent = req.getParameter("diaryContent");
		String tags = req.getParameter("tags");
		// 数据库长度为16777215，空余70万字符用作文字
		if (diaryContent.length() > 1600 * 1000) {
			return "imgError";
		}
		if (!"".equals(tags.trim())) {
			tags = tags.replace(" ", "_");
		}
	  	return  diaryDao.updateDiary(Long.valueOf(diaryid), title,tags,diaryContent);
	}

	@Override
	public List<DiaryBO> getUserDiaryList(HttpServletRequest req,
			HttpServletResponse resp) {
		UserBO visitUser = UserUtil.getVisitedUser(req, resp);
		String pageNum = req.getParameter("p1");
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		/*
		 * 获取日志总页数
		 */
		int totalDiary = diaryDao.queryDiaryNumByUserId(visitUser.getId());
		int totalPage = totalDiary / 10 + 1;

		req.setAttribute("currentPage", currentPage);
		req.setAttribute("totalPage", totalPage);
		// TODO 考虑添加用户定义置顶的日志逻辑
		return diaryDao.queryUserDiaryList(visitUser.getId(),
				10 * (currentPage - 1), 10 * currentPage);
	}

	@Override
	public List<DiaryBO> getAllDiaryList(HttpServletRequest req,
			HttpServletResponse resp) {
		String pageNum = req.getParameter("p1");
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		/*
		 * 获取日志总页数
		 */
		int totalDiary = diaryDao.queryTotalDiaryCount();
		int totalPage = totalDiary / 5 + 1;

		req.setAttribute("currentPage", currentPage);
		req.setAttribute("totalPage", totalPage);
		// TODO 考虑添加置顶的日志逻辑
		return diaryDao.queryAllDiaryList(5 * (currentPage - 1),
				5 * currentPage);
	}

	@Override
	public DiaryBO getTopDiaryRand() {
		List<DiaryBO> topDiaries = diaryDao.queryDiaryByStatus("top");
		int index = 0;
		index = (int) (Math.random()*(topDiaries.size()+1));
		if(index!=0&&index==topDiaries.size()) index--;
		return topDiaries.get(index);
	}

	@Override
	public Map<String, List<DiaryBO>> getHotDiaries() {
		List<DiaryBO> diaries = diaryDao.queryDiaryOrderByReadNum(0, 5);
		Map<String, List<DiaryBO>> result = new HashMap<String, List<DiaryBO>>();
		result.put("left", diaries);
		diaries = diaryDao.queryDiaryOrderByReadNum(5, 5);
		result.put("right", diaries);
		return result;
	}

	@Override
	public DiaryBO getTopDiaryExcept(String id) {
		List<DiaryBO> topDiaries = diaryDao.queryDiaryByStatusExcept("top",id);
		int index = 0;
		index = (int) (Math.random()*(topDiaries.size()+1));
		if(index!=0&&index==topDiaries.size()) index--;
		return topDiaries.get(index);
	}

	@Override
	public String getUserDiaryNum(String userid) {
		/*
		 * 获取日志总页数
		 */
		int totalDiary = diaryDao.queryDiaryNumByUserId(Long.parseLong(userid));
		return totalDiary + "";
	}

	@Override
	public List<DiaryBO> getUserNewDiaryList(HttpServletRequest req,
			HttpServletResponse resp) {
		UserBO visitUser = UserUtil.getVisitedUser(req, resp);
		return diaryDao.queryUserDiaryList(visitUser.getId(), 0, 5);
	}

	@Override
	public List<DiaryBO> getNewDiaryList() {
		return diaryDao.queryAllDiaryList(0, 4);
	}

	@Override
	public DiaryBO getDiaryByID(String diaryId) {
		return diaryDao.queryDiaryById(Long.parseLong(diaryId));
	}

	@Override
	public int newGuestReply(HttpServletRequest req, HttpServletResponse resp) {
		String reply = req.getParameter("reply");
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String website = req.getParameter("website");
		String diaryId = req.getParameter("diaryid");
		String parentId = req.getParameter("parentid");
		if (parentId == null)
			parentId = "0";
		String parentName = "";
		if (!parentId.equals("0")) {
			parentName = getDiaryReplyById(parentId).getUser_name();
		}
		int result = diaryDao.insertReply(diaryId, parentName, parentId, reply,
				name, email, website);
		/*
		 * 更新日志回复数
		 */
		diaryDao.updateDiaryReplyNum(diaryId);

		return result;
	}

	@Override
	public int newUserReply(HttpServletRequest req, HttpServletResponse resp) {
		String reply = req.getParameter("reply");
		String diaryId = req.getParameter("diaryid");
		String parentId = req.getParameter("parentid");
		UserBO user = UserUtil.getLoginUser(req, resp);
		if (parentId == null)
			parentId = "0";
		String parentName = "";
		if (!parentId.equals("0")) {
			parentName = getDiaryReplyById(parentId).getUser_name();
		}
		int result = diaryDao.insertReply(diaryId, parentName, parentId, reply,
				user);
		/*
		 * 更新日志回复数
		 */
		diaryDao.updateDiaryReplyNum(diaryId);
		return result;
	}

	@Override
	public DiaryReplyBO getDiaryReplyById(String replyId) {
		return diaryDao.queryDiaryReplyById(Long.parseLong(replyId));
	}

	@Override
	public List<DiaryReplyBO> getDiaryReplyListById(String diaryid) {
		return diaryDao.queryDiaryReplyListById(Long.parseLong(diaryid));
	}

	@Override
	public int updateDiaryRead(String diaryid) {
		return diaryDao.updateDiaryRead(diaryid);
	}

	@Override
	public int getTotalDiaryCount() {
		return diaryDao.queryTotalDiaryCount();
	}

	@Override
	public int deleteDiary(HttpServletRequest req, HttpServletResponse resp) {
		String diaryId = req.getParameter("diaryid");
		if (diaryId == null || "".equals(diaryId)) {
			return -1;
		} else {
			return diaryDao.updateDiaryState(diaryId, "delete");
		}
	}
}
