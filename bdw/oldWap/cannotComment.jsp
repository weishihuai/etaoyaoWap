<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>商品评价</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/details.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}"};
    </script>
</head>
<body>
<%--<div class="row" id="d_row1">--%>
    <%--<div class="col-xs-2"><a onclick="javascript: history.go(-1);" href="javascript:void(0);" style="color:#FFF"><span class="glyphicon glyphicon-arrow-left"></span></a></div>--%>
    <%--<div class="col-xs-8">商品评价</div>--%>
<%--</div>--%>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=商品评价"/>
<%--页头结束--%>
<div class="container container3">
    <div class="row d_rows5">
        <div class="col-xs-12">
            <div class="rows5_title">商品信息</div>
        </div>

        <div class="col-xs-3 rows5_left"><img src="${productProxy.defaultImage['60X60']}" width="60" height="60"></div>
        <div class="col-xs-9 rows5_right">
            <div class="rows5_title2"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">${productProxy.name}</a></div>
            <div class="col-xs-6">
                <div class="rows5_title3"></div>
            </div>
            <div class="col-xs-6">
                <div class="rows5_title3"></div>
            </div>
            <div class="col-xs-12">
                <div class="rows5_price">￥${productProxy.price.unitPrice}</div>
            </div>
        </div>

        <div class="row" style="padding:0 20px;">
            <div class="box" style="margin-top:10px;">
                <h1 style="line-height: 20px; color: #CC3333;font-size: 14px;font-weight: bold;font-family: airal,verdana,tahoma,helvetica,'微软雅黑'">您暂不能对该商品进行评价，可能有以下原因：</h1>
                <p>1.您可能没有购买过该商品；</p>
                <p>2.相关的订单还未确认收货；</p>
                <p>3.您发表的评论正在审核中。</p>
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


</body>
</html>