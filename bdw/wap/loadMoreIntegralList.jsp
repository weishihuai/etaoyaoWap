<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<c:set var="loginUserIntegral" value="${loginUser.integral}"/>
<%--根据分类Id查找积分商品--%>
<c:set value="${sdk:findIntegralProductsByCategoryId(param.categoryId,param.limit)}" var="integralProducts"/>

<c:choose>
    <c:when test="${not empty integralProducts.result}">
        <c:forEach var="integralProduct" items="${integralProducts.result}" varStatus="i">
            <%--根据积分商品Id取出积分商品--%>
            <c:set value="${sdk:getIntegralProduct(integralProduct.integralProductId)}" var="product"/>
            <div class="item">
                <c:choose>
                    <c:when test="${integralProduct.type == 0}">
                        <a class="pic" href="${webRoot}/wap/integralDetail.ac?integralProductId=${integralProduct.integralProductId}">
                            <img src="${integralProduct.icon['']}" alt=""/>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <img src="${integralProduct.icon['']}" alt=""/>
                    </c:otherwise>
                </c:choose>
                <a <c:if test="${integralProduct.type == 0}">href="${webRoot}/wap/integralDetail.ac?integralProductId=${integralProduct.integralProductId}"</c:if>><p class="name">${integralProduct.integralProductNm}</p></a>
                <p class="number">剩余 ${product.num}件</p>
                <p class="integral-number"><span><fmt:formatNumber value="${integralProduct.integral}" type="number"/></span>积分</p>
                <c:choose>
                    <c:when test="${integralProduct.integral * 1 <= loginUserIntegral * 1}">
                        <a class="btn01" href="${webRoot}/wap/integralDetail.ac?integralProductId=${integralProduct.integralProductId}">我要兑</a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn02" href="javascript:void(0);">我要兑</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <%--暂无数据--%>
    </c:otherwise>
</c:choose>



