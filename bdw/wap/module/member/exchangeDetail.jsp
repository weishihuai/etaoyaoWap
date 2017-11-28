<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>

<c:set value="${sdk:getExchangedOrder(param.id)}" var="exchangeOrderProxy"/>
<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="utf-8">
    <title>售后详情-换货</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/order-detail.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/exchange.js" type="text/javascript"></script>

</head>

<body>
    <div class="m-top">
        <a href="${webRoot}/wap/module/member/exchangeList.ac" class="back"></a>
        <span>售后详情</span>
    </div>

    <div style="padding-top: 1.40625rem;" class="order-d-main">
        <div class="zhifu-time-box zhifu-time-box2">
            <c:choose>
                <c:when test="${exchangeOrderProxy.stat == '已取消'}">
                    <div class="zhifu-time-inner">
                        <p class="title">已取消</p>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '待确认'}">
                    <div class="zhifu-time-inner">
                        <p class="title">待审核</p>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '同意换货'}">
                    <div class="zhifu-time-inner">
                        <p class="title">已同意</p>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '换货入库'}">
                    <div class="zhifu-time-inner">
                        <p class="title">已同意</p>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '换货出库'}">
                    <div class="zhifu-time-inner">
                        <p class="title">已同意</p>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '已完成'}">
                    <div class="zhifu-time-inner">
                        <p class="title">已完成</p>
                    </div>
                </c:when>
            </c:choose>
        </div>

        <div class="lc-box">
            <c:choose>
                <c:when test="${exchangeOrderProxy.stat == '已取消'}">
                    <div style="width: 12rem; padding-left: 1rem; padding-right: 1rem;" class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                    </div>
                    <div style="width: 12.206rem;" class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">取消申请</span>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '待确认'}">
                    <div style="width: 14rem; padding-left: 1rem; padding-right: 1rem;" class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                    </div>
                    <div style="width: 14rem;" class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">商家审核</span>
                        <span>待商家收货</span>
                        <span>验货入库</span>
                        <span>商家发货</span>
                        <span style="width: 2rem;">完成</span>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '同意换货'}">
                    <div style="width: 14rem; padding-left: 1rem; padding-right: 1rem;" class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                    </div>
                    <div style="width: 14rem;" class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">商家审核</span>
                        <span class="cur">待商家收货</span>
                        <span>验货入库</span>
                        <span>商家发货</span>
                        <span style="width: 2rem;">完成</span>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '换货入库'}">
                    <div style="width: 14rem; padding-left: 1rem; padding-right: 1rem;" class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                    </div>
                    <div style="width: 14rem;" class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">商家审核</span>
                        <span class="cur">待商家收货</span>
                        <span class="cur">验货入库</span>
                        <span>商家发货</span>
                        <span style="width: 2rem;">完成</span>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '换货出库'}">
                    <div style="width: 14rem; padding-left: 1rem; padding-right: 1rem;" class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                    </div>
                    <div style="width: 14rem;" class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">商家审核</span>
                        <span class="cur">待商家收货</span>
                        <span class="cur">验货入库</span>
                        <span class="cur">商家发货</span>
                        <span style="width: 2rem;">完成</span>
                    </div>
                </c:when>
                <c:when test="${exchangeOrderProxy.stat == '已完成'}">
                    <div style="width: 14rem; padding-left: 1rem; padding-right: 1rem;" class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                    </div>
                    <div style="width: 14rem;" class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">商家审核</span>
                        <span class="cur">待商家收货</span>
                        <span class="cur">验货入库</span>
                        <span class="cur">商家发货</span>
                        <span style="width: 2rem;" class="cur">完成</span>
                    </div>
                </c:when>
            </c:choose>

        </div>

        <div class="question-box">
            <p class="question-name">问题描述</p>
            <p class="question-txt">${exchangeOrderProxy.descr}</p>
        </div>

        <div class="sp-dd">
            <p class="dd-head dd-head-integral">售后单信息</p>
            <c:set var="exchangeOrderItem" value="${exchangeOrderProxy.orderItemProxyList[0]}"/>
            <div class="dd-item">
                <a class="pic" href="javascript:;"><img src="${exchangeOrderItem.images[0]['150X150']}" alt=""></a>
                <a class="name" href="javascript:;">${exchangeOrderItem.productNm}</a>
                <p><span class="price">&nbsp;</span><span class="number">x${exchangeOrderItem.quantity}</span></p>
            </div>
        </div>

        <div style="padding-top: 0.3125rem; margin-top: 0;" class="order-d-info">
            <div class="dd">
                <p><span>售后类型</span>换货</p>
                <p><span>联系人</span>${exchangeOrderProxy.name} &nbsp; ${exchangeOrderProxy.tel}</p>
                <p><span>申请时间</span> ${exchangeOrderProxy.createTimeString}</p>
                <p><span>换货单号</span>${exchangeOrderProxy.exchangeOrderId}</p>
            </div>
        </div>


        <c:choose>
            <c:when test="${exchangeOrderProxy.stat == '待确认'}">
                <div class="bottom-btn-box">
                    <a class="zhifu-btn2" href="javascript:cancelExchange(${exchangeOrderProxy.exchangeOrderId});">取消申请</a>
                </div>
            </c:when>
            <c:when test="${exchangeOrderProxy.stat == '同意换货'}">
                <div class="bottom-btn-box">
                    <a class="zhifu-btn2" href="javascript:showLogisticsWind('${exchangeOrderProxy.exchangeOrderId}','${exchangeOrderProxy.logisticsOrderCode}','${exchangeOrderProxy.logisticsCompany}');">填写物流信息</a>
                </div>
            </c:when>
            <c:when test="${exchangeOrderProxy.stat == '换货出库'}">
                <div class="bottom-btn-box">
                    <a class="zhifu-btn2" href="javascript:confirmPackage(${exchangeOrderProxy.exchangeOrderId});">确认收货</a>
                    <a class="zhifu-btn3" href="javascript:;">查看物流</a>
                </div>
            </c:when>
        </c:choose>
    </div>

    <div style="display: none;" class="logistics-layer">
        <div class="logistics-box">
            <div class="dt">填写物流单</div>
            <div class="dd">
                <input id="exchangeOrderId" type="hidden"/>
                <input id="logisticsOrderCode" type="text" placeholder="物流单号"/>
                <input id="logisticsCompany" type="text" placeholder="物流公司"/>
            </div>
            <div class="btn-box">
                <a href="javascript:$('.logistics-layer').hide();">取消</a>
                <a href="javascript:updateLogistics();">确认</a>
            </div>
        </div>
    </div>
</body>

</html>
