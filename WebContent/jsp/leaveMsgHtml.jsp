<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.util.DateUtil"%>
<%@page import="com.wnJava.util.StringUtil"%>
<%@page import="com.wnJava.bo.LeaveMsgBO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.wnJava.util.ConstantsUtil"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	//获取留言
	List<LeaveMsgBO> leaveMsgs = (List<LeaveMsgBO>) request
			.getAttribute("leaveMsgs");
	if (leaveMsgs == null) {
		leaveMsgs = new ArrayList<LeaveMsgBO>();
	}
%>
<h3 class="major">
	<span><i class="icon-envelope-alt"></i> 留言</span>
</h3>
<ul class="unstyled quote-list">
	<%
		for (LeaveMsgBO leaveMsg : leaveMsgs) {
	%>
	<li><a href="#" title="<%=leaveMsg.getName()%>"><img
			src="<%=ConstantsUtil.FW_DOMAIN%><%=leaveMsg.getUser_photo()%>"
			class="img-polaroid" width="40px" height="40px" alt="" /> </a>
		<p title="<%=leaveMsg.getMsg()%>">
			"<%=StringUtil.cutString(leaveMsg.getMsg(), 20)%>"
		</p> <span>-- <a href="#" title="<%=leaveMsg.getName()%>"><%=leaveMsg.getName()%></a>,
			<em><%=DateUtil.formatDate(leaveMsg.getLeave_time(), 3)%></em> </span>
	</li>
	<%
		}
	%>
</ul>
<a class="button button-alt" data-type="pjax" href="<%=ConstantsUtil.FW_DOMAIN%>/action/user/leaveMsgList">查看全部 <i
	class=" icon-hand-right"></i> </a>
