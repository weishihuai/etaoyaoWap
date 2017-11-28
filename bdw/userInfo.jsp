<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page import="sun.misc.BASE64Decoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-完善注册-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/userCheck.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/jquery.validate.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/additional-methods.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.passwordStrength.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/userInfo.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>
<%
    String decodeBase64 = request.getParameter("code");
    decodeBase64 = decodeBase64.replace(" ","+");
    BASE64Decoder decoder = new BASE64Decoder();
    String fidStr = new String(decoder.decodeBuffer(decodeBase64), "UTF-8");
    String[] paramArray = fidStr.split("&");//paramArray[0]: erpUserId,paramArray[1]:真实姓名,paramArray[2]:身份证号码,paramArray[3]:手机号码,paramArray[4]:性别编码(1表示男,2表示女)
    request.setAttribute("erpUserId",paramArray[0]);
    request.setAttribute("realName", paramArray[1]);
    request.setAttribute("mobile",paramArray[3]);
    if (paramArray[4].equals("1")) {
        request.setAttribute("userSex", 0);//男
    } else if (paramArray[4].equals("2")) {
        request.setAttribute("userSex", 1);//女
    } else {
        request.setAttribute("userSex", 2);//保密
    }
%>

<div id="register">
    <div class="newRegist">
        <form method="post" id="registerForm" name="registerForm" >
            <input type="hidden" name="erpUserId" value="${erpUserId}"/>
            <input type="hidden" name="userSexCode" value="${userSex}"/>
            <div class="l">
                <h2>请填写信息：</h2>
                <div class="fixBox">
                    <label>登录账号：</label>
                    <div class="put"><input id="loginId" name="loginId" maxlength="20" type="text"/></div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                    <div class="tips" id="loginIdTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics//images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>

                <div class="fixBox">
                    <label>登录密码：</label>
                    <div class="put"><input maxlength="16" name="userPsw" onclick="return checkPsw()" onblur="return checkPsw()"  id="userPsw" type="password" /></div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                    <div class="tips" id="userPswTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics//images/register_ico01.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>

                <div class="fixBox">
                    <label>确认密码：</label>
                    <div class="put"><input maxlength="16" name="checkPassword"  onclick="return cheCkcheckPsw()" onblur="return cheCkcheckPsw()" id="checkPassword" type="password" /></div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics//images/register_passIco.gif" /></div>
                    <div class="tips" id="checkPasswordTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>

                <div class="PasswordTipsBox" style="display:block;">
                    <%--密码强度提示框--%>
                    <div class="powerTip">
                        <div style="float:left;margin-top:-3px;padding-right: 5px;">密码强度</div>
                        <div style="height:7px;overflow:hidden;">
                            <div id="passwordStrengthDiv" class="is0"></div>
                        </div>
                    </div>
                    <%--密码确认框--%>
                </div>

                <div class="fixBox" id="email_div" style="width: 740px;">
                    <label>电子邮箱：</label>
                    <div class="put"><input maxlength="32" name="userEmail" onclick="return checkUserMailValidate()" onblur="return checkUserMailValidate()" id="userEmail" type="text" /></div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                    <div class="tips" id="emailTip" style="display:none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                
                <div class="fixBox mobileRegClass">
                    <label>手机号码：</label>
                    <div class="put">
                        <input maxlength="12" id="userMobile" name="userMobile" readonly="readonly" type="text" value="${mobile}"/>
                    </div>
                </div>

                <div class="fixBox">
                    <label>真实姓名：</label>
                    <div class="put"><input id="userName" name="userName" maxlength="20" readonly="readonly" type="text" value="${realName}"/></div>
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
                <div class="fixBox_b">
                    <div class="put">
                        <input type="checkbox" name="tongYi" id="tongYi"/>
                        我已阅读并同意
                        <a href="${webRoot}/mallNotice.ac?categoryId=82599&infArticleId=60949">《${webName}用户服务协议》</a>
                    </div>
                </div>
                <div class="btn">
                    <a href="javascript:" onclick="checkRegisterForm();">完善注册</a>
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
