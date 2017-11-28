<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page import=" com.iloosen.imall.module.cash.domain.code.ApproveStatTypeCodeEnum" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>申请推广员</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-index.css">

    <%
        request.setAttribute("unApprove", ApproveStatTypeCodeEnum.UN_APPROVE.toCode());  //未审核
        request.setAttribute("passApprove", ApproveStatTypeCodeEnum.PASS_APPROVE.toCode());  //审核通过
        request.setAttribute("cancelApprove", ApproveStatTypeCodeEnum.CANCEL_APPROVE.toCode());  //审核不通过
    %>

    <c:set var="memberInfo" value="${sdk:getPromoteMemberByUserId()}"/>
</head>
<body>

<div class="main">
    <%--<header class="header">
        <a href="${webRoot}/wap/module/member/index.ac?type=member" class="back"></a>
        <div class="header-title">申请推广</div>
    </header>--%>
    <form class="form-horizontal">
        <div class="form-group">
            <label class="control-label">联系人</label>
            <div class="input-group">
                <a class="clear" href="javascript:void(0);"></a>
                <c:choose>
                    <c:when test="${empty memberInfo.name}">
                        <input class="form-control" type="text" placeholder="请输入联系人" id="userName" />
                    </c:when>
                    <c:otherwise>
                        <input class="form-control" type="text" placeholder="请输入联系人" id="userName" value="${memberInfo.name}" />
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label">手机号</label>
            <div class="input-group">
                <a class="clear" href="javascript:void(0);"></a>
                <c:choose>
                    <c:when test="${empty memberInfo.mobile}">
                        <input class="form-control" type="text" placeholder="请输入手机号" id="userPhone" />
                    </c:when>
                    <c:otherwise>
                        <input class="form-control" type="text" placeholder="请输入手机号" id="userPhone" value="${memberInfo.mobile}" />
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <a class="btn-block" href="javascript:gotoSecondStep();">下一步</a>
    </form>

    <form id="gotoSecondStepForm" action="${webRoot}/wap/module/member/cps/myPromoteRegisterSecondStep.ac" type="hidden">
        <input type="hidden" id="userNameHidden" name="userName">
        <input type="hidden" id="userPhoneHidden" name="userPhone">

        <input type="hidden" value="${memberInfo.id}" id="id" name="id">
        <input type="hidden" value="${memberInfo.withdrawalWayCode}" id="withdrawalWayCode" name="withdrawalWayCode">
        <input type="hidden" value="${memberInfo.approveStat}" id="approveStat" name="approveStat">

        <c:choose>
            <c:when test="${memberInfo.withdrawalWayCode eq '0'}">
                <input type="hidden" value="${memberInfo.bankInf}" id="bankInf" name="bankInf">
                <input type="hidden" value="${memberInfo.bankAccount}" id="bankAccount" name="bankAccount">
                <input type="hidden" value="${memberInfo.bankOfDeposit}" id="bankOfDeposit" name="bankOfDeposit">
                <input type="hidden" value="${memberInfo.bankOpenManName}" id="bankOpenManName" name="bankOpenManName">
            </c:when>
            <c:otherwise>
                <input type="hidden" value="${memberInfo.alipayAccount}" id="alipayAccount" name="alipayAccount">
                <input type="hidden" value="${memberInfo.alipayOpenManName}" id="alipayOpenManName" name="alipayOpenManName">
            </c:otherwise>
        </c:choose>
    </form>
</div>

<div class="modal fade in" id="sysMsg" style="display: none;">
    <div class="modal-dropback"></div>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">系统消息</h4>
            </div>
            <div class="modal-body">
                您好，您的申请被拒绝了，请填写真实信息重新进行申请。
            </div>
            <div class="modal-footer">
                <a class="btn-link" href="javascript:hideMeg();">我知道了</a>
            </div>
        </div>
    </div>
</div>


<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/myPromoteRegisterFirstStep.js"></script>
<script type="text/javascript">
    var webPath = {webRoot:"${webRoot}"};
    var unApprove = '${unApprove}';
    var passApprove = '${passApprove}';
    var cancelApprove = '${cancelApprove}';
</script>
</body>

</html>
