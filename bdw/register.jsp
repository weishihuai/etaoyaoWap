<%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-5-29
  Time: 上午11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%-- 检查手机号是否已经经过短信验证 --%>
<c:if test="${empty param.code || empty param.mobile || !bdw:checkMobile(param.mobile,param.code)}">
    <c:redirect url="/checkMobile.ac?mobile=${param.mobile}"/>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-会员注册-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>--%>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/jquery.validate.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/additional-methods.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.passwordStrength.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/register.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="register">
    <div class="newRegist">
        <form method="post" id="registerForm" name="registerForm" >
            <input value="${param.fid}" name="fid" type="hidden"/>
            <input value="${param.mobile}" name="userMobile" type="hidden"/>
            <input value="${param.mobile}" name="loginId" type="hidden" id="loginId" readonly="readonly"/>
            <div class="l">
                <h2>请填写信息</h2>
                <div class="fixBox">
                    <label>手机号：</label>
                    <!-- 显示手机号 -->
                    <label style="margin-left:0px;width:90px;">${param.mobile}</label>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                    <%--<div class="tips" id="loginIdTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics//images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>--%>
                </div>
                <div class="fixBox">
                    <label>密 码：</label>
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
                    <label>密码确认：</label>
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
                <%--<div class="fixBox" id="email_div" style="width: 740px;">--%>
                    <%--<label>电子邮箱：</label>--%>
                    <%--<div class="put"><input maxlength="32" name="userEmail" onclick="return checkUserMailValidate()" onblur="return checkUserMailValidate()" id="userEmail" type="text" /></div>--%>
                    <%--<div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>--%>
                    <%--<div class="tips" id="emailTip" style="display:none; width:auto;">--%>
                        <%--<div class="l-l"></div>--%>
                        <%--<div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>--%>
                        <%--<div class="r-l"></div>--%>
                        <%--<div class="clear"></div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="fixBox">--%>
                    <%--<label>验证码：</label>--%>
                    <%--<div class="put" style="width:90px;"><input style="width:80px;" class="code" type="text"  name="validateCode" id="validateCode"  maxlength="4" tabindex="3"/></div>--%>
                    <%--<div class="codeImg" style="float:left;margin-top: 3px;"><img style="float:left" id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'> <a href="#" onclick="changValidateCode();return false;" style="display: block;float: left;margin-left: 5px;padding-top: 5px;">看不清？换一个</a>&nbsp;<span></span>&nbsp;</div>--%>
                    <%--<div class="tips" id="checkValidateCodeTip" style="display: none; width:auto;">--%>
                        <%--<div class="l-l"></div>--%>
                        <%--<div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>--%>
                        <%--<div class="r-l"></div>--%>
                        <%--<div class="clear"></div>--%>
                    <%--</div>--%>
                    <%--<div class="clear"></div>--%>
                <%--</div>--%>
                <%--2015年12月11日 会员注册去除手机验证--%>
                <%--短信验证去掉--%>
                <%--<div class="fixBox mobileRegClass">
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
                <div class="fixBox mobileRegClass">
                    <label>短信验证码：</label>
                    <div class="put"><input maxlength="6" id="messageCode" name="messageCode" type="text"/></div>
                    <div>
                        <input type="button" id="sendValidateNumBtn" onclick="sendValidateNum(this);" value="发送验证码"/>
                    </div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif"/></div>
                    <div class="tips" id="messageCodeTip" style="display:none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif"/>&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>--%>
                

                <div class="fixBox_b">
                    <div class="put">
                        <input type="checkbox" name="tongYi" id="tongYi"/>
                        我已阅读并同意
                        <c:set value="${sdk:getArticleCategoryById(7).userAgreement.top}" var="article"/>
                        <a href="javascript:" id="content" style="display: none;">${article.articleCont}</a>
                        <c:choose>
                            <c:when test="${not empty article}">
                                <a href="javascript:" id="userAgreement">《${webName}用户服务协议》</a>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:" id="unRelease">《${webName}用户服务协议》</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="btn">
                    <a href="javascript:" onclick="checkRegisterForm();">注册</a>
                </div>
            </div>
        </form>
        <div class="r">
            <div class="box">
                <label>我已经注册，现在就</label><br>
               <a href="${webRoot}/login.ac">
               </a>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
