<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${param.tabSelect}"  var="tabSelect"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>  <%--获取页码--%>
<c:set value="${sdk:getMarketingActivityById(param.activityId)}" var="marketActivity"/>
<c:set value="${sdk:getMarketingActivitySignUpProxyList(_page,16,param.activityId)}" var="marketActivityProduct"/>

<!DOCTYPE html>
<html>
<head>
    <title>${webName}-活动首页-${sdk:getSysParamValue('index_title')}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/buying.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/activityIndex.js"></script>
  </head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=促销活动"/>
<%--页头结束--%>
<div class="row t-nav">
	<div class="col-xs-4 cur"><a class="process" href="${webRoot}/wap/activityIndex.ac?tabSelect=process">正在进行</a></div>
    <div class="col-xs-4"><a class="last" href="${webRoot}/wap/activityIndex.ac?tabSelect=last">最后一天</a></div>
    <div class="col-xs-4"><a class="already" href="${webRoot}/wap/activityIndex.ac?tabSelect=already&at=fTab">即将开始</a></div>
</div>
<div id="descriptionAlert" style="margin-top: 20px;margin-left: auto;margin-right: auto;" class="alert alert-danger fade in">
    <h4>温馨提示!</h4>
    <input type="hidden"  value="${marketActivity.activityEndTimeStr}" name="listPageTime"/>
    <p class="listPageTime"></p>
</div>

<c:forEach items="${marketActivityProduct.result}" var="activity">
    <c:set var="productProxy" value="${sdk:getProductById(activity.productId)}"/>
    <div class="row" id="list_rows">
        <div class="col-xs-4" >
            <div class="list_pic"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}"><img
                    class="img-rounded" src="${productProxy.defaultImage["100X100"]}" width="90" height="90"></a></div>
        </div>
        <div class="col-xs-8"  >
            <div class="list_title"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">${productProxy.name}<em>${productProxy.salePoint}</em></a>
            </div>
            <div class="list_rice"> <em>¥<fmt:formatNumber value="${activity.price}" type="number" pattern="#0.00#"/></em></div>
            <div class="volume" >市场价:${productProxy.marketPrice}</div>
        </div>
    </div>
</c:forEach>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
