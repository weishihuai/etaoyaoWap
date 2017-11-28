<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getProductCollect(param.pageSize)}" var="userProductPage"/>   <%--获取收藏商品列表--%>
<c:choose>
    <c:when test="${empty userProductPage.result}">
        <div>
            <div class="row" >
                <div class="col-xs-12 " style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无收藏</div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <%--收藏商品列表 start--%>
            <c:forEach items="${userProductPage.result}" var="prdProxy" varStatus="statu">
                <div class="item" >
                    <em class="checkbox" onclick="collect(${prdProxy.productId})" id="product_${prdProxy.productId}"style="display:none;" productId="${prdProxy.productId}"></em>
                    <a class="pic" href="">
                        <img src="${prdProxy.defaultImage['160X160']}" alt="" />
                    </a>
                    <a class="name" href="#">${prdProxy.name}</a>
                    <div><p class="price">￥<fmt:formatNumber value="${prdProxy.price.unitPrice}" type="number" pattern="#0.00#"/></p><span class="cuxiao" style="<c:if test="${!prdProxy.price.isSpecialPrice}">display: none</c:if>">促销</span></div>
                    <em class="cancel" onclick="cancelCellect(${prdProxy.productId})"></em>
                </div>
            </c:forEach>
            <div style="display: none;" class="cancel-collect-box">
                <a href="javascript:;" onclick="closeCancelCollect()" class="close"></a>
                <a class="cancel-collect-btn" href="javascript:;"  onclick="cancelOne()">取消收藏</a>
            </div>
            <div class="btn-box" style="display: none;"><p class="btn-box-l"><em class="checkboxAll" onclick="selectAll()"></em>全选</p><p class="btn-box-r"><a href="javascript:;" onclick="cancelAll()">取消收藏</a></p></div>
    </c:otherwise>
</c:choose>





