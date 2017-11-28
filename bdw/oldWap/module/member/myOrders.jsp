<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-26
  Time: 上午10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="systemTime" class="java.util.Date" />
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page ? 1 : param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findOrdinaryOrder(loginUser.userId,pageNum,8)}" var="orderProxyPage"/> <%--获取当前用户普通订单--%>
<c:set value="${sdk:findReturnOrderPage(loginUser.userId,pageNum,8,true)}" var="returnOrderProxyPage"/> <%--获取当前用户退货订单--%>
<!DOCTYPE HTML>
<html>

<head>
    <title>我的订单</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/details.css" rel="stylesheet">
    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/saleServiceApply.css" />
    <style type="text/css">
        .timeColor{
            color:#ff0000;
        }
    </style>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var dataValue = {
            webRoot: '${webRoot}',
            orderId: "${param.id}",
            logisticsCompany: "${orderProxy.logisticsCompany}",
            logisticsNum: "${orderProxy.logisticsNum}",
            companyHomeUrl: "${orderProxy.companyHomeUrl}",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"
        }
    </script>
    <script type="text/javascript">
        document.addEventListener("WeixinJSBridgeReady", function () {
            document.getElementById("weixinPay").addEventListener("click", function () {
//                alert("进行微信支付中.....");
                vpayWay(${orderProxy.orderId}, ${orderProxy.orderNum});
            }, !1);
        });

        //微信APP支付
        function vpayWay(orderId, orderNum) {
            $.ajax({
                url: dataValue.webRoot + "wxsdk/wxpay/jspay.json",
                data: {orderNum: orderNum},
                type: "post",
                success: function (data) {
//                    alert("成功生成支付");
//                    alert(data.result);
//                    alert(eval("(" + data.result + ")").appId);
                    if (data.success == "true") {
                        var result = eval("(" + data.result + ")");
                        if(result==null){
                            alert("请求失败，请稍后再进行支付...");
                            result;
                        }
                        var appId = result.appId;
                        var package = result.package;
                        var timestamp = result.timestamp;
                        var noncestr = result.noncestr;
                        var paySign = result.paySign;
                        var signType = result.signType;

                        //微信app支付
                        WeixinJSBridge.invoke('getBrandWCPayRequest', {
                            "appId": appId,
                            "timeStamp": timestamp,
                            "nonceStr": noncestr,
                            "package": package,
                            "signType": signType,
                            "paySign": paySign
                        }, function (res) {
                            // 返回 res.err_msg,取值
                            // get_brand_wcpay_request:cancel 用户取消
                            // get_brand_wcpay_request:fail 发送失败
                            // get_brand_wcpay_request:ok 发送成功

                            var err = res.err_msg;
//                            alert(err);
//                            alert(res.err_code + res.err_desc);
                            WeixinJSBridge.log(err);
                            if (res == null || err == 'get_brand_wcpay_request:fail') {
                                alert("支付失败!");
                                return;
                            }
                            if (err == 'get_brand_wcpay_request:cancel') {
//                                alert("您已取消该次支付!");
                                return;
                            }
                            if (err == 'get_brand_wcpay_request:ok') {
                                setTimeout(function () {
                                    window.location.href = dataValue.webRoot + "/wechat/vpaySuccess.ac?id=" + orderId + "&documentNum=" + result.out_trade_no;
                                }, 1);
                            }
                        });
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });

        }
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=我的订单"/>
<%--页头结束--%>
<div class="container container3">
    <c:choose>
        <c:when test="${empty orderProxyPage.result}">
            <div class="container">
                <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                    <div class="col-xs-12">
                        <%--<span class="glyphicon glyphicon-ok glyphicon-ok2"></span>--%>
                        您还没有下过订单哦，请您先
                        <a href="${webRoot}/wap/list.ac">选购商品»</a>
                    </div>
                </div>
                <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                    <div class="col-xs-12">
                        <button onclick="window.location.href='${webRoot}/wap/index.ac'" class="btn btn-danger btn-danger2" type="button">
                            返回首页
                        </button>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                <div class="row d_rows5">
                    <c:choose>
                        <c:when test="${orderProxy.orderStat == '交易完成' || orderProxy.orderStat =='已取消' || orderProxy.orderStat == '退款完成'}">
                            <div class="row">
                                <div class="col-xs-4 rows5_left4">订单状态：</div>
                                <div class="col-xs-4 rows5_right4" style="color:#009900;">${orderProxy.orderStat}</div>
                                <a href="javascript:void(0);"  class="col-xs-4 rows5_right4" onclick="orderDelete('${orderProxy.orderId}')">删除订单</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <div class="col-xs-4 rows5_left4">订单状态：</div>
                                <div class="col-xs-8 rows5_right4" style="color:#009900;">${orderProxy.orderStat}</div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="row">
                        <div class="col-xs-3 rows5_left2">
                            <c:if test="${not empty orderProxy.orderItemProxyList}">
                                <c:choose>
                                    <c:when test="${not empty orderProxy.sysShopInf.shopType && orderProxy.sysShopInf.shopType == '2'}">
                                        <a href="${webRoot}/wap/citySend/product.ac?productId=${orderProxy.orderItemProxyList[0].productProxy.productId}">
                                            <img src="${orderProxy.orderItemProxyList[0].productProxy.defaultImage["50X50"]}" width="60px;" height="60px;" alt="${orderProxy.orderItemProxyList[0].productProxy.name}"/>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${webRoot}/wap/product-${orderProxy.orderItemProxyList[0].productProxy.productId}.html">
                                            <img src="${orderProxy.orderItemProxyList[0].productProxy.defaultImage["50X50"]}" width="60px;" height="60px;" alt="${orderProxy.orderItemProxyList[0].productProxy.name}"/>
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                            </c:if>
                        </div>
                        <div class="col-xs-9 rows5_right2">
                            <a href="<c:choose>
                                     <c:when test="${isWeixin == 'Y'}">
                                     ${webRoot}/wechat/orderDetail.ac?id=${orderProxy.orderId}
                                     </c:when>
                                     <c:otherwise>
                                     ${webRoot}/oldWap/module/member/orderDetail.ac?id=${orderProxy.orderId}
                                     </c:otherwise>
                                  </c:choose>" title="查看详细">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="rows5_title3">订单编号：${orderProxy.orderNum}</div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-11">
                                        <div class="rows5_title3">订单金额：¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#"/></div>
                                    </div>
                                    <div class="col-xs-1">
                                        <div class="rows5_title3"><span
                                                class="glyphicon glyphicon-chevron-right"></span></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="rows5_title3">下单时间：<fmt:formatDate value="${orderProxy.createDate}"  pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                    </div>
                                </div>

                                <c:if test="${bdw:isShowPayEndTimeOnPage(orderProxy.orderId)}">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="rows5_title3 countDown" id="orderId${orderProxy.orderId}" orderId="${orderProxy.orderId}" lastPayTime="${bdw:getPayEndTimeStr(orderProxy.orderId)}"></div>
                                        </div>
                                    </div>
                                </c:if>
                            </a>

                        <%--    <div class="col-xs-12">
                                <c:if test="${not orderProxy.pay && orderProxy.orderStat != '已取消'}">
                                <c:if test="${orderProxy.payment.payWayId != 1}">
                                    <c:choose>
                                        <c:when test="${isWeixin == 'Y'}">
                                            <c:if test="${orderProxy.payment.payWayId == 30}">
                                                <button class="btn btn-danger btn-danger2" type="button"
                                                        style="margin-top:10px;"
                                                        onclick="window.location.href='${webRoot}/wechat/orderDetail.ac?id=${orderProxy.orderId}&time='+(new Date()).toTimeString();">
                                                    微信支付
                                                </button>
                                            </c:if>
                                            <c:if test="${orderProxy.payment.payWayId != 30}">
                                                <button class="btn btn-danger btn-danger2" type="button"
                                                        style="margin-top:10px; background:#EDEEEE; border:#EDEEEE 1px solid;color:#666666;">当前环境无法进行支付
                                                </button>
                                            </c:if>

                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${orderProxy.payment.payWayId != 30}">
                                                <button class="btn btn-danger btn-danger2" type="button"
                                                        style="margin-top:10px;"
                                                        onclick="window.location.href='${webRoot}/wap/module/member/orderDetail.ac?id=${orderProxy.orderId}&time='+(new Date()).toTimeString();">
                                                    付款
                                                </button>
                                            </c:if>
                                            <c:if test="${orderProxy.payment.payWayId == 30}">
                                                <button class="btn btn-danger btn-danger2" type="button"
                                                        style="margin-top:10px; background:#EDEEEE; border:#EDEEEE 1px solid;color:#666666;">当前环境无法进行支付
                                                </button>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                </c:if>
                                <c:if test="${orderProxy.orderStat=='待买家确认收货'}">
                                    <button class="btn btn-danger btn-danger2" type="button"
                                            style="margin-top:10px; background:#428bca; border:#357ebd 1px solid;"
                                            onclick="buyerSigned('${orderProxy.orderId}')">确认收货
                                    </button>
                                </c:if>

                            </div>--%>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 box_bottom"></div>
                </div>
            </c:forEach>
            <div class="pn-page row">
                <form action="${webRoot}/module/member/orderList.ac" id="pageForm" method="post"
                      style="display: inline;"
                      totalPages='${orderProxyPage.lastPageNumber}' currentPage='${pageNum}'  displayNum='6'
                      totalRecords='${orderProxyPage.totalCount}'>
                    <c:if test="${orderProxyPage.lastPageNumber >1}">
                        <c:choose>
                            <c:when test="${orderProxyPage.firstPage}">
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1">首页</a>
                                </div>
                                <div class="col-xs-3">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=${pageNum-1}">上一页</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default" href="?page=1">首页</a>
                                </div>
                                <div class="col-xs-3">
                                    <a type="button" class="btn btn-sm btn-default" href="?page=${pageNum-1}">上一页</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="col-xs-2 dropup">
                            <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                                    data-toggle="dropdown">
                                    ${pageNum}/${orderProxyPage.lastPageNumber} <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" style="min-width:60px;width:60px;height: auto;max-height:140px;overflow-y: scroll;">

                                <c:forEach begin="1" end="${orderProxyPage.lastPageNumber}" varStatus="status">

                                    <li><a href="?page=${status.index}">${status.index}</a></li>

                                </c:forEach>
                            </ul>
                        </div>
                        <c:choose>
                            <c:when test="${orderProxyPage.lastPage}">
                                <div class="col-xs-3">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                                </div>
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                       href="?page=${orderProxyPage.lastPageNumber}">末页</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-xs-3">
                                    <a type="button" class="btn btn-sm btn-default" href="?page=${pageNum+1}">下一页</a>
                                </div>
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default"
                                       href="?page=${orderProxyPage.lastPageNumber}">末页</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </form>
            </div>


        </c:otherwise>
    </c:choose>
</div>

<div class="overlay" style="display: none;">
    <img src="${webRoot}/template/bdw/statics/images/zoomloader.gif" style="position: absolute; top: 50%; left: 50%;" />
</div>

<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/myOrders.js"></script>
</body>
</html>