<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/ajaxload/js/product_detail_combos_info.js"></script>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<c:set value="${productProxy.combos}" var="combos"/>
<div class="mt"><span>组合套餐</span></div>
<c:set value="${fn:length(combos)*105+105}" var="divWidth"/>
<div class="mc">
    <%--<ul class="nav nav-tabs nav-justified">
        <c:forEach items="${combos}" var="combo" varStatus="s">
            <li <c:if test="${s.index == 0}">class="active"</c:if>><a href="javascript:void(0);" data-toggle="tab" class="text-danger" comboid="${combo.comboId}" onclick="triggerComboTab(${combo.comboId})"><strong>${combo.title}</strong></a></li>
        </c:forEach>
    </ul>--%>
    <c:forEach items="${combos}" var="cont_combo" varStatus="cs">
        <div class="mc-top">
            <div id="${cont_combo.comboId}" <%--class="tab-pane fade <c:if test="${cs.index eq 0}">in active</c:if>"--%>>
                <ul style="width: ${divWidth}px;">
                    <c:forEach items="${cont_combo.skus}" var="sku" varStatus="ss">
                        <li>
                            <a href="${webRoot}/wap/product.ac?id=${sku.productProxy.productId}" class="pic"><img src="${sku.productProxy.defaultImage["120X120"]}" style="width: 80px;height: 80px;"/></a>
                            <div class="title"><a href="${webRoot}/wap/product.ac?id=${sku.productProxy.productId}">${sku.productProxy.name}</a></div>
                            <span class="comboPrice">￥${sku.price.unitPrice} × ${sku.amountNum}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <%--组合商品总价计算--%>
        <div class="mc-bot">
            <a href="javascript:" class="combo_addcart" id="comboAddCart${cs.count}" skuid="${cont_combo.comboId}" handler="combo" carttype="normal" num="1" count="${cs.count}">购买组合套餐</a>
            <p>套餐价格：<span><i>￥</i>${cont_combo.price}</span></p>
            <p>为您节省：<span><i>￥</i>${cont_combo.saveMoney}</span></p>
        </div>
        <hr>
    </c:forEach>
</div>