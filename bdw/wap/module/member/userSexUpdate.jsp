<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>


<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>设置性别-${webName}</title>
      <meta content="yes" name="apple-mobile-web-app-capable">
      <meta content="yes" name="apple-touch-fullscreen">
      <meta content="telephone=no,email=no" name="format-detection">
      <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/module/member/statics/css/seting-age.css" type="text/css" rel="stylesheet" />

      <script type="text/javascript">
          var dataValue={
              webRoot:"${webRoot}",
              sexCode:"${param.sexCode}"
          };
      </script>
      <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
      <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
      <script src="${webRoot}/template/bdw/wap/module/member/statics/js/userSexUpdate.js"></script>
  </head>
  <body>
  <input id="userSexCode" type="hidden" value="${loginUser.sexCode}">
      <div class="m-top">
          <a href="javascript:history.go(-1)" class="back"></a>
          <span>设置性别</span>
      </div>
      <div class="seting-age-main">
          <div class="item <c:if test="${param.sexCode eq '0'}">cur</c:if>" rel="0">男</div>
          <div class="item <c:if test="${param.sexCode eq '1'}">cur</c:if>" rel="1">女</div>
          <div class="item <c:if test="${param.sexCode eq '2'}">cur</c:if>" rel="2">保密</div>
      </div>
      <div id="tipsDiv" class="rem-get" style="display: none;"><span id="tipsSpan"></span></div>
  </body>
</html>

