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
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/jquery.validate.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/fetchPswByPhone.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="register">
	<div class="resulr">
		<%--<div class="tab_title">
			<a class="tab_mobile tab_hover" title="手机号找回密码" href="${webRoot}/fetchPsw/fetchPswByPhone.ac">手机号找回密码</a>
		</div>--%>

			<div class="tab_title">
				<a class="tab_email tab_out" title="邮箱找回密码" href="${webRoot}/fetchPsw/fetchPsw.ac">邮箱找回密码</a>
				<a class="tab_mobile tab_hover" title="手机号找回密码" href="${webRoot}/fetchPsw/fetchPswByPhone.ac">手机号找回密码</a>
			</div>
		<form method="post" id="fetchPswForm" name="fetchPswForm" >
			<div class="findPassword">
			<h1 style="font-size:22px;padding-left: 190px;">找回密码</h1>
			<div class="fixBox mobileRegClass">
				<label>手机号：</label>
				<div class="put">
					<input maxlength="11" id="userMobile" name="userMobile" type="text" placeholder="请输入手机号码"/></div>
				<div class="pass" style="display:none;margin-top:5px;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" style="margin-left: 5px;"/></div>
				<div class="tips" id="mobileTip" style="display:none; width:auto;">
					<div class="l-l"></div>
					<div class="t-b" style="margin:5px;"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" style="margin-left: 5px;"/>&nbsp;<span></span>&nbsp;</div>
					<div class="r-l"></div>
					<div class="clear"></div>
				</div>
			</div>
			<%--<div class="fixBox">
				<label>验证码：</label>
				<div class="put" style="width:90px;"><input style="width:80px;" class="code" type="text"  name="validateCode" id="validateCode"  maxlength="4" tabindex="3"/></div>
				<div class="codeImg" style="float:left;margin-top: 3px;"><img style="float:left" id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'> <a href="#" onclick="changValidateCode();return false;" style="display: block;float: left;margin-left: 5px;padding-top: 5px;">看不清？换一个</a>&nbsp;<span></span>&nbsp;</div>
				<div class="tips" id="checkValidateCodeTip" style="display: none; width:auto;">
					<div class="l-l"></div>
					<div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
					<div class="r-l"></div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>--%>
			<div class="fixBox mobileRegClass">
				<label>验证码：</label>
				<div class="put"><input maxlength="6" id="messageCode" name="messageCode" type="text" placeholder="请输入验证码" style="width: 104px;"/></div>
				<div class="sendCode">
					<input type="button" id="sendValidateNumBtn" onclick="sendValidateNum(this);" value="发送验证码" />
				</div>
				<div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" style="margin-left: 5px;"/></div>
				<div class="tips" id="messageCodeTip" style="display:none; width:auto;">
					<div class="l-l"></div>
					<div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" style="margin-left: 5px;"/>&nbsp;<span></span>&nbsp;</div>
					<div class="r-l"></div>
					<div class="clear"></div>
				</div>
			</div>
			<%--新密码start--%>
			<div class="fixBox boxDiv">
				<label>新密码：</label>
				<div class="put"><input maxlength="16" name="userPsw" onclick="return checkPsw()" onblur="return checkPsw()"  id="userPsw" type="password" /></div>
				<div class="pass" style="display:none;margin-top:5px;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" style="margin-left: 5px;"/></div>
				<div class="tips" id="userPswTip" style="display: none; width:auto;">
					<div class="l-l"></div>
					<div class="t-b" style="margin-top:5px;"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" style="margin-left: 5px;"/>&nbsp;<span></span>&nbsp;</div>
					<div class="r-l"></div>
					<div class="clear"></div>
				</div>
			</div>
			<div class="fixBox boxDiv">
				<label>密码确认：</label>
				<div class="put"><input maxlength="16" name="checkPassword"  onclick="return cheCkcheckPsw()" onblur="return cheCkcheckPsw()" id="checkPassword" type="password" /></div>
				<div class="pass" style="display:none;margin-top: 5px;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" style="margin-left: 5px;"/></div>
				<div class="tips" id="checkPasswordTip" style="display: none; width:auto;">
					<div class="l-l"></div>
					<div class="t-b" style="margin-top: 5px;"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" style="margin-left: 5px;"/>&nbsp;<span></span>&nbsp;</div>
					<div class="r-l"></div>
					<div class="clear"></div>
				</div>
			</div>
			<%--新密码end--%>
			<div class="btn boxConfirm"><a href="javascript:void(0);" id="fetchSubmit">验证</a></div>
			<div class="btn boxDiv"><a href="javascript:void(0);" id="fetchPassword">修改密码</a></div>
		</div>
		</form>
	</div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
