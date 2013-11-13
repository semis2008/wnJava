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
	<span><i class="icon-lightbulb"></i> 添加大事件</span>
</h3>
<form class="form-horizontal">
	<div class="control-group">
		<div class="alert alert-success span6 row">添加时间后，会记录下来，并产生相关的提醒。</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="inputPassword">恋爱时刻</label>
		<div class="controls date form_datetime"
			data-date-format="yyyy MM dd - HH:ii p" data-link-field="dtp_input1">
			<input size="16" type="text" value="" readonly> <span
				class="add-on"><i class="icon-remove"></i> </span> <span
				class="add-on"><i class="icon-th"></i> </span>
		</div>
		<input type="hidden" id="dtp_input1" value="" />
	</div>
	<div class="control-group">
		<label class="control-label" for="inputPassword">结婚时刻</label>
		<div class="controls date form_datetime"
			data-date-format="yyyy MM dd - HH:ii p" data-link-field="dtp_input1">
			<input size="16" type="text" value="" readonly> <span
				class="add-on"><i class="icon-remove"></i> </span> <span
				class="add-on"><i class="icon-th"></i> </span>
		</div>
		<input type="hidden" id="dtp_input1" value="" />
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