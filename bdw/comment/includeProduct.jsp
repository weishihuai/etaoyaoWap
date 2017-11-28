<%--
  Created by IntelliJ IDEA.
  User: xws
  Date: 12-6-1
  Time: 下午5:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--取出商品--%>
<c:set var="productProxy" value="${bdw:getAllStatusProductById(param.id)}"/>
<%--商品评论统计--%>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>
<div class="m1">
    <h2>商品详细</h2>
    <div class="box">
        <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}"><img src="${productProxy.defaultImage['160X160']}" style="width: 160px;height: 160px;" /></a></div>
        <div class="title">商品名称：<a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></div>
        <div class="price">销售价：<b>￥${productProxy.price.unitPrice}</b></div>
        <p>评论数：${commentStatistics.total}条</p>
        <div class="btn"><a href="${webRoot}/product-${productProxy.productId}.html"></a></div>
    </div>
</div>
