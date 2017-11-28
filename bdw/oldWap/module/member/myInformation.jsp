<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE HTML>
<html>
<head>
    <title>个人资料</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.md5.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/myInformation.js" type="text/javascript"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=个人资料"/>
<%--页头结束--%>
<div class="container">
    <div class="row m_rows2">
        <div class="col-xs-12"> <div class="alert alert-warning">温馨提示：修改手机号的同时也会修改登录账号，请慎重修改！</div></div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-12">
            <input type="tel" class="form-control" id="mobile" placeholder="请输入手机号" onblur="return checkMobile()" value="${loginUser.mobile}">
            <div class="alert alert-warning sr-only" id="mobileTip"></div>
        </div>
    </div>

    <div class="row m_rows2">
        <div class="col-xs-12">
            <input type="email"  class="form-control" id="email"  placeholder="请输入电子邮箱" onblur="return checkUserMailValidate()" value="${loginUser.email}">
            <div class="alert alert-warning sr-only"id="emailTip"></div>
        </div>
    </div>

    <div class="row m_rows2">
        <div class="col-xs-12">
            <button class="btn btn-danger btn-lg btn-danger2" type="button" onclick="modUserInfo()">确定</button>
        </div>
    </div>
</div>
<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>

</body>
</html>