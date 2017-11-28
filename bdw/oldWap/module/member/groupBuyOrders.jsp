<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-26
  Time: 上午10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page ? 1 : param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findGroupBuyOrder(loginUser.userId,pageNum,8)}" var="orderProxyPage"/> <%--获取当前用户的团购订单--%>
<!DOCTYPE HTML>
<html>

<head>
    <title>我的团购订单</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/details.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script type="text/javascript">
        var dataValue = {
            webRoot:"${webRoot}"
        };
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=我的团购订单"/>
<%--页头结束--%>
<div class="container container3">
    <c:choose>
        <c:when test="${empty orderProxyPage.result}">
            <div class="container">
                <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                    <div class="col-xs-12">
                        <%--<span class="glyphicon glyphicon-ok glyphicon-ok2"></span>--%>
                        您还没有下过团购订单哦，请您先
                        <a href="${webRoot}/wap/list.ac">选购商品»</a>
                    </div>
                </div>
                <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                    <div class="col-xs-12">
                        <button onclick="window.location.href='${webRoot}/wap/index.ac'" class="btn btn-danger btn-danger2" type="button">返回首页</button>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                <div class="row d_rows5">
                    <div class="row">
                        <div class="col-xs-4 rows5_left4">订单状态：</div>
                        <div class="col-xs-8 rows5_right4" style="color:#009900;">${orderProxy.orderStat}</div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3 rows5_left2">
                            <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                                <img src="${orderItemProxy.productProxy.defaultImage["50X50"]}" width="60px;" height="60px;" alt="${orderItemProxy.productProxy.name}"/>
                            </c:forEach>
                        </div>
                        <div class="col-xs-9 rows5_right2">
                            <a href="${webRoot}/wap/module/member/orderDetail.ac?id=${orderProxy.orderId}" title="查看详细">
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
                                        <div class="rows5_title3">
                                            <span class="glyphicon glyphicon-chevron-right"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="rows5_title3">下单时间：<fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                    </div>
                                </div>
                            </a>

                            <div class="col-xs-12">
                                <c:if test="${not orderProxy.pay && orderProxy.orderStat != '已取消'}">
                                    <%--<c:if test="${orderProxy.payment.payWayId != 1}">--%>
                                        <button class="btn btn-danger btn-danger2" type="button" style="margin-top:10px;" onclick="window.location.href='${webRoot}/wap/module/member/orderDetail.ac?id=${orderProxy.orderId}';">
                                            付款
                                        </button>
                                    <%--</c:if>--%>
                                </c:if>
                                <c:if test="${orderProxy.orderStat=='待买家确认收货'}">
                                    <button class="btn btn-danger btn-danger2" type="button" style="margin-top:10px; background:#428bca; border:#357ebd 1px solid;" onclick="buyerSigned('${orderProxy.orderId}')">
                                        确认收货
                                    </button>
                                </c:if>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 box_bottom"></div>
                </div>
            </c:forEach>

            <div class="pn-page row">
                <form action="${webRoot}/module/member/orderList.ac" id="pageForm" method="post" style="display: inline;" totalPages='${orderProxyPage.lastPageNumber}' currentPage='${pageNum}' displayNum='6' totalRecords='${orderProxyPage.totalCount}'>
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
                                    ${pageNum}/${orderProxyPage.lastPageNumber}<span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" style="width:50px">

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
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>

<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/myOrders.js"></script>
</body>
</html>