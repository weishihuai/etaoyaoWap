<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-26
  Time: 下午6:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findOrderDetailed(param.orderId)}" var="orderProxy"/> <%--获取当前订单--%>
<!DOCTYPE HTML>
<html>
<head>
    <title>物流信息</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/details.css" rel="stylesheet">

    <script type="text/javascript" language="javascript">

        var dataValue = {
            webRoot: "${webRoot}",
            orderId: "${param.orderId}",
            logisticsCompany: "${orderProxy.logisticsCompany}",
            logisticsNum: "${orderProxy.logisticsNum}",
            companyHomeUrl: "${orderProxy.companyHomeUrl}"
        }

    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=物流信息"/>
<%--页头结束--%>
<div class="container container3">

    <div class="row d_rows5">
        <div class="row">
            <div class="col-xs-3 rows5_left4">订单状态：</div>
            <div class="col-xs-9 rows5_right4" style="color:#009900;">${orderProxy.orderStat}</div>
        </div>
        <div class="row">
            <div class="col-xs-12 rows5_right2">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="rows5_title3">订单编号：${orderProxy.orderNum}</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="rows5_title3">订单金额：¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#"/></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="rows5_title3">下单时间：<fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row wl_rows">
            <div class="col-xs-12" id="tracking">

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12" id="box_bottom"></div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/queryLogistic.js"></script>
</body>
</html>