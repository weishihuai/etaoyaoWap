<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>我的资料</title>
        <meta content="yes" name="apple-mobile-web-app-capable" />
        <meta content="yes" name="apple-touch-fullscreen" />
        <meta content="telephone=no,email=no" name="format-detection" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">
        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/myProfile.css">

        <c:set var="memberInfo" value="${sdk:getPromoteMemberByUserId()}"/>

        <%
            request.setAttribute("yes", BoolCodeEnum.YES.toCode());
            request.setAttribute("no", BoolCodeEnum.NO.toCode());
        %>
    </head>

    <body style="background-color: #f8f8f8;">
        <%--<header class="header">
            <a href="${webRoot}/wap/module/member/cps/cpsMe.ac" class="back"></a>
            <div class="header-title">我的资料</div>
        </header>--%>
        <div class="main m-my-profile">
            <div class="entry-block entry-layer" type="name">
                <a href="javascript:void(0);" class="entry-layer" type="name">
                    <i class="icon icon-angle-right"></i>
                    <span class="lab">联系人</span>
                    <span class="val" id="nameSpan">${memberInfo.name}</span>
                </a>
            </div>
           <%-- <div class="entry-block entry-layer" type="mobile">
                <a href="javascript:void(0);" class="entry-layer" type="mobile">
                    <i class="icon icon-angle-right"></i>
                    <span class="lab">联系手机</span>
                    <span class="val"  id="mobileSpan">${memberInfo.mobile}</span>
                </a>
            </div>--%>
            <div class="entry-block" onclick="gotoMyAlipayProfile()">
                <a href="javascript:gotoMyAlipayProfile();">
                    <i class="icon icon-angle-right"></i>
                    <span class="lab">支付宝</span>
                    <c:if test="${empty memberInfo.alipayAccount}">
                        <span class="val stress">去绑定</span>
                    </c:if>
                </a>
            </div>
        </div>

        <!--弹窗-->
        <div class="layer-bg hide" id="layerBg" ></div>
        <!--修改联系人、联系手机-->
        <div class="layer2 layer hide">
            <h2></h2>
            <input id="inputInfo" type="text" value="" style="float: left">
            <a class="op-icon del inputInfoDel" href="javascript:void(0);" style="float: left"></a>
            <a class="btn" href="javascript:void(0);" style="margin-top: 6rem;">确定</a>
        </div>

        <form id="infoForm" type="hidden" action="">
            <input type="hidden" name="promoteMemberId" value="${memberInfo.id}" id="idHide">
            <input type="hidden" name="name" value="${memberInfo.name}" id="nameHide">
            <input type="hidden" name="mobile" value="${memberInfo.mobile}" id="mobileHide">
            <input type="hidden" name="bankOfDeposit" value="${memberInfo.bankOfDeposit}" id="bankOfDepositHide">
            <input type="hidden" name="bankInf" value="${memberInfo.bankInf}" id="bankInfHide">
            <input type="hidden" name="bankOpenManName" value="${memberInfo.bankOpenManName}" id="bankOpenManNameHide">
            <input type="hidden" name="bankAccount" value="${memberInfo.bankAccount}" id="bankAccountHide">
            <input type="hidden" name="alipayOpenManName" value="${memberInfo.alipayOpenManName}" id="alipayOpenManNameHide">
            <input type="hidden" name="alipayAccount" value="${memberInfo.alipayAccount}" id="alipayAccountHide">
            <input type="hidden" name="withdrawalWayCode" value="${memberInfo.withdrawalWayCode}" id="withdrawalWayCodeHide">
            <input type="hidden" name="isNeedValidateCode" value="${no}">
        </form>


        <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/base.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/myProfile.js" type="text/javascript"></script>
        <script type="text/javascript">
            var webParams = {
                webRoot:"${webRoot}"
            };
        </script>
    </body>
</html>
