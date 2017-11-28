<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>

<c:set value="${sdk:getReturnedOrder(param.id)}" var="returnPurchaseOrderProxy"/>

<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="utf-8">
    <title>售后详情-退货</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/order-detail.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/return.js" type="text/javascript"></script>

</head>

<body>
    <div class="m-top">
        <a href="${webRoot}/wap/module/member/returnList.ac" class="back"></a>
        <span>售后详情</span>
    </div>

    <div style="padding-top: 1.40625rem;" class="order-d-main">
        <div class="zhifu-time-box zhifu-time-box2">
            <c:choose>
                <c:when test="${returnPurchaseOrderProxy.stat == '已取消'}">
                    <div class="zhifu-time-inner">
                        <p class="title">已取消</p>
                    </div>
                </c:when>
                <c:when test="${returnPurchaseOrderProxy.stat == '待确认'}">
                    <div class="zhifu-time-inner">
                        <p class="title">待审核</p>
                    </div>
                </c:when>
                <c:when test="${returnPurchaseOrderProxy.stat == '同意退货'}">
                    <div class="zhifu-time-inner">
                        <p class="title">已同意</p>
                    </div>
                </c:when>
                <c:when test="${returnPurchaseOrderProxy.stat == '退货完成'}">
                    <div class="zhifu-time-inner">
                        <p class="title">已完成</p>
                    </div>
                </c:when>
            </c:choose>
        </div>

        <c:choose>
            <c:when test="${returnPurchaseOrderProxy.stat == '已取消'}">
                <div class="lc-box">
                    <div class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                    </div>
                    <div class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">取消申请</span>
                    </div>
                </div>
            </c:when>
            <c:when test="${returnPurchaseOrderProxy.stat == '待确认'}">
                <div class="lc-box">
                    <div class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                        <span style="width: 2.2rem;" class="wire"></span>
                        <span class="dot"></span>
                    </div>
                    <div class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">商家审核</span>
                        <span>待商家收货</span>
                        <span>验货入库/完成</span>
                    </div>
                </div>
            </c:when>
            <c:when test="${returnPurchaseOrderProxy.stat == '同意退货'}">
                <div class="lc-box">
                    <div class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span style="width: 2.2rem;" class="wire "></span>
                        <span class="dot"></span>
                    </div>
                    <div class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">商家审核</span>
                        <span class="cur">待商家收货</span>
                        <span>验货入库/完成</span>
                    </div>
                </div>
            </c:when>
            <c:when test="${returnPurchaseOrderProxy.stat == '退货完成'}">
                <div class="lc-box">
                    <div class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span style="width: 2.2rem;" class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                    </div>
                    <div class="txt clearfix">
                        <span class="cur">提交申请</span>
                        <span class="cur">商家审核</span>
                        <span class="cur">待商家收货</span>
                        <span class="cur">验货入库/完成</span>
                    </div>
                </div>
            </c:when>
        </c:choose>


        <div class="question-box">
            <p class="question-name">问题描述</p>
            <p class="question-txt">${returnPurchaseOrderProxy.descr}</p>
        </div>

        <div class="sp-dd">
            <p class="dd-head dd-head-integral">售后单信息</p>
            <c:set value="${returnPurchaseOrderProxy.returnedPurchaseOrderItemProxyList[0]}" var="returnPurchaseOrderItemProxy"/>
            <div class="dd-item">
                <a class="pic" href="javascript:;"><img src="${returnPurchaseOrderItemProxy.images[0]['150X150']}" alt=""></a>
                <a class="name" href="javascript:;">${returnPurchaseOrderItemProxy.productNm}</a>
                <p><span class="price">&nbsp;</span><span class="number">x${returnPurchaseOrderItemProxy.quantity}</span></p>
            </div>
        </div>

        <div style="padding-top: 0.3125rem; margin-top: 0;" class="order-d-info">
            <div class="dd">
                <p><span>售后类型</span>退货</p>
                <p><span>退款金额</span>¥<fmt:formatNumber value="${returnPurchaseOrderProxy.orderTotalAmount}" pattern="0.00"/></p>
                <p><span>联系人</span>${returnPurchaseOrderProxy.name} &nbsp; ${returnPurchaseOrderProxy.tel}</p>
                <p><span>申请时间</span> ${returnPurchaseOrderProxy.createTimeString}</p>
                <p><span>退货单号</span>${returnPurchaseOrderProxy.returnedPurchaseOrderId}</p>
            </div>
        </div>


        <c:choose>
            <c:when test="${returnPurchaseOrderProxy.stat == '待确认'}">
                <div class="bottom-btn-box">
                    <a class="zhifu-btn2" href="javascript:cancelReturn(${returnPurchaseOrderProxy.returnedPurchaseOrderId});">取消申请</a>
                </div>
            </c:when>
            <c:when test="${returnPurchaseOrderProxy.stat == '同意退货' && empty returnPurchaseOrderProxy.logisticsOrderCode}">
                <div class="bottom-btn-box">
                    <a class="zhifu-btn2" href="javascript:showLogisticsWind('${returnPurchaseOrderProxy.returnedPurchaseOrderId}','','');">填写物流信息</a>
                </div>
            </c:when>
            <c:when test="${returnPurchaseOrderProxy.stat == '同意退货' && not empty returnPurchaseOrderProxy.logisticsOrderCode}">
                <div class="bottom-btn-box">
                    <a class="zhifu-btn2" href="javascript:showLogisticsWind('${returnPurchaseOrderProxy.returnedPurchaseOrderId}','${returnPurchaseOrderProxy.logisticsOrderCode}','${returnPurchaseOrderProxy.logisticsCompany}');">修改物流信息</a>
                </div>
            </c:when>
        </c:choose>

    </div>


    <div style="display: none;" class="logistics-layer">
        <div class="logistics-box">
            <div class="dt">填写物流单</div>
            <div class="dd">
                <input id="returnedPurchaseOrderId" type="hidden"/>
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
