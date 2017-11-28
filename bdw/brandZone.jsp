<%--
  Created by IntelliJ IDEA.
  User: feng
  Date: 11-11-25
  Time: 上午10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-品牌专区-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/other.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var t="${param.t}";
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/brandZone.js"></script>
</head>

<style type="text/css">

</style>

<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=brand"/>
<%--页头结束--%>
<%--所有商品分类--%>
<c:set value="${sdk:findAllProductCategory()}" var="categoryProxys"/>
<%--热销排行--%>
<c:set value="${sdk:findMonthTopProducts(1,9)}" var="weekTopProducts"/>
<div id="Other">
    <div class="t_Menu2">
        <div class="l_menu">
            <ul>
                <li><a <c:if test="${param.type == 'brank'||empty param.type}">class="cur"</c:if> id="allBrank" style="cursor:pointer" title="品牌专区">品牌专区</a></li>
                <li><a <c:if test="${param.type =='category'}">class="cur"</c:if> id="allCategory" style="cursor:pointer" title="全部分类">全部分类</a></li>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    <div class="linkList">全部分类 |
        <c:forEach items="${categoryProxys}" var="categoryProxy" varStatus="s">
            <a  href="${webRoot}/productlist-${categoryProxy.categoryId}.html" title="${categoryProxy.name}">${categoryProxy.name}</a><c:if test="${!s.last}"> | </c:if>
        </c:forEach>
    </div>
    <div class="z-q" id="brank" style="<c:if test="${param.type =='category'}">display:none;</c:if>">
        <div class="l">
            <c:forEach items="${categoryProxys}" var="categoryProxy" varStatus="s" >
                <div class="each" onmouseover="setEachOverStyle(this)" onmouseout="setEachOutStyle(this)">
                    <dl>
                        <dt>${categoryProxy.name}</dt>
                        <c:forEach items="${categoryProxy.brands}" var="brand" >
                            <dd>
                                <a href="${webRoot}/productlist.ac?category=1&q=brandId:${brand.brandId}"  style="margin-bottom: 10px;" title="${brand.name}">
                                    <img width="100" height="40"  src="${brand.logo['100X100']}" alt="${brand.name}" />
                                </a>
                                <br />${brand.name}
                            </dd>
                        </c:forEach>
                    </dl>
                </div>
            </c:forEach>
        </div>

        <div class="r">
            <h1>热销排行</h1>
            <div class="box">
                <table width="100%" border="0" cellspacing="0">
                    <c:forEach items="${weekTopProducts}" var="phoneList" varStatus="s">
                    <tr <c:if test="${s.count % 2 == 0}">class="bg"</c:if> <c:if test="${s.count == 1}">class='hover'</c:if>>
                        <td class="td1"><span>${s.count}</span></td>
                        <td class="td2"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="${phoneList.name}">${sdk:cutString(phoneList.name,10,'')}</a></td>
                        <td class="td3">￥ <span><fmt:formatNumber value="${phoneList.price.unitPrice}" type="number" pattern="#0.00#" /></span></td>
                    </tr>
                    </c:forEach>
                </table>
            </div>
        </div>

        <div class="clear"></div>
    </div>
    <div class="z-q" id="categoryList" style="<c:if test="${param.type == 'brank'||empty param.type}">display:none;</c:if>">
        <div class="l">
            <c:forEach items="${categoryProxys}" var="categoryProxy" varStatus="s">

                <div class="each"  onmouseover="setEachOverStyle(this)" onmouseout="setEachOutStyle(this)">
                    <c:forEach items="${categoryProxy.children}" var="child" >
                        <div class="fixBox">
                            <label><a href="${webRoot}/productlist-${child.categoryId}.html" title="${child.name}">${child.name}</a></label>
                            <div class="text">
                                <c:forEach items="${child.children}" var="tchild" varStatus="s">
                                    <a href="${webRoot}/productlist-${tchild.categoryId}.html" title="${tchild.name}">${tchild.name}</a>&nbsp;&nbsp;&nbsp;</c:forEach>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>

        <div class="r">
            <h1>热销排行</h1>
            <div class="box">
                <table width="100%" border="0" cellspacing="0">
                    <c:forEach items="${weekTopProducts}" var="phoneList" varStatus="s">
                        <tr <c:if test="${s.count % 2 == 0}">class="bg"</c:if>>
                            <td class="td1"><span>${s.count}</span></td>
                            <td class="td2"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="${phoneList.name}">${sdk:cutString(phoneList.name,10,'')}</a></td>
                            <td class="td3">￥ <span><fmt:formatNumber value="${phoneList.price.unitPrice}" type="number" pattern="#0.00#" /></span></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>

        <div class="clear"></div>
    </div>
</div>


<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
