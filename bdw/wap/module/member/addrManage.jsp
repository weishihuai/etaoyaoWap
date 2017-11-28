<html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<head lang="en">
    <meta charset="utf-8">
    <title>地址管理</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/site-management.css" type="text/css" rel="stylesheet" />
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/addrManage.js"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot: "${webRoot}"
        };
    </script>
</head>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${loginUser.receiverAddress}" var="addrs"/>

<body>
<div class="m-top">
    <a class="back" target="_self"  onclick="back()"></a>
    <span>地址管理</span>
</div>

<div class="site-management-main">
    <c:choose>
        <c:when test="${not empty addrs}">
            <c:forEach items="${addrs}" var="addr" varStatus="status">
                <div class="item">
                    <p class="name-phone"><span class="name">${addr.name}</span><span class="phone">${addr.mobile}</span></p>
                    <p class="site">${fn:replace(fn:replace(addr.addressPath, "-", ""), "中国", "")}&nbsp;${addr.addr}</p>
                    <div class="btn-box">
                        <c:choose>
                            <c:when test="${status.first}"><em data-id="${addr.receiveAddrId}" class="checkbox checkbox-active" ></em></c:when>
                            <c:otherwise><em data-id="${addr.receiveAddrId}"  class="checkbox"></em></c:otherwise>
                        </c:choose>
                        默认地址<a data-id="${addr.receiveAddrId}" class="del" href="javascript:;">删除</a>
                        <a href="${webRoot}/wap/module/member/addrAdd.ac?id=${addr.receiveAddrId}">编辑</a></div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="none-box">
                <img class="none-icon" src="${webRoot}/template/bdw/wap/module/member/statics/images/kongdizhi.png" alt="">
                <p>暂无收货地址</p>
            </div>
        </c:otherwise>
    </c:choose>
    <a class="site-management-btn" href="${webRoot}/wap/module/member/addrAdd.ac">新建收货地址</a>
</div>
</body>
</html>
