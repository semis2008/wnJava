<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.wnJava.util.DateUtil"%>
<%@page import="com.wnJava.util.StringUtil"%>
<%@page import="com.wnJava.bo.LeaveMsgBO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.wnJava.util.ConstantsUtil"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	
%>
<section>
<h3 class="major">
	<span><i class="icon-plus"></i> 添加记忆</span>
</h3>
<form class="form-horizontal">
	<div class="control-group">
		<label class="control-label" for="memName">起个名字</label>
		<div class="controls">
			<input type="text" class="span4" id="memName" placeholder="这段记忆的简略词">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="memDetail">具体安排</label>
		<div class="controls">
			<textarea  class="span4" id="memDetail" placeholder="大概都做了什么？" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="memPlace">地点</label>
		<div class="controls">
			<input type="text"  class="span4" id="memPlace" placeholder="在哪儿？">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">天气如何</label>
		<div class="controls inline">
			<div class="span1">
				<input type="radio" checked="checked" name="weather" value="晴天" /> 晴天
			</div>
			<div class="span1">
				<input type="radio" name="weather" value="阴天" /> 阴天
			</div>
			<div class="span1">
				<input type="radio" name="weather" value="有雨" /> 有雨
			</div>
			<div class="span1">
				<input type="radio" name="weather" value="下雪了" /> 下雪了
			</div>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="memMood">心情如何</label>
		<div class="controls">
			<input type="text"  class="span4" id="memMood" placeholder="期待？开心？郁闷？失望？激动？...">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="memDress">穿着</label>
		<div class="controls">
			<input type="text"  class="span4" id="memDress" placeholder="想想都穿了啥衣服？">
		</div>
	</div>

	<div class="control-group">
		<label class="control-label" for="memTimeH">时间</label>
		<div class="controls date form_datetime"
			data-date-format="yyyy MM dd - HH:ii p" data-link-field="memTime">
			<input size="16" type="text" value="" id="memTimeH" readonly> <span
				class="add-on"><i class="icon-remove"></i> </span> <span
				class="add-on"><i class="icon-th"></i> </span>
		</div>
		<input type="hidden" id="memTime" value="" />
	</div>
	<div class="control-group">
		<div class="controls">
			<a class="button button-alt"
				href="javascript:void(0);" onclick="saveMemmory()">保存下来
				<i class="icon-save"></i> </a>
		</div>
	</div>
</form>
<script type="text/javascript">
	$('input').iCheck({
		checkboxClass : 'icheckbox_square-pink',
		radioClass : 'iradio_square-pink',
		increaseArea : '20%' // optional
	});
	$('.form_datetime').datetimepicker({
		language : 'zh-CN',
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		todayHighlight : 1,
		startView : 2,
		forceParse : 0,
		showMeridian : 1
	});
	function saveMemmory() {
		var name = $("#memName").val();
		var detail = $("#memDetail").val();
		var place = $("#memPlace").val();
		var weather = $('input:radio[name="weather"]:checked').val();
		var mood = $("#memMood").val();
		var dress = $("#memDress").val();
		var time = $("#memTime").val();
		
		$
		.ajax({
			type : "POST",
			url : "/action/lovertime/saveMemmory",
			data : {
				name : name,
				detail : detail,
				place : place,
				weather : weather,
				mood : mood,
				dress : dress,
				time : time
			},
			dataType : "text",
			success : function(msg) {
				if (msg < 0) {
					showErrorMsg("保存失败，系统正在维护中...");
					return false;
				} else {
					showSuccessMsg("保存成功！");
				}
			}
		});
		
	}
	
</script> </section>