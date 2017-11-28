<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>
<c:set value="${sdk:getPromoteMemberByUserId()}" var="memberInfo" />
<c:set value="${sdk:calcCpsOrderClearing()}" var="cpsOrderClearingCalc"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>我的CPS</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cpsMe.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/foot.css">

    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            memberId:"${memberInfo.id}"
        };
    </script>
</head>

<c:set value="${sdk:getPromoteMemberByLoginUserId()}" var="memberInfo" /><!--会员信息，通过登录用户的id获得推广员对象-->
<c:set value="${webUrl}/cps/cpsPromote.ac?unid=${memberInfo.id}&target=${wapUrl}?1=1" var="promoteHref"/>
<c:set value="${weixinSdk:getQRCodeLongFormat2(promoteHref,'')}" var="vorderaddQr"/>
<body style="background-color: #f8f8f8;">
    <%--<header class="header">
        <a href="${webRoot}/wap/module/member/index.ac?type=member" class="back"></a>
        <div class="header-title">我要推广</div>
    </header>--%>
    <div class="main m-mine-index">
        <div class="my-info">
            <span class="my-img">
                <c:choose>
                    <c:when test="${empty  loginUser.icon['80X80'] or (loginUser.icon['80X80'] eq '/template/bdw/statics/images/noPic_80X80.jpg')}">
                        <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/share-qzone.png" alt="">
                    </c:when>
                    <c:otherwise>
                        <img src="${loginUser.icon['80X80']}" alt="">
                    </c:otherwise>
                </c:choose>
            </span>
            <div class="my-property">
                <p>账户余额（元）</p>
                <em><fmt:formatNumber value="${sdk:getTheRebateAccountNum()}" pattern="#0.00#" /></em>
                <p>待返现  ￥<fmt:formatNumber value="${cpsOrderClearingCalc.totalWaitCashBackAmount}" pattern="#0.00#" /></p>
            </div>
            <a href="${webRoot}/wap/module/member/cps/cpsApplying.ac">申请提现</a>
        </div>

        <div class="entry-block" id="myRebateAccount">
            <a href="${webRoot}/wap/module/member/cps/myRebateAccount.ac">
                <i class="icon icon-angle-right"></i>
                <span class="lab">账户明细</span>
            </a>
        </div>
        <div class="entry-block" id="cpsMyMember">
            <a href="${webRoot}/wap/module/member/cps/cpsMyMember.ac?unid=${memberInfo.id}">
                <i class="icon icon-angle-right"></i>
                <span class="lab">线下会员</span>
            </a>
        </div>

        <div class="entry-block mar-top" id="myProfile">
            <a href="${webRoot}/wap/module/member/cps/myProfile.ac">
                <i class="icon icon-angle-right"></i>
                <span class="lab">我的资料</span>
            </a>
        </div>
        <div class="entry-block" id="myQrCode">
            <a href="javascript:void(0);">
                <i class="qr"><img src="${webRoot}/QRCodeServlet?qrcodelong=${vorderaddQr}" alt=""></i>
                <span class="lab">我的推广二维码</span>
            </a>
        </div>

    </div>

    <div class="layer-bg" id="qr-share-div" style="display: none;;">
        <div class="share-code">
            <div class="cont">
                <div class="shop-info">
                    <h2 class="shop-name elli">我的推广二维码</h2>
                </div>
                <div class="code">
                    <img src="${webRoot}/QRCodeServlet?qrcodelong=${vorderaddQr}" alt="">
                </div>
                <p class="tip">扫一扫上面的二维码，注册成为会员</p>
            </div>
        </div>
    </div>
    <%--底部导航--%>
    <c:import url="./cpsFooter.jsp"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsMe.js"></script>
</body>

</html>
