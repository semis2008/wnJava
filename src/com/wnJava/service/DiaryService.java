package com.wnJava.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.DiaryReplyBO;
import com.wnJava.vo.DynamicVO;

/**
 * 日志业务处理类
 * 
 * @author kalor
 * @time 2013-1-24 at 下午04:12:06
 */
public interface DiaryService {

	/**
	 * 发布日志
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	String newDiary(HttpServletRequest req, HttpServletResponse resp);

	/**
	 * 删除日志
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	int deleteDiary(HttpServletRequest req, HttpServletResponse resp);

	/**
	 * 编辑日志
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	String editDiary(HttpServletRequest req, HttpServletResponse resp);

	/**
	 * 登录用户发表回复
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	int newUserReply(HttpServletRequest req, HttpServletResponse resp);

	/**
	 * 游客发表回复
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	int newGuestReply(HttpServletRequest req, HttpServletResponse resp);

	/**
	 * 获取指定用户的日志列表
	 * 
	 * @param req
	 * @param resp
	 * @return 日志列表
	 */
	List<DiaryBO> getUserDiaryList(HttpServletRequest req,
			HttpServletResponse resp);

	/**
	 * 获取系统所有的日志列表
	 * 
	 * @param req
	 * @param resp
	 * @return 日志列表
	 */
	List<DiaryBO> getAllDiaryList(HttpServletRequest req,
			HttpServletResponse resp);

	/**
	 * 获取访问用户的最新日志列表 (取前5条)
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	List<DiaryBO> getUserNewDiaryList(HttpServletRequest req,
			HttpServletResponse resp);

	/**
	 * 获取用户的日志数目
	 * 
	 * @param userid
	 * @return
	 */
	String getUserDiaryNum(String userid);

	/**
	 * 获取最新日志列表 (取前8条)
	 * 
	 * @return
	 */
	List<DiaryBO> getNewDiaryList();

	/**
	 * 获取系统公告
	 * 
	 * @return
	 */
	List<DiaryBO> getNotices();

	/**
	 * 通过日志id获取日志信息
	 * 
	 * @param diaryId
	 *            日志id
	 * @return 日志实体类
	 */
	DiaryBO getDiaryByID(String diaryId);

	/**
	 * 获取指定日志的所有回复
	 * 
	 * @param diaryid
	 *            日志id
	 * @return
	 */
	List<DiaryReplyBO> getDiaryReplyListById(String diaryid);

	/**
	 * 获取指定id的回复
	 * 
	 * @param replyId
	 * @return
	 */
	DiaryReplyBO getDiaryReplyById(String replyId);

	/**
	 * 更新日志的阅读数
	 * 
	 * @param diaryid
	 *            日志id
	 * @return
	 */
	int updateDiaryRead(String diaryid);

	/**
	 * 获取系统日志总数
	 * 
	 * @return
	 */
	int getTotalDiaryCount();

	/**
	 * 获取首页动态信息之用户最新日志
	 * 
	 * @param dynamicVO
	 * @return
	 */
	DynamicVO getDynamicVOPart1(DynamicVO dynamicVO);

}
