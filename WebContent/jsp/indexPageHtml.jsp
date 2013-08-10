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
%>

<title>懒熊de部落格</title>
<!-- Content -->
<article> <!-- 推荐日志 --> <section id="topDiarySec" class="diarySec">
<h3 class="major">
	<span><i class="icon-star-empty"></i> 推荐日志</span>
</h3>
<div>
	<img width="60px" height="60px" alt="" class="img-polaroid"
		src="../../img/wn_head01.jpg" />
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
	<p><%=StringUtil.cutString(topDiary.getContent(), 200)%></p>
</div>

<a class="button" href="javascript:void(0)">阅读全文 <i
	class=" icon-chevron-down"></i> </a> <a href="javascript:void(0)"
	onclick="changeTopDiary(<%=topDiary.getId()%>)"
	onmouseover="$('.changeTopDiary i').addClass('icon-spin');"
	onmouseout="$('.changeTopDiary i').removeClass('icon-spin');"
	title="换一篇" class="changeTopDiary"><i class="icon-refresh icon-2x"></i>
</a> </section> <!-- /推荐日志 --> <!-- 热门日志 --> <section id="hotDiarySec">
<h3 class="major">
	<span><i class="icon-lightbulb"></i> 热门日志</span>
</h3>
<div>
	<div class="span3">
		<ul class="unstyled">
			<%
				for (DiaryBO diary : hotDiaries.get("left")) {
			%>
			<li><a href="#"><i <%if (diary.getTags().contains("公告")) {%>
					class="icon-bookmark-empty" <%} else {%> class="icon-lightbulb"
					<%}%>></i> <%=StringUtil.cutString(diary.getTitle(), 15)%></a> <em>[<%=diary.getReply_num()%>/<%=diary.getRead_num()%>]</em>
			</li>
			<%
				}
			%>
		</ul>
	</div>
	<div class="span3">
		<ul class="unstyled">
			<%
				for (DiaryBO diary : hotDiaries.get("right")) {
			%>

			<li><a href="#"><i <%if (diary.getTags().contains("公告")) {%>
					class="icon-bookmark-empty" <%} else {%> class="icon-lightbulb"
					<%}%>></i> <%=StringUtil.cutString(diary.getTitle(), 15)%></a> <em>[<%=diary.getReply_num()%>/<%=diary.getRead_num()%>]</em>
			</li>
			<%
				}
			%>
		</ul>
	</div>
</div>
<a class="button" href="javascript:void(0)">查看全部 <i
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

	<div class="span4">
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
	<div class="span6 alert alert-info margin-top-small">GitHub源码地址 ：
		https://github.com/semis2008/wnJava/</div>
</div>
</section> <!-- /关于WnJava --> <!-- 发布留言 --> <section id="leaveMsgSec">
<h3 class="major">
	<span><i class="icon-envelope"></i> 给我留言</span>
</h3>
<div class="row">
	<div class="span3">
		<input type="text" placeholder="Name" id="contact-name" class="text">
	</div>
	<div class="span3">
		<input type="text" placeholder="Email" id="contact-email" class="text">
	</div>
</div>
<div class="row">
	<div class="span6">
		<textarea rows="5" placeholder="Message" id="contact-message"></textarea>
	</div>
</div>
<div class="row">
	<div class="span6">
		<ul class="unstyled inline">
			<li><a class="button" href="javascript:void(0)">留言</a></li>
			<li><a class="button button-alt" href="javascript:void(0)">清空</a>
			</li>
		</ul>
	</div>
</div>
</section> <!-- /发布留言 --> </article>
