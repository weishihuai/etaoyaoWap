<%@ page import="com.iloosen.imall.sdk.user.proxy.UserProxy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>

<%-- 如果地址只有一个的情况下，设置这个地址为默认默认地址 --%>
<c:if test="${fn:length(loginUser.receiverAddress) == 1}">
    <%
        UserProxy loginUser = (UserProxy) pageContext.getAttribute("loginUser");
        ServiceManager.receiverAddrService.updateReceiverAddrDefaultId(Integer.parseInt(loginUser.getReceiverAddress().get(0).getReceiveAddrId()));
    %>
</c:if>

<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no, email=no" />
    <title>收货地址</title>
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/myAddressBook.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">

    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/module/member/statics/js/myAddressBook.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=收货地址"/>
<%--页头结束--%>

    <div class="main">
        <c:forEach items="${loginUser.receiverAddress}" var="addrValue" varStatus="s" end="10">
            <div class="address-list">
                <div class="name-phone">
                    <span class="name">${addrValue.name}</span>
                    <span class="phone">${addrValue.mobile}</span>
                </div>
                <div class="address">${addrValue.displayAddr}</div>
                <div class="button-box">
                    <a href="javascript:void(0);" class="default <c:if test="${addrValue.isDefault == 'Y'}">cur</c:if>" receiveAddrId="${addrValue.receiveAddrId}">默认地址</a>
                    <a href="javascript:void(0);" class="del" receiveAddrId="${addrValue.receiveAddrId}">删除</a>
                    <a href="${webRoot}/wap/module/member/addressOperate.ac?receiveAddrId=${addrValue.receiveAddrId}&method=edit" class="edit">编辑</a>
                </div>
            </div>
        </c:forEach>
    </div>

    <a class="add-btn" href="${webRoot}/wap/module/member/addressOperate.ac">添加新地址</a>

<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>
</body>

</html>
