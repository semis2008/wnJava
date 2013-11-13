<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.vo.LoverHolidayVO"%>
<%@page import="com.wnJava.vo.LoveRoadVO"%>
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
	LoveRoadVO loveRoad = (LoveRoadVO) request.getAttribute("LoveRoad");
	if (loveRoad == null) {
		loveRoad = new LoveRoadVO();
	}
	List<LoverHolidayVO> holidayList = (List<LoverHolidayVO>)request.getAttribute("holidayList");
	if(holidayList==null) {
		holidayList = new ArrayList<LoverHolidayVO>();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link href="<%=ConstantsUtil.FW_DOMAIN%>/css/common.css"
	rel="stylesheet" type="text/css" />
<link
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/bootstrap/css/bootstrap.css"
	rel="stylesheet" />
<link
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/bootstrap/css/bootstrap-responsive.css"
	rel="stylesheet" />
<link type="text/css"
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/css/messenger.css"
	rel="stylesheet" media="screen" />
<link type="text/css"
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/css/messenger-theme-future.css"
	rel="stylesheet" media="screen" />
<link type="text/css"
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/font_icon/css/font-awesome.min.css"
	rel="stylesheet" media="screen" />
<link
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/datepicker/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen" />
<link
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/iCheck/skins/square/pink.css"
	rel="stylesheet" />

<link href="/css/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/js/jquery-1.8.2.js"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/js/jquery.scrollLoading.js"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/js/jquery.pjax.js"></script>

<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/js/underscore-1.4.4.js"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/js/backbone-0.9.10.js"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/js/messenger.min.js"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/datepicker/js/bootstrap-datetimepicker.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/datepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/iCheck/jquery.icheck.js" />

<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/js/common.js"></script>

<script type="text/javascript">
	$(function() {
		$(".scrollLoading").scrollLoading();
		$.pjax({
			selector : "a[data-type='pjax']",
			container : '#right-content', // 内容替换的容器
			show : 'fade', // 展现的动画，支持默认和fade, 可以自定义动画方式，这里为自定义的function即可。
			cache : false, // 是否使用缓存
			storage : true, // 是否使用本地存储
			titleSuffix : '_LOVERTIME', // 标题后缀
			filter : function() {
			},
			callback : function() {

			}
		});
	});
	$(window).scroll(function() {
		var t = $(document).scrollTop();
		if (t >= 300) {
			showGoToTop();
		} else {
			hideGoToTop();
		}
	});
	function showGoToTop() {
		$(".goToTopDiv").show();
	}
	function hideGoToTop() {
		$(".goToTopDiv").hide();
	}
	function showErrorMsg(msg) {
		var msgD = $.globalMessenger().post({
			message : msg,
			type : 'error'
		});
	}
	function showSuccessMsg(msg) {
		var msgD = $.globalMessenger().post({
			message : msg,
			type : 'success'
		});
	}
	function goToTop() {
		$('body,html').animate({
			scrollTop : 0
		}, 1000);
	}
</script>
<title>爱情时间线</title>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a data-target=".nav-collapse" data-toggle="collapse"
					class="btn btn-navbar"> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> </a>
				<div class="brand">&nbsp;&nbsp;&nbsp;&nbsp;LoverTime&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<div class="nav-collapse collapse navbar-responsive-collapse">
					<ul class="nav">
						<li><a data-type="pjax" href="/action/lovertime/showTimeLine"><i
								class="icon-random icon-white"></i> 起航</a>
						</li>
						<li><a data-type="pjax" href="/action/lovertime/addMemmory"><i
								class="icon-camera-retro icon-white"></i> 添加记忆</a>
						</li>
						<li><a data-type="pjax" href="/action/lovertime/addPoint"><i
								class="icon-lightbulb icon-white"></i> add大事件</a>
						</li>
					</ul>
					<ul class="nav pull-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><i class="icon-cogs icon-white"></i>
								设置<b class="caret"></b> </a>
							<ul class="dropdown-menu">
								<li><a href="/action/lovertime/setLoverInfo"
									data-type="pjax"><i class=" icon-user icon-black"></i>
										TA是谁？</a></li>
								<li><a href="#"><i
										class="icon-exclamation-sign icon-black"></i> 设置密码</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</div>
	</div>




	<div id="content">
		<header class="no-radius image hero-unit" id="banner-head">
		<div class="container text-center">
			<h1>
				<img alt="Lover Time"
					src="<%=ConstantsUtil.FW_DOMAIN%>/img/loverlogo.png">
			</h1>
		</div>
		<div class="text-center logo-info">
			<h2>
				<a href="#">Lover Time</a> <small><em class="text-info">-
						-记录爱情路上的点点滴滴~</em> </small>
			</h2>
		</div>
		</header>
		<div id="main-wrapper" class="container">
			<div>
				<div class="row alert alert-info span11">
					本系统还处于开发验证阶段，暂不对公共开放编辑功能。新建记忆等操作需要密码验证。在功能完善之后，会开放相关功能。</div>
				<div class="span3">
					<div class="sidebar">
						<!-- Sidebar -->
						<section>
						<h3 class="major">
							<span><i class="icon-bar-chart"></i> 爱情の路</span>
						</h3>
						<ul class="unstyled side-ul">
							<%
								if (loveRoad.getMeetTime() == null) {
							%>
							<li>
								<div class="alert alert-error">尚未进行设置!</div></li>
							<%
								} else {
							%>
							<li>
								<h5>
									<a data-type="pjax" href="#"><i class="icon-eye-open"></i>
										在<%=loveRoad.getMeetDayPast()%>相识 </a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-calendar"></i><a
										href="javascript:void(0);"> 初次见面时间： <%=DateUtil.formatDate(loveRoad.getMeetTime(),3)%></a>
									</li>
								</ul></li>
							<li>
								<%
									if(loveRoad.getLoveTime()==null) {
								%>
								<h5>
									<a data-type="pjax" href="#"><i class="icon-heart"></i> 相爱
										0 天</a>
								</h5>
								<%
									}else {
								%>
								<h5>
									<a data-type="pjax" href="#"><i class="icon-heart"></i> 在
										<%=loveRoad.getLoveDayPast() %>相爱</a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-calendar"></i><a
										href="javascript:void(0);"> 坠入爱河时间： <%=DateUtil.formatDate(loveRoad.getLoveTime(),3) %></a>
									</li>
								</ul>
								<%
								}
								%>
								</li>
							<li>
								<%
									if(loveRoad.getMarriageTime()==null) {
								%>
								<h5>
									<a data-type="pjax" href="#"><i class="icon-home"></i> 结婚
										0 天</a>
								</h5>
								<%
									}else {
								%>
								<h5>
									<a data-type="pjax" href="#"><i class="icon-home"></i> 在
										<%=loveRoad.getMarriageDayPast() %>结婚</a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-calendar"></i><a
										href="javascript:void(0);"> 结婚时间： <%=DateUtil.formatDate(loveRoad.getMarriageTime(),3) %></a>
									</li>
								</ul>
								<%
								}
								%>
								</li>
							<%
								}
							%>
						</ul>
						</section>

						<section>
						<h3 class="major">
							<span><i class="icon-bell"></i> 节日提醒</span>
						</h3>
						<ul class="unstyled side-ul">
						<%
							for(LoverHolidayVO vo:holidayList) {
						%>
							<li><span class="label label-info"><%=vo.getDaysStr() %></span> ： <%=vo.getHolidayName() %></li>
						<%
							}
						%>
							 
						</ul>
					    </section>
					</div>

				</div>
			</div>
			<div class="span8" id="right-content">
				<jsp:include page="/jsp/loverTime/timeLineHtml.jsp" flush="true" />
			</div>
		</div>
	</div>
	<div class="fixed goToTopDiv hide pointer padding-small">
		<i onclick="goToTop()" class="icon-chevron-up icon-white icon-2x"></i>
	</div>
	<!-- 底部 -->
	<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>