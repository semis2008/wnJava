<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.wnJava.util.*"%>
<%@page import="com.wnJava.bo.DiaryBO"%>
<%
//推荐日志
DiaryBO topDiary = (DiaryBO) request.getAttribute("topDiary");
if (topDiary == null) {
	topDiary = new DiaryBO();
}
%>
<h3 class="major">
	<span><i class="icon-star-empty"></i> 推荐日志</span>
</h3>
<div>
	<img width="60px" height="60px" alt="" class="img-polaroid left"
		src="<%=ConstantsUtil.FW_DOMAIN %><%=topDiary.getAuthor_photo() %>" />
	<blockquote>
		<h3 class="muted">
			<%=StringUtil.cutString(topDiary.getTitle(), 100)%>
			<em title="回复/阅读数">[<%=topDiary.getReply_num()%>/<%=topDiary.getRead_num()%>]</em>
		</h3>
		<small> <%
 	String[] tags = topDiary.getTags().split("_");
 	for (String tag : tags) {
 %> <label class="label"><i class="icon-tag"></i> <%=tag%></label> <%
									}
								%> <em><a class="text-info" title="查看他发布的所有博文"
				href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/mainpage/<%=topDiary.getAuthor_id()%>"><%=topDiary.getAuthor_name()%></a>
				发布于 <%=DateUtil.formatDate(topDiary.getPublish_time(), 3)%></em> </small>
	</blockquote>
</div>
<div>
	<p><%=StringUtil.cutString(topDiary.getContent(), 150)%></p>
</div>

<a class="button" href="javascript:void(0)">阅读全文 <i
	class=" icon-chevron-down"></i> </a>
<a href="javascript:void(0)"
	onclick="changeTopDiary(<%=topDiary.getId() %>)"
	onmouseover="$('.changeTopDiary i').addClass('icon-spin');"
	onmouseout="$('.changeTopDiary i').removeClass('icon-spin');"
	title="换一篇" class="changeTopDiary"><i class="icon-refresh icon-2x"></i>
</a>