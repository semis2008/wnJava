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

<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/editor/editor.js"></script>
<script type="text/javascript"
	src="<%=ConstantsUtil.FW_DOMAIN%>/plugin/editor/hotkey.js"></script>
<script language="javascript" type="text/javascript">
	$(function() {
		$('#editor').wysiwyg();
	});

	function newDiary() {
		var diaryContent = $("#editor").html();
		if (diaryContent == "") {
			showErrorMsg("内容不能为空！");
			return false;
		}
		var title = $("#diaryTitle").val();
		var tags = $("#diaryTags").val();

		if ($.trim(title) == "") {
			showErrorMsg("标题不能为空！");
			return false;
		}
		$
				.ajax({
					type : "POST",
					url : "/action/diary/newdiary",
					data : {
						title : title,
						tags : tags,
						diaryContent : diaryContent
					},
					dataType : "text",
					success : function(msg) {
						if ("imgError" == msg) {
							showErrorMsg("上传的图片总大小不能超过12M!");
							return false;
						} else if (msg < 0) {
							showErrorMsg("发布失败，系统正在维护中...");
							return false;
						} else {
							showSuccessMsg("发布成功！点击查看<a target='_self' href='../system/diarydetail/"+msg+"'>日志详情</a>~");
						}
					}
				});
	}
</script>
<title>wnJava--写日志</title>
	<div>
		<div class="padding-small">
			<div class="input-prepend">
				<span class="add-on"><i class="icon-quote-left"></i> </span><input
					type="text" id="diaryTitle" name="diaryTitle" class="span6"
					placeholder="点击输入标题" required />
			</div>
			<span class="muted">标题尽量简明扼要要好哦~</span>
		</div>

		<div class="padding-small">
			<div class="btn-toolbar" data-role="editor-toolbar"
				data-target="#editor">
				<div class="btn-group">
					<a class="btn dropdown-toggle" data-toggle="dropdown" title="字体"
						data-original-title="Font"><i class="icon-font"></i><b
						class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li><a data-edit="fontName Micro YAHEI"
							style="font-family: 'Micro YAHEI'">微软雅黑</a></li>
						<li><a data-edit="fontName 楷体" style="font-family: '楷体'">楷体</a>
						</li>
						<li><a data-edit="fontName 黑体" style="font-family: '黑体'">黑体</a>
						</li>
						<li><a data-edit="fontName Serif"
							style="font-family: 'Serif'">Serif</a></li>
						<li><a data-edit="fontName Sans" style="font-family: 'Sans'">Sans</a>
						</li>
						<li><a data-edit="fontName Arial"
							style="font-family: 'Arial'">Arial</a></li>
						<li><a data-edit="fontName Comic Sans MS"
							style="font-family: 'Comic Sans MS'">Comic Sans MS</a></li>
						<li><a data-edit="fontName Helvetica"
							style="font-family: 'Helvetica'">Helvetica</a></li>
						<li><a data-edit="fontName Times New Roman"
							style="font-family: 'Times New Roman'">Times New Roman</a></li>
						<li><a data-edit="fontName Verdana"
							style="font-family: 'Verdana'">Verdana</a></li>
					</ul>
				</div>
				<div class="btn-group">
					<a class="btn dropdown-toggle" data-toggle="dropdown" title="字体大小"
						data-original-title="Font Size"><i class="icon-text-height"></i>&nbsp;<b
						class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li><a data-edit="fontSize 5"><font size="5">Huge</font>
						</a></li>
						<li><a data-edit="fontSize 3"><font size="3">Normal</font>
						</a></li>
						<li><a data-edit="fontSize 1"><font size="1">Small</font>
						</a></li>
					</ul>
				</div>
				<div class="btn-group">
					<a class="btn" data-edit="bold" title="粗体"
						data-original-title="Bold (Ctrl/Cmd+B)"><i class="icon-bold"></i>
					</a> <a class="btn" data-edit="italic" title="斜体"
						data-original-title="Italic (Ctrl/Cmd+I)"><i
						class="icon-italic"></i> </a> <a class="btn" data-edit="strikethrough"
						title="贯穿线" data-original-title="Strikethrough"><i
						class="icon-strikethrough"></i> </a> <a class="btn"
						data-edit="underline" title="下划线"
						data-original-title="Underline (Ctrl/Cmd+U)"><i
						class="icon-underline"></i> </a>
				</div>
				<div class="btn-group">
					<a class="btn" data-edit="insertunorderedlist" title=""
						data-original-title="Bullet list"><i class="icon-list-ul"></i>
					</a> <a class="btn" data-edit="insertorderedlist" title=""
						data-original-title="Number list"><i class="icon-list-ol"></i>
					</a> <a class="btn" data-edit="outdent" title=""
						data-original-title="Reduce indent (Shift+Tab)"><i
						class="icon-indent-left"></i> </a> <a class="btn" data-edit="indent"
						title="" data-original-title="Indent (Tab)"><i
						class="icon-indent-right"></i> </a>
				</div>
				<div class="btn-group">
					<a class="btn btn-info" data-edit="justifyleft" title=""
						data-original-title="Align Left (Ctrl/Cmd+L)"><i
						class="icon-align-left"></i> </a> <a class="btn"
						data-edit="justifycenter" title=""
						data-original-title="Center (Ctrl/Cmd+E)"><i
						class="icon-align-center"></i> </a> <a class="btn"
						data-edit="justifyright" title=""
						data-original-title="Align Right (Ctrl/Cmd+R)"><i
						class="icon-align-right"></i> </a> <a class="btn"
						data-edit="justifyfull" title=""
						data-original-title="Justify (Ctrl/Cmd+J)"><i
						class="icon-align-justify"></i> </a>
				</div>
				<div class="btn-group">
					<a class="btn" title="上传的图片总大小不能超过12M" id="pictureBtn"
						data-original-title="Insert picture (or just drag &amp; drop)"><i
						class="icon-picture"></i> </a> <input type="file"
						data-role="magic-overlay" data-target="#pictureBtn"
						data-edit="insertImage"
						style="opacity: 0; position: absolute; top: 0px; left: 0px; width: 41px; height: 30px;" />
				</div>
				<div class="btn-group">
					<a class="btn" data-edit="undo" title=""
						data-original-title="Undo (Ctrl/Cmd+Z)"><i class="icon-undo"></i>
					</a> <a class="btn" data-edit="redo" title=""
						data-original-title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i>
					</a>
				</div>
				<input type="text" data-edit="inserttext" id="voiceBtn"
					x-webkit-speech="" style="display: none;" />
			</div>

			<div id="editor" contenteditable="true"></div>
		</div>
		<div class="padding-small">
			<div class="input-prepend">
				<span class="add-on"><i class="icon-tags"></i> </span><input
					type="text" id="diaryTags" name="diaryTags" class="input-large"
					placeholder="标签" required />
			</div>
			<small class="muted">不同标签之间用空格隔开即可~</small>
		</div>
		<div class="padding-small margin-bottom-middle">
			<button class="btn btn-success" onclick="newDiary()">发布</button>
			<button type="reset" class="btn">清空</button>
		</div>
	</div>

