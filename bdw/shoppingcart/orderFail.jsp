<%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-11-24
  Time: 下午8:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>订单失败=${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/order-item.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/sp-header.css" rel="stylesheet" type="text/css" />
    <%--<link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css" />--%>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart.js"></script>
</head>

<body  style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">
<%--页头开始--%>
<c:import url="/template/bdw/module/common/cartTop.jsp?sta=3"/>
<%--页头结束--%>
<%--<div id="orderSuccess">
    <ul class="nav">
        <li class="done"><span>1.查看购物车</span></li>
        <li class="done2"><span>2.填写订单信息</span></li>
        <li class="cur"><span>3.付款到收银台</span></li>
        <li class="last"><span>4.收货评价</span></li>
    </ul><div class="clear"></div>
    <div class="box paySuccessBox">
        <ul style="margin: 0px;">
            &lt;%&ndash;<h2><a href="#"><img src="${webRoot}/template/bdw/statics/images/buyCar_succeIco.gif" /></a></h2>&ndash;%&gt;
            <li>
                <p>${errorObject.errorText}！</p>
                <div class="return">
                    <h4>您现在还可以：<a href="${webRoot}/index.jsp">首页</a></h4>
                </div>
            </li><div class="clear"></div>
        </ul>

    </div>
</div>--%>

<div class="main-bg">
    <div class="main">
        <div class="fail-od">
            <div class="fail-icon"></div>
            <h5>订单提交失败，${errorObject.errorText}</h5>
            <p>如果您确认其他任何操作均无异常提醒，且长时间尝试后仍然订单提交失败，建议联系客服热线，以便及时帮您核实处理。</p>
            <div class="bot">
                <a href="${webRoot}/index.ac" class="back">返回首页</a>
                <a href="${webRoot}/shoppingcart/cart.ac" class="cart">我的购物车</a>
            </div>
        </div>
    </div>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>
