<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.wnJava.util.*"%>
<%@page import="com.wnJava.bo.*"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	//推荐日志
	DiaryBO topDiary = (DiaryBO) request.getAttribute("topDiary");
	if (topDiary == null) {
		topDiary = new DiaryBO();
	}
	//获取热门日志
	Map<String, List<DiaryBO>> hotDiaries = (Map<String, List<DiaryBO>>) request
			.getAttribute("hotDiaries");
	if (hotDiaries == null) {
		hotDiaries = new HashMap<String, List<DiaryBO>>();
	}
	//是否登录
	UserBO user = (UserBO) request.getAttribute("loginUser");

	boolean hasLogin = false;
	if (user == null) {
		user = new UserBO();
	} else {
		hasLogin = true;
	}
%>

<title>懒熊de部落格</title>
<!-- Content -->
<article> <!-- 推荐日志 --> <section id="topDiarySec" class="diarySec">
	<jsp:include page="/jsp/topDiaryHtml.jsp" />
 </section> <!-- /推荐日志 --> <!-- 热门日志 --> <section id="hotDiarySec">
<h3 class="major">
	<span><i class="icon-lightbulb"></i> 热门日志</span>
</h3>
<div>
	<div class="span3">
		<ul class="unstyled">
			<%
				for (DiaryBO diary : hotDiaries.get("left")) {
			%>
			<li><a data-type="pjax" href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diarydetail/<%=diary.getId()%>"><i <%if (diary.getTags().contains("公告")) {%>
					class="icon-bookmark-empty" <%} else {%> class="icon-lightbulb"
					<%}%>></i> <%=StringUtil.cutString(diary.getTitle(), 15)%></a> <em>[<%=diary.getReply_num()%>/<%=diary.getRead_num()%>]</em>
			</li>
			<%
				}
			%>
		</ul>
	</div>
	<div class="span4">
		<ul class="unstyled">
			<%
				for (DiaryBO diary : hotDiaries.get("right")) {
			%>

			<li><a data-type="pjax" href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diarydetail/<%=diary.getId()%>"><i <%if (diary.getTags().contains("公告")) {%>
					class="icon-bookmark-empty" <%} else {%> class="icon-lightbulb"
					<%}%>></i> <%=StringUtil.cutString(diary.getTitle(), 15)%></a> <em>[<%=diary.getReply_num()%>/<%=diary.getRead_num()%>]</em>
			</li>
			<%
				}
			%>
		</ul>
	</div>
</div>
<a class="button" data-type="pjax" href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/hotdiary ">查看全部 <i
	class=" icon-hand-right"></i> </a> </section> <!-- /热门日志 --> <!-- 关于 --> <section
	id="aboutSec">
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
			<li>游泳篮球LOL,And<span class="label label-info">进击の巨人</span></li>
			<li>喜欢各种萌物，单身...</li>
		</ul>
	</div>

	<div class="span5">
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
	<div class="span7 alert alert-info row margin-top-small"><i class="icon-github"></i> GitHub源码地址 ：
		https://github.com/semis2008/wnJava/</div>
</div>
</section> <!-- /关于WnJava --> <!-- 发布留言 --> <section id="leaveMsgSec">
<h3 class="major">
	<span><i class="icon-envelope"></i> 给我留言</span>
</h3>
<%
	if(!hasLogin) {
%>
<div class="row">
	<div class="span3">
		<input type="text" placeholder="Name" id="leave-msg-name" class="text">
	</div>
	<div class="span4">
		<input type="email" placeholder="Email" id="leave-msg-email" class="text">
	</div>
</div>
<%
}
%>
<div class="row">
	<div class="span7">
		<textarea rows="5" placeholder="Message" id="leave-msg-content"></textarea>
	</div>
</div>
<div class="row">
	<div class="span8">
		<ul class="unstyled inline">
			<li><a class="button" <%if(!hasLogin) {%>href="javascript:leaveMsg('1')"<%}else { %>href="javascript:leaveMsg('2')"<%} %>>留言</a></li>
			<li><a class="button button-alt" <%if(!hasLogin) {%>href="javascript:resetLeaveMsgForm('1')"<%}else { %>href="javascript:resetLeaveMsgForm('2')"<%} %>>清空</a>
			</li>
		</ul>
	</div>
</div>
</section> <!-- /发布留言 --> </article>
