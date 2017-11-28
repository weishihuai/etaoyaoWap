<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取当前登录用户信息--%>
<c:set value="${sdk:getLoginUser()}" var="userProxy" />
<%--根据当前登录用户查询建议投诉信息--%>
<c:set value="${sdk:findComplainSuggestByTypeUserId(userProxy.userId,10 ,'')}" var="remarkPage"/>
<c:set value="${remarkPage.result}" var="remarks" />
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty userProxy}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>

<!DOCTYPE html>
<html>
    <head lang="en">
        <meta charset="utf-8">
        <title>意见反馈-${webName}</title>
        <meta content="yes" name="apple-mobile-web-app-capable">
        <meta content="yes" name="apple-touch-fullscreen">
        <meta content="telephone=no,email=no" name="format-detection">
        <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/module/member/statics/css/feedback.css" type="text/css" rel="stylesheet" />

        <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    </head>
    <body>
        <div class="m-top">
           <a class="back" href="javascript:history.go(-1)"></a>
           <span>意见反馈</span>
       </div>
       <div class="feedback-main">
            <c:if test="${not empty remarks}">
                <c:forEach var="remark" items="${remarks}" varStatus="s">
                    <div class="item">
                        <div class="ask-box">
                            <c:set var="preUsername" value="${fn:substring(userProxy.userName, 0, 1)}"/>
                            <c:set var="lastUsername" value="${fn:substring(userProxy.userName, fn:length(userProxy.userName) - 1,fn:length(userProxy.userName))}"/>
                            <p class="user-info">${preUsername}***${lastUsername}<span><c:if test="${not empty remark.createTimeStr}">${remark.createTimeStr}</c:if></span></p>
                            <p class="ask-txt"><em>馈</em>${remark.complainCont}</p>
                        </div>
                        <c:if test="${not empty remark.replyCont}">
                            <div class="answer-box"><p><em>答</em>${remark.replyCont}</p></div>
                        </c:if>
                    </div>
                </c:forEach>
            </c:if>
           <a class="feedback-btn" href="${webRoot}/wap/module/member/feedbackAdd.ac"><span>我要反馈</span></a>
       </div>
    </body>
</html>
