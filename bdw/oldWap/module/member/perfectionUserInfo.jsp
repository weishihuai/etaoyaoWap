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
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${webName}-完善资料</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/perfectionUserInfo.js"></script>
    <script type="text/javascript">
        <%--初始化参数，供myAddressBook.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
    </script>
</head>

<body style="background-color: #fff;">

<div class="container wdjp_box" style="box-shadow: none; margin-top: 0px;">
    <div class="row d_rows">
        <div class="col-xs-3 text-right">绑定邮箱：</div>
        <div class="col-xs-9">
            <input type="hidden" id="userId" value="${param.userid}" >
            <c:choose>
                <c:when test="${not empty loginUser.email}"><input type="email" class="form-control" id="userEmail" placeholder="请输入您的邮箱"onfocus="getFocus('userEmail','email_msg')" value="${loginUser.email}" ></c:when>
                <c:otherwise><input type="email" class="form-control" id="userEmail" placeholder="请输入您的邮箱"onfocus="getFocus('userEmail','email_msg')"></c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
<div class="container wdjp_box" style="box-shadow: none; margin-top: 0px;">
    <div class="row d_rows">
        <div class="col-xs-3 text-right">绑定手机：</div>
        <div class="col-xs-9">
            <c:choose>
                <c:when test="${not empty loginUser.mobile}"><input type="NUMBER" class="form-control" id="userMobile" placeholder="请输入11位手机号码" onfocus="getFocus('userMobile','uobile_msg')" value="${loginUser.mobile}"></c:when>
                <c:otherwise><input type="NUMBER" class="form-control" id="userMobile" placeholder="请输入11位手机号码" onfocus="getFocus('userMobile','uobile_msg')"></c:otherwise>
            </c:choose>

        </div>
    </div>
</div>

<div class="row">
    <div class="col-xs-12" style="padding-left: 15px;padding-right: 15px;">
            <a type="button" class="btn btn-danger btn-block" onclick="updateSysUser()">保存</a>
    </div>
</div>

<div class="row" style="margin-top: 10px;">
    <div class="col-xs-12" style="padding-left: 15px;padding-right: 15px;">
        <a class="btn btn-default btn-block" type="button" href="${webRoot}/wap/module/member/myAccount.ac">取消</a>
    </div>
</div>


</body>
</html>
