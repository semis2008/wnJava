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
	$(function() {
		/* 随机背景 */
		var bg_num = Math.ceil(Math.random() * 5 + 1);
		$("#banner-head").addClass("hero-unit04");
	});
</script>
<title>懒熊de部落格</title>
</head>
<body>
	<div id="content">
		<header class="no-radius image" id="banner-head">
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
							<li><article class="is-post-summary">
								<h4>
									<a href="#">撒打asdas算打算打开国际..</a>
								</h4>
								<ul class="meta inline">
									<li><i class="icon-edit"></i> 2014/07/12 11:33</li>
									<li><i class="icon-comment"></i><a href="#"> 34</a></li>
								</ul>
								</article>
							</li>
							<li><article class="is-post-summary">
								<h4>
									<a href="#">撒打算打asdasdasd算打开国际..</a>
								</h4>
								<ul class="meta inline">
									<li><i class="icon-edit"></i> 2014/07/12 11:33</li>
									<li><i class="icon-comment"></i><a href="#"> 34</a></li>
								</ul>
								</article>
							</li>
							<li><article class="is-post-summary">
								<h4>
									<a href="#">撒打算打算打开国asdasdasdasdasd际..</a>
								</h4>
								<ul class="meta inline">
									<li><i class="icon-edit"></i> 2014/07/12 11:33</li>
									<li><i class="icon-comment"></i><a href="#"> 34</a></li>
								</ul>
								</article>
							</li>
							<li><article class="is-post-summary">
								<h4>
									<a href="#">撒打算asdsaq打算打开国际..</a>
								</h4>
								<ul class="meta inline">
									<li><i class="icon-edit"></i> 2014/07/12 11:33</li>
									<li><i class="icon-comment"></i><a href="#"> 34</a></li>
								</ul>
								</article>
							</li>
						</ul>
						<a class="button button-alt" href="#">查看全部</a> </section>
						<!-- /Recent Posts -->


						<!-- 活跃用户 -->
						<section>
						<h3 class="major">
							<span><i class="icon-user-md"></i> 活跃用户</span>
						</h3>
						<p>Donec sagittis massa et leo semper scele risque metus
							faucibus. Morbi congue mattis mi. Phasellus sed nisl vitae risus
							tristique volutpat. Cras rutrum sed commodo luctus blandit.</p>
						<a class="button button-alt" href="#">查看全部</a> </section>
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
							<p>"啊实打实大！！啊实打实大啊？"</p> <span>--C.C, 2013/02/04 14:33</span></li>
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
						<a class="button button-alt" href="#">查看全部</a> </section>
						</section>
						<!-- /活跃用户 -->

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
					<article> <section class="topDiary">
					<h3 class="major">
							<span><i class="icon-star-empty"></i>推荐日志</span>
						</h3>
					<div>
						<img width="60px" height="60px" alt="" class="img-polaroid"
							src="../../img/wn_head01.jpg" />
							<blockquote >
								<h3 class="text-info">
							啊擦拭打算打算发的 <em title="回复/阅读数">[12/111]</em>
								</h3>
								<small >
								<label class="label">tag1</label>
								<label class="label">tag2</label>
								 <em><a class="text-info"
								title="查看他发布的所有博文"
								href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/mainpage/1">kalor</a>
								发布于 2013/04/08 14:22</em>
							</small>
							</blockquote>
					</div>
					<div>
					<p>
						Phasellus quam turpis, feugiat sit amet ornare in, hendrerit
						in lectus. Praesent semper  mod quis eget mi. Etiam eu ante risus.
						Aliquam erat volutpat. Aliquam luctus et mattis lectus sit amet
						pulvinar. Nam turpis nisi consequat etiam lorem ipsum dolor sit
						amet nullam.
					</p></div>
					
					<a class="button" href="#">Continue Reading</a> 
					<a href="#"
						title="换一篇" class="changeTopDiary"><i class="icon-refresh icon-spin icon-2x"></i></a> </section> 
					 	
						<section>
					<h3>More intriguing information</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
						Maecenas ac quam risus, at tempus justo. Sed dictum rutrum massa
						eu volutpat. Quisque vitae hendrerit sem. Pellentesque lorem
						felis, ultricies a bibendum id, bibendum sit amet nisl. Mauris et
						lorem quam. Maecenas rutrum imperdiet vulputate. Nulla quis nibh
						ipsum, sed egestas justo. Morbi ut ante mattis orci convallis
						tempor. Etiam a lacus a lacus pharetra porttitor quis accumsan
						odio. Sed vel euismod nisi. Etiam convallis rhoncus dui quis
						euismod. Maecenas lorem tellus, congue et condimentum ac,
						ullamcorper non sapien vulputate. Nulla quis nibh ipsum, sed
						egestas justo. Morbi ut ante mattis orci convallis tempor. Etiam a
						lacus a lacus pharetra porttitor quis accumsan odio. Sed vel
						euismod nisi. Etiam convallis rhoncus dui quis euismod. Maecenas
						lorem tellus, congue et condimentum ac, ullamcorper non sapien.
						Donec sagittis massa et leo semper a scelerisque metus faucibus.
						Morbi congue mattis mi. Phasellus sed nisl vitae risus tristique
						volutpat. Cras rutrum commodo luctus.</p>
					<p>Phasellus odio risus, faucibus et viverra vitae, eleifend ac
						purus. Praesent mattis, enim quis hendrerit porttitor, sapien
						tortor viverra magna, sit amet rhoncus nisl lacus nec arcu.
						Suspendisse laoreet metus ut metus imperdiet interdum aliquam
						justo tincidunt. Mauris dolor urna, fringilla vel malesuada ac,
						dignissim eu mi. Praesent mollis massa ac nulla pretium pretium.
						Etiam a lacus a lacus pharetra porttitor quis accumsan odio. Sed
						vel euismod nisi. Etiam convallis rhoncus dui quis euismod.
						Maecenas lorem tellus, congue et condimentum ac, ullamcorper non
						sapien. Donec sagittis massa et leo semper a scelerisque metus
						faucibus. Morbi congue mattis mi. Maecenas tortor mauris,
						consectetur pellentesque dapibus eget, tincidunt vitae arcu.
						Vestibulum purus augue, tincidunt sit amet iaculis id, porta eu
						purus.</p>
					<a class="button" href="#">Continue Reading</a> </section> <section>
					<h3>So in conclusion ...</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
						Maecenas ac quam risus, at tempus justo. Sed dictum rutrum massa
						eu volutpat. Quisque vitae hendrerit sem. Pellentesque lorem
						felis, ultricies a bibendum id, bibendum sit amet nisl. Mauris et
						lorem quam. Maecenas rutrum imperdiet vulputate. Nulla quis nibh
						ipsum, sed egestas justo. Morbi ut ante mattis orci convallis
						tempor. Etiam a lacus a lacus pharetra porttitor quis accumsan
						odio. Sed vel euismod nisi. Etiam convallis rhoncus dui quis
						euismod. Maecenas lorem tellus, congue et condimentum ac,
						ullamcorper non sapien. Donec sagittis massa et leo semper a
						scelerisque metus faucibus. Morbi congue mattis mi. Phasellus sed
						nisl vitae.</p>
					<p>Suspendisse laoreet metus ut metus imperdiet interdum
						aliquam justo tincidunt. Mauris dolor urna, fringilla vel
						malesuada ac, dignissim eu mi. Praesent mollis massa ac nulla
						pretium pretium. Maecenas tortor mauris, consectetur pellentesque
						dapibus eget, tincidunt vitae arcu. Vestibulum purus augue,
						tincidunt sit amet iaculis id, porta eu purus.</p>
					<a class="button" href="#">Continue Reading</a> </section> </article>
					<!-- /Content -->
				</div>
			</div>
		</div>
	</div>
	<!-- 底部 -->
	<jsp:include page="/jsp/common/bottom.jsp" flush="true" />
</body>
</html>