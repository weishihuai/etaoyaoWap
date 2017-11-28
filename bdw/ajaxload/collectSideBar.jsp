<%--
  Created by IntelliJ IDEA.
  User: Arthur Tsang
  Date: 2015/3/11 0011
  Time: 下午 8:26
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.type ? 'normal' : param.type}" var="type"/>
<c:set value="${empty param.handler ? 'sku' : param.handler}" var="handler"/>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<c:if test="${not empty user}">
  <c:set value="${sdk:getProductCollect(4)}" var="userProductPage"/>   <%--获取收藏商品列表--%>
  <c:set value="${bdw:getShopCollect(3)}" var="userShopCollectPage"/>
</c:if>



<div class="sidebar-collect" >
  <div class="dt" data-onoff="true"><div class="dt-zz"><em class="icon"></em></div><span class="span-tip">收藏</span></div>
  <div class="dd" style="display: block">
    <div class="title titleOnclick">我的收藏<em></em></div>
    <div class="merchandise-shop">
      <p class="active">商品<span></span></p>
      <p>店铺<span></span></p>
      <em class="icon-b"></em>
    </div>
    <c:choose>
      <c:when test="${empty userProductPage.result}">
        <div class="mbar-null merchandise-mbar-null dd-mbar">
          <div class="mbar-null-box">
            <em></em>
            <p>暂时没有收藏任何商品～</p>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <div class="merchandise-mbar dd-mbar">
          <c:forEach items="${userProductPage.result}" var="prdProxy" varStatus="statu">
            <div class="item"><a href="${webRoot}/product-${prdProxy.productId}.html">
              <img src="${prdProxy.defaultImage['100X100']}" alt=""><p>¥<fmt:formatNumber value="${prdProxy.price.unitPrice}" type="number" pattern="#0.00#" /></p></a></div>
          </c:forEach>
          <a class="check-more" href="${webRoot}/module/member/productCollection.ac?pitchOnRow=3">查看更多收藏商品 >></a>
        </div>
        <%--收藏商品列表 end--%>
      </c:otherwise>
    </c:choose>
    <c:choose>
      <c:when test="${empty userShopCollectPage.result}">
        <div style="display: none;" class="mbar-null merchandise-mbar-null dd-mbar">
          <div class="mbar-null-box">
            <em></em>
            <p>暂时没有收藏任何店铺～</p>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <div style="display: none;" class="shop-mbar dd-mbar">
          <c:forEach items="${userShopCollectPage.result}" var="shopProxy" varStatus="statu">
            <c:choose>
              <c:when test="${not empty shopProxy.shopType && shopProxy.shopType == '2'}">
                <div class="item">
                  <img alt="${shopProxy.shopNm}" src="${shopProxy.defaultImage['100X100']}"    />
                  <p>${shopProxy.shopNm}</p>
                  <a class="join-shop" href="${webRoot}/citySend/storeDetail.ac?orgId=${shopProxy.sysOrgId}">进入店铺 ></a>
                </div>
              </c:when>
              <c:otherwise>
                <div class="item">
                  <img alt="${shopProxy.shopNm}" src="${shopProxy.defaultImage['100X100']}"    />
                  <p>${shopProxy.shopNm}</p>
                  <a class="join-shop" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}">进入店铺 ></a>
                </div>
              </c:otherwise>
            </c:choose>
          </c:forEach>
          <a class="check-more" href="${webRoot}/module/member/shopCollection.ac?pitchOnRow=23">查看更多收藏店铺 >></a>
            <%--收藏商品列表 end--%>
        </div>
      </c:otherwise>
    </c:choose>



  </div>
  <div class="icon-lx icon-lx2" style="display: block"></div>

  <!-- 空收藏 -->
  <!--<div class="dd">
      <div class="title">我的收藏<em></em></div>
      <div class="merchandise-shop">
        <p class="active">商品</p>
        <p>店铺</p>
        <em class="icon-b"></em>
      </div>
      <div class="mbar-null merchandise-mbar-null dd-mbar">
        <div class="mbar-null-box">
          <em></em>
          <p>暂时没有收藏任何商品～</p>
        </div>
      </div>
      <div style="display: none;" class="mbar-null merchandise-mbar-null dd-mbar">
        <div class="mbar-null-box">
          <em></em>
          <p>暂时没有收藏任何店铺～</p>
        </div>
      </div>
    </div>

              <div class="icon-lx icon-lx"></div>-->
</div>