<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${webName}-密码找回</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
	<link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-0.1.tip.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.passwordStrength.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/fetchPsw.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="register">
	<div class="resulr">
		<div class="tab_title">
			<a class="tab_email tab_hover" title="邮箱找回密码" href="${webRoot}/fetchPsw/fetchPsw.ac">邮箱找回密码</a>
			<a class="tab_mobile tab_out" title="手机号找回密码" href="${webRoot}/fetchPsw/fetchPswByPhone.ac">手机号找回密码</a>
		</div>
		<div class="findPassword">
			<h1 style="font-size:22px;">请输入您的电子邮件地址，我们将把您的密码发送到您的邮箱里：</h1>
			<div class="fixBox">
				<label>请填写你的E-mail地址：</label>
				<div class="put"><input id="email" name="email" type="text" tabindex="1" maxlength="32" /></div>
				<div class="clear"></div>
			</div>
			<div class="fixBox">
				<label>验证码：</label>
				<div class="put"><input class="code" type="text"  name="code" id="code"  maxlength="4" tabindex="2"/></div>
				<div class="codeImg"><img id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'> <a href="javascript:void(0)" onclick="changValidateCode();return false;">换一个</a></div>
				<div class="clear"></div>
			</div>
			<div class="btn"><a href="javascript:void(0);" id="fetchSubmit">提交</a></div>
		</div>
	</div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
