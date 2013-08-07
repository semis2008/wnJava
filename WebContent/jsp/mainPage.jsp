<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.util.UserUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wnJava.bo.DiaryReplyBO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.wnJava.util.*"%>
<%@page import="com.wnJava.bo.DiaryBO"%>
<%@page import="com.wnJava.util.ConstantsUtil"%>
<%@page import="com.wnJava.bo.*"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String fun = (String) request.getAttribute("fun");
	if (fun == null)
		fun = "";
	UserBO user = (UserBO) request.getAttribute("loginUser");
	UserBO visitedUser = (UserBO) request.getAttribute("visitedUser");
	List<LeaveMsgBO> leaveMsgList = (List<LeaveMsgBO>) request
			.getAttribute("leaveMsgList");
	List<DiaryBO> newDiaryList = (List<DiaryBO>) request
			.getAttribute("newDiaryList");
		UserInfoBO info = (UserInfoBO) request
			.getAttribute("visitedUserInfo");
	String hobbyStr = "";
	if (info == null) {
		info = new UserInfoBO();
	} else {
		hobbyStr = info.getHobby().replace(" ", "_");
	}
	if (visitedUser == null) {
		visitedUser = new UserBO();
	}
	if (leaveMsgList == null) {
		leaveMsgList = new ArrayList<LeaveMsgBO>();
	}
	boolean hasLogin = false;
	String userDiaryNum = "0";
	if (user == null) {
		user = new UserBO();
	} else {
		hasLogin = true;
		userDiaryNum = (String) request
		.getAttribute("userDiaryNum");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- 网站公用顶部 -->
<jsp:include page="/jsp/common/head.jsp" flush="true" >
	<jsp:param value="<%=hasLogin %>" name="hasLogin"/>
	<jsp:param value="<%=user.getName() %>" name="userName"/>
	<jsp:param value="<%=user.getId() %>" name="userId"/>
	<jsp:param value="<%=userDiaryNum %>" name="userDiaryNum" />
</jsp:include>

<link href="/css/mainpage.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript">
	$(function() {
		 //设置userinfo显示与否
		initInfoShow();

	});

	function initInfoShow() {
		var publicstr = $("#userinfo_iframe_publicstr").val();
		if (publicstr.indexOf("hobby") != -1) {
			$("#hobby_main").show();
		}
		if (publicstr.indexOf("contact") != -1) {
			$("#contact_main").show();
		}
		if (publicstr.indexOf("birthday") != -1) {
			$("#birthday_main").show();
		}
		if (publicstr.indexOf("relname") != -1) {
			$("#relname_main").show();
		}
		if (publicstr.indexOf("homeprovince") != -1) {
			$("#homeprovince_main").show();
		}
	}
	function userQuit() {
		$.ajax({
			type : "POST",
			url : "/action/user/userquit",
			dataType : "text",
			success : function(msg) {
				location.reload();
			}

		});
	}
</script>
<title>wnJava--个人主页</title>
</head>
<body>
	<div class="container padding-large">
	  <h1>Coming Soon~!</h1>
	</div>
		<!-- 底部 -->
<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>