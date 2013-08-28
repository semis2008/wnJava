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
	UserBO user = (UserBO) request.getAttribute("loginUser");
	if (user == null) {
		user = new UserBO();
	}
	List<DiaryBO> diaryList = (List<DiaryBO>) request
			.getAttribute("diaries");
	if (diaryList == null) {
		diaryList = new ArrayList<DiaryBO>();
	}
	String userDiaryNum = "0";

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
					$("#diaryList_"+diaryid).hide();
				}
			}
		});
	}
</script>
<title>日志</title>

<article> <%
 	int num = 0;
 	for (DiaryBO diary : diaryList) {
 		num++;
 %> <section id="diaryList_<%=diary.getId()%>" class="diarySec">
<%
	if (num == 1) {
%>
<h3 class="major">
	<span><i class="icon-list-ul"></i> 最新日志</span>
</h3>
<%
	}
%>
<div>
	<img width="60px" height="60px" alt="" class="img-polaroid left"
		src="<%=ConstantsUtil.FW_DOMAIN%><%=diary.getAuthor_photo()%>" />
	<blockquote>
		<h3 class="muted">
			<%=StringUtil.cutString(diary.getTitle(), 100)%>
			<%
				if (user.getId() == diary.getAuthor_id() ||(user.getId()!=null&&user.getId() == 1l)) {
			%>
			<span>
				<ul class="inline">
					<li><a titile="编辑" data-type="pjax"
						href="/action/system/showeditdiary/<%=diary.getId() %>"><i class="icon-edit"></i>
					</a>
					</li>
					<li><a title="删除" href="javascript:void(0);"
						onclick="deleteDiary(<%=diary.getId()%>)"><i
							class="icon-trash"></i>
					</a>
					</li>
					<li>|</li>
				</ul> </span>
			<%
				}
			%>
			<em title="回复/阅读数">[<%=diary.getReply_num()%>/<%=diary.getRead_num()%>]</em>
		</h3>
		<small> <%
 	String[] tags = diary.getTags().split("_");
 		for (String tag : tags) {
 %> <label class="label"><i class="icon-tag"></i> <%=tag%></label> <%
 	}
 %> <em><a class="text-info" title="查看他发布的所有博文"
				href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/mainpage/<%=diary.getAuthor_id()%>"><%=diary.getAuthor_name()%></a>
				发布于 <%=DateUtil.formatDate(diary.getPublish_time(), 3)%></em> </small>
	</blockquote>
</div>
<div>
	<p><%=StringUtil.cutString(diary.getContent(), 150)%></p>
</div>
<div>
	<a class="button" data-type="pjax"
		href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diarydetail/<%=diary.getId()%>">阅读全文
		<i class="icon-chevron-down"></i> </a>
</div>
</section> <%
 	}
 %> </article>
<div class="pagination pagination-centered" id="diaryPageDiv">
	<ul>
		<%
			if (currentPage != 1) {
		%>
		<li><a data-type="pjax"
			href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diary/<%=currentPage - 1%>#diaryPageDiv">上一页</a>
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
		<li class="disabled"><a href="#">...</a></li>
		<%
			count++;
				} else {
		%>
		<li <%if (i == currentPage) {%> class="active" <%}%>><a
			data-type="pjax"
			href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diary/<%=i%>#diaryPageDiv"><%=i%></a>
		</li>
		<%
			}
			}
			if (currentPage != totalPage) {
		%>
		<li><a data-type="pjax"
			href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diary/<%=currentPage + 1%>#diaryPageDiv">下一页</a>
		</li>
		<%
			}
		%>
	</ul>
</div>
