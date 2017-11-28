<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.promotion.resolver.ResolverUtils" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.ShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ taglib prefix="bdw" uri="http://www.iloosen.com/bdw" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--获取门店信息--%>
<c:set value="${bdw:getShopInfProxyByOrgId(param.orgId)}" var="store"/>
<c:if test="${empty store || store.isFreeze == 'Y' || 'Y' != store.isSupportBuy}">
  <c:redirect url="${webRoot}/wap/citySend/index.ac"></c:redirect>
</c:if>
<c:if test="${store.shopType != '2'}"><%--如果不是门店则跳转到普通店铺首页--%>
  <c:redirect url="${webRoot}/wap/module/shop/index.ac?shopId=${store.shopInfId}"></c:redirect>
</c:if>

<!--判断店铺是否已收藏-->
<c:if test="${not empty loginUser && not empty store.shopInfId}">
  <c:set value="${bdw:getShopIsCollected(loginUser.userId, store.shopInfId)}" var="isCollected"/>
</c:if>

<%--获取门店的一级分类--%>
<c:set value="${bdw:findShopCategory(store.shopInfId)}" var="categoryList"/>
<%--取出门店所有商品--%>
<c:set value="10" var="limit"/>
<c:set value="${bdw:searchProductInCitySend(limit)}" var="productProxys"/>
<%--评论--%>
<c:set value="10" var="commentLimit"/>
<c:set value="${bdw:findAllCommentProxy(commentLimit, param.orgId, null)}" var="commentProxyResult"/>
<%--总评论数--%>
<c:set value="${commentProxyResult.totalCount}" var="allCommentCount"/>
<%--好评论数--%>
<c:set value="${bdw:getGoodCommentCountByOrgId(param.orgId)}" var="goodCommentCount"/>
<%--中评论数--%>
<c:set value="${bdw:getNormalCommentCountByOrgId(param.orgId)}" var="normalCommentCount"/>
<%--差评论数--%>
<c:set value="${bdw:getBadCommentCountByOrgId(param.orgId)}" var="badCommentCount"/>
<%--商家信息--%>
<c:set value="${bdw:getShopInfProxyByOrgId(param.orgId)}" var="storeInf" />
<%--商家背景图--%>
<c:if test="${not empty storeInf.backgroundPicUrl}">
  <c:set var="storeBackgroundStyle" value="background: url(${webRoot}/upload/${store.backgroundPicUrl}) no-repeat 0 0 / cover;"/>
</c:if>
<%--默认商家图片--%>
<c:set var="noPic" value="${webRoot}/template/bdw/wap/citySend/statics/images/store-avatar.png"/>
<%--默认商品图片--%>
<c:set var="noProductPic" value="${webRoot}/template/bdw/statics/images/noPic_120X120.jpg"/>
<%--商家优惠规则--%>
<c:set value="${bdw:getShopBusinessRule(store.shopInfId)}" var="shopBusinessRule"/>
<c:set value="store" var="carttype"/> <%--购物车类型--%>
<%
  // 清除购物卷，在取出购物车之前
  if (WebContextFactory.getWebContext().getFrontEndUser() != null) {
    String carttype = (String)pageContext.getAttribute("carttype");
    UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), WebContextFactory.getWebContext().getFrontEndUser().getSysUserId());
    for (ShoppingCart shoppingCart : userCartList.getCarts()) {
      ResolverUtils.clearCoupon(shoppingCart);
      ResolverUtils.clacCartMisc(shoppingCart);
    }
    ServiceManager.shoppingCartStoreService.saveUserCartList(userCartList);
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>门店详情</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/base.css" />
  <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/scrollbar.css" />
  <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/store.css" />

  <script type="text/javascript">
    var webPath = {
      webRoot:"${webRoot}",
      orgId:'${param.orgId}',
      userId:"${loginUser.userId}",
      productId:'${param.productId}',
      lastPageNumber: "${productProxys.lastPageNumber}",
      lastCommentPageNumber: "${commentProxyResult.lastPageNumber}",
      commentLimit: "${commentLimit}",
      shopCollectCount: "${store.collectdByUserNum}",
      allCommentCount:"${allCommentCount}"
    };
  </script>
  <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
  <script src="${webRoot}/template/bdw/otoo/statics/js/layer-v1.8.4/layer/layer.min.js" type="text/javascript"></script>
  <script src="${webRoot}/template/bdw/wap/statics/js/main.js" type="text/javascript"></script>
  <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
  <script src="https://3gimg.qq.com/lightmap/components/geolocation/geolocation.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/wap/citySend/statics/js/storeIndex.js"></script>
