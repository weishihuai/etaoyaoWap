<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${param.withdrawalWayCode}" var="withdrawalWayCode"/>
<c:set value="${param.amount}" var="amount"/>
<c:if test="${amount == null ||withdrawalWayCode == null}">
    <c:redirect url="/wap/module/member/cps/cpsApplying.ac"></c:redirect>
</c:if>

<%--判断是否登录--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="loginUrl" value="${webRoot}/wap/noLogin.ac"/>
<c:if test="${empty loginUser}">
    <c:redirect url="${loginUrl}"/>
</c:if>

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
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.md5.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsApplyPwd.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webParams={
            webRoot: '${webRoot}',
            amount : ${amount},
            withdrawalWayCode : ${withdrawalWayCode}
        }

    </script>
</head>

<body>

    <div class="main m-pay-pwd">
        <form class="form-horizontal">
            <div class="form-group">
                <div class="input-group validate-code">
                    <a class="clear" href="javascript:;"></a>
                    <input class="form-control" id="validateCode" type="text" value="" placeholder="请输入手机验证码"  maxlength="6"/>
                </div>
                <label class="control-label validate-btn" onclick="sendValidateNum(this)" id="second"  >发送验证码</label>
            </div>

            <a class="btn-block" href="javascript:;" id="applyToCash" onclick="">提交保存</a>
        </form>
    </div>

    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
</body>

</html>
