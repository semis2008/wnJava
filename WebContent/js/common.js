//判断浏览器类型
function getOs() {  
	var OsObject = "";  
	if(navigator.userAgent.indexOf("MSIE")>0) {  
		return "MSIE";  
	}  
	if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
		return "Firefox";  
	}  
	if(isSafari=navigator.userAgent.indexOf("Safari")>0) {  
		return "Safari";  
	}   
	if(isCamino=navigator.userAgent.indexOf("Camino")>0){  
		return "Camino";  
	}  
	if(isMozilla=navigator.userAgent.indexOf("Gecko/")>0){  
	     return "Gecko";  
	}  
}  
function goToTop() {
	$('body,html').animate({
		scrollTop : 0
	}, 1000);
}

// 用户相关
function userLogin(){
	var email = $("#txtEmailLogin").val();
	var pass = $("#txtPasswordLogin").val();
	// 非空验证
	if (email == "") {
		showErrorMsg("邮箱不能为空！");
		return;
	}
	if (pass == "") {
		showErrorMsg("密码不能为空！");
		return;
	}
	// 验证邮箱格式
	var emailRegExp = new RegExp(
			"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
	if (!emailRegExp.test(email) || email.indexOf('.') == -1) {
		showErrorMsg("您输入的邮箱格式不正确！");
		return;
	}
	// 异步登录
	$.ajax({
		type : "POST",
		url : "/action/user/login",
		data : {
			email : email,
			pass : pass
		},
		dataType : "text",
		success : function(msg) {
			if("email_error" == msg) {
				showErrorMsg("帐号不存在！");
				return;
			}else if ("success" == msg) {
				parent.location.reload();
				return;
			} else {
				showErrorMsg("对不起，登录失败：系统正在维护~");
			}
		}
	});
	
}

function userRegist() {
	var email = $.trim($("#txtEmailAddressRegist").val());
	var name = $.trim($("#txtNameRegist").val());
	var pass = $.trim($("#txtPasswordRegist").val());
	var pass_con = $.trim($("#txtPasswordCon").val());
	var randImg = $("#txtRandImg").val();
	
	// 非空验证
	if (email == "") {
		showErrorMsg("邮箱不能为空！");
		return;
	}
	if (name == "") {
		showErrorMsg("昵称不能为空！");
		return;
	}
	if (pass == "") {
		showErrorMsg("密码不能为空！");
		return;
	}
	if (pass_con == "") {
		showErrorMsg("确认密码不能为空！");
		return;
	}
	// 验证邮箱格式
	var emailRegExp = new RegExp(
			"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
	if (!emailRegExp.test(email) || email.indexOf('.') == -1) {
		showErrorMsg("您输入的邮箱格式不正确！");
		return;
	}
	// 验证密码
	if (pass != pass_con) {
		showErrorMsg("密码不一致！");
		return;
	}
	$
			.ajax({
				type : "POST",
				url : "/action/user/regist",
				data : {
					email : email,
					pass : pass,
					name : name,
					randImg : randImg
				},
				dataType : "text",
				success : function(msg) {
					if("randCode_error" == msg) {
						showErrorMsg("验证码错误！");
						return;
					}else if ("email_error" == msg) {
						showErrorMsg("邮箱已经被注册！");
						$('#registModal').modal('hide');
					} else {
						if ("success" == msg) {
							showSuccessMsg("恭喜您，注册成功!");
							$('#registModal').modal('hide');
						} else {
							showErrorMsg("对不起，注册失败:系统正在维护中~");
							$('#registModal').modal('hide');
						}
					}
				}
			});
}

function showErrorMsg(msg) {
	var msgD = $.globalMessenger().post({
		message : msg,
		type : 'error'
	});
}
function showSuccessMsg(msg) {
	var msgD = $.globalMessenger().post({
		message : msg,
		type : 'success'
	});
}
function userQuit() {
 	$.ajax({
		type : "POST",
		url : "/action/user/userquit",
		dataType : "text",
		success : function(msg) {
			location.reload();
		}
 	});
}
function leaveMsg(type) {
	var content = $("#leave-msg-content").val();
	var name = $("#leave-msg-name").val();
	var email = $("#leave-msg-email").val();
	
	if(type=="1") {
		if (name == "") {
			showErrorMsg("名字不能为空~");
			return;
		}
		if (email == "") {
			showErrorMsg("邮箱不能为空~");
			return;
		}
	}
	if (content == "") {
		showErrorMsg("还什么都没写哦~");
		return;
	}
	$.ajax({
		type : "POST",
		url : "/action/user/leavemsg",
		data : {
			msg : content,
			name : name,
			email : email,
			type : type
		},
		dataType : "text",
		success : function(msg) {
			if ("success" == msg) {
				showSuccessMsg("留言成功~");
				resetLeaveMsgForm();
				refreshLeaveMsg();
			} else {
				showErrorMsg("对不起,留言失败~系统正在维护中...");
			}
		}
	});
}
$(window).scroll(function() {
	var t = $(document).scrollTop();
	if (t >= 300) {
		showGoToTop();
	} else {
		hideGoToTop();
	}
});
function showGoToTop() {
	$(".goToTopDiv").show();
}
function hideGoToTop() {
	$(".goToTopDiv").hide();
}
function togglePlayer(){
	$(".musicbox").toggle(500);
	var title = $("#player .tag strong").text(); 
	$(".musicbox-mini marquee").text(title);
	$(".musicbox-mini").toggle(500);
}
function togglePlayList(){
	$("#playlist").toggle(500);
	
}

function changeTopDiary(id) {
	$.ajax({
		type : "POST",
		url : "/action/diary/changetopdiary",
		data : {
			id : id	
		},
		dataType : "html",
		success : function(msg) {
		  $("#topDiarySec").html(msg);
		}
	});
}

function tsina_a() {
	var s = screen;
	var d = document;
	var e = encodeURIComponent;
	var f = 'http://v.t.sina.com.cn/share/share.php?', u = d.location.href, p = ['url=', e(u), '&title=', e(d.title)].join('');
	if (!window.open([f, p].join(''), 'mb', ['toolbar=0,status=0,resizable=1,width=620,height=450,left=', (s.width - 620) / 2, ',top=', (s.height - 450) / 2].join(''))) u.href = [f, p].join('');
	}

	function ShareToTsina() {
	if (/Firefox/.test(navigator.userAgent)) { setTimeout(tsina_a, 0) } else { tsina_a() };
} 
//刷新首页留言列表
function refreshLeaveMsg() {
	$.ajax({
		type : "POST",
		url : "/action/user/refreshLeaveMsg",
		dataType : "html",
		success : function(msg) {
		  $("#leaveMsgListSec").html(msg);
		}
	});
}

//清空留言框内容
function resetLeaveMsgForm(type) {
	$("#leave-msg-content").val("");
	if(type==1) {
		$("#leave-msg-email").val("");
		$("#leave-msg-name").val("");
	}
}
