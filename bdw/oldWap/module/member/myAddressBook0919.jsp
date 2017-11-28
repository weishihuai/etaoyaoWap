<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-27
  Time: 下午2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE HTML>
<html>
<head>
    <title>收货地址</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">
    <script type="text/javascript">
        <%--初始化参数，供myAddressBook.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
        <%--初始化参数，供myAddressBook.js调用 end--%>
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=收货地址"/>
<%--页头结束--%>

<c:forEach end="10" items="${loginUser.receiverAddress}" var="addrValue">
<div class="row">
    <div class="col-xs-12 adr_rows" style="border-bottom: 1px solid #DCDDDD;border-top: none;">
        <a href="${webRoot}/wap/module/member/addressOperate.ac?receiveAddrId=${addrValue.receiveAddrId}">
        <div class="row">
            <div class="col-xs-12 adr_name">${addrValue.name}&nbsp;&nbsp;${addrValue.mobile}&nbsp;&nbsp; ${addrValue.tel}</div>
        </div>

        <div class="row">
            <div class="col-xs-11 adr_text">${addrValue.addressPath}</div>
            <div class="col-xs-1">
                <div class="rows5_title3">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </div>
            </div>
        </div>
<%--        <div class="row">
            <div class="col-xs-12 adr_text">${addrValue.addressstr}</div>
        </div>--%>
        </a>
    </div>
</div>
</c:forEach>

<div class="row" style=" margin-top: 8px; margin-bottom: 10px;">
    <div class="col-xs-10 col-xs-offset-1" >
        <button onclick="window.location.href='${webRoot}/wap/module/member/addressOperate.ac'" class="btn btn-default btn-default_adr btn-block" style="border: 1px solid #CC3333;background: none repeat scroll 0 0 #CC3333; color: #fff; font-weight: bold;" type="button">添加收货地址</button>
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