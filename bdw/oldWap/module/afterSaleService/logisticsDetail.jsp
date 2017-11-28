<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findOrderDetailed(param.orderId)}" var="orderProxy"/> <%--获取当前订单--%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>物流详情-易淘药健康网</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/base.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/logistics.css">
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
</head>

<body>
<header class="head-bar">
    <a class="back" href="javascript:history.go(-1);">返回</a>
    <h1 class="head-title">物流详情</h1>
</header>
<section class="main m-logs">
    <section class="logs-info">
        <div class="media">
            <%--<div class="media-left">--%>
                <%--&lt;%&ndash;<span>${orderProxy.}件商品</span>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<img src="case/good_110x110.jpg" alt="">&ndash;%&gt;--%>
            <%--</div>--%>
            <div class="media-body">
                <h2>订单状态：<strong>${orderProxy.orderStat}</strong></h2>
                <p>物流公司：${orderProxy.logisticsCompany}</p>
                <p>运单编号：${orderProxy.logisticsNum}</p>
            </div>
        </div>
    </section>

    <section class="logs-detail">
        <dl id="tracking">
        </dl>

    </section>
</section>


<script src="${webRoot}/template/bdw/oldWap/statics/js/base.js"></script>
</body>

</html>
