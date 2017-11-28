<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<html>

<head lang="en">
    <meta charset="utf-8">
    <title>提交订单-成功</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/order.css" type="text/css" rel="stylesheet" />
</head>

<body>

<c:choose>
    <c:when test="${(empty param.carttype or param.carttype eq 'normal' or param.carttype eq 'store' or param.carttype eq 'groupBuy') and param.carttype ne 'drug' and param.carttype ne 'store_drug'}">
        <div class="m-top">
            <a href="javascript:history.go(-1);" class="back"></a>
            <span>提交订单成功</span>
        </div>
        <div class="order-main">
            <div class="submit-order">
                <div class="dt"><em></em><p>恭喜！您已成功提交订单</p></div>
                    <div class="submit-btn-box">
                        <c:choose>
                            <c:when test="${empty param.carttype or param.carttype eq 'normal'}">
                                <a class="check-btn" href="${webRoot}/wap/module/member/myOrders.ac">查看订单</a>
                            </c:when>
                            <c:when test="${param.carttype eq 'store'}">
                                <a class="check-btn" href="${webRoot}/wap/module/member/storeOrder.ac">查看订单</a>
                            </c:when>
                            <c:when test="${param.carttype eq 'groupBuy'}">
                                <a class="check-btn" href="${webRoot}/wap/module/member/myOrders.ac?promotionTypeCode=1">查看订单</a>
                            </c:when>
                        </c:choose>
                        <a class="return-index-btn" href="${webRoot}/wap/index.ac">返回首页</a>
                    </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="m-top">
            <a href="javascript:history.go(-1);" class="back"></a>
            <span>提交预定成功</span>
        </div>
        <div class="order-main">
            <div class="submit-order">
                <div class="dt"><em></em><p>恭喜！您已成功提交预定</p></div>
                <div class="submit-lc">
                    <p>稍后药房会通过电话或者短信通知您预定结果</p>
                    <div class="icon clearfix">
                        <span class="dot dot-c"></span>
                        <span class="wire wire-c"></span>
                        <span class="dot dot-c"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                        <span class="wire"></span>
                        <span class="dot"></span>
                    </div>
                    <div class="txt clearfix"><span class="cur">提交预定</span><span class="cur">药师回拨</span><span>线下付款</span><span>结束流程</span></div>
                </div>
                <div class="submit-btn-box">
                    <c:choose>
                        <c:when test="${param.carttype eq 'store_drug'}">
                            <a class="check-btn" href="${webRoot}/wap/module/member/storeOrder.ac">查看预定</a>
                        </c:when>
                        <c:otherwise>
                            <a class="check-btn" href="${webRoot}/wap/module/member/myOrders.ac">查看预定</a>
                        </c:otherwise>
                    </c:choose>
                    <a class="return-index-btn" href="${webRoot}/wap/index.ac">返回首页</a>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>
<script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
</body>
