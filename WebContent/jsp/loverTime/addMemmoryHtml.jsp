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
		<label class="control-label" for="inputEmail">起个名字</label>
		<div class="controls">
			<input type="text" class="span4" id="loverName" placeholder="这段记忆的简略词">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="inputEmail">具体安排</label>
		<div class="controls">
			<textarea  class="span4" placeholder="大概都做了什么？" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="inputEmail">地点</label>
		<div class="controls">
			<input type="text"  class="span4" placeholder="在哪儿？">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">天气如何</label>
		<div class="controls inline">
			<div class="span1">
				<input type="radio" checked="checked" name="gender" value="1" /> 晴天
			</div>
			<div class="span1">
				<input type="radio" name="gender" value="2" /> 阴天
			</div>
			<div class="span1">
				<input type="radio" name="gender" value="3" /> 有雨
			</div>
			<div class="span1">
				<input type="radio" name="gender" value="4" /> 下雪了
			</div>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" >心情如何</label>
		<div class="controls">
			<input type="text"  class="span4" id="loverName" placeholder="期待？开心？郁闷？失望？激动？...">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" >穿着</label>
		<div class="controls">
			<input type="text"  class="span4" id="loverName" placeholder="想想都穿了啥衣服？">
		</div>
	</div>

	<div class="control-group">
		<label class="control-label" for="inputPassword">时间</label>
		<div class="controls date form_datetime"
			data-date-format="yyyy MM dd - HH:ii p" data-link-field="dtp_input1">
			<input size="16" type="text" value="" readonly> <span
				class="add-on"><i class="icon-remove"></i> </span> <span
				class="add-on"><i class="icon-th"></i> </span>
		</div>
		<input type="hidden" id="dtp_input1" value="" />
	</div>
	<div class="control-group">
		<label class="control-label" for="inputEmail">上传照片</label>
		<div class="controls">
			<input type="file" id="loverName" />
		</div>
	</div>

	<div class="control-group">
		<div class="controls">
			<a data-type="pjax" class="button button-alt"
				href="<%=ConstantsUtil.FW_DOMAIN%>/action/lovertime/saveloverInfo">保存下来
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
</script> </section>