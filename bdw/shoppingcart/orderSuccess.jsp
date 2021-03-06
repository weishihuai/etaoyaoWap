<%@ page import="com.iloosen.imall.client.commons.StringUtils" %>
<%@ page import="com.iloosen.imall.commons.util.BigDecimalUtil" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page import="com.iloosen.imall.module.order.domain.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-11-24
  Time: 下午8:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%
    String orderIds=request.getParameter("orderIds");
    List<Order> orderList =new ArrayList<Order>();
    for(String orderId:orderIds.split(",")){
        if(StringUtils.isBlank(orderId)){
            continue;
        }
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
        totalAmount= BigDecimalUtil.add(totalAmount,order.getOrderTotalAmount());
    }

    request.setAttribute("isCod",isCod);
    request.setAttribute("orderList",orderList);
    request.setAttribute("totalAmount",totalAmount);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>订单成功-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart.js"></script>
    <script type="text/javascript">
        //2015-04-21,zch,宝得网要自动跳转
        var isCode = eval('${isCod}');
        var pay = eval('${param.pay}');
        //判断是否是货到付款
        if(!isCode){
            var goToUrlOrder = function (url) {
                setTimeout(function () {
                    window.location.href = url
                }, 5)
            };

            var pay = eval('${param.pay}');
            var url = "";
            if(!pay){
                 url = "${webRoot}/shoppingcart/returnPay.ac?type=order";
            }else{
                url = "${webRoot}/shoppingcart/cashier.ac?type=${param.type}&orderIds=${param.orderIds}";
            }

            $(function(){
                goToUrlOrder(url);
            });
        }
        
    </script>
</head>

<body  style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>
<div id="orderSuccess" style="margin-top:20px;">
    <ul class="nav">
        <li class="look done"><span>1.查看购物车</span></li>
        <li class="look done" style="background-position: 0 -100px;width: 257px;"><span>2.填写订单信息</span></li>
        <li><span><c:choose><c:when test="${isCod}">3.确认货到付款订单信息</c:when><c:otherwise>3.付款到收银台</c:otherwise></c:choose></span></li>
        <li class="last"><span>4.收货评价</span></li>
    </ul><div class="clear"></div>
    <div class="box">
        <ul>
            <h2><a href="#"><img src="${webRoot}/template/bdw/statics/images/register_result_succe.gif" /></a></h2>
            <li>
                <p>您的订单提交成功！</p>
                <%--<p>我们将为您保留订单2日，如果2日后乐商网仍未收到您的付款，我们将会自动取消此订单。</p>--%>
                <div class="info">
                    <h3>订单编号：<c:forEach items="${orderList}" var="order">${order.orderNum}<a href="${webRoot}/module/member/orderDetail.ac?id=${order.orderId}">查看订单详情</a> | </c:forEach></h3>
                    <h3>付款方式：<c:choose><c:when test="${isCod}">货到付款</c:when><c:otherwise>在线支付</c:otherwise></c:choose></h3>
                    <h3>应付金额：<em>¥${totalAmount}</em></h3>
                </div>
                <%--<c:if test="${!isCod}">
                    <div class="pay"><a href="${webRoot}/shoppingcart/cashier.ac?orderIds=${param.orderIds}">去付款</a></div>
                </c:if>--%>
                <div class="return">
                    <h4>您现在还可以：</h4>
                    <h4><a href="${webRoot}/index.jsp">返回首页</a><a href="${webRoot}/index.jsp">继续购物</a><a href="${webRoot}/module/member/index.ac">订单中心</a></h4>
                </div>
            </li><div class="clear"></div>
        </ul>

    </div>
    <div class="careful">
        <h2>注意事项：</h2>
        <h3>
            <p>订单提交成功仅表明${webName}收到了您的订单，只有您的订单通过审核后，才代表订单正式生效；</p>
            <p>选择货到付款的客户，请您务必认真检查所收货物，如有不符，您可以拒收；</p>
            <p>选择其他方式的客户，请您认真检查外包装。如有明显损坏迹象，您可以拒收该货品，并及时通知我们；</p>
            <p>建议您在购物的15天内保留商品的全套包装、附件、发票等所有随货物品，以便后续的保修处理。</p>
        </h3><div class="clear"></div>
    </div>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>
