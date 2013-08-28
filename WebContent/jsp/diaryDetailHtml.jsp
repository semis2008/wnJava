<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.wnJava.bo.DiaryReplyBO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.wnJava.util.DateUtil"%>
<%@page import="com.wnJava.bo.DiaryBO"%>
<%@page import="com.wnJava.util.*"%>
<%@page import="com.wnJava.bo.UserBO"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	UserBO user = (UserBO) request.getAttribute("loginUser");
	DiaryBO diary = (DiaryBO) request.getAttribute("diary");
	List<DiaryReplyBO> replies = (List<DiaryReplyBO>) request
			.getAttribute("replies");
	if (replies == null) {
		replies = new ArrayList<DiaryReplyBO>();
	}
	if (diary == null) {
		diary = new DiaryBO();
	}
	boolean hasLogin = false;
	if (user == null) {
		user = new UserBO();
	} else {
		hasLogin = true;
	}
%>

<script language="javascript" type="text/javascript">
	//游客回复,parentidw：回复日志：0，回复评论：评论id
	function commitReplyGuest() {
		var content = $('#guest_reply').val();
		var name = $("#guest_name").val();
		var email = $("#guest_email").val();
		var website = $("#guest_website").val();
		var parentid = $("#parentId").val();
		if ($.trim(content) == '' || $.trim(name) == '' || $.trim(email) == '') {
			return;
		}
		var diaryid = $("#diaryId").val();
		$.ajax({
			type : "POST",
			url : "/action/diary/newreply",
			dataType : "text",
			data : {
				diaryid : diaryid,
				parentid : parentid,
				type : "guest",
				reply : content,
				name : name,
				email : email,
				website : website
			},
			success : function(msg) {
				//刷新回复列表，清空回复信息
				if (msg == 'fail') {
					alert("回复失败！");
				} else if (msg == 'success') {
					location.reload();
				}
			}
		});
	}
	//会员回复,parentidw：回复日志：0，回复评论：评论id
	function commitReplyUser() {
		var content = $('#user_reply').val();
		var diaryid = $("#diaryId").val();
		var parentid = $("#parentId").val();
		$.ajax({
			type : "POST",
			url : "/action/diary/newreply",
			dataType : "text",
			data : {
				diaryid : diaryid,
				parentid : parentid,
				type : "user",
				reply : content
			},
			success : function(msg) {
				//刷新回复列表，清空回复信息
				if (msg == 'fail') {
					alert("回复失败！");
				} else if (msg == 'success') {
					location.reload();
				}
			}
		});
	}
	//回复评论时候，显示所回复的节点信息到quote内
	function showParentDiv(replyid) {
		$("#parentId").val(replyid);
		var quotehtml = $("#comment"+replyid).html();
		$("#quote").html(quotehtml);
		$("#quote .reply-btn").text("取消回复");
		$("#quote .reply-btn").removeAttr("onclick");
		$("#quote .reply-btn").attr("onclick","hideParentDiv()");
		$("#quote").slideDown(800);
		$("#quote-img").slideDown(800);
		$('body,html').animate({scrollTop: $('#reply-div').offset().top-100}, 1000);
	}
	function hideParentDiv() {
		$("#quote").slideUp(500);
		$("#quote-img").slideUp(500);
	}
</script>
<title>wnJava--<%=diary.getTitle()%></title>

<article>
<section id="diaryDetail_<%=diary.getId()%>" class="diarySec">
<h3 class="major">
	<span><i class="icon-reorder"></i> 日志详情</span>
</h3>

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
<hr />
<div class="padding-small">
	<p><%=diary.getContent()%></p>
	<p>-----</p>
</div>
 
