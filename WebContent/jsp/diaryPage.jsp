<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.util.UserUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.wnJava.util.StringUtil"%>
<%@page import="com.wnJava.util.DateUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wnJava.bo.DiaryBO"%>
<%@page import="java.util.List"%>
<%@page import="com.wnJava.util.ConstantsUtil"%>
<%@page import="com.wnJava.bo.UserBO"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String fun = (String) request.getAttribute("fun");
	if (fun == null)
		fun = "";
	UserBO user = (UserBO) request.getAttribute("loginUser");
	List<DiaryBO> diaryList = (List<DiaryBO>) request
			.getAttribute("diaries");
	if (diaryList == null) {
		diaryList = new ArrayList<DiaryBO>();
	}
	String userDiaryNum = "0";
	boolean hasLogin = false;
	if (user == null) {
		user = new UserBO();
	} else {
		hasLogin = true;
		userDiaryNum = (String) request
		.getAttribute("userDiaryNum");
	}
	Integer currentPage = (Integer) request.getAttribute("currentPage");
	if (currentPage == null) {
		currentPage = 1;
	}
	Integer totalPage = (Integer) request.getAttribute("totalPage");
	if (totalPage == null) {
		totalPage = 1;
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

<link href="/css/diary.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript">
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
	function deleteDiary(diaryid) {
		$.ajax({
			type : "POST",
			url : "/action/diary/delete",
			data : {
				diaryid : diaryid
			},
			dataType : "text",
			success : function(msg) {
				if (msg == 'fail') {
					alert("删除失败！");
				} else {
					alert("删除成功！");
					location.reload();
				}
			}
		});
	}
</script>
<title>日志</title>
</head>
<body>
<div class="bookmark">
	<ul class="breadcrumb">
	 	<li><a href="<%=ConstantsUtil.FW_DOMAIN%>">首页</a> <span class="divider">/</span></li>
	 	<li class="active">日志</li>
	</ul>

</div>
<article class="container"> <%
 	if (diaryList.size() == 0) {
 		out.print("<h3> 没有日志可供查看~~</h3>");
 	} else {
 		for (DiaryBO diary : diaryList) {
 %>
 
<section class="row article" id="article<%=diary.getId()%>"><!--日志 --> 
	<div class="span10 offset1 panel">
		<div class="padding-middle">
		<div class="art-head well">
			<div class="art-cats">
				<ul>
					<li class="blogTime"><a title="<%=diary.getTitle()%>" href="#"><em><%=DateUtil.dateToCalendar(diary.getPublish_time())
							.get(Calendar.MONTH) + 1%>/</em><%=DateUtil.dateToCalendar(diary.getPublish_time())
							.get(Calendar.DAY_OF_MONTH)%></a> </li>
							
					<%
													String[] tags = diary.getTags().split("_");
															for (String tag : tags) {
												%>
					<li class="diary-tag"><a title="<%=tag%>" href="#"><%=tag%></a> </li>
					<%
						}
					%>
				</ul>
			</div>
				<h3>
					<a title="<%=diary.getTitle()%>"
						href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diarydetail/<%=diary.getId()%>"><%=diary.getTitle()%>
					</a>
				</h3>
				<small>Posted on <a title="发布日期" href="#"><%=DateUtil.formatDate(diary.getPublish_time(), 3)%></a><span>by<a
					title="查看他发布的所有博文" href="<%=ConstantsUtil.FW_DOMAIN %>/action/system/mainpage/<%=diary.getAuthor_id() %>"><%=diary.getAuthor_name()%></a> </span>
				</small>
		</div>
			<div class="art-content padding-small">
				<p><%=StringUtil.cutString(diary.getContent(), 200)%></p>
			</div>
			<div class="art-foot">
				 <ul class="unstyled inline">
					<li>
						<a class="btn btn-info btn-small button" href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diarydetail/<%=diary.getId()%>">
						查看全文<icon class="icon-arrow-down icon-white"></icon></a>
					</li>
					<%
						if (user.getId() == diary.getAuthor_id()) {
					%>
					<li>
						<a class="btn btn-info btn-small button"
							href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/showeditdiary/<%=diary.getId()%>">编辑 <icon class="icon-edit icon-white"></icon>
							
						</a>
					</li>
					<li>
						 <a class="btn btn-danger btn-small button" href="#"
							onclick="javascript:deleteDiary('<%=diary.getId()%>')">删除 <icon class="icon-remove icon-white"></icon>
						</a>
					</li>
					<%
						}
					%>
				 </ul>
			</div>
		</div>
	</div>
</section> <%
 	}
}
 %> 
 </article>
<div class="pagination pagination-centered">
	<ul>
	<%
		if(currentPage!=1) {
	%>
		<li><a href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diary/<%=currentPage - 1%>">上一页</a></li>
	<%
		}
		int i = 1;
		if(totalPage>7) {
			i=currentPage;
		}
		for(;i<totalPage+1;i++) {
			int count = 1;
			if(count>7) {
			%>
		    <li class="disabled"><a href="#">...</a></li>
			<%
			count++;
			}else {
				%>
			    <li  <% if(i==currentPage) { %> class="active" <%}%>><a href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diary/<%=i %>"><%=i %></a></li>
				<%		
			}
		}
		if(currentPage!=totalPage) {
	%>
	    <li><a href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diary/<%=currentPage + 1%>">下一页</a></li>
	<%
		}
	%>
	</ul>
</div>
<!-- 底部 -->
<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>