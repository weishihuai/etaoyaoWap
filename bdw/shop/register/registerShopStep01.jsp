<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>填写商家信息-供应商入驻-${webName}</title>
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <c:set value="${sdk:getSysParamValue('sendSmsFrequency')}" var="seconds"></c:set>           <!--倒计时间-->
	<link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",  countDown: "yes",smsSeconds:"${seconds}" };
    </script>
    <link href="${webRoot}/template/bdw/shop/register/statics/css/registered.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/main.js"></script>
	<script type="text/javascript" src="${webRoot}/commons/js/localStorage.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/shop/register/statics/js/tip.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/shop/register/statics/js/registerShopStep01.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.md5.js"></script>

</head>



<body>
<%--页头开始--%>
<%@ include file="/template/bdw/shop/register/registerShopHeader.jsp" %>
<%--页头结束--%>

	<!--主体-->
	<div class="main-bg">
		<div class="main">
			<div class="mt step01"><!-- step01就是第一步，step02就是第二步 -->
				<div class="mt-item m1">
					1.账号注册
					<span class="after"></span>
				</div>
				<div class="mt-item m2">
					2.填写入驻企业信息
					<span class="after"></span>
					<span class="before"></span>
				</div>
				<div class="mt-item m3">
					3.提交审核
					<span class="after"></span>
					<span class="before"></span>
				</div>
				<div class="mt-item m4">
					4.开通商家
					<span class="before"></span>
				</div>
			</div>
			<div class="step01-mc">
				<div class="info-cont">
					<div class="ic-item">
						<span>账号名称</span>
						<div class="mrt">
                            <input type="text" id="registerLoginId" name="loginId" maxlength="20" type="text">
							<p>作为登录帐号，填写未被${webName}平台注册的账号</p>
						</div>
                        <a id="registerLoginIdTip"> </a>
                        <div id="registerLoginIdTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
					</div>
					<div class="ic-item">
						<span>密码</span>
						<div class="mrt">
                            <input maxlength="16" name="userPsw"  id="userPsw"  <%--onblur="return checkPsw()"--%> type="password">
							<p>密码必须包含数字、字母，区分大小写，最短8位，区分大小写</p>
						</div>
                        <a id="userPswTip"> </a>
                        <div id="userPswTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
					</div>
					<div class="ic-item">
						<span>再次输入密码</span>
						<div class="mrt">
                            <input maxlength="16" name="checkPassword" id="checkPassword" <%-- onblur="return cheCkcheckPsw()" --%> type="password">
						</div>
                        <a id="checkPasswordTip"> </a>
                        <div id="checkPasswordTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
					</div>
					<div class="ic-item">
						<span>联系邮箱</span>
						<div class="mrt">
                            <input id="email" name="email" type="text" maxlength="64">
							<p>填写未被${webName}平台注册的邮箱</p>
						</div>
                        <a id="emailTip"> </a>
                        <div id="emailTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
					</div>
					<div class="ic-item">
						<span>手机号码</span>
						<div class="mrt">
                            <input id="mobile" name="mobile" type="text" maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
							<p>完成验证后，你可以用该手机登录和找回密码</p>
						</div>
                        <a id="mobileTip"> </a>
                        <div id="mobileTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
					</div>
					<div class="ic-item">
						<span>手机验证码</span>
						<div class="mrt">
							<input type="text" style="width: 210px;" maxlength="6"  name="validateCode" id="validateCode">
							<button   id="sendValidateCode" onclick="sendValidateCode()" class="yzm-btn">发送手机验证码</button>
                            <a id="validateCodeTip"> </a>
                            <div id="validateCodeTipError" class="message" style=" float: none; margin-left: 415px"><i></i></div>
							<div class="agree">
								<label class="selected">我同意并遵守</label>
								<a href="javascript:;" onclick="showRegisterProvisions()" class="protocol">《${webName}服务协议》</a>
							</div>
						</div>
					</div>
				</div>
				<div class="mc-bot">
					<a onclick="checkShopStep01()" class="next-btn" style="cursor: pointer;">下一步</a>
				</div>
			</div>
		</div>
	</div>


<div class="layer registerProvisions" style="display: none">
    <div class="agreement">
        <div class="mt">
            <span>${webName}服务协议</span>
            <a href="javascript:;" onclick="$('.registerProvisions').hide();" class="del"></a>
        </div>
        <div class="mc">
            ${sdk:getSysParamValue('register_provisions_shop')}
        </div>
        <div class="mb"><a href="javascript:;" class="btnConfirm">确认</a></div>
    </div>
</div>


<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>

</html>