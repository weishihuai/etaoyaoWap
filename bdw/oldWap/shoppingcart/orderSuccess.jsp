<%@ page import="com.iloosen.imall.commons.util.BigDecimalUtil" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page import="com.iloosen.imall.module.order.domain.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%
    String orderIds=request.getParameter("orderIds");
    List<Order> orderList =new ArrayList<Order>();
    for(String orderId:orderIds.split(",")){
        orderList.add(ServiceManager.orderService.getById(Integer.parseInt(orderId)));
    }

    Boolean isCod=false;
    for(Order order:orderList){
        if(order.getIsCod().equals(BoolCodeEnum.YES.toCode())){
            isCod=true;
            break;
        }
    }
    Double totalAmount=0.0;
    for(Order order:orderList){
        totalAmount= BigDecimalUtil.add(totalAmount, order.getOrderTotalAmount());
    }

    request.setAttribute("isCod",isCod);
    request.setAttribute("orderList",orderList);
    request.setAttribute("totalAmount",totalAmount);
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订单提交成功</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/orderSuccess.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript">var webPath = {webRoot:"${webRoot}"};</script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/orderSuccess.js"></script>
</head>

<body>

    <!--中间内容-->
    <div class="main">
        <h5>订单提交成功</h5>
        <p>您的订单已提交成功，我们会为你尽快处理。</p>
        <p>订单总额:&yen;${totalAmount}</p>
        <p>支付方式:<c:choose><c:when test="${isCod}">货到付款</c:when><c:otherwise>在线支付</c:otherwise></c:choose></p>
        <a href="${webRoot}/wap/index.ac" class="back-index">返回首页</a>
        <c:if test="${!isCod}"><a href="${webRoot}/wap/shoppingcart/cashier.ac?orderIds=${param.orderIds}" class="order-center">去付款</a></c:if>
    </div>
</body>

</html>