</head>

<body>
<div class="main">
  <!-- 门店 -->
  <div class="store-sec" style="z-index: 10;position: fixed;${not empty storeBackgroundStyle ? storeBackgroundStyle : ''}">
    <!-- 分享 -->
    <ul class="action-box">
      <li class="search">
        <a href="javascript:">搜索</a>
      </li>
      <li class="share" style="display: none;">
        <a href="javascript:">分享</a>
      </li>
    </ul>

    <!-- 门店信息 -->
    <div class="store">
      <div class="avatar">
        <c:choose>
          <c:when test="${not empty store.shopPicUrl}">
            <img src="${webRoot}/upload/${store.shopPicUrl}" alt="${store.shopNm}" style="width: 100%; height: 100%;" />
          </c:when>
          <c:otherwise>
            <img src="${noPic}" alt="${store.shopNm}" style="width: 100%; height: 100%;" />
          </c:otherwise>
        </c:choose>
      </div>
      <div class="detail">
        <h3 class="name">${store.shopNm}</h3>
        <p class="info">
          <span>品种&ensp;${store.productTotalCount}</span>
          <span>好评率&ensp;${empty store.goodRate || store.goodRate eq 0 ? '0.0' : store.goodRate}%</span>
          <span>距离:&ensp;<em id="shopDistinct" shopInfId="${store.shopInfId}" lat="" lng="">正在定位...</em></span>
        </p>
        <a class="collect ${not empty isCollected && 'Y' == isCollected ? 'collected' : ''}" href="javascript:" shopInfId="${store.shopInfId}">收藏&nbsp;<em>${store.collectdByUserNum}</em></a>
      </div>
    </div>

    <!-- 公告 -->
    <%--订单折扣或订单免运费折扣存在才显示--%>
    <c:if test="${shopBusinessRule.orderOffRuleSaveProxy.orderOffRuleStr != '' || shopBusinessRule.orderLogisticsSaveProxy.orderLogisticsStr != ''}">
      <div class="notice">
        <a href="javascript:" id="textScrollDiv" style="height: 2.5rem;position: relative;margin-left: 3.25rem;margin-right: 2.5rem;padding-left: 0;padding-right: 0;">
          <div style="position: absolute;top:0;">
          <span>
            <c:if test="${shopBusinessRule.orderOffRuleSaveProxy.orderOffRuleStr != ''}">
              ${shopBusinessRule.orderOffRuleSaveProxy.orderOffRuleStr};
            </c:if>
          <c:if test="${shopBusinessRule.orderLogisticsSaveProxy.orderLogisticsStr != ''}">
            ${shopBusinessRule.orderLogisticsSaveProxy.orderLogisticsStr};
          </c:if>
          </span>
          </div>
        </a>
      </div>
    </c:if>
  </div>

  <ul class="toggle-sec" style="position: fixed;z-index: 10;width: 100%;top: 13.5rem;">
    <li class="active">
      <a href="javascript:" class="tab-nav" rel="1">商品</a>
    </li>
    <li>
      <a href="javascript:" class="tab-nav" rel="2" id="comment">评价(${allCommentCount})</a><%--异步加载load--%>
    </li>
    <li>
      <a href="javascript:" class="tab-nav" rel="3">商家</a><%--异步加载load--%>
    </li>
  </ul>

  <div class="target-sec">
    <!-- 商品 -->
    <div class="tabpanel shop-tabpanel info1" style="display: block;position: relative;" >
      <div class="menu-nav" style="position:fixed;top: 17.5rem;z-index: 10;">
        <%--店铺一级分类--%>
        <ul class="categoryUl">
          <li class="${not empty param.shopCategoryId ? '' : 'active'}" nodeId="">全部</li>
          <c:forEach items="${categoryList}" var="category">
            <li class="${category.sysTreeNodeId == param.shopCategoryId ? 'active' : ''}" nodeId="${category.sysTreeNodeId}">${category.sysTreeNodeNm}</li><%--选中时加上class=active--%>
          </c:forEach>
        </ul>
      </div>
      <div class="menu-content" id="mainList" style="position: relative;width: 70%;">
        <dl class="search-list" id="thelist">
          <c:choose>
            <c:when test="${productProxys.totalCount !=0}">
              <c:forEach items="${productProxys.result}" var="productProxy">
                <dd class="media">
                  <a class="media-img" href="${webRoot}/wap/citySend/product.ac?productId=${productProxy.productId}">
                    <c:choose>
                      <c:when test="${not empty productProxy.defaultImage['120X120']}">
                        <img src="${productProxy.defaultImage['120X120']}" alt="${productProxy.name}" style="width: 100%;height: 100%;">
                      </c:when>
                      <c:otherwise>
                        <img src="${noProductPic}" alt="${productProxy.name}" style="width: 100%;height: 100%;">
                      </c:otherwise>
                    </c:choose>
                  </a>
                  <div class="media-body">
                    <span class="add-to-cart" onclick="addCart(${productProxy.productId});">加入购物车</span>
                    <input type="hidden" class="addCartSelector" value="${productProxy.productId}"/>
                    <a class="media-tit" style="max-height: 2.3em;" href="${webRoot}/wap/citySend/product.ac?productId=${productProxy.productId}">${productProxy.name}</a>
                    <p class="media-desc">
                      <span>已售&nbsp;${productProxy.salesVolume}</span>
                      <span>评论&nbsp;${productProxy.commentQuantity}</span>
                    </p>
                    <c:set value="${productProxy.price.unitPrice}" var="unitPrice"/>
                    <%
                      Double unitPrice = (Double) pageContext.getAttribute("unitPrice");
                      String priceStr = String.valueOf(unitPrice);
                      String[] price = priceStr.split("[.]");
                      String intgerPrice = price[0];
                      String decimalPrice = price[1];
                      if (StringUtils.isBlank(decimalPrice)) {
                        decimalPrice = "00";
                      } else if (decimalPrice.length() < 2) {
                        decimalPrice += "0";
                      }
                      pageContext.setAttribute("intgerPrice", intgerPrice);
                      pageContext.setAttribute("decimalPrice", decimalPrice);
                    %>
                    <p class="price"><small>&yen;</small>${intgerPrice}<small>.${decimalPrice}</small></p>
                  </div>
                </dd>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <dd class="media" style="text-align: center;margin-top: 1.0rem;margin-bottom: 2.0rem;">
                查询不到相关数据
              </dd>
            </c:otherwise>
          </c:choose>
        </dl>
      </div>
    </div>

    <!-- 评价 -->
    <div class="tabpanel evaluation-tabpanel info2" style="display: none;position: relative;top: 17.5rem;width: 100%;padding-bottom:5.0rem;" id="ajaxComment">

      <ul class="tab-nav" id="com_tab">
        <a href="javascript:">
          <li class="all active" rel="all">全部评价<span>${allCommentCount}</span></li>
        </a>
        <a href="javascript:">
          <li class="good " rel="good">好评<span>${goodCommentCount}</span></li>
        </a>
        <a href="javascript:">
          <li class="normal " rel="normal">中评<span>${normalCommentCount}</span></li>
        </a>
        <a href="javascript:">
          <li class="bad " rel="bad">差评<span>${badCommentCount}</span></li>
        </a>
      </ul>
      <div id="commentCont">
        <ul class="eval-list commentList ${allCommentCount == 0 ? ' noComment ' : ''}">
          <c:choose>
            <c:when test="${commentProxyResult.totalCount !=0}">
              <c:forEach items="${commentProxyResult.result}" var="comentProxy">
                <li class="eval-item">
                  <c:set value="${fn:substring(comentProxy.loginId, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
                  <c:set value="${fn:substring(comentProxy.loginId, 7,fn:length(comentProxy.loginId))}" var="mobileStern"/><%-- 用户名后4位 --%>
                  <div class="from">
                    <span>${mobileHeader}****${mobileStern}</span>
                    <span><fmt:formatDate value="${comentProxy.createTime}" pattern="yyyy-MM-dd hh:mm"></fmt:formatDate></span>
                  </div>
                  <div class="stars">
                    <c:set value="${5-comentProxy.score}" var="notActive"/>
                    <c:forEach begin="1" end="${comentProxy.score}">
                      <span class="active"></span>
                    </c:forEach>
                    <c:forEach begin="1" end="${notActive}">
                      <span></span>
                    </c:forEach>
                  </div>
                  <div class="cont" style="word-wrap:break-word;">
                    <p>${comentProxy.content}</p>
                  </div>
                  <c:if test="${not empty comentProxy.commentReplys}">
                    <c:forEach items="${comentProxy.commentReplys}" var="reply">
                      <div class="reply">
                        <p>管理员回复:${reply.commentCont}</p>
                      </div>
                    </c:forEach>
                  </c:if>
                </li>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <li class="eval-item">
                查询不到相关数据
              </li>
            </c:otherwise>
          </c:choose>
        </ul>
      </div>
    </div>

    <!-- 商家 -->
    <div class="tabpanel business-tabpanel info3" style="display: none;position: absolute;top: 17.5rem;padding-bottom:5.0rem;width: 100%;" id="shopInfoPanel">
      <ul class="info">
        <c:set value="tel:${storeInf.mobile}" var="moblieHref"/>
        <li>${storeInf.mobile} <a class="tel" href="${not empty storeInf.mobile ? moblieHref : 'javascript:;'}"></a></li>
        <li>
          <a href="javascript:">${storeInf.outStoreAddress}</a>
        </li>
        <%--<li>配送时间：10:00-14:00,16:00-20:00</li>--%>
        <%--<li>配送服务：提供配送服务，配送费 ￥5.00</li>--%>
      </ul>

      <ul class="promotion">
        <c:if test="${shopBusinessRule.orderOffRuleSaveProxy.orderOffRuleStr != ''}">
          <li><img src="${webRoot}/template/bdw/wap/citySend/statics/images/p-mj.png" alt="">${shopBusinessRule.orderOffRuleSaveProxy.orderOffRuleStr}</li>
        </c:if>
        <c:if test="${shopBusinessRule.orderLogisticsSaveProxy.orderLogisticsStr != ''}">
          <li><img src="${webRoot}/template/bdw/wap/citySend/statics/images/p-my.png" alt="">${shopBusinessRule.orderLogisticsSaveProxy.orderLogisticsStr}</li>
        </c:if>
      </ul>

      <dl class="announcement">
        <dt><span>商家公告</span></dt>
        <c:choose>
          <c:when test="${empty storeInf.shopNoticeStr}">
            <dd style="text-align: center;">暂无公告</dd>
          </c:when>
          <c:otherwise>
            <dd>${storeInf.shopNoticeStr}</dd>
          </c:otherwise>
        </c:choose>

      </dl>

      <dl class="qualification" style="height: 20rem;">
        <dt><span>商家资质</span></dt>
        <c:choose>
          <c:when test="${empty storeInf.licFileImg && empty storeInf.taxFileImg && empty storeInf.orgCodeFileImg}">
            <div style="text-align: center;">暂无资质</div>
          </c:when>
          <c:otherwise>
            <c:if test="${not empty storeInf.licFileImg}">
              <dd style="width: 32%;height: 47%;">
                <img src="${webRoot}/upload/${storeInf.licFileImg}" alt="" style="width: 100%;height: 100%;">
                <div>
                  <span style="float:left;">{&nbsp;</span>
                  <p class="tit" style="width: 82%;float: left;line-height: 1.4rem;">企业经营执照副本</p>
                  <span style="float:left;">&nbsp;}</span>
                </div>
              </dd>
            </c:if>
            <c:if test="${not empty storeInf.taxFileImg}">
              <dd style="width: 32%;height: 47%;">
                <img src="${webRoot}/upload/${storeInf.taxFileImg}" alt="" style="width: 100%;height: 100%;">
                <div>
                  <span style="float:left;">{&nbsp;</span>
                  <p class="tit" style="width: 82%;float: left;line-height: 1.4rem;">税务登记复印件</p>
                  <span style="float:left;">&nbsp;}</span>
                </div>
              </dd>
            </c:if>
            <c:if test="${not empty storeInf.orgCodeFileImg}">
              <dd style="width: 32%;height: 47%;">
                <img src="${webRoot}/upload/${storeInf.orgCodeFileImg}" alt="" style="width: 100%;height: 100%;">
                <div>
                  <span style="float:left;">{&nbsp;</span>
                  <p class="tit" style="width: 82%;float: left;line-height: 1.4rem;">组织机构代码证复印件</p>
                  <span style="float:left;">&nbsp;}</span>
                </div>
              </dd>
            </c:if>
          </c:otherwise>
        </c:choose>
      </dl>
    </div>
  </div>
