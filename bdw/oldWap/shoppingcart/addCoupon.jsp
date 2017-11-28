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
<!doctype html>
<html>
  <head>
    <title>添加购物卷</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
      <script src="${webRoot}/template/bdw/oldWap/statics/js/addCoupon.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",handler:"${handler}",carttype:"${carttype}"};
    </script>
  </head>
  <body>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=添加购物券"/>
    <%--页头结束--%>
    <div class="container">
    	<div class="row coupon_rows" id="m_rows1">
        	<div class="col-xs-2">卷号</div>
            <div class="col-xs-9"><input type="text" id="couponNum" class="form-control"/></div>
        </div>
        <div class="row coupon_rows" id="m_rows2">
        	<div class="col-xs-2">密码</div>
            <div class="col-xs-9"><input type="password" id="couponPsw" class="form-control"/></div>
        </div>
        <div class="row coupon_rows" id="m_rows3">
        	<div class="col-xs-12"><button class="btn btn-danger btn-danger2 addNewCoupon" type="button">确定</button></div>
        </div>
    </div>
    <%--页脚开始--%>
    <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
    <%--页脚结束--%>
  </body>
</html>