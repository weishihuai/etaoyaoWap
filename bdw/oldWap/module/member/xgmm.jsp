<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>密码修改</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.md5.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        <%--初始化参数，供myPswModify.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
        <%--初始化参数，供myPswModify.js调用 end--%>
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/xgmm.js" type="text/javascript"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=密码修改"/>
<%--页头结束--%>
<div class="container">
    <div class="row m_rows2">
        <div class="col-xs-4">当前密码：</div>
        <div class="col-xs-8">
            <input type="password" class="form-control" id="password" placeholder="请输入当前密码!" onblur="return checkPassword()">
            <div class="alert alert-warning sr-only" id="passwordTip"></div>
        </div>
    </div>

    <div class="row m_rows2">
        <div class="col-xs-4">输入新密码：</div>
        <div class="col-xs-8">
            <input type="password"  class="form-control" id="new_password" maxlength="16" placeholder="密码为6-16个字母或数字!" onblur="return checkNewPassword()">
            <div class="alert alert-warning sr-only"id="new_passwordTip"></div>
        </div>
    </div>
    <div class="row m_rows2">
        <div class="col-xs-4">确认新密码：</div>
        <div class="col-xs-8">
            <input type="password"  class="form-control" id="confirm_password" maxlength="16" placeholder="密码为6-16个字母或数字!" onblur="return checkConfirmPassword()">
            <div class="alert alert-warning sr-only"id="confirm_passwordTip"></div>
        </div>
    </div>

    <div class="row m_rows2">
        <div class="col-xs-12">

            <button class="btn btn-danger btn-lg btn-danger2" type="button" onclick="modPsw()">确定</button>
            <%--<div class="alert alert-success" id="succTip"></div>--%>
        </div>
    </div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>