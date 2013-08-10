package com.wnJava.dao;

import java.util.List;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.DiaryReplyBO;
import com.wnJava.bo.UserBO;

/**
 * 日志数据处理接口
 * 
 * @author kalor
 * @time 2013-1-24 at 下午04:15:41
 */
public interface DiaryDao {

	/**
	 * 新增日志
	 * 
	 * @param title
	 *            日志标题
	 * @param tags
	 *            标签
	 * @param diaryContent
	 *            日志内容
	 * @param userId
	 *            作者id
	 * @param userName
	 *            作者姓名
	 * @return 受影响的行的主键
	 */
	String insertDiary(String title, String tags, String diaryContent,
			Long userId, String userName);

	/**
	 * 编辑日志
	 * 
	 * @param diaryId
	 *            作者id
	 * @param title
	 *            日志标题
	 * @param tags
	 *            标签
	 * @param diaryContent
	 *            日志内容
	 * @return 受影响的行的主键
	 */
	String updateDiary(Long diaryId, String title, String tags, String diaryContent);

	/**
	 * 插入新回复
	 * 
	 * @param diaryId
	 *            日志id
	 * @param parentId
	 *            上级id 0为回复的日志，其余为回复的日志回复
	 * @param reply
	 *            回复内容
	 * @param user
	 *            用户
	 * @return
	 */
	int insertReply(String diaryId, String parentName, String parentId,
			String reply, UserBO user);

	/**
	 * 插入新回复
	 * 
	 * @param diaryId
	 *            日志id
	 * @param parentId
	 *            上级id 0为回复的日志，其余为回复的日志回复
	 * @param reply
	 *            回复内容
	 * @param name
	 *            姓名
	 * @param email
	 *            邮箱
	 * @param website
	 *            网站
	 * @return
	 */
	int insertReply(String diaryId, String parentName, String parentId,
			String reply, String name, String email, String website);

	/**
	 * 查询用户日志列表
	 * 
	 * @param userId
	 *            用户id
	 * @param start
	 *            开始下标
	 * @param end
	 *            结束下标
	 * @return 日志实体类的List
	 */
	List<DiaryBO> queryUserDiaryList(Long userId, int start, int end);

	/**
	 * 获取热门日志
	 * @param start
	 * @param end
	 * @return
	 */
	List<DiaryBO> queryDiaryOrderByReadNum(int start,int end);
	/**
	 * 按照状态查询日志	
	 * @param status
	 * @return
	 */
	List<DiaryBO> queryDiaryByStatus(String status);
	
	/**
	 * 按照状态查询除指定id之外的日志
	 * @param status
	 * @param id
	 * @return
	 */
	List<DiaryBO> queryDiaryByStatusExcept(String status, String id);
	/**
	 * 查询所有日志列表
	 * 
	 * @param start
	 *            开始下标
	 * @param end
	 *            结束下标
	 * @return 日志实体类的List
	 */
	List<DiaryBO> queryAllDiaryList(int start, int end);

	/**
	 * 查询指定用户的日志总数
	 * 
	 * @param userId
	 *            用户id
	 * @return 日志总数
	 */
	int queryDiaryNumByUserId(Long userId);

	/**
	 * 根据日志id获取日志主要信息
	 * 
	 * @param diaryId
	 *            日志id
	 * @return 日志实体类
	 */
	DiaryBO queryDiaryById(Long diaryId);

	/**
	 * 获取指定日志的回复信息
	 * 
	 * @param diaryid
	 *            日志id
	 * @return 日志回复信息list
	 */
	List<DiaryReplyBO> queryDiaryReplyListById(Long diaryid);

	/**
	 * 日志回复数加一
	 * 
	 * @param diaryid
	 *            日志id
	 * @return
	 */
	int updateDiaryReplyNum(String diaryid);

	/**
	 * 更新日志阅读数
	 * 
	 * @param diaryid
	 *            日志id
	 * @return
	 */
	int updateDiaryRead(String diaryid);

	/**
	 * 更新日志状态
	 * 
	 * @param diaryid
	 *            日志id
	 * @return
	 */
	int updateDiaryState(String diaryid, String state);

	/**
	 * 获取系统日志总数
	 * 
	 * @return
	 */
	int queryTotalDiaryCount();

	/**
	 * 获取指定id的回复
	 * 
	 * @param id
	 * @return
	 */
	DiaryReplyBO queryDiaryReplyById(Long id);
}
