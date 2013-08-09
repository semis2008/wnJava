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
	//获取留言
	List<LeaveMsgBO> leaveMsgs = (List<LeaveMsgBO>) request
			.getAttribute("leaveMsgs");
	if (leaveMsgs == null) {
		leaveMsgs = new ArrayList<LeaveMsgBO>();
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

<script type=
	
/javascript">
	
</script>
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
		<div class="bookmark">
			<ul class="breadcrumb">
				<li class="active">首页</li>
			</ul>
		</div>
		<div id="main-wrapper" class="container">
			<div>
				<div class="span4">
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
									<a href="#"><i class="icon-file-alt"></i> <%=StringUtil.cutString(diary.getTitle(), 100)%></a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-time"></i><a href="#"> <%=DateUtil.formatDate(diary.getPublish_time(), 3)%></a>
									</li>
									<li><i class="icon-comment"></i><a href="#"> <%=diary.getReply_num()%></a>
									</li>
								</ul></li>
							<%
								}
							%>
						</ul>
						<a class="button button-alt" href="javascript:void(0)">查看全部 <i
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
									class="img-polaroid" width="40px" height="40px" alt=""> <span
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
						<section>
						<h3 class="major">
							<span><i class="icon-envelope-alt"></i> 留言</span>
						</h3>
						<ul class="unstyled quote-list">
							<%
								for (LeaveMsgBO leaveMsg : leaveMsgs) {
							%>
							<li><a href="#" title="<%=leaveMsg.getName()%>"><img
									src="<%=ConstantsUtil.FW_DOMAIN%><%=leaveMsg.getUser_photo()%>"
									class="img-polaroid" width="40px" height="40px" alt="" />
							</a>
								<p>
									"<%=StringUtil.cutString(leaveMsg.getMsg(), 100)%>"
								</p> <span>-- <a href="#" title="<%=leaveMsg.getName()%>"><%=leaveMsg.getName()%></a>,
									<em><%=DateUtil.formatDate(leaveMsg.getLeave_time(), 3)%></em>
							</span></li>
							<%
								}
							%>
						</ul>
						<a class="button button-alt" href="javascript:void(0)">查看全部 <i
							class=" icon-hand-right"></i> </a> </section>
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
				<div class="span7">
					<!-- Content -->
					<article> <!-- 推荐日志 --> <section id="topDiarySec">
					<h3 class="major">
						<span><i class="icon-star-empty"></i> 推荐日志</span>
					</h3>
					<div>
						<img width="60px" height="60px" alt="" class="img-polaroid"
							src="../../img/wn_head01.jpg" />
						<blockquote>
							<h3 class="muted">
								<%=StringUtil.cutString(topDiary.getTitle(), 100)%>
								<em title="回复/阅读数">[<%=topDiary.getReply_num()%>/<%=topDiary.getRead_num()%>]</em>
							</h3>
							<small> <%
 	String[] tags = topDiary.getTags().split("_");
 	for (String tag : tags) {
 %> <label class="label"><i class="icon-tag"></i> <%=tag%></label>
								<%
									}
								%> <em><a class="text-info" title="查看他发布的所有博文"
									href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/mainpage/<%=topDiary.getAuthor_id()%>"><%=topDiary.getAuthor_name()%></a>
									发布于 <%=DateUtil.formatDate(topDiary.getPublish_time(), 3)%></em> </small>
						</blockquote>
					</div>
					<div>
						<p><%=StringUtil.cutString(topDiary.getContent(), 200)%></p>
					</div>

					<a class="button" href="javascript:void(0)">阅读全文 <i
						class=" icon-chevron-down"></i> </a> <a href="#"
						onmouseover="$('.changeTopDiary i').addClass('icon-spin');"
						onmouseout="$('.changeTopDiary i').removeClass('icon-spin');"
						title="换一篇" class="changeTopDiary"><i
						class="icon-refresh icon-2x"></i> </a> </section> <!-- /推荐日志 --> <!-- 热门日志 --> <section
						id="hotDiarySec">
					<h3 class="major">
						<span><i class="icon-lightbulb"></i> 热门日志</span>
					</h3>
					<div>
						<div class="span3">
							<ul class="unstyled">
								<%
									for (DiaryBO diary : hotDiaries.get("left")) {
								%>
								<li><a href="#"><i
										<%if (diary.getTags().contains("公告")) {%>
										class="icon-bookmark-empty" <%} else {%>
										class="icon-lightbulb" <%}%>></i> <%=StringUtil.cutString(diary.getTitle(), 15)%></a>
										<em>[<%=diary.getReply_num() %>/<%=diary.getRead_num() %>]</em>
								</li>
								<%
									}
								%>
							</ul>
						</div>
						<div class="span3">
							<ul class="unstyled">
								<%
									for (DiaryBO diary : hotDiaries.get("right")) {
								%>

								<li><a href="#"><i
										<%if (diary.getTags().contains("公告")) {%>
										class="icon-bookmark-empty" <%} else {%>
										class="icon-lightbulb" <%}%>></i> <%=StringUtil.cutString(diary.getTitle(), 15)%></a>
										<em>[<%=diary.getReply_num() %>/<%=diary.getRead_num() %>]</em>
								</li>
								<%
									}
								%>
							</ul>
						</div>
					</div>
					<a class="button" href="javascript:void(0)">查看全部 <i
						class=" icon-hand-right"></i>
					</a> </section> <!-- /热门日志 --> <!-- 关于 --> <section id="aboutSec">
					<h3 class="major">
						<span><i class="icon-info-sign"></i> 关于</span>
					</h3>
					<div class="row">
						<div class="span2">
							<img style="width: 80px; height: 80px"
								src="<%=ConstantsUtil.FW_DOMAIN%>/img/wn_head01.jpg"
								class="img-rounded margin-bottom-middle" />
							<h5>我是王宁，本站的作者，毕业一年,程序员。</h5>
							<ul>
								<li>喜欢创造的快乐。</li>
								<li>喜欢<span class="label label-info">宅</span>。</li>
								<li>游泳篮球LOL,And<span class="label label-info">进击の巨人</span>
								</li>
								<li>喜欢各种萌物，单身...</li>
							</ul>
						</div>

						<div class="span4">
							<img style="width: 200px; height: 80px"
								src="<%=ConstantsUtil.FW_DOMAIN%>/img/logo.png"
								class="img-rounded margin-bottom-middle" />
							<p>
								<h5>现在大家看到的wnJava的设计样式，算是第三版了，相比前面的版本，第三版主要进行了以下几处的改进：</h5>
								<ul class="">
									<li>重新设计了全站的样式</li>
									<li>采用Pjax来实现模块间的跳转。</li>
									<li>完善了用户主页。</li>
									<li>删除了图册功能。</li>
									<li>进一步完善了代码的质量。</li>
								</ul>
							</p>
						</div>
					</div>
					<div class="row">
						<div class="span6 alert alert-info margin-top-small">
							GitHub源码地址 ： https://github.com/semis2008/wnJava/</div>
					</div>
					</section> <!-- /关于WnJava --> <!-- 发布留言 --> <section id="leaveMsgSec">
					<h3 class="major">
						<span><i class="icon-envelope"></i> 给我留言</span>
					</h3>
					<div class="row">
						<div class="span3">
							<input type="text" placeholder="Name" id="contact-name"
								class="text">
						</div>
						<div class="span3">
							<input type="text" placeholder="Email" id="contact-email"
								class="text">
						</div>
					</div>
					<div class="row">
						<div class="span6">
							<textarea rows="5" placeholder="Message" id="contact-message"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="span6">
							<ul class="unstyled inline">
								<li><a class="button" href="javascript:void(0)">留言</a>
								</li>
								<li><a class="button button-alt" href="javascript:void(0)">清空</a>
								</li>
							</ul>
						</div>
					</div>
					</section> <!-- /发布留言 --> </article>
					<!-- /Content -->
				</div>
			</div>
		</div>
	</div>
	<!-- 底部 -->
	<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>