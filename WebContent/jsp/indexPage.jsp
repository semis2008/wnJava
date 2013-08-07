<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.vo.DynamicVO"%>
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
	UserBO visitedUser = (UserBO) request.getAttribute("visitedUser");

	List<UserBO> users = (List<UserBO>) request.getAttribute("users");
	if (users == null) {
		users = new ArrayList<UserBO>();
	}
	Integer diaryCount = (Integer) request.getAttribute("diaryCount");
	if (diaryCount == null) {
		diaryCount = 0;
	}

	List<DiaryBO> diaries = (ArrayList<DiaryBO>) request
			.getAttribute("diaries");
	if (diaries == null) {
		diaries = new ArrayList<DiaryBO>();
	}
	List<DiaryBO> notices = (ArrayList<DiaryBO>) request
			.getAttribute("notices");
	if (notices == null) {
		notices = new ArrayList<DiaryBO>();
	}
	DynamicVO dynamicVO = (DynamicVO) request.getAttribute("dynamics");
	if (dynamicVO == null) {
		dynamicVO = new DynamicVO();
	}
	String userDiaryNum = "0";
	boolean hasLogin = false;
	if (user == null) {
		user = new UserBO();
	} else {
		hasLogin = true;
		userDiaryNum = (String) request.getAttribute("userDiaryNum");
	}
	if (visitedUser == null) {
		visitedUser = new UserBO();
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

<script type="text/javascript">
	$(function() {
		//轮播
		$('#picCarousel').carousel({
			interval : 6000
		});
	});
</script>
<title>懒熊de部落格</title>
</head>
<body>
	<header class="no-radius" id="banner-head">
	<div class="container text-center">
		<h1>
			<img alt="WN Java" src="<%=ConstantsUtil.FW_DOMAIN%>/img/logo.png">
		</h1>
	</div>
	</header>
	<article class="container"> <section class="row description"
		id="description"> <!-- 网站描述 -->
	<div
		class="span10 offset1 panel-description button-text-panel text-center">
		<div class="padding-middle">
			<img style="width: 110px; height: 110px"
				src="<%=ConstantsUtil.FW_DOMAIN%>/img/wn_head01.jpg"
				class="profile img-circle loading" />
			<h4>我是王宁，本站的作者，89年生于河北。毕业一年，程序员。</h4>
			<h5>喜欢创造的快乐，喜欢宅。有算不上远大的理想，有算不上智慧的想法。生活是一架天梯，一步一步走，总有到达终点的那一刻。我是低头赶路的行者，脚下生根。</h5>
			<hr class="soften" />
			<p>
				<span class="hidden-phone">这是我开发的网站，</span>欢迎访问<a target="_blank"
					href="http://blog.sina.com.cn/u/1876469127">我的博客</a>和我的另一个作品：<a
					target="_blank" href="http://www.wnjava.com/action/chat/test">ChatBear平台</a>
			</p>
		</div>
	</div>

	</section> <section class="row" id="dynamic"> <!-- 网站动态-->
	<div class="span12 panel">
		<div class="row">
			<div class="span3 block-left">
				<h1>网站动态</h1>
				<p>注册之后你也会出现在这里，可以发布自己的日志，以及与大家进行交流~</p>
				<a data-toggle="modal" data-target="#registModal"
					data-keyboard="true" data-backdrop="true"
					class="btn btn-info btn-large button" href="#">马上注册~</a>
			</div>
			<div class="span8">
				<div class="padding-large">
					<ul class="unstyled">
						<%
							for (DiaryBO bo : dynamicVO.getDynamicPart1()) {
						%>
						<li>
							<blockquote>
								<p>
									我发布了一篇名叫<a
										href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diarydetail/<%=bo.getId()%>">《<%=bo.getTitle()%>》</a>的日志，赶紧来<a
										href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diarydetail/<%=bo.getId()%>">看看</a>吧
								</p>
								<small><%=DateUtil.formatDate(bo.getPublish_time(), 3)%>
									<cite title="<%=bo.getAuthor_name()%>"><a href="<%=ConstantsUtil.FW_DOMAIN %>/action/system/mainpage/<%=bo.getAuthor_id() %>"><%=bo.getAuthor_name()%></a>
								</cite> </small>
							</blockquote>
						</li>
						<%
							}
							for (UserBO bo : dynamicVO.getDynamicPart2()) {
						%>
						<li>
							<blockquote>
								<p>
									在<%=DateUtil.formatDate(bo.getReg_time(), 2)%>这个值得纪念的时刻，<a
										href="<%=ConstantsUtil.FW_DOMAIN %>/action/system/mainpage/<%=bo.getId() %>"><%=bo.getName()%></a>加入了~WN Java~这个大家庭，撒花欢迎~~
								</p>
							</blockquote>
						</li>
						<%
							}
						%>
					</ul>
				</div>
			</div>
		</div>
	</div>
	</section>  <section class="row" id="about">
	<div class="span12 panel">
		<div class="row">
			<div class="span11 padding-large">
				<h1 class="text-center">关于</h1>
				<hr class="soften" />
				<div class="aboutMe span7">
					<h3>>关于我</h3>
					<p>
						我是本站的作者。<br />
						熟悉J2EE那套技术，之前粗略学习了SSH框架，一直觉得这些框架虽然在泛用性上很强大，但是对于特定的项目也就存在资源的浪费。<br />
						喜欢全局上构架网站，喜欢那种创造之后的喜悦，喜欢新技术。不擅长页面设计。WNJava现在的效果是参照了许多别人的设计得来的。
						目前在北京生活，节奏比较快，在通往架构师的道路上不断学习着...
					</p>
				</div>
				<div class="aboutProcess span3">
					<h3>>WNJAVA历程</h3>
					<ol>
						<li>构建开发环境<em>(12/07~14)</em></li>
						<li>完成主体框架<em>(12/10~19)</em></li>
						<li>前台页面设计<em>(12/18~1/13)</em></li>
						<li>逻辑功能实现<em>(1/14~2/25)</em></li>
						<li>beta版上线<em>(2/26)</em></li>
						<li>日志模块完成<em>(4/3)</em></li>
						<li>开始开发ChatBear模块<em>(5/27)</em></li>
					</ol>
				</div>
				<div class="aboutFW span10">
					<h3>>关于WNJAVA</h3>
					<p>
						WNJava这个项目是我为了独自搭建一个完整的网站而开始开发设计的。JSP-Servlet-Spring的基础架构，让我在搭建的过程中学习到了一些基础的J2EE架构知识。<br />
						小站从最基础的地方起步，开发过程中会不断尝试使用个人认为流行而实用的互联网技术。<br />
						小站刚刚起步，还有许多功能需要完善，还有许多样式需要调整，慢慢写吧~
					</p>
				</div>

			</div>
		</div>
	</div>
	</section> </article>

	<!-- 底部 -->
	<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>