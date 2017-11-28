<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>${webName}-找回密码</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/findPsw.css" rel="stylesheet" media="screen">
	<link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
      <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.md5.js"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/jquery.validate.js"></script>

      <script type="text/javascript">
          var webPath = {webRoot:"${webRoot}"};
      </script>
      <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/findPsw.js"></script>
  </head>
  <body>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=找回密码"/>
    <%--页头结束--%>
    <form method="post" id="findPswForm" name="findPswForm" >
        <div class="container">
            <div class="mobileRegClass">
                <div class="row step1">
                    <div class="col-xs-12">
                        <div class="fixBox">
                            <input type="text" class="form-control login_btn1" id="userMobile" name="userMobile" maxlength="20"  placeholder="请输入手机号">
                        </div>
                    </div>
                    <div class="tips" id="mobileTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="row step1">
                    <div class="col-xs-5">
                        <input type="number" class="form-control yzm" name="messageCode" id="messageCode"  maxlength="6" placeholder="请输入验证码">
                        <div class="tips" id="checkValidateCodeTip" style="display: none; width:auto;">
                            <div class="l-l"></div>
                            <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <input type="button" class="sendCode" onclick="sendValidateNum(this)" id="second" value="发送验证码" />
                    <%--<div class="sendCode" onclick="sendValidateNum()" id="second" >发送验证码</div>--%>
                </div>
                <div class="row step1" style="margin-top: 10px;">
                    <div class="col-xs-12">
                        <button type="button" class="btn btn-primary btn-lg btn-block login_btn2" onclick="checkUserMsg()">验证</button>
                    </div>
                </div>
            </div>

            <%--密码--%>
            <div class="row step2" style="margin-top: 10px;display: none;">
                <div class="col-xs-12">
                    <div class="fixBox">
                        <input type="password" class="form-control" id="userPsw" name="userPsw" maxlength="20"  placeholder="新密码">
                    </div>
                </div>
                <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                <div class="tips" id="userPswTip" style="display: none; width:auto;">
                    <div class="l-l"></div>
                    <div class="t-b"><img src="${webRoot}/template/bdw/statics//images/register_ico01.gif" />&nbsp;<span></span>&nbsp;</div>
                    <div class="r-l"></div>
                    <div class="clear"></div>
                </div>
            </div>
            <%--确认密码--%>
            <div class="row step2" style="margin-top: 10px;display: none;">
                <div class="col-xs-12">
                    <div class="fixBox">
                        <input type="password" class="form-control" id="checkPassword" name="checkPassword" maxlength="20"  placeholder="确认密码">
                    </div>
                </div>
                <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics//images/register_passIco.gif" /></div>
                <div class="tips" id="checkPasswordTip" style="display: none; width:auto;">
                    <div class="l-l"></div>
                    <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                    <div class="r-l"></div>
                    <div class="clear"></div>
                </div>
            </div>


            <div class="row step2" style="margin-top: 10px;display: none;">
                <div class="col-xs-12">
                    <button type="button" class="btn btn-primary btn-lg btn-block login_btn2" id="fetchPassword" <%-- onclick="$('#findPswForm').submit();"--%>>修改密码</button>
                </div>
            </div>
        </div>
    </form>
  </body>
</html>

