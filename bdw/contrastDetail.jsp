<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.s1 ? null : sdk:getProductById(param.s1)}" var="product1"/>
<c:set value="${empty param.s2 ? null : sdk:getProductById(param.s2)}" var="product2"/>
<c:set value="${empty param.s3 ? null : sdk:getProductById(param.s3)}" var="product3"/>
<c:set value="${empty param.s4 ? null : sdk:getProductById(param.s4)}" var="product4"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}" /> <%--SEO description优化--%>
    <title>商城比较-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/contrastDetail.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>
<body>
<c:import url="/template/bdw/module/common/top.jsp"/>

<div id="pcomprare" style="width: 980px;margin: 0 auto;">
    <div class="tabcon">
        <table class="tb-1">
            <tbody>
            <tr style="background-color: rgb(255, 255, 255);" class="hover">
                <th>商品图片</th>
                <td>
                    <a class="cur" href="${webRoot}/product-${product1.productId}.html" title="${product1.name}" target="_blank">
                        <img src="${product1.defaultImage["200X200"]}" alt="${product1.name}"/>
                    </a>

                    <div>
                        <a class="cur" href="${webRoot}/product-${product1.productId}.html" title="${product1.name}" target="_blank">
                            ${product1.name}
                        </a>
                    </div>
                </td>
                <td>
                    <a class="cur" href="${webRoot}/product-${product2.productId}.html" title="${product2.name}" target="_blank">
                        <img src="${product2.defaultImage["200X200"]}" alt="${product2.name}"/>
                    </a>

                    <div>
                        <a class="cur" href="${webRoot}/product-${product2.productId}.html" title="${product2.name}" target="_blank">
                            ${product2.name}
                        </a>
                    </div>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty product3}">
                            <a class="cur" href="${webRoot}/product-${product3.productId}.html" title="${product3.name}" target="_blank">
                                <img src="${product3.defaultImage["200X200"]}" alt="${product3.name}"/>
                            </a>
                            <div>
                                <a class="cur" href="${webRoot}/product-${product3.productId}.html" title="${product3.name}" target="_blank">
                                        ${product3.name}
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-contrast">暂无对比项</div>
                            <div class="add-contrast"><a href="${webRoot}/productlist.html">添加</a></div>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty product4}">
                            <a class="cur" href="${webRoot}/product-${product4.productId}.html" title="${product4.name}" target="_blank">
                                <img src="${product4.defaultImage["200X200"]}" alt="${product4.name}"/>
                            </a>

                            <div>
                                <a class="cur" href="${webRoot}/product-${product4.productId}.html" title="${product4.name}" target="_blank">
                                        ${product4.name}
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-contrast">暂无对比项</div>
                            <div class="add-contrast"><a href="${webRoot}/productlist.html">添加</a></div>
                        </c:otherwise>
                    </c:choose>

                </td>
            </tr>
            <tr class="p-price">
                <th>市场价</th>
                <td><fmt:formatNumber value="${product1.marketPrice}" type="number"  pattern="#0.00#" /></td>
                <td><fmt:formatNumber value="${product2.marketPrice}" type="number"  pattern="#0.00#" /></td>
                <td class="data_empty">
                    <c:choose>
                        <c:when test="${not empty product3}">
                            <fmt:formatNumber value="${product3.marketPrice}" type="number"  pattern="#0.00#" />
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="data_empty">
                    <c:choose>
                        <c:when test="${not empty product4}">
                            <fmt:formatNumber value="${product4.marketPrice}" type="number"  pattern="#0.00#" />
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr class="p-price">
                <th>销售价</th>
                <td><fmt:formatNumber value="${product1.price.unitPrice}" type="number"  pattern="#0.00#" /></td>
                <td><fmt:formatNumber value="${product2.price.unitPrice}" type="number"  pattern="#0.00#" /></td>
                <td class="data_empty">
                    <c:choose>
                        <c:when test="${not empty product3}">
                            <fmt:formatNumber value="${product3.price.unitPrice}" type="number"  pattern="#0.00#" />
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="data_empty">
                    <c:choose>
                        <c:when test="${not empty product4}">
                            <fmt:formatNumber value="${product4.price.unitPrice}" type="number"  pattern="#0.00#" />
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr class="brand">
                <th>所属品牌</th>
                <td>${product1.brand.name}</td>
                <td>${product2.brand.name}</td>
                <td class="${empty product3 ? 'data_empty' : ""}">${empty product3 ? '' : product3.brand.name}</td>
                <td class="${empty product4 ? 'data_empty' : ""}">${empty product4 ? '' : product4.brand.name}</td>
            </tr>
            <tr class="">
                <th>商家</th>
                <td>${product1.shopInfProxy.shopNm}</td>
                <td>${product2.shopInfProxy.shopNm}</td>
                <td class="${empty product3 ? 'data_empty' : ""}">${empty product3 ? '' : product3.shopInfProxy.shopNm}</td>
                <td class="${empty product4 ? 'data_empty' : ""}">${empty product4 ? '' : product4.shopInfProxy.shopNm}</td>
            </tr>
            <tr class="">
                <th>售后服务</th>
                <td>${product1.afterSaleService}</td>
                <td>${product2.afterSaleService}</td>
                <td class="${empty product3 ? 'data_empty' : ""}">${empty product3 ? '' : product3.afterSaleService}</td>
                <td class="${empty product4 ? 'data_empty' : ""}">${empty product4 ? '' : product4.afterSaleService}</td>
            </tr>
            <tr class="">
                <th>销量</th>
                <td>${product1.salesVolume}</td>
                <td>${product2.salesVolume}</td>
                <td class="${empty product3 ? 'data_empty' : ""}">${empty product3 ? '' : product3.salesVolume}</td>
                <td class="${empty product4 ? 'data_empty' : ""}">${empty product4 ? '' : product4.salesVolume}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
