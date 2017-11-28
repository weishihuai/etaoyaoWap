<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>${webName}-会员注册页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/login.css" rel="stylesheet" media="screen">
	<link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
      <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js" type="text/javascript"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.form.js"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery-validation-1.8.1/jquery.validate.js"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery-validation-1.8.1/additional-methods.js"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.passwordStrength.js"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/register.js"></script>
      <script type="text/javascript">
          var webPath = {webRoot:"${webRoot}"};
      </script>
  </head>
  <body>

    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=会员注册"/>
    <%--页头结束--%>

    <form method="post" id="registerForm" name="registerForm" >
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <div class="fixBox">
                        <input type="text" class="form-control login_btn1" id="loginId" name="loginId" maxlength="20"  placeholder="手机号">
                        <div class="tips" id="loginIdTip" style="display: none; width:auto;">
                            <div class="l-l"></div>
                            <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="fixBox">
                        <input type="password" class="form-control login_btn1"  id="userPsw" maxlength="16" name="userPsw"  placeholder="会员密码" >
                        <div class="tips" id="userPswTip" style="display: none; width:auto;">
                            <div class="l-l"></div>
                            <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico01.gif" />&nbsp;<span></span>&nbsp;</div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="fixBox">
                        <input type="password" class="form-control login_btn1" id="checkPassword" maxlength="16" name="checkPassword"  placeholder="密码确认">
                        <div class="tips" id="checkPasswordTip" style="display: none; width:auto;">
                            <div class="l-l"></div>
                            <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <%--<div class="fixBox">
                        <input type="text" class="form-control login_btn1" id="userEmail" maxlength="32" name="userEmail"  placeholder="电子邮箱">
                        <div class="tips" id="emailTip" style="display:none; width:auto;">
                            <div class="l-l"></div>
                            <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                    </div>--%>
                    <%--<div class="fixBox">
                        <input type="text" class="form-control login_btn1" id="userMobile" maxlength="11" name="userMobile"  placeholder="手机号码" onclick="return checkUserMobileValidate()" onblur="return checkUserMobileValidate()">
                        <div class="tips" id="mobileTip" style="display:none; width:auto;">
                            <div class="l-l"></div>
                            <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                        <button type="button" class="btn btn-primary btn-lg btn-block login_btn2" id="sendValidateNumBtn" onclick="sendValidateNum(this);">发送验证码</button>
                    </div>
                    <div class="fixBox">
                        <input type="text" class="form-control login_btn1" id="messageCode" name="messageCode" maxlength="6" placeholder="短信验证码">
                        <div class="tips" id="messageCodeTip" style="display:none; width:auto;">
                            <div class="l-l"></div>
                            <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                    </div>--%>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <input type="number" class="form-control yzm" name="code" id="code"  maxlength="6" placeholder="请输入验证码">
                    <div class="tips" id="checkValidateCodeTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="sendCode" onclick="sendCode()" id="second">发送验证码</div>
                <%--<div class="col-xs-4">
                    <div class="yzm_pic"><a href="javascript:"><img id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'></a></div>
                </div>
                <div class="col-xs-4">
                    <a class="hyz" href="javascript:" onclick="changValidateCode();return false;">换一张</a>
                </div>--%>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <button type="button" class="btn btn-primary btn-lg btn-block login_btn2" onclick="checkRegisterForm();">同意以下协议并注册</button>
                </div>
                <div class="col-xs-6">
                    <div class="yyzh">已有账号？
                        <a class="qdl" href="${webRoot}/wap/login.ac">请登录</a>
                    </div>
                </div>
            </div>

            <div class="panel panel-default" style="height:430px;overflow-y: scroll;">
                <div class="panel-heading">${webName}服务协议</div>
                <c:set value="${sdk:getArticleCategoryById(7)}" var="articleCategory"/>
                <c:if test="${not empty articleCategory}">
                    <c:set value="${articleCategory.userAgreement}" var="userAgreement"/>
                </c:if>
                <c:if test="${not empty userAgreement}">
                    <c:set var="article" value="${userAgreement.top}"/>
                </c:if>
                <c:choose>
                    <c:when test="${not empty article}">
                        <p style=" word-wrap: break-word;">${article.articleCont}</p>
                    </c:when>
                    <c:otherwise>
                        <p style=" word-wrap: break-word;">${sdk:getSysParamValue('register_provisions')}</p>
                    </c:otherwise>
                </c:choose>
                <%--<div class="panel-body">--%>
                    <%--<p style=" word-wrap: break-word;">${sdk:getSysParamValue('register_provisions')}</p>--%>
                <%--</div>--%>
            </div>
        </div>
    </form>

  </body>
</html>

