<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.util.UserUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wnJava.bo.DiaryReplyBO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.wnJava.util.DateUtil"%>
<%@page import="com.wnJava.bo.DiaryBO"%>
<%@page import="com.wnJava.util.ConstantsUtil"%>
<%@page import="com.wnJava.bo.UserBO"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String fun = (String) request.getAttribute("fun");
	if (fun == null)
		fun = "";
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
	String userDiaryNum = "0";
	boolean hasLogin = false;
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


<link href="/css/diaryDetail.css" rel="stylesheet" type="text/css" />

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
</head>
<body>
	<div class="bookmark">
		<ul class="breadcrumb">
		 	<li><a href="<%=ConstantsUtil.FW_DOMAIN%>">首页</a> <span class="divider">/</span></li>
		 	<li><a href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/diary">日志</a> <span class="divider">/</span></li>
		 	<li class="active"><%=diary.getTitle()%></li>
		</ul>
	</div>
 <article class="container">  
	<section class="row article" id="article<%=diary.getId()%>"><!--日志 --> 
	<div class="span10 offset1 panel">
		<div class="padding-middle">
			<div class="art-head well">
				<div class="art-cats">
					<ul>
					<li class="blogTime"><a title="<%=diary.getTitle()%>" href="#"><em><%=DateUtil.dateToCalendar(diary.getPublish_time()).get(
					Calendar.MONTH) + 1%>/</em><%=DateUtil.dateToCalendar(diary.getPublish_time()).get(
					Calendar.DAY_OF_MONTH)%></a> </li>
							
					<%
													String[] tags = diary.getTags().split("_");
													for (String tag : tags) {
												%>
					<li class="tag"><a title="<%=tag%>" href="#"><%=tag%></a> </li>
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
			<hr class="soften" />
			<div class="art-content padding-small">
				<p><%=diary.getContent()%></p>
			</div>
						<!-- Baidu Button BEGIN -->
						<!-- Baidu Button BEGIN -->
						<div id="bdshare" style="float: right;"
							class="bdshare_t bds_tools get-codes-bdshare">
							<span class="bds_more">分享到：</span> <a class="bds_qzone"></a> <a
								class="bds_tsina"></a> <a class="bds_tqq"></a> <a
								class="bds_renren"></a> <a class="bds_t163"></a> <a
								class="shareCount"></a>
						</div>
						<script type="text/javascript" id="bdshare_js"
							data="type=tools&amp;uid=240802"></script>
						<script type="text/javascript" id="bdshell_js"></script>
						<script type="text/javascript">
						document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
</script>
						<!-- Baidu Button END -->

					</div>
					<hr class="soften" />
					<div id="comments" class="padding-middle">
						<div class="alert">
  							日志“<a href="#"><%=diary.getTitle()%></a>”
							<%
							if (diary.getReply_num() == 0l) {
						%>
							还没有人回复哦，来做第一个<a href="#reply-div">回复</a>的吧~
						</div>
					</div>
							<%
								} else {
							%>
							有<%=diary.getReply_num()%>条回复
						</div>
					</div>
					<%
						for (DiaryReplyBO reply : replies) {
				%>
							<div id="comment<%=reply.getId()%>" class="well media margin-middle">
								<a href="#" class="pull-left">
									<img class="img-polaroid media-object" style="width: 64px;height: 64px;" src="<%=ConstantsUtil.FW_DOMAIN + reply.getUser_photo()%>" data-src="holder.js/64x64" />
								</a>
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
								<small>回复 <em><a href="<%=ConstantsUtil.FW_DOMAIN %>/action/system/mainpage/<%=reply.getParent_id() %>"><%=reply.getParent_name() %></a></em></small>
							<%
								}
							%>
									
									<div class="btn-toolbar pull-right">
  											<div class="btn-group">
											<button class="btn btn-mini btn-success" onclick="#">
												<icon class="icon-thumbs-up icon-white"></icon>
												顶
											</button>
											<button class="btn btn-mini btn-danger" onclick="#">
											<icon class="icon-thumbs-down icon-white"></icon>
											踩
											</button>
											</div>
											<button class="reply-btn btn btn-mini btn-info" onclick="showParentDiv(<%=reply.getId()%>)">
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
						<hr class="soften" />
						<div id="reply-div" class="padding-middle">
								<div class="span1" id="quote-img" style="display: none">
									<p>
										<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/big-quote.png" style="width: 40px;" />
									</p>
								</div>
								<div>
									<div class="well media margin-middle" id="quote" style="display: none"></div>		
								</div>
							<%
								if (hasLogin) {
							%>
								<div class="well media">
									<a href="#" class="pull-left">
										<img class="media-object img-polaroid" style="width: 64px;height: 64px;" src="<%=ConstantsUtil.FW_DOMAIN%><%=user.getPhoto()%>" data-src="holder.js/64x64" />
									</a>
									<div class="media-body">
	    								<h4 class="media-heading">
											<textarea rows="3" id="user_reply" class="span8" placeholder="发表回复..." required></textarea>
										</h4>
									</div>
									<div class="span4 offset2">
										<button class="btn btn-block btn-success" type="submit" onclick="commitReplyUser()">回复</button>  									
									</div>
								</div>
							<%
								} else {
							%>
							<div>
								<div class="well media">
									<a href="#" class="pull-left">
										<img class="media-object img-polaroid" style="width: 64px;height: 64px;" src="<%=ConstantsUtil.FW_DOMAIN%>/img/head/default/defaultGuest.jpg" data-src="holder.js/64x64" />
									</a>
									<div class="media-body">
	    								<h4 class="media-heading">
											<textarea rows="3" id="guest_reply" class="span8" placeholder="发表回复..." required></textarea>
										</h4>
									</div>
									<ul class="inline">
										<li>
											<input type="text" id="guest_name" class="span3" placeholder="称呼" required/>
										</li>
										<li>
											<input type="email" id="guest_email" class="span3" placeholder="邮箱" required/>
										</li>
										<li>
											<input type="text"  placeholder="网站" class="span3" id="guest_website" required/>
										</li>
									</ul>
									<div class="span4 offset2">
										<button class="btn btn-block btn-success" type="submit" onclick="commitReplyGuest()">回复</button>
									</div>
								</div>	
							 </div>
							<%
								}
							%>
						</div>
					</div>
				</div>
				<!-- 隐藏域，提供日志id信息 -->
				<input id="diaryId" value="<%=diary.getId()%>" type="hidden" />
				<!-- 隐藏域，提供评论id信息 -->
				<input id="parentId" value="0" type="hidden" />
		</section>
		</article>
<!-- 底部 -->
<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>