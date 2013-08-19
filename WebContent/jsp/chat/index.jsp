<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.wnJava.util.ConstantsUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/bootstrap/css/bootstrap.css"
	rel="stylesheet" media="screen" />
<link type="text/css"
	href="<%=ConstantsUtil.FW_DOMAIN%>/css/chat/index.css" rel="stylesheet"
	media="screen" />
<link type="text/css"
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/css/messenger.css"
	rel="stylesheet" media="screen" />
<link type="text/css"
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/switch/bootstrapSwitch.css"
	rel="stylesheet" media="screen" />
<link type="text/css"
	href="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/css/messenger-theme-future.css"
	rel="stylesheet" media="screen" />



<title>WNChat首页</title>
</head>
<body>
	<!-- 导航条 -->
	<div class="navbar-wrapper">
		<div class="container">
			<div class="navbar navbar-inverse">
				<div class="navbar-inner">
					<button data-target=".nav-collapse" data-toggle="collapse"
						class="btn btn-navbar" type="button">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a href="#" class="brand">Chat
						Bear&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
					<div class="nav-collapse collapse">
						<ul class="nav">
							<li class="active"><a href="#"><i
									class="icon-home icon-white"></i> 首页</a>
							</li>
							<li><a href="#about"><i class="icon-list icon-white"></i>
									About</a>
							</li>
							<li><a href="#contact"><i
									class="icon-envelope icon-white"></i> Contact</a>
							</li>
							<li class="dropdown"><a data-toggle="dropdown"
								class="dropdown-toggle" href="#"><i
									class="icon-plus icon-white"></i> 更多<b class="caret"></b> </a>
								<ul class="dropdown-menu">
									<li><a href="#"><i class="icon-user"></i> 个人信息</a>
									</li>
									<li><a href="#" data-toggle="modal"
										data-target="#loginModal" data-keyboard="true"
										data-backdrop="true"><i class="icon-ok"></i> 登陆</a>
									</li>
									<li><a href="#" data-toggle="modal"
										data-target="#registModal" data-keyboard="true"
										data-backdrop="true"><i class="icon-plus-sign"></i> 注册</a>
									</li>
									<li class="divider"></li>
									<li class="nav-header">相关项目</li>
									<li><a href="<%=ConstantsUtil.FW_DOMAIN%>" target="_blank"><i
											class="icon-hand-right"></i> wnJava网络社区</a>
									</li>
									<li><a href="#"><i class="icon-hand-right"></i> Kalor网</a>
									</li>
									<li><a
										href="<%=ConstantsUtil.FW_DOMAIN%>/action/chat/comet"><i
											class="icon-hand-right"></i>comet推送</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 弹出对话框 -->
	<!-- 登录 -->
	<div class="modal hide fade" id="loginModal">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
			<h3>
				<span class="label label-info"><i
					class="icon-user icon-white"></i>欢迎您登录ChatBear,开始轻松之旅~</span>
			</h3>
		</div>
		<div class="modal-body">
			<form class="well form-inline">
				<input type="text" class="input-medium" placeholder="帐号" />
				<input type="password" class="input-medium" placeholder="密码" />
				<label class="checkbox"> <input type="checkbox" /> 记住我 </label>
				<button type="submit" class="btn btn-primary">登录</button>
			</form>
		</div>
	</div>
	<!-- 注册 -->
	<div class="modal hide fade" id="registModal">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
			<h3>
				<span class="label label-info offset1"><i
					class="icon-plus icon-white"></i>欢迎您注册ChatBear，马上开始吧~</span>
			</h3>
		</div>
		<div class="modal-body span7">
			<form class="form-horizontal">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="input01">您的尊姓大名</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-user"></i> </span><input
									type="text" size="16" id="input01" />
							</div>
							<p class="help-block">字母，数字，汉字皆可</p>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="input02">您的Email</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-envelope"></i> </span><input
									type="text" size="16" id="input02" />
							</div>
							<p class="help-block">邮箱将直接作为您登录的帐号哦</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="input03">您要使用的密码</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-asterisk"></i> </span><input
									type="text" size="16" id="input03" />
							</div>
							<p class="help-block">字母，数字皆可</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="input04">请再输入一次密码</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on"><i class="icon-asterisk"></i> </span><input
									type="password" size="16" id="input04" />
							</div>
							<p class="help-block">两次密码输入必须一致</p>
						</div>
					</div>
					<div class="control-group">
						<button class="btn btn-primary offset1" type="submit">确认注册</button>
						<button class="btn">取消</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>


	<!-- 轮播 -->
	<div class="carousel slide" id="topCarousel">
		<div class="carousel-inner">
			<div class="item active">
				<img alt="" src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/slide-01.jpg" />
				<div class="container">
					<div class="carousel-caption">
						<h1>简单即是美.</h1>
						<br></br>
						<p class="lead">即时的接收朋友们的信息，并简短的进行回复。你可以在无序的信息中，认识新的朋友；通过简单的说明，分享自己的生活点滴。</p>
						<a href="#" class="btn btn-large btn-primary">马上加入&nbsp;<i
							class="icon-user icon-white"></i> </a>
					</div>
				</div>
			</div>
			<div class="item">
				<img alt="" src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/slide-02.jpg" />
				<div class="container">
					<div class="carousel-caption">
						<h1>敏于行.</h1>
						<br></br>
						<p class="lead">有一万个好点子，不如把其中最不起眼的那个变成现实。一步一步走，总有到达终点的那一刻。我是低头赶路的行者，脚下生根。</p>
						<a href="#" class="btn btn-large btn-primary">更多&nbsp;<i
							class="icon-plus icon-white"></i> </a>
					</div>
				</div>
			</div>
			<div class="item">
				<img alt="" src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/slide-03.jpg" />
				<div class="container">
					<div class="carousel-caption">
						<h1>是什么呢.</h1>
						<br />
						<p class="lead">是一个不断push短消息供你阅读的仆人，是一个给你与陌生人自由交流机会的神秘女子，是一个不知道你究竟想要什么，但是却可以给你最近接答案的.....</p>
						<a href="#" class="btn btn-large btn-primary">了解WN Chat&nbsp;<i
							class="icon-th icon-white"></i> </a>
					</div>
				</div>
			</div>
		</div>
		<a data-slide="prev" href="#topCarousel" class="left carousel-control">‹</a>
		<a data-slide="next" href="#topCarousel"
			class="right carousel-control">›</a>
	</div>



	<!-- 主体 -->
	<div class="container marketing">
		<div class="row" id="intro">
			<div class="span4">
				<img data-src="holder.js/140x140" class="img-circle" alt="140x140"
					style="width: 140px; height: 140px;"
					src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/slide-03.jpg" />
				<h2>是什么？</h2>
				<p class="text-info">是一个不断push短消息供你阅读的仆人，是一个给你与陌生人自由交流机会的神秘女子，是一个不知道你究竟想要什么，但是却可以给你最近接答案的.....</p>
				<p>
					<a href="#" class="btn">查看 »</a>
				</p>
			</div>
			<div class="span4">
				<img data-src="holder.js/140x140" class="img-circle" alt="140x140"
					style="width: 140px; height: 140px;"
					src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/slide-01.jpg" />
				<h2>简单</h2>
				<p class="text-info">哪怕不用注册，也可以即时的获取朋友们发布的信息。系统会依据你的习惯来筛选消息。而如果你打算回应对方或者分享自己的心情，那么就需要简单的注册一下啦。</p>
				<p>
					<a href="#" class="btn">注册 »</a>
				</p>
			</div>
			<div class="span4">
				<img data-src="holder.js/140x140" class="img-circle" alt="140x140"
					style="width: 140px; height: 140px;"
					src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/slide-02.jpg" />
				<h2>迅捷</h2>
				<p class="text-info">基于简单的设计思路，为你呈现出即时无序的反馈信息。我们不知道您喜欢看什么，可是我们知道您看什么看的多。更多本系统的设计过程，欢迎关注~</p>
				<p>
					<a href="#" class="btn">盯上 ChatBear »</a>
				</p>
			</div>
		</div>


		<!-- 关于About -->
		<div class="row" id="about">
			<div class="span12">
				<h2 class="icon-line">
					<span>About</span>
				</h2>
			</div>
			<div class="span12">
				<h2>
					<a href="#">ChatBear</a> 是什么呢？ <span class="muted"><small>下面做一个简单的说明.</small>
					</span>
				</h2>
				<p class="lead">它当然不是一只熊，它是我即兴起的名字...O(∩_∩)O哈哈~老实说我也不知道怎么介绍，或许这会是一个很独特的产品，但是单就目前而言，它离‘产品’差的还是比较远。</p>
				<p class="lead text-info">
					我是打算把ChatBear做成一个即时的即兴聊天平台。不知道这样定义准不准确，具体来说就是完成后的该平台具备下面的这些特征：</p>
				<div class="row">
					<div class="span3">
						<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/about1.png" />
						<p class="text-success">不管是否登录，访问本网站的用户都可以接收来自系统自动推送的消息。</p>
					</div>
					<div class="span3">
						<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/about2.png" />
						<p class="text-success">系统推送的消息，若用户不进行操作，则一段时间后自动隐藏。</p>
					</div>
					<div class="span3">
						<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/about3.png" />
						<p class="text-success">消息是系统即时筛选的，并在一定过滤后推送给用户。</p>
					</div>
					<div class="span3">
						<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/about4.png" />
						<p class="text-success">用户可以对接收到的任意消息进行回复。</p>
					</div>
				</div>

			</div>
		</div>

		<!-- 联系Contact -->
		<div class="row" id="contact">
			<div class="span12">
				<h2 class="icon-line">
					<span>Contact</span>
				</h2>
			</div>
			<div class="span8 offset2">
				<div class="row-fluid">
					<div id="conCarousel" class="carousel slide">
						<div class="carousel-inner">
							<div class="item active">
								<div class="span1 offset2">
									<p class="ar">
										<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/big-quote.png"
											alt="" />
									</p>
								</div>
								<div class="span7">
									<blockquote>
										<p>
											"刚收到<span class="label label-info">前女友</span>发给我过几天<span
												class="label label-error">结婚</span>的信息：<span
												class="label label-info">我结婚</span>你来吗，我默默回了<span
												class="label label-error">三</span>个字：<span
												class="label label-important">下次</span>去。。。。"
										</p>
										<small> <strong>冷笑话精选</strong> 新浪微博, <a
											title="weibo.com" target="_blank" href="http://weibo.com">weibo.com</a>
										</small>
									</blockquote>
								</div>
							</div>
							<div class="item">
								<div class="span1 offset2">
									<p class="ar">
										<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/big-quote.png"
											alt="" />
									</p>
								</div>
								<div class="span7">
									<blockquote>
										<p>
											"<span class="label label-info">哈特菲尔德</span>的研究表明：人们<span
												class="label label-error">接触</span>的时间越长，越容易产生友谊或<span
												class="label label-important">爱情</span>。一 名男子给女友写了<span
												class="label label-important">700</span>封信，最后……最后……女友嫁给了<span
												class="label">邮递员</span>。。。"
										</p>
										<small> <strong>冷笑话精选</strong> 新浪微博, <a
											title="weibo.com" target="_blank" href="http://weibo.com">weibo.com</a>
										</small>
									</blockquote>
								</div>
							</div>
							<div class="item">
								<div class="span1 offset2">
									<p class="ar">
										<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/big-quote.png"
											alt="" />
									</p>
								</div>
								<div class="span7">
									<blockquote>
										<p>
											" 在<span class="label label-info">quora</span>上看到有人问：“当你<span
												class="label label-important">进退两难的时候如何做出决定</span>？”下面有
											人回答：“抛硬币，当你第一次抛了以后想<span class="label">再抛一次</span>的时候，你就已经知道答案了。"
										</p>
										<small> <strong>豆丁网</strong> 新浪微博, <a
											title="weibo.com" target="_blank" href="http://weibo.com">weibo.com</a>
										</small>
									</blockquote>
								</div>
							</div>
							<div class="item">
								<div class="span1 offset2">
									<p class="ar">
										<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/big-quote.png"
											alt="" />
									</p>
								</div>
								<div class="span7">
									<blockquote>
										<p>
											"<span class="label label-warning">俺</span> 一直想找人<span
												class="label label-success">说说话</span> ，可是没人愿意<span
												class="label label-error">亲近俺</span>。难道是俺不够<span
												class="label label-info">萌</span> 么？ 是<span
												class="label label-warning">俺</span>年纪大了么？可是<span
												class="label label-warning">俺</span>才1岁啊...<span
												class="label">主人</span>也不许俺乱说话，俺可怎么办啊~~（哭）"
										</p>
										<small> <strong>ChatBear</strong> WNJava, <a
											title="wnjava.com" target="_blank" href="http://wnjava.com">wnjava.com</a>
										</small>
									</blockquote>
								</div>
							</div>
						</div>
						<a href="#conCarousel" data-slide="prev"
							class="carousel-control left">‹</a> <a href="#conCarousel"
							data-slide="next" class="carousel-control right">›</a>
					</div>
				</div>
			</div>
			<div class="span12">
				<div class="span9 offset1 alert alert-success">
					<h4>
						有什么想和我们<span class="label label-warning">聊</span>的么？有什么必须和我们<span
							class="label label-warning">聊</span>的么？有什么一定要和我们<span
							class="label label-warning">聊</span>......咳咳....在这里就可以！
					</h4>
				</div>
				<div class="span10 offset2">
					<form class="form-inline" id="contact_form">
						<div class="row-fluid">
							<div class="input-prepend span3">
								<span class="add-on"><i class="icon-user"></i> </span><input
									id="name" type="text" placeholder="姓名" />
							</div>
							<div class="input-prepend span3">
								<span class="add-on"><i class="icon-envelope"></i> </span><input
									id="email" type="text" placeholder="邮箱" />
							</div>
							<div class="input-prepend span3">
								<span class="add-on"><i class="icon-home"></i> </span><input
									id="webSite" type="text" placeholder="网站" />
							</div>
						</div>
						<div class="row-fluid">
							<textarea class="contact_textarea" id="textarea" rows="5">
							</textarea>
						</div>
						<div class="row-fluid span6 offset2">
							<a href="#" class="btn btn-large btn-success">提交</a> <a href="#"
								class="btn btn-large offset1">清空</a>
						</div>

					</form>
				</div>
			</div>
		</div>




		<!-- 历程 -->
		<div class="row" id="progress">
			<div class="span12">
				<h2 class="icon-line">
					<span>历程</span>
				</h2>
			</div>
			<div class="span12">
				<ul>
					<li>ChatBear一开始我想延续WNJava的命名，起了一个WNBear的名字，后来更名为Chat Bear.</li>
					<li>采用Bootstrap作为前台的框架，省去了我许多的对页面和样式的设计，这对于已经开发了WNJava，全部页面和样式手动设计的我来说，无疑解放了我
						大量的工作时间。项目从2013-06-01完成了静态页面的整体规划，后续几天我连续的进行工作，主要是学习怎样使用Bootstrap.</li>
					<li>到06-03的时候，继续添加了 登录和注册的页面（均为静态页面）.</li>
					<li>之后从06-04开始，我开始设计简单网络爬虫平台，并在06-07提交了一个简单可用的版本。爬虫对我来讲是新领域，在借鉴了
						别人的代码之后，我重写了适合ChatBeat系统的爬虫平台，并测试通过.</li>
						<li>截至7-5，推送系统的主题功能已经完成，可以直观的看到结果了~，当然，后续还需要更多的细节上，可用性，易用性上的修正.</li>
				</ul>
			</div>
		</div>


		<!-- 示例 -->
		<div class="row" id="example">
			<div class="span12">
				<h2 class="icon-line">
					<span>示例</span>
				</h2>
			</div>
			<div class="span12">
				<ul>
					<li><h3 class="lead">预览推送框显示效果</h3> <a
						onclick="javascript:showMsg('测试消息显示效果~');"
						class="btn btn-large btn-success">显示效果1</a> <a
						onclick="javascript:showMsg('测试消息显示效果~');"
						class="btn btn-large btn-success">显示效果2</a> <a
						onclick="javascript:showMsg('测试消息显示效果~');"
						class="btn btn-large btn-success">显示效果3</a></li>
					<li><h3 class="lead">推送系统个人设置</h3>
						<ul class="inline">
							<li><span class="label label-info">推送开关</span>
								<div id="mySwitch1" class="switch switch-small" data-on="primary" data-off="info">
									<input type="checkbox" checked />
								</div></li>
							<li><span class="label label-info">是否推送《糗事百科--热门》</span>
								<div id="mySwitch2" class="switch switch-small" data-on="primary" data-off="info">
									<input type="checkbox" checked />
								</div></li>
							<li><span class="label label-info">是否推送《新浪新闻--世界各地》</span>
								<div id="mySwitch3"  class="switch switch-small" data-on="primary" data-off="info">
									<input type="checkbox" checked />
								</div></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</div>































	<!-- 底部 -->
	<footer class="footer">
	<div class="container">
		<div class="row">
			<div class="span3">
				<h5>作品</h5>
				<a target="_blank" href="<%=ConstantsUtil.FW_DOMAIN%>">wnJava社区</a><br />
				<a href="#">java迭代打包工具</a><br /> <a href="#">Help</a><br /> <a
					target="_blank" href="#">开发者 /API</a>
			</div>
			<div class="span3">
				<h5>About</h5>
				<a href="#about">关于 WNChat</a> <br /> <a href="#">历程</a> <br /> <a
					href="#">Core Technology</a> <br />
			</div>
			<div class="span3">
				<h5>友情链接：</h5>
				<a target="_blank" href="http://baipeng.alwaysdata.net">BAI
					Peng's</a><br /> <a target="_blank" href="http://www.eamonning.com">清泉逐流</a>
			</div>
			<div class="span3">
				<p>
					<img src="<%=ConstantsUtil.FW_DOMAIN%>/img/chat/bear.png"
						alt="Chat Bear" /><br />
				</p>
			</div>
		</div>
		<div class="row">
			<div class="span9">
				<hr class="featurette-divider" />
				&copy; 2013
				京ICP备13011487号.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				all designed by <a
					href="<%=ConstantsUtil.FW_DOMAIN%>/action/system/mainpage/1">偷懒的熊</a>
			</div>
		</div>
	</div>
	</footer>




	<!-- js file -->
	<script language="javascript" type="text/javascript"
		src="<%=ConstantsUtil.FW_DOMAIN%>/js/jquery-1.8.2.js"></script>
	<script type="text/javascript"
		src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript"
		src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/switch/bootstrapSwitch.js"></script>

	<script type="text/javascript"
		src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/js/underscore-1.4.4.js"></script>

	<script type="text/javascript"
		src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/js/backbone-0.9.10.js"></script>
	<script type="text/javascript"
		src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/messenger/js/messenger.js"></script>
	<script type="text/javascript">
		var count1 = 0;
		var count2 = 0;
		$(function() {
			//轮播
			$('#topCarousel').carousel({
				interval : 6000
			});
			$('#conCarousel').carousel({
				interval : 7000
			});
			getMsg(1, 1);
		});
		
		var _MsgOn = true;
		var _SiteONE = true;
		var _SiteTWO = true;
		
		//开关事件处理
		$('#mySwitch1').on('switch-change', function(e, data) {
			value = data.value;
			if(value) {
				_MsgOn = true;
				getMsg(1,count1);
			}else {
				_MsgOn = false;
			}
		});
		//开关事件处理
		$('#mySwitch2').on('switch-change', function(e, data) {
			  value = data.value;
			  if(value) {
					_SiteONE = true;
					getMsg(1,count1);
				}else {
					_SiteONE = false;
				}
		});
		//开关事件处理
		$('#mySwitch3').on('switch-change', function(e, data) {
			  value = data.value;
			  if(value) {
					_SiteTWO = true;
					getMsg(2,count2);
				}else {
					_SiteTWO = false;
				}
		});
		
		function showMsg(msg) {
			var msgD = $.globalMessenger().post({
				message : msg,
				hideAfter : 15,
				actions : {
					retry : {
						label : '回复',
						auto : false,
						action : function() {
						}
					},
					cancel : {
						action : function() {
							return msgD.cancel();
						}
					}
				}
			});
		}

		//获取推送的消息
		function getMsg(msgId, count) {
			if (msgId == 1) {
				count1++;
			} else if (msgId == 2) {
				count2++;
			}
			if(_MsgOn) {
				$.getJSON("/getmsgajax.do", {
					id : msgId,
					count : count
				}, function(json) {
					$(json).each(function(i) {
						showMsg(json[i].msg);
						if (json[i].isEnd == "true") {
							if (msgId == 1) {
								count1 = 0;
							} else if (msgId == 2) {
								count2 = 0;
							}
						}
						if (Math.ceil(Math.random() * 10) > 5&&_SiteONE) {
							getMsg(1, count1);
						} else if(_SiteTWO) {
							getMsg(2, count2);
						}
					});
				});	
			}
		}
	</script>
</body>
</html>