</div>


<c:set var="storeCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(param.orgId)}"/>
<c:set var="storeCartNum" value="${storeCartProxy.cartNum}" />
<c:set var="mdCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(param.orgId)}"/>


<!-- 底栏 -->
<div class="bottom-bar" id="cart" style="z-index:105;">
  <c:choose>
    <c:when test="${storeCartProxy.selectedCartItemNum>0}">
      <a href="${webRoot}/wap/citySend/cityCheckout.ac?orgId=${param.orgId}" class="settlement" orgid="${param.orgId}" style="z-index: 105;" carttype="${carttype}">去结算</a>
    </c:when>
    <c:otherwise>
      <a href="javascript:" class="settlement" style="background-color: #ccc;z-index: 105;" aria-disabled="true">去结算</a>
    </c:otherwise>
  </c:choose>
  <a class="cart-toggle" id="storeCartLayer" orgid="${param.orgId}" href="javascript:">
    <c:choose>
      <c:when test="${empty loginUser}">
        <span>0</span>
      </c:when>
      <c:otherwise>
        <span>${storeCartNum}</span>
      </c:otherwise>
    </c:choose>
  </a>
  <div class="total">
    <span style="position: relative;top: -1px;"><small>&yen;&nbsp;</small>${storeCartProxy.realProductTotalAmount}</span>
    <p class="price"><small style="font-size: 1.0rem">优惠：&yen;${storeCartProxy.discountAmount}</small></p>
  </div>
