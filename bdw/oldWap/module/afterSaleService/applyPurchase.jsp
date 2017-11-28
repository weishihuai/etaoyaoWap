<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${sdk:findOrderDetailed(param.orderId)}" var="orderProxy"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>填写换货申请-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/base.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/return.css">
    <%--<link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />--%>
    <%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>--%>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/ObjectToJsonUtil.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>

    <script src="${webRoot}/template/bdw/oldWap/statics/js/applyPurchase.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            receiverZoneId:"${orderProxy.receiverZoneId}",
            orderItems :'${param.orderItems}',
            orderId:'${param.orderId}',
            isReturn: '${param.isReturn}',
            itemNums: '${param.numStr}'
        };
    </script>
</head>

<body>
<div class="main m-fill">
    <c:forEach items="${userCartListProxy.receiverAddrVoByUserId}" var="receiver" varStatus="status">
        <c:if test="${receiver.isDefault == 'Y'}">
            <c:set var="defaultReceiver" value="${receiver}"/>
            <%--<input type="hidden" id="receiveAddrId" value="${receiver.receiveAddrId}">--%>
        </c:if>
    </c:forEach>
    <div class="addr-box" style="display: <c:if test="${param.isReturn=='true'}">none</c:if>">
        <c:choose>
            <c:when test="${not empty defaultReceiver}">
        <dl>
            <dt>
                <a href="javascript:;">收货地址</a>
            </dt>
            <dd>
                <p><em id="receiverName" >${defaultReceiver.name}</em>&emsp;&emsp;<em id="mobile">${defaultReceiver.mobile}</em></p>
                <p ><em id="receiver">${defaultReceiver.addressPath}</em>&nbsp;<em id="address">${defaultReceiver.addr}</em></p>
            </dd>
        </dl>
            </c:when>
            <c:otherwise>
            <dl>
                <dt>
                    <a href="javascript:;">收货地址</a>
                </dt>
                <dd>
                    添加收货地址
                </dd>
            </dl>
            </c:otherwise>
        </c:choose>
    </div>
    <ul class="good-list">
    <c:forEach end="10" items="${param.orderItems}" var="orderItemId">
        <c:set value="${sdk:getOrderItemProxyById(orderItemId)}" var="orderItemProxy"/>
        <li class="good checked">
            <div class="good-img">
                <img src="${orderItemProxy.productProxy.defaultImage["100X100"]}" alt="">
            </div>
            <div class="good-body">
                <p class="good-name">${orderItemProxy.productProxy.name}</p>
                <span class="good-amount" orderItemId="${orderItemId}"  /></span>
            </div>
        </li>
    </c:forEach>
    </ul>
    <dl class="question-box">
        <dt>问题描述</dt>
        <dd>
            <textarea name="describe" id="descr" placeholder="请描述下您遇到的问题(120字以内)" maxlength="120"></textarea>
        </dd>
    </dl>
    <dl class="img-box">
        <dt>上传图片</dt>
        <dd>
            <button class="add" type="button">添加图片</button>
            <div class="img">
                <%--<button class="del" type="button">删除</button>--%>
                <img id="hh_upload_pic" src="${webRoot}/${templateCatalog}/statics/images/noPic_100X100.jpg" alt="">
                        <input type="hidden" name="photoFileId" id="hh_photoFileId" value="" />

            </div>
        </dd>
    </dl>
    <div class="submit-box">
        <button class="btn-block" type="button">提交申请</button>
    </div>

</div>

<div class="overlay" style="display: none;" id="tip" >
    <div class="lightbox fill-dt">
        <div class="mt">
            <span>上传图片</span>
            <a href="javascript:" class="close"></a>
        </div>
        <div class="mc">
            <form id="upload" action="${webRoot}/member/uploadPhoto.ac" method="post" enctype="multipart/form-data">
                <input type="file" id="tmpFile" name="imageFile" />
                <a href="javascript:"  id="sm" class="confirm color">确定</a>
            </form>

        </div>
    </div>
</div>


<script src="${webRoot}/template/bdw/oldWap/statics/js/base.js"></script>
</body>

</html>
