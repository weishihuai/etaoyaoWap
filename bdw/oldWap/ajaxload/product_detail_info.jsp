<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<script type="text/javascript">
  var isCollect = '${productProxy.collect}';
  var skuData = eval('${productProxy.skuJsonData}');
  var userSpecData = eval('${productProxy.userSpecJsonData}');
  var isCanBuy = eval('${productProxy.isCanBuy}');
</script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/ajaxload/js/product_detail_info.js"></script>
<c:set var="specList" value="${productProxy.productUserSpecProxyList}"/>
<c:if test="${productProxy.isEnableMultiSpec=='Y'}">
  <c:forEach items="${specList}" var="spec">
    <div class="mp2-item">
      <span>${spec.name}：</span>
      <c:forEach items="${spec.specValueProxyList}" var="specValue">
        <a title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}" class="gg_btn">
          <c:if test="${spec.specType eq '0'}">${specValue.value}</c:if>
          <c:if test="${spec.specType eq '1'}"><img width='30' height='30' src="${specValue.value}" /></c:if>
        </a>
      </c:forEach>
    </div>
  </c:forEach>
</c:if>

<div class="quantity">
  <span>数量：</span>
  <a href="javascript:" class="quantity-decrease prd_subNum">-</a>
  <input type="num" value="1" class="prd_num" maxlength="4">
  <a href="javascript:" class="quantity-increase prd_addNum">+</a>
</div>