<div id="comments" class="padding-mini margin-middle">
	<div class="alert">
		日志“<a href="#"><%=diary.getTitle()%></a>”
		<%
		if (diary.getReply_num() == 0l) {
	%>
		还没有人回复哦，来做第一个<a href="#reply-div">回复</a>的吧~  
		<a onclick="ShareToTsina()" class="pull-right"
			title="分享至新浪微博" href="javascript:void(0);"  ><img
				alt="" src="http://static.cnblogs.com/images/icon_weibo_24.png">
		</a>  
	</div>
</div>
<%
	} else {
%> 有<%=diary.getReply_num()%>条回复
<a onclick="ShareToTsina()" class="pull-right"
			title="分享至新浪微博" href="javascript:void(0);"  ><img
				alt="" src="http://static.cnblogs.com/images/icon_weibo_24.png">
		</a>  
</div>
</div>
<%
	for (DiaryReplyBO reply : replies) {
%>
<div id="comment<%=reply.getId()%>" class="well media margin-mini">
	<a href="#" class="pull-left"> <img
		class="img-polaroid media-object" style="width: 50px; height: 50px;"
		src="<%=ConstantsUtil.FW_DOMAIN + reply.getUser_photo()%>"
		data-src="holder.js/64x64" /> </a>
	<div class="media-body">
		<h4 class="media-heading">
			<%=DateUtil.formatDate(reply.getReply_time(), 3)%>
			<a
				href="<%if (reply.getUser_id() == null) {
						out.print("#");
					} else {
						out.print(ConstantsUtil.FW_DOMAIN
								+ "/action/system/mainpage/"
								+ reply.getUser_id());
					}%>"
				class="name"><%=reply.getUser_name()%></a>

			<%
				if (reply.getParent_id() > 0l) {
			%>
			<small>回复 <a
					href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/mainpage/<%=reply.getParent_id()%>"><%=reply.getParent_name()%></a>
			</small>
			<%
				}
			%>

			<div class="btn-toolbar pull-right">
				<button class="reply-btn btn btn-mini btn-info"
					onclick="showParentDiv(<%=reply.getId()%>)">
					<icon class="icon-pencil icon-white"></icon>
					回复
				</button>
			</div>
		</h4>
		<div><%=reply.getReply()%></div>
	</div>
</div>
<%
	}
	}
%>
<hr />
<div id="reply-div" class="padding-mini">
	<div class="span1" id="quote-img" style="display: none">
		<p>
			<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/big-quote.png"
				style="width: 40px;" />
		</p>
	</div>
	<div>
		<div class="well media margin-mini" id="quote" style="display: none"></div>
	</div>
	<%
		if (hasLogin) {
	%>
	<div class="well media">
		<a href="#" class="pull-left"> <img
			class="media-object img-polaroid" style="width: 50px; height: 50px;"
			src="<%=ConstantsUtil.FW_DOMAIN%><%=user.getPhoto()%>"
			data-src="holder.js/50x50" /> </a>
		<div class="media-body">
			<h4 class="media-heading">
				<textarea rows="3" id="user_reply" class="span8"
					placeholder="发表回复..." required></textarea>
			</h4>
		</div>
		<div class="span4 offset2">
			<button class="btn btn-block btn-success" type="submit"
				onclick="commitReplyUser()">回复</button>
		</div>
	</div>
	<%
		} else {
	%>
	<div>
		<div class="well media">
			<a href="#" class="pull-left"> <img
				class="media-object img-polaroid" style="width: 50px; height: 50px;"
				src="<%=ConstantsUtil.FW_DOMAIN%>/img/head/default/defaultGuest.jpg"
				data-src="holder.js/50x50" /> </a>
			<div class="media-body">
				<h4 class="media-heading">
					<textarea rows="3" id="guest_reply" class="span6"
						placeholder="发表回复..." required></textarea>
				</h4>
			</div>
			<ul class="inline">
				<li><input type="text" id="guest_name" class="span2"
					placeholder="称呼" required /></li>
				<li><input type="email" id="guest_email" class="span2"
					placeholder="邮箱" required /></li>
				<li><input type="text" placeholder="网站" class="span3"
					id="guest_website" required /></li>
			</ul>
			<div class="span4 offset1">
				<button class="btn btn-block btn-success" type="submit"
					onclick="commitReplyGuest()">回复</button>
			</div>
		</div>
	</div>
	<%
		}
	%>
</div>
</div>
</div>
<!-- 隐藏域，提供日志id信息 --> <input id="diaryId" value="<%=diary.getId()%>"
	type="hidden" /> <!-- 隐藏域，提供评论id信息 --> <input id="parentId" value="0"
	type="hidden" /> </section> </article>