</div>

<!-- 加入购物车 -->
<div class="modal modal-add-cart" style="display: none;" id="ajaxCartSeletor">

</div>

<!-- 查看购物车 -->
<div class="modal modal-view-cart" style="display: none;" id="ajaxLoadShoppingCart">

</div>

<!-- 优惠弹窗 -->
<div class="modal-promotion" style="display: none;">
  <div class="content">
    <span class="close"></span>
    <div class="store">
      <h2>易淘药药房萝岗店</h2>
      <div class="score">
        <div class="stars">
          <span class="active"></span>
          <span class="active"></span>
          <span class="active"></span>
          <span class="active"></span>
          <span></span>
        </div>
        96%
      </div>
      <p>
        <span>配送费&ensp;&yen;5</span>
        <span>商品数&ensp;86</span>
        <span>距离&ensp;68km</span>
      </p>
    </div>

    <dl class="promotion">
      <dt> 优惠信息 </dt>
      <dd><img src="${webRoot}/template/bdw/wap/citySend/statics/images/p-mj.png" alt="">满100减15; 满200减34;满300减50；满400减60； 满500减70。</dd>
      <dd><img src="${webRoot}/template/bdw/wap/citySend/statics/images/p-sd.png" alt="">新用户立减16元，首次使用银行卡支付再减3元</dd>
      <dd><img src="${webRoot}/template/bdw/wap/citySend/statics/images/p-zk.png" alt="">折扣商品5.0折起（在线支付专享）</dd>
    </dl>

    <dl class="notice">
      <dt>商家公告</dt>
      <dd>1. 购买过程中遇到任何问题，请联系我们客服10086， 我们   会及时解决您的问题； </dd>
      <dd>2. 为了商品能及时送到，请在每天下午</dd>
    </dl>
  </div>
</div>

<script src="${webRoot}/template/bdw/wap/citySend/statics/js/base.js"></script>

<nav id="page-nav">
  <a href="${webRoot}/wap/citySend/loadProduct.ac?page=2&categoryId=${param.shopCategoryId}&orgId=${param.orgId}&keyword=${param.keyword}&limit=${limit}"></a>
</nav>

<nav id="page-nav-comment">
  <a href="${webRoot}/wap/citySend/loadComment.ac?page=2&orgId=${param.orgId}&limit=${commentLimit}&stat="></a>
</nav>

</body>

</html>
