<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.vo.TagVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.wnJava.util.*"%>
<%@page import="com.wnJava.bo.*"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String fun = (String) request.getAttribute("fun");
	if (fun == null)
		fun = "";
	UserBO user = (UserBO) request.getAttribute("loginUser");
	//最新日志
	List<DiaryBO> latestDiaries = (ArrayList<DiaryBO>) request
			.getAttribute("latestDiaries");
	if (latestDiaries == null) {
		latestDiaries = new ArrayList<DiaryBO>();
	}
	//推荐日志
	DiaryBO topDiary = (DiaryBO) request.getAttribute("topDiary");
	if (topDiary == null) {
		topDiary = new DiaryBO();
	}
	//获取活跃用户
	List<UserBO> activeUsers = (List<UserBO>) request
			.getAttribute("activeUsers");
	if (activeUsers == null) {
		activeUsers = new ArrayList<UserBO>();
	}
	//获取热门日志
	Map<String, List<DiaryBO>> hotDiaries = (Map<String, List<DiaryBO>>) request
			.getAttribute("hotDiaries");
	if (hotDiaries == null) {
		hotDiaries = new HashMap<String, List<DiaryBO>>();
	}
	//获取热门标签
	List<TagVO> hotTags = (List<TagVO>) request.getAttribute("hotTags");
	if (hotTags == null) {
		hotTags = new ArrayList<TagVO>();
	}

	String userDiaryNum = "0";
	boolean hasLogin = false;
	if (user == null) {
		user = new UserBO();
	} else {
		hasLogin = true;
		userDiaryNum = (String) request.getAttribute("userDiaryNum");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- 网站公用顶部 -->
<jsp:include page="/jsp/common/head.jsp" flush="true">
	<jsp:param value="<%=hasLogin %>" name="hasLogin" />
	<jsp:param value="<%=user.getName() %>" name="userName" />
	<jsp:param value="<%=user.getId() %>" name="userId" />
	<jsp:param value="<%=fun %>" name="fun" />
	<jsp:param value="<%=userDiaryNum %>" name="userDiaryNum" />
</jsp:include>

<link href="/css/index.css" rel="stylesheet" type="text/css" />
 
<title>懒熊de部落格</title>
</head>
<body>
	<div id="content">
		<header class="no-radius image hero-unit" id="banner-head">
		<div class="container text-center">
			<h1>
				<img alt="WN Java" src="<%=ConstantsUtil.FW_DOMAIN%>/img/logo.png">
			</h1>
		</div>
		<div class="text-center logo-info">
			<h2>
				<a href="#">Wn Java</a> <small><em class="text-info">-
						-或许可以做成一个最简捷的社区~</em> </small>
			</h2>
		</div>
		</header>
		<div id="main-wrapper" class="container">
			<div>
				<div class="span3">
					<div class="sidebar">
						<!-- Sidebar -->
						<!-- Recent Posts -->
						<section>
						<h3 class="major">
							<span><i class="icon-list-ul"></i> 最新日志</span>
						</h3>
						<ul class="unstyled side-ul">
							<%
								for (DiaryBO diary : latestDiaries) {
							%>
							<li>
								<h5>
									<a data-type="pjax_highLight" href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diarydetail/<%=diary.getId()%>"><i class="icon-file-alt"></i> <%=StringUtil.cutString(diary.getTitle(), 100)%></a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-time"></i><a href="javascript:void(0);"> <%=DateUtil.formatDate(diary.getPublish_time(), 3)%></a>
									</li>
									<li><i class="icon-comment"></i><a href="javascript:void(0);"> <%=diary.getReply_num()%></a>
									</li>
								</ul></li>
							<%
								}
							%>
						</ul>
						<a data-type="pjax_highLight" class="button button-alt" href="<%=ConstantsUtil.FW_DOMAIN %>/action/system/diary">查看全部 <i
							class=" icon-hand-right"></i> </a> </section>
						<!-- /Recent Posts -->


						<!-- 活跃用户 -->
						<section id="activeUserSec">
						<h3 class="major">
							<span><i class="icon-user-md"></i> 活跃用户</span>
						</h3>
						<ul class="unstyled inline">
							<%
								for (UserBO activeUser : activeUsers) {
							%>
							<li class="padding-mini"><a href="#"
								title="<%=activeUser.getName()%>"> <img
									src="<%=ConstantsUtil.FW_DOMAIN%><%=activeUser.getPhoto()%>"
									class="img-polaroid" width="32px" height="32px" alt=""> <span
										class="activeUserName text-center"> <%=StringUtil.cutString(activeUser.getName(), 6)%>
									</span>
							</a></li>
							<%
								}
							%>
						</ul>
						<a class="button button-alt" href="javascript:void(0)">查看全部 <i
							class="icon-hand-right"></i> </a> </section>
						<!-- /活跃用户 -->


						<!-- 留言 -->
						<section id="leaveMsgListSec">
							<jsp:include page="/jsp/leaveMsgHtml.jsp" />
						</section>
						<!-- /留言 -->

						<!-- 热门标签 -->
						<section id="hotTagSec">
						<h3 class="major">
							<span><i class="icon-tags"></i> Hot Tags</span>
						</h3>
						<p>
							<%
								for (TagVO tag : hotTags) {
							%>
							<a href="#" class="margin-small tagSize<%=tag.getWeight()%>"><%=tag.getName()%></a>
							<%
								}
							%>
						</p>
						<!-- /热门标签 --> <!-- /Sidebar -->
					</div>
				</div>
				<div class="span8" id="right-content">
					<!-- 引入indexPageHtml -->	
					<jsp:include page="/jsp/indexPageHtml.jsp" /> 
				</div>
			</div>
		</div>
	</div>
	<!-- 底部 -->
	<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>