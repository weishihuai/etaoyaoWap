<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:if test="${not empty loginUser}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>

<%-- 登录后返回登录前页面 --%>
<%
    String source = request.getHeader("Referer");
    if(source!=null && !source.contains("register.ac")){
        request.getSession().setAttribute("redirectUrl",source);
    }
%>

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>${webName}-会员登录页</title>
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
      <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.md5.js"></script>
      <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/loginValidate.js"></script>
      <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/loginValidateCode.js"></script><%--登录验证插件--%>
      <script type="text/javascript">
          var webPath = {webRoot:"${webRoot}"};
      </script>
  </head>
  <body>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=会员登录"/>
    <%--页头结束--%>
    <form method="post"  id="loginForm" name="loginForm" >
    <div class="container">
    	<div class="row">
        	<div class="col-xs-12">
                <div class="fixBox">
                    <input type="text" id="loginId" class="form-control login_btn1"  placeholder="会员登录">
                    <div  id="alert" style="display: none;">
                        <div class="t-b" id="alerttext" style="color: red"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="fixBox">
                    <input type="password" class="form-control login_btn1" id="userPsw" name="userPsw" placeholder="会员密码">
                    <div id="alert2" style="display: none;">
                        <div class="t-b" id="alerttext1" style="color: red"></div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="fixBox" style="display:none;" id="validateCodeField">
            <div class="row">
                <div class="col-xs-4">
                    <input type="text" class="form-control yzm"  name="validateCode" id="validateCode"  maxlength="4" placeholder="验证码">
                </div>
                <div class="col-xs-4">
                    <div class="yzm_pic"><a href="javascript:"><img id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'></a></div>
                </div>
                <div class="col-xs-4">
                    <a class="hyz" href="javascript:void(0)" onclick="changValidateCode();return false;">换一张</a>
                </div>
            </div>
            <div id="alert3" style="display: none;">
                <div class="t-b" id="alerttext2" style="color: red"></div>
                <div class="clear"></div>
            </div>
        </div>
        <div class="row">
        	<div class="col-xs-12">
            	<button type="button" class="btn btn-primary btn-lg btn-block login_btn2" onclick="$('#loginForm').submit();" >登录</button>
            </div>
        </div>

        <c:if test="${isWeixin!='Y'}">
            <div class="row other" style="text-align: right;margin-top: 5px;">
                <a href="${webRoot}/wap/regist.ac" class="register">注册</a><i class="line">|</i>
                <a href="${webRoot}/wap/findPsw.ac" class="findPsw">忘记密码?</a>
            </div>
        </c:if>

        <div class="row" style="margin-top: 10px">
        	<div class="col-xs-9"></div>
            <div class="col-xs-3">
            	<%--<a href="${webRoot}/wap/regist.ac" class="mfzc">免费注册</a>--%>
            </div>
        </div>
        <c:choose>
            <c:when test="${empty loginUser.bytUserId}">
                <%--页脚开始1--%>
                <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
                <%--页脚结束--%>
            </c:when>
        </c:choose>
    </div>
     </form>

    <%--<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->--%>
    <%--<script src="js/jquery.js"></script>--%>
    <%--<!-- Include all compiled plugins (below), or include individual files as needed -->--%>
    <%--<script src="js/bootstrap.js"></script>--%>
  </body>
</html>

