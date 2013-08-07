package com.wnJava.vo;

import java.util.List;

import com.wnJava.bo.DiaryBO;
import com.wnJava.bo.UserBO;

/**
 * 用于首页用户动态展示的VO，目前该VO包括两部分，一部分是三个用户最新发布的日志信息；另一部分是最近注册的5个用户的信息
 * @author Kalor
 * @time 13-4-4
 */
public class DynamicVO {
	private List<DiaryBO> dynamicPart1;
	private List<UserBO> dynamicPart2;
	public List<DiaryBO> getDynamicPart1() {
		return dynamicPart1;
	}
	public void setDynamicPart1(List<DiaryBO> dynamicPart1) {
		this.dynamicPart1 = dynamicPart1;
	}
	public List<UserBO> getDynamicPart2() {
		return dynamicPart2;
	}
	public void setDynamicPart2(List<UserBO> dynamicPart2) {
		this.dynamicPart2 = dynamicPart2;
	}
	
}
