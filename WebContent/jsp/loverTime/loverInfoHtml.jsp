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
	<span><i class="icon-user"></i> 设置TA</span>
</h3>
<form class="form-horizontal">
	<div class="control-group">
		<label class="control-label" for="loverName">姓名</label>
		<div class="controls">
			<input type="text" id="loverName" placeholder="姓名">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">性别</label>
		<div class="controls inline">
			<div class="span1">
				<input type="radio" checked="checked" name="gender" value="1" /> 女
			</div>
			<div class="span1">
				<input type="radio" name="gender" value="2" /> 男
			</div>
		</div>
	</div>
	<div class="control-group">
			<label class="control-label" for="inputBir">TA的生日</label>
			<div class="controls date form_datetime" id="inputBir"
				data-date-format="yyyy MM dd - HH:ii p" data-link-field="time_bir">
				<input size="16" type="text" value="" readonly> <span
					class="add-on"><i class="icon-remove"></i>
				</span> <span class="add-on"><i class="icon-th"></i>
				</span>
			</div>
			<input type="hidden" id="time_bir" value="" /> 
	</div>
	<div class="control-group">
			<label class="control-label" for="inputFir">初次见面时间</label>
			<div class="controls date form_datetime" id="inputFir"
				data-date-format="yyyy MM dd - HH:ii p" data-link-field="time_fir">
				<input size="16" type="text" value="" readonly> <span
					class="add-on"><i class="icon-remove"></i>
				</span> <span class="add-on"><i class="icon-th"></i>
				</span>
			</div>
			<input type="hidden" id="time_fir" value="" /> 
	</div>

	<div class="control-group">
		<div class="controls">
			<a class="button button-alt" href="javascript:void(0);" onclick="saveLoverInfo()">保存 <i
							class="icon-save"></i> </a> 
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
	function saveLoverInfo() {
		var name = $("#loverName").val();
		var gender = $("input[name='gender']:checked").val();
		var birthday = $("#time_bir").val();
		var meetday = $("#time_fir").val();
		
		$
		.ajax({
			type : "POST",
			url : "/action/lovertime/saveLoverInfo",
			data : {
				name : name,
				gender : gender,
				birthday : birthday,
				meetTime : meetday
			},
			dataType : "text",
			success : function(msg) {
				if (msg < 0) {
					showErrorMsg("设置失败，系统正在维护中...");
					return false;
				} else {
					showSuccessMsg("设置成功！");
				}
			}
		});
	}
	
	
	
</script> </section>