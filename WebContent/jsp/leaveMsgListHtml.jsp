<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.bo.LeaveMsgBO"%>
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
	 
	List<LeaveMsgBO> leaveMsgList = (List<LeaveMsgBO>) request
			.getAttribute("leaveMsgs");
	if (leaveMsgList == null) {
		leaveMsgList = new ArrayList<LeaveMsgBO>();
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

<script language="javascript" type="text/javascript">
	function deleteMsg(msgid) {
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

<article> <section id="leaveMsgPageSec">
<h3 class="major">
	<span><i class="icon-list-ul"></i> 留言</span>
</h3>
 <ul class="unstyled">
	<%
		for (LeaveMsgBO leaveMsg : leaveMsgList) {
	%>
	<li><a href="#" title="<%=leaveMsg.getName()%>"><img
			src="<%=ConstantsUtil.FW_DOMAIN%><%=leaveMsg.getUser_photo()%>"
			class="img-polaroid" width="40px" height="40px" alt="" /> </a>
		<p title="<%=leaveMsg.getMsg()%>">
			"<%=StringUtil.cutString(leaveMsg.getMsg(), 100)%>"
		</p> <span>-- <a href="#" title="<%=leaveMsg.getName()%>"><%=leaveMsg.getName()%></a>,
			<em><%=DateUtil.formatDate(leaveMsg.getLeave_time(), 3)%></em> </span>
	</li>
	<%
		}
	%>
</ul> </section></article>
<div class="pagination pagination-centered" id="diaryPageDiv">
	<ul>
		<%
			if (currentPage != 1) {
		%>
		<li><a data-type="pjax"
			href="<%=ConstantsUtil.FW_DOMAIN%>/action/user/leaveMsgList/<%=currentPage - 1%>">上一页</a>
		</li>
		<%
			}
			int i = 1;
			if (totalPage > 7) {
				i = currentPage;
			}
			for (; i < totalPage + 1; i++) {
				int count = 1;
				if (count > 7) {
		%>
		<li class="disabled"><a href="#">...</a>
		</li>
		<%
			count++;
				} else {
		%>
		<li <%if (i == currentPage) {%> class="active" <%}%>><a data-type="pjax"
			href="<%=ConstantsUtil.FW_DOMAIN%>/action/user/leaveMsgList/<%=i%>"><%=i%></a>
		</li>
		<%
			}
			}
			if (currentPage != totalPage) {
		%>
		<li><a data-type="pjax"
			href="<%=ConstantsUtil.FW_DOMAIN%>/action/user/leaveMsgList/<%=currentPage + 1%>">下一页</a>
		</li>
		<%
			}
		%>
	</ul>
</div>
