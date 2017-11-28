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
        var applyExchangeData = {
            webRoot:'${webRoot}',
            orderId:${orderItemProxy.orderId},
            canExchangeNum:${not empty orderItemProxy.canExchangeNum ? orderItemProxy.canExchangeNum : 0},
            orderItemId:${orderItemProxy.orderItemId},
            combinedProductId:${empty orderItemProxy.combinedProductId ? -1:orderItemProxy.combinedProductId}
        }
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/plupload/plupload.full.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/applyExchange.js" defer></script>

</head>
<body>
    <div class="m-top">
        <a class="back" href="javascript:window.history.back(-1);"></a>
        <div class="toggle-box">填写换货单</div>
    </div>

    <div class="ser-main">
        <div class="mt">
            <div class="pic"><a href="javascript:;"><img src="${orderItemProxy.productProxy.defaultImage['200X200']}" alt="${orderItemProxy.productProxy.name}"></a></div>
            <a href="javascript:;" class="title">${orderItemProxy.productProxy.name}</a>
            <span class="price">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" pattern="0.00"/></span>
            <div class="add-subtract">
                <a class="subtract" id="exchangeNum_subtract" href="javascript:;">-</a>
                <input type="text" id="exchangeNum" value="${not empty orderItemProxy.canExchangeNum ? orderItemProxy.canExchangeNum : 0}"/>
                <a class="add " id="exchangeNum_add" href="javascript:;">+</a>
            </div>
        </div>
        <div class="info">
            <div class="item">
                <span>联系人</span>
                <p class="elli" id="name">${loginUser.defaultAddress.name}</p>
            </div>
            <div class="item">
                <span>手机号码</span>
                <p class="elli" id="tel">${loginUser.defaultAddress.mobile}</p>
            </div>
            <div class="item">
                <span>收货地址</span>
                <a href="javascript:;"><p class="elli" id="receiverAddr">${loginUser.defaultAddress.displayAddr}</p></a>
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
        <a href="javascript:;" class="sub-btn" id="applyExchange">提交申请</a>
    </div>
    <div class="address-layer" style="display: none">
        <div class="addr-box">
            <h5>收货地址</h5>
            <ul id="addrList">
                <c:forEach var="addrValue" items="${loginUser.receiverAddress}" >
                    <li>
                        <a href="javascript:;" class="${addrValue.isDefault eq 'Y' ? 'selected':''}">
                            <span class="addrNm">${addrValue.name}</span>
                            <span class="addrMobile">${addrValue.mobile}</span>
                            <p class="addrStr">${addrValue.displayAddr}</p>
                        </a>
                    </li>
                </c:forEach>
            </ul>
            <a href="javascript:;" class="confirm" id="selectingAddr">确定</a>
        </div>
    </div>

</body>
</html>
