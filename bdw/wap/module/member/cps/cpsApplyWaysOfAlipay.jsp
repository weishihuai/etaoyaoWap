<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

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

    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css" />

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsApplyWaysInf.js"></script>
    <script type="text/javascript">
     var webParams = {
    	webRoot: '${webRoot}'
   
    };
    </script>
</head>

<body>
    <%--<header class="header">
        <a href="javascript:history.go(-1);" class="back"></a>
        <div class="header-title">绑定支付宝</div>
    </header>--%>
    <div class="main">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="control-label" for="">真实姓名</label>
                <div class="input-group">
                    <a class="clear" href="javascript:;"></a>
                    <input class="form-control" type="text" value="" placeholder="请输入真实姓名" id="alipayOpenManName"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label" for="">支付账号</label>
                <div class="input-group">
                    <a class="clear" href="javascript:;"></a>
                    <input class="form-control" type="text" value="" placeholder="请输入支付账号" id="alipayAccount"/>
                </div>
            </div>

            <a class="btn-block" href="javascript:submitAlipay()">提交保存</a>
        </form>
    </div>

    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
</body>

</html>
