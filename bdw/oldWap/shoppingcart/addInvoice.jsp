<%--
  Created by IntelliJ IDEA.
  User: xws
  Date: 13-12-5
  Time: 下午2:10
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: xws
  Date: 13-12-4
  Time: 上午11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${sdk:getShoppingCartProxy(carttype)}" var="shoppingCartProxy"/>
<c:set value="${shoppingCartProxy.userOrderPreferenceProxy}" var="preferenceProxy"/>
<!doctype html>
<html>
  <head>
    <title>发票信息</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",handler:"${handler}",carttype:"${carttype}"};
    </script>
      <script src="${webRoot}/template/bdw/oldWap/statics/js/addInvoice.js"></script>
  </head>
  <body>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=填写发票信息"/>
    <%--页头结束--%>
    <div class="container">
    	<div class="row coupon_rows" id="m_rows1">
            <div class="col-xs-12"><input type="text" id="invoiceTitle" name="invoice.invoiceTitle" class="form-control" placeholder="填写发票抬头" /></div>
            <input type="hidden" name="invoice.invoiceType" class="invoiceType"  value="0"/>
            <input type="hidden" name="invoice.invoiceCont" class="invoiceCont" value="<c:forEach items="${fn:split(sdk:getSysParamValue('invoiceContent'),',')}" var="invoiceType" end="0">${invoiceType}</c:forEach>"/>
        </div>
        <div class="row coupon_rows" id="m_rows3">
        	<div class="col-xs-12"><button class="btn btn-danger btn-danger2 saveInvoice" type="button">确定</button></div>
        </div>
    </div>
    <%--&lt;%&ndash;页脚开始&ndash;%&gt;--%>
    <%--<c:import url="/template/jvan/wap/module/common/bottom.jsp"/>--%>
    <%--&lt;%&ndash;页脚结束&ndash;%&gt;--%>
  </body>
</html>
