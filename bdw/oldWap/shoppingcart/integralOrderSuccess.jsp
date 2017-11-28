<%@ page import="com.iloosen.imall.module.order.domain.IntegralOrder" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%
    String integralOrderId=request.getParameter("integralOrderId");
    IntegralOrder integralOrder = ServiceManager.integralOrderService.getById(Integer.parseInt(integralOrderId));

    Double totalAmount= new BigDecimal(integralOrder.getTotalExchangeAmount()).doubleValue();

    request.setAttribute("integralOrder",integralOrder);
    request.setAttribute("totalAmount",totalAmount);
%>
<!doctype html>
<html>
  <head>
    <title>订单提交成功</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
      <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
      <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" rel="stylesheet">
      <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
      <link href="${webRoot}/template/bdw/oldWap/statics/css/buycar3.css" rel="stylesheet" media="screen">

      <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
      <script type="text/javascript">var webPath = {webRoot:"${webRoot}"};</script>
      <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
      <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
      <script src="${webRoot}/template/bdw/oldWap/statics/js/orderSuccess.js"></script>


  </head>
  <body>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=订单提交成功"/>
    <%--页头结束--%>

    <article class="tips">
        <em>提交订单成功；我们会及时为您处理</em>
    </article>

    <div class="container pay-main">
        <div class="row">

            <div class="col-xs-12 orders">
                <div class="col-xs-3 od-dd">订单编号：</div>
                <div class="col-xs-6 od-num">${integralOrder.orderNum}</div>
                <div class="col-xs-3 od-check"><a href="${webRoot}/wap/module/member/integralOrderDetail.ac?id=${integralOrder.integralOrderId}">查看详情</a></div>
            </div>

            <div class="col-xs-12 orders lh36">
                <div class="col-xs-3 od-dd">支付方式：</div>
                <div class="col-xs-9">在线支付</div>
            </div>
            <div class="col-xs-12 orders">
                <div class="col-xs-4 od-bdd">应付总额：</div>
                <div class="col-xs-3 od-bpri">￥${totalAmount}</div>
                <%--微信下没办法使用这个收银台的页面支付,所以让他进入订单详情进行支付--%>
                <div class="col-xs-5 od-pay">
                        <a href="${webRoot}/wap/shoppingcart/integralCashier.ac?integralOrderId=${param.integralOrderId}">去付款</a>
                </div>
            </div>
            <div class="col-xs-12 tips2">
                <p>温馨提示<br />由于系统需要进行订单处理，您可以1～3分钟后才能查询到您提交的订单，请谅解。</p>
                <p>网上支付订单请您在24小时内支付，否则订单将被自动取消。</p>
                <p><i>未及时付款的订单可在我的订单-订单详情进行支付！</i></p>
            </div>
        </div>

    </div>

    <%--页脚开始--%>
    <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
    <%--页脚结束--%>

  </body>
</html>
