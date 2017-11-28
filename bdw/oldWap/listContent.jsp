<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:searchProductByType(10,'N')}" var="productProxys"/>
        <c:if test="${productProxys.totalCount ==0}">
        <div class="container">
            <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                <div class="col-xs-12">
                            没有您要查找的商品，您可以去
                            <a href="${webRoot}/wap/list.ac">选购其他商品»</a>
                </div>
            </div>
            <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                <div class="col-xs-12">
                    <button onclick="window.location.href='${webRoot}/wap/index.ac'"
                            class="btn btn-danger btn-danger2" type="button">返回首页
                    </button>
                </div>
            </div>
        </div>
        </c:if>

        <c:forEach items="${productProxys.result}" var="productProxy">
            <div class="row" id="list_rows">
                <div class="col-xs-4 pro">

                    <%--<li class="pic">
                        <a href="${webRoot}/product-${proxy.productId}.html" target="_blank">
                            <c:choose>
                                <c:when test="${proxy.jdProductCode != null}">
                                    <img src="${proxy.defaultImage["jdUrl"]}"  alt="${proxy.name}" width="60" height="60" >
                                </c:when>
                                <c:otherwise>
                                    <img src="${proxy.defaultImage["60X60"]}"  alt="${proxy.name}" width="60" height="60" >
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </li>--%>
                    <div class="list_pic"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">

                        <img class="img-rounded" src="${productProxy.defaultImage["150X150"]}" width="100" height="100"></a>
                        <c:if test="${productProxy.isJoinActivity && not empty productProxy.activityPlateImageUrl}">
                            <div class="ac_image"><img src="${webRoot}/upload/${productProxy.activityPlateImageUrl}" alt=""/></div>
                        </c:if>
                    </div>
                </div>
                <div class="col-xs-8"  >
                    <div class="list_title"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">${productProxy.name}<em>${productProxy.salePoint}</em></a>
                    </div>
                    <div class="list_rice"> <em>¥<fmt:formatNumber value="${productProxy.price.unitPrice}" type="number" pattern="#0.00#"/></em></div>
                    <div class="g-old-price"><del>¥ <span>${productProxy.marketPrice}</span></del></div>
                    <div style="clear: both;"></div>
                        <%--${productProxy.price.discountType}--%>
                    <div class="volume" >销量:${productProxy.salesVolume}</div>
                    <c:if test="${not empty productProxy.presentProductList}">
                        <div class="zp">赠品</div>
                    </c:if>
                    <c:if test="${'SPECIAL_PRICE' ==productProxy.price.discountType}">
                        <div class="zj">直降</div>
                    </c:if>
                    <c:if test="${'PANIC_BUY' ==productProxy.price.discountType}">
                        <div class="xs">限时抢</div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
        <div class="pn-page row">
            <c:if test="${productProxys.lastPageNumber >1}">
                <c:choose>
                    <c:when test="${productProxys.firstPage}">
                        <div class="col-xs-2">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               disabled="disabled">首页</a>
                        </div>
                        <div class="col-xs-3">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               disabled="disabled">上一页</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-2">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               onclick="topage(1)">首页</a>
                        </div>
                        <div class="col-xs-3">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               onclick="topage(${productProxys.thisPageNumber-1})">上一页</a>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="col-xs-2 dropup">
                    <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                            data-toggle="dropdown">
                            ${productProxys.thisPageNumber}/${productProxys.lastPageNumber} <span class="caret"></span>
                    </button>

                    <ul class="dropdown-menu" style="min-width:60px;width:60px;overflow-y: scroll;height: auto;max-height: 140px;">
                        <c:forEach begin="1" varStatus="n" end="${productProxys.lastPageNumber}">
                            <li><a href="javascript:void(0);" onclick="topage(${n.index});">${n.index}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <c:choose>
                    <c:when test="${productProxys.lastPage}">
                        <div class="col-xs-3">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               disabled="disabled">下一页</a>
                        </div>
                        <div class="col-xs-2">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               disabled="disabled">末页</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-3">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               onclick="topage(${productProxys.thisPageNumber+1})">下一页</a>
                        </div>
                        <div class="col-xs-2">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               onclick="topage(${productProxys.lastPageNumber})">末页</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>

<script type="text/javascript">
    var thispage = '${productProxys.thisPageNumber}';
</script>