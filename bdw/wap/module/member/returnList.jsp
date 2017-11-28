<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<%--页码--%>
<c:set value="${empty param.page ? 1:param.page}" var="pageNum"/>
<%--当前用户的退货记录--%>
<c:set value="${sdk:getReturnedPurchaseOrderPage(pageNum,5)}" var="returnOrderPage"/>

<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="utf-8">
    <title>售后服务-退货</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/service-operation.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript">
        var returnOrderListData = {
            webRoot: '${webRoot}',
            lastPageNum:${returnOrderPage.lastPageNumber}
        }
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/return.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {

            // 加载分页
            $(".after-service-main").infinitescroll({
                navSelector: "#page-nav",
                nextSelector: "#page-nav a",
                itemSelector: ".order-list" ,//需要加载到下一页的内容
                animate: true,
                maxPage: returnOrderListData.lastPageNum,
                loading: {
                    finishedMsg: '无更多数据'
                },
                extraScrollPx: 50
            });

        });
    </script>
</head>

<body>

    <div class="m-top">
        <a href="${webRoot}/wap/module/member/index.ac" class="back"></a>
        <span>售后服务</span>
    </div>

    <div class="after-service-toggle">
        <p class="cur">退货进度</p>
        <p><a href="${webRoot}/wap/module/member/exchangeList.ac">换货进度</a></p>
    </div>

    <div class="after-service-main">
        <c:choose>
            <c:when test="${not empty returnOrderPage.result}">
                <div class="order-list">
                    <c:forEach var="returnOrderProxy" items="${returnOrderPage.result}">
                        <div class="sp-dd">
                            <div class="dd-head">退货单号：${returnOrderProxy.returnedPurchaseOrderId}</div>
                            <c:set var="returnOrderItemProxy" value="${returnOrderProxy.returnedPurchaseOrderItemProxyList[0]}"/>
                            <div class="dd-item" onclick="window.location.href='${webRoot}/wap/module/member/returnDetail.ac?id=${returnOrderProxy.returnedPurchaseOrderId}'">
                                <a class="pic" href="javascript:;"><img src="${returnOrderItemProxy.images[0]['200X200']}" alt=""></a>
                                <a class="name" href="javascript:;">${returnOrderItemProxy.productNm}</a>
                                <span class="number">x${returnOrderItemProxy.quantity}</span>
                                <p class="tukuan-price">预计退款金额：¥<fmt:formatNumber value="${returnOrderProxy.orderTotalAmount}" pattern="0.00"/></p>
                            </div>
                            <c:choose>
                                <c:when test="${returnOrderProxy.stat == '待确认'}">
                                    <div class="dd-tips">您的退货申请提交成功，等待商家审核</div>
                                    <div class="btn-box">
                                        <a class="zhifu-btn2" href="javascript:cancelReturn(${returnOrderProxy.returnedPurchaseOrderId});">取消申请</a>
                                    </div>
                                </c:when>
                                <c:when test="${returnOrderProxy.stat == '同意退货' && empty returnOrderProxy.logisticsOrderCode}">
                                    <div class="dd-tips">商家已同意退货，请填写物流单号</div>
                                    <div class="btn-box">
                                        <a class="zhifu-btn2" href="javascript:showLogisticsWind('${returnOrderProxy.returnedPurchaseOrderId}','','');">填写物流信息</a>
                                    </div>
                                </c:when>
                                <c:when test="${returnOrderProxy.stat == '同意退货' && not empty returnOrderProxy.logisticsOrderCode}">
                                    <div class="dd-tips">商品寄送中，等待商家验货入库</div>
                                    <div class="btn-box">
                                        <a class="zhifu-btn2" href="javascript:showLogisticsWind('${returnOrderProxy.returnedPurchaseOrderId}','${returnOrderProxy.logisticsOrderCode}','${returnOrderProxy.logisticsCompany}');">修改物流信息</a>
                                    </div>
                                </c:when>
                                <c:when test="${returnOrderProxy.stat == '退货完成'}">
                                    <div class="dd-tips">退货成功</div>
                                </c:when>
                                <c:when test="${returnOrderProxy.stat == '已取消'}">
                                    <div class="dd-tips">本次退货已取消</div>
                                </c:when>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="none-box">
                    <img class="none-icon" src="${webRoot}/template/bdw/wap/module/member/statics/images/kongshouhou.png" alt="">
                    <p>你还没有任何售后订单</p>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <%--下一页导航--%>
    <nav id="page-nav">
        <a href="${webRoot}/wap/module/member/returnList.ac?&page=${pageNum+1}"></a>
    </nav>

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
