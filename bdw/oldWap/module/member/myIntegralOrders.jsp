<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findAllIntegralOrder(loginUser.userId,pageNum,8)}" var="orderProxyPage"/>
<!DOCTYPE HTML>
<html>
<head>
    <title>我的积分订单</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/details.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var dataValue = {
            webRoot: "${webRoot}",
            orderId: "${param.id}",
            <%--logisticsCompany: "${orderProxyPage.logisticsCompany}",--%>
            <%--logisticsNum: "${orderProxyPage.logisticsNum}",--%>
            <%--companyHomeUrl: "${orderProxyPage.companyHomeUrl}"--%>
        }
    </script>
    <script type="text/javascript">
        document.addEventListener("WeixinJSBridgeReady", function () {
            document.getElementById("weixinPay").addEventListener("click", function () {
//                alert("进行微信支付中.....");
                vpayWay(${orderProxyPage.result[0].integralOrderId}, ${orderProxyPage.result[0].orderNum});
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
                        if (result == null) {
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
                                    window.location.href = dataValue.webRoot + "/wechat/vpaySuccess.ac?id=" + orderId;
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
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=我的积分订单"/>
<%--页头结束--%>
<div class="container container3">
    <c:choose>
        <c:when test="${empty orderProxyPage.result}">
            <div class="container">
                <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                    <div class="col-xs-12">
                            <%--<span class="glyphicon glyphicon-ok glyphicon-ok2"></span>--%>
                        您还没有下过积分订单哦，请您先
                        <a href="${webRoot}/wap/integralList.ac">选购积分商品»</a>
                    </div>
                </div>
                <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                    <div class="col-xs-12">
                        <button onclick="window.location.href='${webRoot}/wap/index.ac'"
                                class="btn btn-danger btn-danger2" type="button">
                            返回首页
                        </button>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                <div class="row d_rows5">
                    <div class="row">
                        <div class="col-xs-4 rows5_left4">订单状态：</div>
                        <div class="col-xs-8 rows5_right4" style="color:#009900;">
                            <div class="row">
                                <div class="col-xs-6 ">
                                    ${orderProxy.orderStat}
                                </div>
                                <div class="col-xs-6 ">
                                    <c:if test="${orderProxy.isBuyerSigned=='N'&&orderProxy.orderStat=='已发货'}">
                                        <a id="buyerSignedBtn" class="btn btn-xs btn-default" href="javascript:" onclick="buyerSigned('${orderProxy.integralOrderId}')">确认收货 </a>
                                    </c:if>
                                    <c:if test="${orderProxy.isPayed eq 'N' && orderProxy.orderStat eq '未支付'}">
                                        <a class="btn btn-xs" href="javascript:" onclick="goToPay('${orderProxy.integralOrderId}')">在线支付</a>
                                    </c:if>
                                </div>

                            </div>
                        </div>
                    </div>
                    <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" end="0">
                        <div class="row">
                            <div class="col-xs-3 rows5_left2">
                               <%-- <c:if test="${not empty orderProxy.orderItemProxyList}">
                                    <img src="${orderItemProxy.productImage['50X50']}" width="60px;" height="60px;"
                                         alt="${orderItemProxy.integralProductNm}"/>
                                </c:if>--%>
                                <%--wap/product.ac?id=1356--%>
                                <c:if test="${not empty orderProxy.orderItemProxyList}">
                                    <a  href="${webRoot}/wap/integralDetails.ac?integralProductId=${orderItemProxy.integralProductId}">
                                        <img src="${orderItemProxy.productImage["50X50"]}" width="50px" height="50px" alt="${orderItemProxy.integralProductNm}"/></a>
                                    <a  href="${webRoot}/wap/integralDetails.ac?integralProductId=${orderItemProxy.integralProductId}" title="${orderItemProxy.integralProductNm}">
                                            ${sdk:cutString(orderItemProxy.integralProductNm, 30, "...")}</a>
                                </c:if>
                            </div>
                            <div class="col-xs-9 rows5_right2">
                                <a href="<c:choose>
                                     <c:when test="${isWeixin == 'Y'}">
                                     ${webRoot}/wap/module/member/integralOrderDetail.ac?id=${orderItemProxy.integralOrderId}
                                     </c:when>
                                     <c:otherwise>
                                     ${webRoot}/wap/module/member/integralOrderDetail.ac?id=${orderItemProxy.integralOrderId}
                                     </c:otherwise>
                                  </c:choose>" title="查看详细">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="rows5_title3">支付类型：
                                                <c:choose>
                                                    <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                                        固定积分
                                                    </c:when>
                                                    <c:otherwise>
                                                        积分+现金
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="rows5_title3">订单编号：${orderProxy.orderNum}</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-11">
                                            <div class="rows5_title3">订单总计：
                                                <c:choose>
                                                    <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                                        <fmt:formatNumber value="${orderProxy.totalIntegral}" type="number" pattern="######.##"/>分
                                                    </c:when>
                                                    <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                                        <fmt:formatNumber value="${orderProxy.totalExchangeIntegral}" type="number" pattern="######.##"/>分 +
                                                        <fmt:formatNumber value="${orderProxy.totalExchangeAmount}" type="number" pattern="######.##"/>元
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="col-xs-1">
                                            <div class="rows5_title3"><span
                                                    class="glyphicon glyphicon-chevron-right"></span></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="rows5_title3">下单时间：<fmt:formatDate
                                                    value="${orderProxy.createDate}"
                                                    pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                        </div>
                                    </div>
                                </a>

                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="row">
                    <div class="col-xs-12 box_bottom"></div>
                </div>
            </c:forEach>
            <div class="pn-page row">
                <form action="${webRoot}/module/member/orderList.ac" id="pageForm" method="post"
                      style="display: inline;"
                      totalPages='${orderProxyPage.lastPageNumber}' currentPage='${pageNum}' displayNum='6'
                      totalRecords='${orderProxyPage.totalCount}'>
                    <c:if test="${orderProxyPage.lastPageNumber >1}">
                        <c:choose>
                            <c:when test="${orderProxyPage.firstPage}">
                                <div class="col-xs-2">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1">首页</a>
                                </div>
                                <div class="col-xs-3">
                                    <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                       href="?page=${pageNum-1}">上一页</a>
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
                        <div class="col-xs-2">
                            <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                                    data-toggle="dropdown">
                                    ${pageNum}/${orderProxyPage.lastPageNumber} <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" style="width:50px;height: 160px;overflow-y: scroll;">

                                <c:forEach begin="1" end="${orderProxyPage.lastPageNumber}" varStatus="status">

                                    <li><a href="?page=${status.index}">第${status.index}页</a></li>

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

<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始1--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/integralOrders.js"></script>
</body>
</html>