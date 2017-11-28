<%--
  Created by IntelliJ IDEA.
  User: lxq
  Date: 12-3-31
  Time: 上午11:52
  菜单
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<html>
<head>
    <title>${webName}-${empty productProxy.metaTitle ? productProxy.name : productProxy.metaTitle}</title>
    <meta name="keywords" content="${productProxy.metaKeywords}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${productProxy.metaDescr}-${webName}" /> <%--SEO description优化--%>
    <meta charset="utf-8">
    <%--<link href="${webRoot}/template/bdw/wap/statics/css/bootstrap.min.css" rel="stylesheet" >--%>
    <%--<link href="${webRoot}/template/bdw/wap/statics/css/footer.css" rel="stylesheet" media="screen">--%>
</head>
<body style="TEXT-ALIGN: center; ">

<!-- 商品页换了新页面之后，这个header.jsp不能加载，不然页面会有两个header -->
<%--<c:import url="/template/bdw/wap/module/common/head.jsp?title=product"/>--%>

<c:choose>
    <c:when test="${not empty productProxy.description}">
        <div style="text-align: center;margin-top: 4px;"><img src="${webRoot}/template/bdw/statics/images/price-explain.jpg" width="570" height="210"></div>
        ${productProxy.description}
    </c:when>
    <c:otherwise>
        <div style="margin: 120px auto; width: 100%; height: 100%;">
            <img src="${webRoot}/template/bdw/wap/statics/images/no_record.png"  width="570" height="210">
            <p style="font-size:36">暂无数据</p>
        </div>
    </c:otherwise>
</c:choose>
</body>
</html>