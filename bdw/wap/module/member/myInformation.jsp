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
    <title>账户资料-${webName}</title>
      <meta content="yes" name="apple-mobile-web-app-capable">
      <meta content="yes" name="apple-touch-fullscreen">
      <meta content="telephone=no,email=no" name="format-detection">
      <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/module/member/statics/css/account-info.css" type="text/css" rel="stylesheet" />

      <script type="text/javascript">
          var dataValue={
              webRoot:"${webRoot}",
              isWeixin:"${isWeixin}"
          };
      </script>
      <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>
      <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
      <c:choose>
          <c:when test="${isWeixin eq 'Y'}"><%--微信端--%>
              <script src="${webRoot}/template/bdw/wap/module/member/statics/js/jweixin-1.0.0.js"></script>
              <script src="${webRoot}/template/bdw/wap/module/member/statics/js/weixinJsOperation.js"></script>
          </c:when>
          <c:otherwise>
              <script src="${webRoot}/template/bdw/wap/module/member/statics/js/plupload.full.min.js"></script>
          </c:otherwise>
      </c:choose>
      <script src="${webRoot}/template/bdw/wap/module/member/statics/js/myInformation.js"></script>
  </head>
  <body>
      <div class="m-top">
          <a id="back" class="back" href="javascript:void(0);"></a>
          <div class="toggle-box">账户资料</div>
      </div>

      <div class="account-info-main">
          <div id="btnUpload" class="item item-logo">头像
              <c:set value="${loginUser.icon['100X100']}" var="userImageUrl"/>
              <c:choose>
                  <c:when test="${userImageUrl eq '/template/bdw/statics/images/noPic_150X150.jpg'}">
                      <img src="${webRoot}/template/bdw/wap/module/member/statics/images/touxiang.png" alt="">
                  </c:when>
                  <c:otherwise>
                      <img src="${userImageUrl}" alt="">
                  </c:otherwise>
              </c:choose>
          </div>
          <div class="item item-name">用户名称<span>${loginUser.userName}</span></div>
          <div class="item item-grade">会员等级<span>${loginUser.level}</span></div>
          <div class="item item-age" onclick="window.location.href = '${webRoot}/wap/module/member/userSexUpdate.ac?sexCode=${loginUser.sexCode}'">性别<span>${loginUser.sexName}</span></div>
          <div class="item item-data-birth" style="display: none">出生日期<span>1993.01.31</span></div>
      </div>
      <div id="tipsDiv" class="rem-get" style="display: none;"><span id="tipsSpan"></span></div>
  </body>
</html>

