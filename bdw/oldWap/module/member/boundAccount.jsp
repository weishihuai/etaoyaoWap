<%--
  Created by IntelliJ IDEA.
  User: ljt
  Date: 14-3-25
  Time: 下午6:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>帐号绑定</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.md5.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script src="${webRoot}/template/bdw/oldWap/module/member/statics/js/boundAccount.js"></script>
</head>

<body>

<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=绑定会员"/>
<%--页头结束--%>
<div class="container wdjp_box" style="box-shadow: none;">
    <div class="row d_rows">
        <div class="col-xs-3 text-right">帐&nbsp;&nbsp;&nbsp;&nbsp;号：</div>
        <div class="col-xs-9">
            <input type="hidden" id="userId" value="${param.userid}" >
            <input type="text" class="form-control" id="loginId" placeholder="请输入您的帐号" onblur="checkLoginId();">
            <div id="loginId_msg"></div>
        </div>
    </div>

    <div class="row d_rows">
        <div class="col-xs-3 text-right">密&nbsp;&nbsp;&nbsp;&nbsp;码：</div>
        <div class="col-xs-9">
            <input type="password" class="form-control" id="userPsw" placeholder="请输入您的密码"onblur="checkUserPsw();">
            <div id="userPsw_msg"></div>
        </div>
    </div>

    <div class="row d_rows">
        <div class="col-xs-3 text-right">验证码：</div>
        <div class="col-xs-5">
            <input type="NUMBER" class="form-control" id="validateCode" name="validateCode" placeholder="请输入验证码" onblur="CheckValidateCode();">
        </div>
        <div class="col-xs-4" style="margin-top:6px;">
            <div class="yzm_pic"><a href="javascript:void(0);;"onclick="changValidateCode();return false;"><img id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'></a></div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-xs-12" style="padding-left: 15px;padding-right: 15px;">
        <a type="button" class="btn btn-danger btn-block" onclick="updateUser()">确定</a>
    </div>
</div>

<div class="row" style="margin-top: 10px;">
    <div class="col-xs-12" style="padding-left: 15px;padding-right: 15px;">
        <a class="btn btn-default btn-block" type="button" href="${webRoot}/wap/module/member/myAccount.ac">取消</a>
    </div>
</div>


</body>
</html>
