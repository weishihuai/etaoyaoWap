<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--判断是否登录--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="loginUrl" value="${webRoot}/wap/noLogin.ac"/>
<c:if test="${empty loginUser}">
    <c:redirect url="${loginUrl}"/>
</c:if>

<c:set value="${sdk:getCpsPromoteMemberProxy()}" var="member"/><%-- 会员信息 proxy --%>
<c:set value="${sdk:getSysParamValue('rebateMoneyFloor')}" var="rebateMoneyFloor"/> <%--提现金额下限--%>
<c:set value="${sdk:getSysParamValue('rebateMoneyUpper')}" var="rebateMoneyUpper"/> <%--提现金额上限--%>
<c:set value="${param.withdrawalWayCode}" var="withdrawalWayCode"/>
<c:set value="${sdk:getPromoteMemberByLoginUserId()}" var="memberInfo" /><!--会员信息，通过登录用户的id获得推广员对象-->

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
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsApplying.js"></script>
    <script type="text/javascript">

        var webParams = {
            webRoot: '${webRoot}',
            rebateMoneyFloor: '${empty rebateMoneyFloor ? "" : rebateMoneyFloor}',
            rebateMoneyUpper: '${empty rebateMoneyUpper ? "" : rebateMoneyUpper}',
            withdrawalWayCode:'${empty withdrawalWayCode?member.withdrawalWayCode:withdrawalWayCode }'
        };

    </script>
   
</head>

<body style="background-color: #f8f8f8;">

	<%--<header class="header">
        <a href="${webRoot}/wap/module/member/cps/cpsMe.ac" class="back"></a>
        <div class="header-title">申请提现</div>
    </header>--%>
    <div class="main m-withdrawal">
        <div class="my-balance">
            <p>我的余额（元）</p>
            <strong id="userBalance"><fmt:formatNumber value="${member.userBalance}" type="number" pattern="#.##" /></strong>
        </div>

        <div class="entry-block" id="choosePayWay" href="${webRoot}/wap/module/member/cps/cpsApplyWays.ac?withdrawalWayCode=${empty withdrawalWayCode?member.withdrawalWayCode:withdrawalWayCode}">
            <a href="javascript:void(0)">
                <i class="icon icon-angle-right"></i>
                <%-- 判断绑定账号的类型 银行卡|支付宝--%>
                <c:choose>
                	<%--<c:when test="${(empty withdrawalWayCode?member.withdrawalWayCode:withdrawalWayCode) == '0'}">
						<span class="img">
                    		<img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/alipay-logo02.png" alt="">
		                </span>
		                <span class="lab">${member.bankOfDeposit}（${fn:substring(member.bankAccountHide,fn:length(member.bankAccountHide)-4 ,fn:length(member.bankAccountHide) )}）</span>
                	</c:when>--%>

                	<c:when test="${(empty withdrawalWayCode?member.withdrawalWayCode:withdrawalWayCode) == '1'}">
						<span class="img">
                    		<img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/alipay-logo.png" alt="">
		                </span>
		                <span class="lab">支付宝（${member.alipayAccount}）</span>
                	</c:when>
                </c:choose>
                
            </a>
        </div>

        <div class="drawal-amount">
            <a href="javascript:void(0)" id="withdrawAllBtn">全部提出</a>
            <input type="text" id="withdrawAllValue" placeholder="可提现<fmt:formatNumber value="${member.userBalance}" type="number" pattern="#.##" />">
        </div>

        <a class="btn-block" id="next" href="javascript:void (0)">下一步</a>
    </div>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
</body>

</html>