<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>提交订单失败</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/jquery.mmenu.css" rel="stylesheet">
   	<link type="${webRoot}/template/bdw/oldWap/statics/text/css" rel="stylesheet" href="css/jquery.mmenu.positioning.css" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/buycar2.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
  </head>
  <body>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=订单失败"/>
    <%--页头结束--%>
<%--    <div class="container">
    	<div class="row m_rows2"  style="margin:20px 0;">
        	<div class="col-xs-12">
                <span class="glyphicon glyphicon-exclamation-sign" style="font-size: 30px;color: red;"></span>
                ${errorObject.errorText}
            </div>
        </div>
        <div class="row m_rows2"  style="margin-bottom:38px;">
            <div class="col-xs-12"><a href="${webRoot}/wap/index.ac" class="btn btn-danger btn-lg btn-danger2" type="button">返回首页</a></div>
        </div>
    </div>--%>
    <article class="tips">
        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon03.png" width="22" height="22" />
        您的订单提交失败，请重新提交
    </article>

    <section class="row successful-pay failure">
        <div class="col-xs-12 ye"><p>抱歉</p>您的订单提交失败！<p>${errorObject.errorText}</p> </div>
        <div class="col-xs-12 btn">
            <a href="${webRoot}/wap/index.ac" class="user">返回首页</a>
        </div>
    </section>

  </body>
  <%--页脚开始--%>
  <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
  <%--页脚结束--%>
  </div>
</html>