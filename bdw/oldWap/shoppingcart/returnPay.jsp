<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:redirect url="${webRoot}/wap/shoppingcart/paySuccess.ac?isCod=N&carttype=${param.carttype}"></c:redirect>

<!doctype html>
<html>
<head>
    <title>支付成功</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">

    <<script type="text/javascript">var webPath = {webRoot:"${webRoot}",orderId:"${param.orderId}",carttype:"${param.carttype}"};</script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=订单支付"/>
<%--页头结束--%>
<div class="container">
    <h5 style="font-weight:bold; padding:10px 0 5px;">您的订单支付成功！</h5>
    <div class="row">
        <div class="col-xs-12">
            <p>您现在还可以：</p>
            <p> <button onclick="window.location.href='${webRoot}/wap/index.ac'"
                        class="btn btn-danger btn-danger2" type="button">返回首页
            </button><p></p>
                <button onclick="window.location.href='${webRoot}/wap/module/member/index.ac'"
                        class="btn btn-danger btn-danger2" type="button">会员中心
                </button>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <label>注意事项：</label>
            <div class="text">
                <p>订单提交成功仅表明${webName}收到了您的订单，只有您的订单通过审核后，才代表订单正式生效；</p>
                <p>选择货到付款的客户，请您务必认真检查所收货物，如有不符，您可以拒收；</p>
                <p>选择其他方式的客户，请您认真检查外包装。如有明显损坏迹象，您可以拒收该货品，并及时通知我们；</p>
                <p>建议您在购买的15天内保留商品的全套包装、附件、发票等所有随货物品，以便后续的保修处理。</p>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>

<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>

</body>
</html>