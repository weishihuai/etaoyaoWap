<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-会员验证-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/userCheck.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.base64.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/jquery.validate.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/additional-methods.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/userCheck.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="check">
    <div class="checkInfo">
        <form method="post" id="checkForm" name="checkForm" >
            <input value="${param.fid}" name="fid" type="hidden"/>
            <div class="l">
                <h2>会员验证：</h2>
                <div class="fixBox">
                    <label>真实姓名：</label>
                    <div class="put"><input id="realName" name="realName" maxlength="20" type="text" onclick="checkUserRealName()" onblur="checkUserRealName()" /></div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                    <div class="tips" id="realNameTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="fixBox" id="idCard_div" style="width: 740px;">
                    <label>身份证号码：</label>
                    <div class="put"><input maxlength="20" name="idCard" onclick="return checkUserIdCardValidate()" onblur="return checkUserIdCardValidate()" id="idCard" type="text" /></div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                    <div class="tips" id="idCardTip" style="display:none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                
                <div class="fixBox mobileRegClass">
                    <label>手机号码：</label>
                    <div class="put">
                        <input maxlength="11" id="userMobile" name="userMobile" onclick="return checkUserMobileValidate()" onblur="return checkUserMobileValidate()" type="text"/></div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif"/></div>
                    <div class="tips" id="mobileTip" style="display:none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif"/>&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                
                <div class="fixBox">
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
                </div>
                <div class="btn">
                    <a href="javascript:" onclick="authCheckUserForm();">验证</a>
                </div>
            </div>
        </form>
        <div class="clear"></div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
