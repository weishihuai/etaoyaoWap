<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<%--获取订单项信息--%>
<c:set var="orderItemProxy" value="${sdk:getOrderItemProxyById(param.id)}"/>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>退换货-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/after-service.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" >
        var applyReturnData = {
            webRoot:'${webRoot}',
            orderId:${orderItemProxy.orderId},
            canReturnNum:${not empty orderItemProxy.canReturnNum ? orderItemProxy.canReturnNum : 0},
            orderItemId:${orderItemProxy.orderItemId},
            combinedProductId:${empty orderItemProxy.combinedProductId ? -1:orderItemProxy.combinedProductId}
        }
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/plupload/plupload.full.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/applyReturn.js" defer></script>
</head>
<body>
    <div class="m-top">
        <a class="back" href="javascript:window.history.back(-1);"></a>
        <div class="toggle-box">填写退货单</div>
    </div>

    <div class="ser-main">
        <div class="mt">
            <div class="pic"><a href="javascript:;"><img src="${orderItemProxy.productProxy.defaultImage['200X200']}" alt="${orderItemProxy.productProxy.name}"></a></div>
            <a href="javascript:;" class="title">${orderItemProxy.productProxy.name}</a>
            <span class="price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" pattern="0.00"/></span>
            <div class="add-subtract">
                <a class="subtract" id="returnNum_subtract" href="javascript:;">-</a>
                <input type="text" id="returnNum" value="${not empty orderItemProxy.canReturnNum ? orderItemProxy.canReturnNum : 0}"/>
                <a class="add " id="returnNum_add" href="javascript:;">+</a>
            </div>
        </div>
        <div class="info">
            <div class="item">
                <span>联系人</span>
                <p class="elli" id="name" contenteditable="true">${loginUser.defaultAddress.name}</p>
            </div>
            <div class="item">
                <span>手机号码</span>
                <p class="elli" id="tel" contenteditable="true">${loginUser.defaultAddress.mobile}</p>
            </div>
        </div>
        <div class="question">
            <h5>问题描述</h5>
            <div class="qs-box">
                <textarea id="descr" class="fill-box" placeholder="请描述下您遇到的问题(120字以内)"></textarea>
                <p id="descriptionNum">0/120</p>
            </div>
        </div>
        <div class="up-pic">
            <h5>上传图片</h5>
            <ul>
                <li id="uploadPhoto">
                    <a href="javascript:;"><img src="${webRoot}/template/bdw/wap/module/member/statics/images/shangchuantupian.png" alt="上传图片"></a>
                </li>
                <li class="pic" id="photoFileId" data-fileid="" style="display: none;">
                    <a href="javascript:;"><img src="" alt=""></a>
                    <span class="del-btn" style="display: none;"></span>
                    <span class="percent" style="display: none;"></span>
                </li>
            </ul>
        </div>
        <a href="javascript:;" class="sub-btn" id="applyReturn">提交申请</a>
    </div>

</body>
</html>
