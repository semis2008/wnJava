<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.vo.DynamicVO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.wnJava.util.*"%>
<%@page import="com.wnJava.bo.*"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String fun = (String) request.getAttribute("fun");
	if (fun == null)
		fun = "";

	UserBO user = (UserBO) request.getAttribute("loginUser");
	UserBO visitedUser = (UserBO) request.getAttribute("visitedUser");

	List<UserBO> users = (List<UserBO>) request.getAttribute("users");
	if (users == null) {
		users = new ArrayList<UserBO>();
	}
	Integer diaryCount = (Integer) request.getAttribute("diaryCount");
	if (diaryCount == null) {
		diaryCount = 0;
	}

	List<DiaryBO> diaries = (ArrayList<DiaryBO>) request
			.getAttribute("diaries");
	if (diaries == null) {
		diaries = new ArrayList<DiaryBO>();
	}
	List<DiaryBO> notices = (ArrayList<DiaryBO>) request
			.getAttribute("notices");
	if (notices == null) {
		notices = new ArrayList<DiaryBO>();
	}
	DynamicVO dynamicVO = (DynamicVO) request.getAttribute("dynamics");
	if (dynamicVO == null) {
		dynamicVO = new DynamicVO();
	}
	String userDiaryNum = "0";
	boolean hasLogin = false;
	if (user == null) {
		user = new UserBO();
	} else {
		hasLogin = true;
		userDiaryNum = (String) request.getAttribute("userDiaryNum");
	}
	if (visitedUser == null) {
		visitedUser = new UserBO();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- 网站公用顶部 -->
<jsp:include page="/jsp/common/head.jsp" flush="true">
	<jsp:param value="<%=hasLogin %>" name="hasLogin" />
	<jsp:param value="<%=user.getName() %>" name="userName" />
	<jsp:param value="<%=user.getId() %>" name="userId" />
	<jsp:param value="<%=fun %>" name="fun" />
	<jsp:param value="<%=userDiaryNum %>" name="userDiaryNum" />
</jsp:include>

<link href="/css/index.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	
</script>
<title>懒熊de部落格</title>
</head>
<body>
	<div id="content">
		<header class="no-radius image hero-unit" id="banner-head">
		<div class="container text-center">
			<h1>
				<img alt="WN Java" src="<%=ConstantsUtil.FW_DOMAIN%>/img/logo.png">
			</h1>
		</div>
		<div class="text-center logo-info">
			<h2>
				<a href="#">Wn Java</a> <small><em class="text-info">-
						-或许可以做成一个最简捷的社区~</em> </small>
			</h2>
		</div>
		</header>
		<div class="bookmark">
			<ul class="breadcrumb">
				<li class="active">首页</li>
			</ul>
		</div>
		<div id="main-wrapper" class="container">
			<div>
				<div class="span4">
					<div class="sidebar">
						<!-- Sidebar -->
						<!-- Recent Posts -->
						<section>
						<h3 class="major">
							<span><i class="icon-list-ul"></i> 最新日志</span>
						</h3>
						<ul class="unstyled side-ul">
							<li>
								<h5>
									<a href="#"><i class="icon-file-alt"></i>
										a撒asddasasd打asds开国大啊际..</a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-time"></i> 2014/07/12 11:33</li>
									<li><i class="icon-comment"></i><a href="#"> 34</a>
									</li>
								</ul>
							</li>
							<li>
								<h5>
									<a href="#"><i class="icon-file-alt"></i>
										a撒asddasasd打asdasd开国大啊际..</a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-time"></i> 2014/07/12 11:33</li>
									<li><i class="icon-comment"></i><a href="#"> 34</a>
									</li>
								</ul>
							</li>
							<li>
								<h5>
									<a href="#"><i class="icon-file-alt"></i>
										a撒asddasasd打开asdasd国大啊际..</a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-time"></i> 2014/07/12 11:33</li>
									<li><i class="icon-comment"></i><a href="#"> 34</a>
									</li>
								</ul>
							</li>
							<li>
								<h5>
									<a href="#"><i class="icon-file-alt"></i>
										a撒asddasasd打开asdasd国大啊际..</a>
								</h5>
								<ul class="meta inline">
									<li><i class="icon-time"></i> 2014/07/12 11:33</li>
									<li><i class="icon-comment"></i><a href="#"> 34</a>
									</li>
								</ul>
							</li>
						</ul>
						<a class="button button-alt" href="javascript:void(0)">查看全部 <i
							class=" icon-hand-right"></i> </a> </section>
						<!-- /Recent Posts -->


						<!-- 活跃用户 -->
						<section>
						<h3 class="major">
							<span><i class="icon-user-md"></i> 活跃用户</span>
						</h3>
						<p>Donec sagittis massa et leo semper scele risque metus
							faucibus. Morbi congue mattis mi. Phasellus sed nisl vitae risus
							tristique volutpat. Cras rutrum sed commodo luctus blandit.</p>
						<a class="button button-alt" href="javascript:void(0)">查看全部 <i
							class="icon-hand-right"></i> </a> </section>
						<!-- /活跃用户 -->


						<!-- 留言 -->
						<section>
						<h3 class="major">
							<span><i class="icon-envelope-alt"></i> 留言</span>
						</h3>
						<ul class="unstyled quote-list">
							<li><img src="../../img/wn_head01.jpg" class="img-polaroid"
								width="40px" height="40px" alt="">
									<p>"阿打算打算打算打算啊实打实大撒阿斯达"</p> <span>--C.C, 2013/02/04
									14:33</span>
							</li>
							<li><img src="../../img/wn_head01.jpg" class="img-polaroid"
								width="40px" height="40px" alt="">
									<p>"啊实打实大！！啊实打实大啊？"</p> <span>--C.C, 2013/02/04 14:33</span>
							</li>
							<li><img src="../../img/wn_head01.jpg" class="img-polaroid"
								width="40px" height="40px" alt="">
									<p>"Magna veroeros amet tempus"</p> <span>--C.C,
										2013/02/04 14:33</span>
							</li>
							<li><img src="../../img/wn_head01.jpg" class="img-polaroid"
								width="40px" height="40px" alt="">
									<p>"Magna veroeros amet tempus"</p> <span>--C.C,
										2013/02/04 14:33</span>
							</li>
						</ul>
						<a class="button button-alt" href="javascript:void(0)">查看全部 <i
							class=" icon-hand-right"></i> </a> </section>
						<!-- /留言 -->

						<!-- 热门标签 -->
						<section>
						<h3 class="major">
							<span><i class="icon-tags"></i> Hot Tags</span>
						</h3>
						<p>Rhoncus dui quis euismod. Maecenas lorem tellus, congue et
							condimentum ac, ullamcorper non sapien. Donec sagittis massa et
							leo semper scele risque metus faucibus. Morbi congue mattis mi.
							Phasellus sed nisl vitae risus tristique volutpat. Cras rutrum
							sed commodo luctus blandit.</p>
						<!-- /热门标签 --> <!-- /Sidebar -->
					</div>
				</div>
				<div class="span7">
					<!-- Content -->
					<article> <!-- 推荐日志 --> <section id="topDiarySec">
					<h3 class="major">
						<span><i class="icon-star-empty"></i> 推荐日志</span>
					</h3>
					<div>
						<img width="60px" height="60px" alt="" class="img-polaroid"
							src="../../img/wn_head01.jpg" />
						<blockquote>
							<h3 class="text-info">
								啊擦拭打算打算发的 <em title="回复/阅读数">[12/111]</em>
							</h3>
							<small> <label class="label"><i class="icon-tag"></i>
									tag1</label> <label class="label"><i class="icon-tag"></i> tag2</label>
								<em><a class="text-info" title="查看他发布的所有博文"
									href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/mainpage/1">kalor</a>
									发布于 2013/04/08 14:22</em> </small>
						</blockquote>
					</div>
					<div>
						<p>Phasellus quam turpis, feugiat sit amet ornare in,
							hendrerit in lectus. Praesent semper mod quis eget mi. Etiam eu
							ante risus. Aliquam erat volutpat. Aliquam luctus et mattis
							lectus sit amet pulvinar. Nam turpis nisi consequat etiam lorem
							ipsum dolor sit amet nullam.</p>
					</div>

					<a class="button" href="javascript:void(0)">阅读全文 <i
						class=" icon-chevron-down"></i> </a> <a href="#"
						onmouseover="$('.changeTopDiary i').addClass('icon-spin');"
						onmouseout="$('.changeTopDiary i').removeClass('icon-spin');"
						title="换一篇" class="changeTopDiary"><i
						class="icon-refresh icon-2x"></i> </a> </section> <!-- /推荐日志 --> <!-- 热门日志 --> <section
						id="hotDiarySec">
					<h3 class="major">
						<span><i class="icon-lightbulb"></i> 热门日志</span>
					</h3>
					<div>
						<div class="span3">
							<ul class="unstyled">
								<li><a href="#"><i class="icon-bookmark-empty"></i>
										asddasdasd阿asdas达d阿斯达斯ddddda...</a></li>
								<li><a href="#"><i class="icon-lightbulb"></i>
										asasdasd阿asdas达d阿斯达斯ddddda...</a></li>
								<li><a href="#"><i class="icon-lightbulb"></i>
										asddasd阿asdas达d阿</a></li>
								<li><a href="#"><i class="icon-lightbulb"></i>
										asddasd阿asdas</a></li>
								<li><a href="#"><i class="icon-lightbulb"></i>
										asddasd阿asdas达d阿斯asd达斯ddddda...</a></li>
							</ul>
						</div>
						<div class="span3">
							<ul class="unstyled">
								<li><a href="#"><i class="icon-bookmark-empty"></i>
										asddasdasd阿asdas达d阿斯达斯ddddda...</a></li>
								<li><a href="#"><i class="icon-lightbulb"></i>
										asasdasd阿asdas达d阿斯达斯ddddda...</a></li>
								<li><a href="#"><i class="icon-lightbulb"></i>
										asddasd阿asdas达d阿</a></li>
								<li><a href="#"><i class="icon-lightbulb"></i>
										asddasd阿asdas</a></li>
								<li><a href="#"><i class="icon-lightbulb"></i>
										asddasd阿asdas达d阿斯asd达斯ddddda...</a></li>
							</ul>
						</div>
					</div>
					<a class="button" href="javascript:void(0)">查看全部</a> </section> <!-- /热门日志 -->

					<!-- 关于 --> <section id="aboutSec">
					<h3 class="major">
						<span><i class="icon-info-sign"></i> 关于</span>
					</h3>
					<div class="row">
						<div class="span2 text-center">
							<img style="width: 80px; height: 80px"
								src="<%=ConstantsUtil.FW_DOMAIN%>/img/wn_head01.jpg"
								class="img-rounded margin-bottom-middle" />
							<h5>我是王宁，本站的作者，89年生于河北。毕业一年,程序员。</h5>
							<em>喜欢创造的快乐，喜欢<span class="label label-info">宅</span>。喜欢游泳篮球LOL,喜欢<span class="label label-info">进击の巨人</span>，喜欢各种萌物，单身...</em>
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
						<div class="span6 alert alert-info margin-top-small">
							GitHub源码地址 ： https://github.com/semis2008/wnJava/							
						</div>
					</div>
					</section> <!-- /关于WnJava --> <!-- 发布留言 --> <section id="leaveMsgSec">
					<h3 class="major">
						<span><i class="icon-envelope"></i> 给我留言</span>
					</h3>
					<div class="row">
						<div class="span3">
							<input type="text" placeholder="Name" id="contact-name"
								class="text">
						</div>
						<div class="span3">
							<input type="text" placeholder="Email" id="contact-email"
								class="text">
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
					<!-- /Content -->
				</div>
			</div>
		</div>
	</div>
	<!-- 底部 -->
	<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>