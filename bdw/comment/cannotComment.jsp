<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${webName}-已发表评论错误</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/userTalk.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/comment.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=product"/>
<%--页头结束--%>

<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>

<div id="position" class="m1-bg"><div class="m1"><a href="${webRoot}/index.html">首页</a>
    <c:forEach items="${productProxy.category.categoryTree}" var="node" begin="1">
        > <a href="${webRoot}/productlist-${node.categoryId}.html">${node.name}</a>
    </c:forEach>
    > <a href="${webRoot}/product-${param.id}.html" title="${productProxy.name}">${productProxy.name}</a>
    </div>
</div>

<div id="userTalk">
	<%--商品详细--%>
        <div class="lBox">
            <c:import url="/template/bdw/comment/includeProduct.jsp?id=${param.id}"/>
        </div>
    <%--商品详细--%>
	<div class="rBox">
		<div class="tip-B">
       <div class="t_Area">
	      <div class="tit">评论该商品</div>
		  <div class="clear"></div>
	   </div>
	   <div class="box">
	      <h1>您暂不能对该商品进行评价，可能有以下原因：</h1>
		  <p>1.您可能没有在${webName}购买过该商品；</p>
          <p>2.相关的订单还未确认收货</p>
		  <p>3.您已经评论过该商品或者发表的评论正在审核中。</p>
          <p>4.您购买的商品已经下架或删除。</p>
		  <div class="btn"><a href="${webRoot}/product-${productProxy.productId}.html">查看商品详细信息</a></div>
	   </div>
   </div>
	</div>
	<div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
