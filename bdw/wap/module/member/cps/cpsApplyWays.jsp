<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--判断是否登录--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="loginUrl" value="${webRoot}/wap/noLogin.ac"/>
<c:if test="${empty loginUser}">
    <c:redirect url="${loginUrl}"/>
</c:if>

<c:set value="${param.withdrawalWayCode}" var="withdrawalWayCode"/><%--记录用户当前选择的支付方式--%>
<c:set value="${sdk:getCpsPromoteMemberProxy()}" var="member"/><%-- 会员信息 proxy --%>
<c:set value="${sdk:getPromoteMemberByLoginUserId()}" var="memberInfo" /><!--会员信息，通过登录用户的id获得推广员对象<--></-->
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>申请提现</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">

    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsApplyWays.js"></script>
    <script type="text/javascript">
    var webParams = {
    webRoot: '${webRoot}',
    withdrawalWayCode:'${member.withdrawalWayCode}'
    };
    </script>



</head>

<body style="background-color: #f8f8f8;">

    <%--<header class="header">
        <a href="${webRoot}/wap/module/member/cps/cpsApplying.ac" class="back"></a>
        <div class="header-title">选择支付方式</div>
    </header>--%>
    <div class="main m-withdrawal-way">
       <%-- <c:choose>
            <c:when test="${empty member.bankAccountHide}">
                <div class="pay-item" withdrawalWayCode="0" url="${webRoot}/wap/module/member/cps/cpsApplyWaysOfBank.ac">
                    <span class="img">
                        <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/alipay-logo02.png" alt="">
                    </span>
                    <a class="toggle" href="javascript:void(0);">去绑定</a>
                    <span class="lab">银行</span>
                </div>
            </c:when>

            <c:when test="${not empty member.bankAccountHide}">
                <div class="pay-item ${(empty withdrawalWayCode  ? member.withdrawalWayCode:withdrawalWayCode )== '0'?"active":""}" withdrawalWayCode="0">
                    <span class="img">
                        <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/alipay-logo02.png" alt="">
                    </span>
                    <span class="lab">${member.bankOfDeposit}（${fn:substring(member.bankAccountHide,fn:length(member.bankAccountHide)-4 ,fn:length(member.bankAccountHide) )}）</span>
                </div>
            </c:when>
        </c:choose>--%>

        <c:choose>
            <c:when test="${empty member.alipayAccount}">
                <div class="pay-item" withdrawalWayCode="1" url="${webRoot}/wap/module/member/cps/cpsApplyWaysOfAlipay.ac">
                    <span class="img">
                        <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/alipay-logo.png" alt="">
                    </span>
                    <a class="toggle" href="javascript:void(0);">去绑定</a>
                    <span class="lab">支付宝</span>
                </div>
            </c:when>

            <c:when test="${not empty member.alipayAccount}">
                <div class="pay-item ${(empty withdrawalWayCode  ? member.withdrawalWayCode:withdrawalWayCode )== '1'?"active":""}" withdrawalWayCode="1">
                    <span class="img">
                        <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/alipay-logo.png" alt="">
                    </span>
                    <span class="lab">支付宝（${member.alipayAccount}）</span>
                </div>
            </c:when>
        </c:choose>

        <a class="btn-block" href="javascript:void(0)" id="btnTrue">确定</a>
    </div>

    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
</body>

</html>
