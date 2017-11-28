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
<%--当前用户的换货记录--%>
<c:set value="${sdk:getExchangedPurchaseOrderPage(pageNum,5)}" var="exchangeOrderPage"/>
<%--物流公司列表--%>
<c:set value="${sdk:getLogisticsCompany()}" var="logisticsCompanys"/>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>售后服务-换货</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/service-operation.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript">
        var exchangeListData = {
            webRoot: '${webRoot}',
            lastPageNum:${exchangeOrderPage.lastPageNumber}
        }
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/exchange.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {

            // 加载分页
            $(".after-service-main").infinitescroll({
                navSelector: "#page-nav",
                nextSelector: "#page-nav a",
                itemSelector: ".order-list" ,//需要加载到下一页的内容
                animate: true,
                maxPage: exchangeListData.lastPageNum,
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
        <p><a href="${webRoot}/wap/module/member/returnList.ac">退货进度</a></p>
        <p class="cur">换货进度</p></div>

    <div class="after-service-main">
        <c:choose>
            <c:when test="${not empty exchangeOrderPage.result}">
                <div class="order-list">
                    <c:forEach  items="${exchangeOrderPage.result}" var="exchangeOrderProxy">
                        <div class="sp-dd">
                            <div class="dd-head">换货单号：${exchangeOrderProxy.exchangeOrderId}</div>
                            <c:set var="exchangeOrderItemProxy" value="${exchangeOrderProxy.orderItemProxyList[0]}"/>
                            <div class="dd-item" onclick="window.location.href='${webRoot}/wap/module/member/exchangeDetail.ac?id=${exchangeOrderProxy.exchangeOrderId}'">
                                <a class="pic" href="#"><img src="${exchangeOrderItemProxy.images[0]['200X200']}"
                                                             alt="${exchangeOrderItemProxy.productNm}"></a>
                                <a class="name" href="#">${exchangeOrderItemProxy.productNm}</a>
                                <span class="number">x${exchangeOrderItemProxy.quantity}</span>
                            </div>

                            <c:choose>
                                <c:when test="${exchangeOrderProxy.stat == '待确认'}">
                                    <div class="dd-tips">您的换货申请提交成功，等待商家审核</div>
                                    <div class="btn-box">
                                        <a class="zhifu-btn2" href="javascript:cancelExchange(${exchangeOrderProxy.exchangeOrderId});">取消申请</a>
                                    </div>
                                </c:when>
                                <c:when test="${exchangeOrderProxy.stat == '同意换货' && empty exchangeOrderProxy.logisticsOrderCode}">
                                    <div class="dd-tips">商家已同意换货，请填写物流单号</div>
                                    <div class="btn-box">
                                        <a class="zhifu-btn2" href="javascript:showLogisticsWind('${exchangeOrderProxy.exchangeOrderId}','','');">填写物流信息</a>
                                    </div>
                                </c:when>
                                <c:when test="${exchangeOrderProxy.stat == '同意换货' && not empty exchangeOrderProxy.logisticsOrderCode}">
                                    <div class="dd-tips">商品寄送中，等待商家验货入库</div>
                                    <div class="btn-box">
                                        <a class="zhifu-btn2" href="javascript:showLogisticsWind('${exchangeOrderProxy.exchangeOrderId}','${exchangeOrderProxy.logisticsOrderCode}','${exchangeOrderProxy.logisticsCompany}');">修改物流信息</a>
                                    </div>
                                </c:when>
                                <c:when test="${exchangeOrderProxy.stat == '换货入库'}">
                                    <div class="dd-tips">商家已验货入库，等待商品重新寄出</div>
                                </c:when>
                                <c:when test="${exchangeOrderProxy.stat == '换货出库' }">
                                    <div class="dd-tips">您的换货商品已重新寄出</div>
                                    <div class="btn-box">
                                        <a class="zhifu-btn2" href="javascript:confirmPackage(${exchangeOrderProxy.exchangeOrderId});">确认收货</a>
                                        <a class="zhifu-btn3" href="${webRoot}/wap/module/member/logisticsDetail.ac?logisticsCompany=${exchangeOrderProxy.newLogisticsCompany}&logisticsOrderCode=${exchangeOrderProxy.newLogisticsOrderCode}">查看物流</a>
                                    </div>
                                </c:when>
                                <c:when test="${exchangeOrderProxy.stat == '已完成'}">
                                    <div class="dd-tips">仅换货成功</div>
                                </c:when>
                                <c:when test="${exchangeOrderProxy.stat == '已取消'}">
                                    <div class="dd-tips">本次换货已取消</div>
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
        <a href="${webRoot}/wap/module/member/exchangeList.ac?&page=${pageNum+1}"></a>
    </nav>

    <div style="display: none;" class="logistics-layer">
        <div style="height: auto; padding-bottom: 1.5625rem;" class="logistics-box">
            <div class="dt">填写物流单</div>
            <div class="dd">
                <input id="exchangeOrderId" type="hidden"/>
                <select class="select-class" name="物流单号" id="logisticsCompany">
                    <c:forEach var="logisticsCompany" items="${logisticsCompanys}">
                    <option value="">请选择物流公司</option>
                    <option value="${logisticsCompany.logisticsCompanyName}">${logisticsCompany.logisticsCompanyName}</option>
                    </c:forEach>

                </select>
                <input id="logisticsOrderCode" type="text" placeholder="物流单号"/>
            </div>
            <div class="btn-box">
                <a href="javascript:$('.logistics-layer').hide();">取消</a>
                <a href="javascript:updateLogistics();">确认</a>
            </div>
        </div>
    </div>
</body>

</html>
