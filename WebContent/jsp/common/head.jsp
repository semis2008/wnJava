<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.wnJava.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<link type="text/css"
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/musicplayer/css/stylesheets/style.css"
	rel="stylesheet" media="screen" />

</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a data-target=".nav-collapse" data-toggle="collapse"
					class="btn btn-navbar"> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> </a>
				<div class="brand">&nbsp;&nbsp;&nbsp;&nbsp;WNJava&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<div class="nav-collapse collapse navbar-responsive-collapse">
					<ul class="nav">
						<%
							String fun = request.getParameter("fun");
						%>
						<li <%if (fun.equals("") || fun.equals("index")) {%>
							class="active" <%}%>><a data-type="pjax" href="/action/system/indexPage"><i
								class="icon-home icon-white"></i> 首页</a>
						</li>
						<li <%if (fun.equals("diarydetail") || fun.equals("diary")) {%>
							class="active" <%}%>><a data-type="pjax"
							href="/action/system/diary"><i class="icon-edit icon-white"></i>
								日志</a>
						</li>
						<li><a data-type="pjax" href="/action/system/indexPage#leaveMsgSec"><i
								class="icon-envelope icon-white"></i> 留言</a>
						</li>
						<li><a data-type="pjax" href="/action/system/indexPage#aboutSec"><i
								class="icon-info-sign icon-white"></i> 关于</a>
						</li>
					</ul>
					<ul class="nav pull-right">
						<li><a href="#" data-toggle="modal"
							data-target="#registModal" data-keyboard="true"
							data-backdrop="true"><i class="icon-plus-sign icon-white"></i>
								注册</a></li>

						<%
							String hasLogin = request.getParameter("hasLogin");
							String userName = request.getParameter("userName");

							String userId = request.getParameter("userId");
							if ("false".equals(hasLogin)) {
						%>
						<li><a href="#" data-toggle="modal" data-target="#loginModal"
							data-keyboard="true" data-backdrop="true"><i
								class="icon-ok icon-white"></i> 登陆</a></li>
						<%
							} else {
								String userDiaryNum = request.getParameter("userDiaryNum");
						%>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><%=userName%> <b class="caret"></b> </a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/mainpage/<%=userId%>"><i
										class="icon-home icon-black"></i> 个人主页</a></li>
								<li><a href="#"><i class="icon-edit icon-black"></i>
										日志：<%=userDiaryNum%>篇</a></li>
								<li class="divider"></li>
								<li><a href="#"
									onclick="pjaxShowPage('/action/system/shownewdiary','main-frame')"><i
										class="icon-pencil icon-black"></i> 写日志</a>
								</li>
								<li class="divider"></li>
								<li><a href="#" onclick="userQuit();"><i
										class="icon-off icon-black"></i> 注销</a>
								</li>
							</ul>
						</li>
						<%
							}
						%>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- 弹出对话框 -->
	<!-- 登录 -->
	<div class="modal hide fade" id="loginModal">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
			<h3>
				<span class="label label-info"><i
					class="icon-user icon-white"></i>欢迎您登录WNJava,开始轻松之旅~</span>
			</h3>
		</div>
		<div class="modal-body">
			<div class="well form-inline">
				<input type="email" id="txtEmailLogin" name="txtEmailLogin"
					class="input-medium" placeholder="帐号" /> <input type="password"
					id="txtPasswordLogin" name="txtPasswordLogin" class="input-medium"
					placeholder="密码" /> <label class="checkbox"> <input
					type="checkbox" id="rememberMe" name="rememberMe" /> 记住我 </label>
				<button onclick="userLogin()" class="btn btn-primary">登录</button>
			</div>
		</div>
	</div>
	<!-- 注册 -->
	<div class="form-horizontal">
		<div class="modal hide fade" id="registModal">
			<div class="modal-header">
				<a class="close" data-dismiss="modal">×</a>
				<h3>
					<span class="label label-info offset1"><i
						class="icon-plus icon-white"></i>欢迎您注册WNJava，马上开始吧~</span>
				</h3>
			</div>
			<div class="modal-body span7">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="input01">您的尊姓大名</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-user"></i> </span><input
									type="text" size="16" id="txtNameRegist" name="txtNameRegist"
									required />
							</div>
							<p class="help-block">字母，数字，汉字皆可</p>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="input02">您的Email</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-envelope"></i> </span><input
									type="email" size="16" id="txtEmailAddressRegist"
									name="txtEmailAddressRegist" required />
							</div>
							<p class="help-block">邮箱将直接作为您登录的帐号哦</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="input03">您要使用的密码</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-asterisk"></i> </span><input
									type="text" size="16" id="txtPasswordRegist"
									name="txtPasswordRegist" required />
							</div>
							<p class="help-block">字母，数字皆可</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="input04">请再输入一次密码</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-asterisk"></i> </span><input
									type="password" size="16" id="txtPasswordCon"
									name="txtPasswordCon" required />
							</div>
							<p class="help-block">两次密码输入必须一致</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="input05">请输入验证码</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-asterisk"></i> </span><input
									class="span2" type="password" size="8" id="txtRandImg"
									name="txtRandImg" required />
							</div>
							<img src="/RandImg"
								onclick="this.src='/RandImg?d='+Math.random();" />
						</div>
					</div>

					<div class="control-group">
						<button class="btn btn-primary offset1" onclick="userRegist();">确认注册</button>
						<button data-dismiss="modal" aria-hidden="true" class="btn">取消</button>
					</div>
				</fieldset>
			</div>
		</div>
	</div>
	<div class="span4 fixed musicbox panel">
		<div id="player">
			<div class="cover"></div>
			<div class="ctrl">
				<div class="tool">
					<icon class="icon-list-ul margin-right-small pointer"
						onclick="togglePlayList()"></icon>
					<icon class="icon-resize-small pointer" onclick="togglePlayer()"></icon>
				</div>
				<div class="tag">
					<strong>Title</strong> <span class="artist">Artist</span> <span
						class="album">Album</span>
				</div>
				<div class="control">
					<div class="left">
						<div class="rewind icon"></div>
						<div class="playback icon"></div>
						<div class="fastforward icon"></div>
					</div>
					<div class="volume right">
						<div class="mute icon left"></div>
						<div class="slider left">
							<div class="pace"></div>
						</div>
					</div>
				</div>
				<div class="music-progress">
					<div class="slider">
						<div class="loaded"></div>
						<div class="pace"></div>
					</div>
					<div class="timer left">0:00</div>
					<div class="right">
						<div class="repeat icon"></div>
						<div class="shuffle icon"></div>
					</div>
				</div>
			</div>
		</div>
		<ul id="playlist"></ul>
	</div>
	<div
		class="fixed musicbox-mini pointer panel hide padding-mini text-center"
		onclick="togglePlayer()">
		<i class="icon-headphones"></i>
		<marquee scrollamount="3" onmouseover="this.stop();"
			onmouseout="this.start();"></marquee>
		<i class="icon-fullscreen"></i>
	</div>
	
	<div class="fixed goToTopDiv hide pointer padding-small">
		<i onclick="goToTop()" class="icon-chevron-up icon-white icon-2x"></i>
	</div>

	<div id="main-frame"></div>

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
		src="<%=ConstantsUtil.FW_DOMAIN%>/js/common.js"></script>
	<script type="text/javascript"
		src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/musicplayer/js/jquery-ui.min.js"></script>
	<script type="text/javascript"
		src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/musicplayer/js/script.js"></script>
	<script type="text/javascript">
		$(function() {
			$(".scrollLoading").scrollLoading();
			$.pjax({
				selector : "a[data-type='pjax']",
				container : '#right-content', // 内容替换的容器
				show : 'fade', // 展现的动画，支持默认和fade, 可以自定义动画方式，这里为自定义的function即可。
				cache : false, // 是否使用缓存
				storage : true, // 是否使用本地存储
				titleSuffix : '', // 标题后缀
				filter : function() {
				},
				callback : function() {
					
				}
			});

		});
	</script>
</body>
</html>