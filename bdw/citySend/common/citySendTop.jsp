<%@ page import="com.iloosen.imall.commons.util.holder.SpringContextHolder" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.service.ShoppingCartProxyService" %>
<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/16
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/external/jquery.cookie.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:searchZones()}" var="zones"/>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="store"/>
<jsp:useBean id="dataTime" class="java.util.Date" />
<script>
  var _hmt = _hmt || [];
  (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?9781eeadda233d8e366b87735b4feb80";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
  })();
</script>
<script type="text/javascript">
  var goToUrl = function (url) {
    setTimeout(function () {
      window.location.href = url
    }, 1)
  };
  var Top_Path = {webUrl: "${webUrl}", webRoot: "${webRoot}", topParam: "${param.p}", keyword: "${param.keyword}", webName: "${webName}",userId:"${user.userId}",handler : "${handler}",carttype : "${carttype}"};
  var top_searchField = "${param.searchField}";
  function dealCookie(key, value){
    if(value){
      $.cookie(key, value, {
        path: "/"
      });
    }
    return $.cookie(key);
  }

  $(document).ready(function(){
    $(".hover").hover(function(){
      $(this).addClass("cur");
    }, function(){
      $(this).removeClass("cur");
    });
    $("#addr").html(dealCookie("addr"));
  });

  $(function(){
    var userId = Top_Path.userId;
    $("#cartLayer").click(function () {

      if(undefined == userId || null == userId || "" == userId) {
        loadHideCart();
        showUserLogin();
      }
    });

    $("#storeCartLayer").click(function () {
      var orgid = $(this).attr("orgid");
      if(undefined == userId || null == userId || "" == userId) {
        loadStoreHideCart(orgid);
        showUserLogin();
      }
    });
  });


</script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/top.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/addFavorite.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/citySend/statics/js/sendCart.js"></script>
<style type="text/css">
  .btnLock{ opacity: 0.2; cursor: not-allowed;}
  .storeBtnLock{opacity: 0.4; border:1px solid;cursor: not-allowed;}
</style>
<%
  SpringContextHolder.getBean(ShoppingCartProxyService.class).reloadCartForJSPPage(CartTypeEnum.STORE.toCode());
%>

<div class="header" id="header">
  <div class="shortcut">
    <div class="sh-cont">
      <div class="fl">
        <c:if test="${not empty user}">
          [&nbsp;<a href="${webRoot}/module/member/index.ac" class="userName">${user.userName}</a>&nbsp;]
        </c:if>
        您好，欢迎来到<a href="${webRoot}/index.ac">${sdk:getSysParamValue('webName')}</a>
        <c:choose>
          <c:when test="${empty user}">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            [<a href="${webRoot}/login.ac" class="login">登录</a>]
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="${webRoot}/checkMobile.ac" class="register">免费注册</a>
          </c:when>
          <c:otherwise>
           [<a style="margin-left: 0px;" href="<c:url value='/member/exit.ac?sysUserId=${user.userId}'/>">退出</a>]
          </c:otherwise>
        </c:choose>
      </div>

      <ul class="fr">
        <li class="more">
          <a href="${webRoot}/module/member/index.ac" class="dt">会员中心</a>
          <div class="w-block"></div>
          <div class="dd">
            <a href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">我的订单</a>
            <a href="${webRoot}/module/member/productCollection.ac?pitchOnRow=3">我的收藏夹</a>
            <a href="${webRoot}/module/member/myCoupon.ac?pitchOnRow=17">我的优惠券</a>
          </div>
        </li>
        <li>|</li>
        <li>
          <a href="${webRoot}/attractAgentList.ac" class="dt">我要代理</a>
        </li>
        <li>|</li>
        <li>
          <a href="${webRoot}/shop/register/registerShopStep01.ac" class="dt">商家入驻</a>
        </li>
        <li>|</li>
        <li class="more frameEdit" frameInfo="sy_index_navigate">
          <a href="javascript:void(0);" class="dt">网站导航</a>
          <div class="w-block"></div>
          <div class="dd">
            <c:forEach items="${sdk:findPageModuleProxy('sy_index_navigate').links}" var="navigate">
              <a href="${navigate.link}" title="${navigate.title}">${navigate.title}</a>
            </c:forEach>
          </div>
        </li>
        <li>|</li>
        <li>
          <a href="${webRoot}/help-60010.html" class="dt">帮助中心</a>
        </li>
        <li>|</li>
  <%--      <li class="more frameEdit" frameInfo="sy_shiyao_brand">
          <a href="javascript:void(0);" class="dt">石药品牌</a>
          <div class="w-block"></div>
          <div class="dd">
            <c:forEach items="${sdk:findPageModuleProxy('sy_shiyao_brand').links}" var="brand">
              <a href="${brand.link}" title="${brand.title}">${brand.title}</a>
            </c:forEach>
          </div>
        </li>--%>
      </ul>
    </div>
  </div>
  <div class="header-mc">
    <div class="logo frameEdit"  frameInfo="sy_index_logo">
      <c:forEach items="${sdk:findPageModuleProxy('sy_index_logo').advt.advtProxy}" var="logo" varStatus="s" end="0">
        <a href="${logo.link}"><img src="${logo.advUrl}"></a>
      </c:forEach>
    </div>
    <c:choose>
      <c:when test="${param.p == 'order'}">
        <div class="hd-title">订单提交</div>
      </c:when>
      <c:otherwise>
        <div class="hd-title"><a href="${webRoot}/citySend/index.ac" title="淘药店">淘药店</a></div>
      </c:otherwise>
    </c:choose>
    <c:choose>
      <c:when test="${param.p == 'order'}">
        <ul class="step fr">
          <li class="step-item active">
            <span class="lab">1</span>
            <span class="text">我的购物车</span>
          </li>
          <li class="step-item active">
            <span class="lab">2</span>
            <span class="text">确认订单信息</span>
          </li>
          <li class="step-item">
            <span class="lab">3</span>
            <span class="text">成功提交订单</span>
          </li>
        </ul>
      </c:when>
      <c:otherwise>
        <c:choose>
          <c:when test="${param.p == 'index'}">
            <div class="sel-addr"><a href="javascript:void(0);" id="selectAddr">选择配送地址</a></div>
            <div class="search">
              <div class="form">
                <div class="search-sel">
                  <span><a class="city-toggle" id="city-toggle" href="javascript:void(0);" style="color: #E5151F;"></a></span>
                  <div style="display: none;" class="city-box city-dropdown">
                    <div class="box-top">
                      <label>请选择您所在的城市</label>
                      <em><a href="javascript:void(0);">选城市</a> > 定位置 > 购买商品</em>
                    </div>
                    <div class="box-bot">
                      <div class="bot-sc">
                        <i>猜你在</i>
                        <div class="ct g-city"></div>
                        <div class="sc-cont">
                          <input type="text" id="cityToggle" autocomplete="off" value="" placeholder="请输入城市或城市首字母">
                          <a href="javascript:void(0);" id="se" class="sc-btn"></a>
                        </div>
                      </div>
                      <div class="bot-ct">
                        <c:forEach items="${zones}" var="zone">
                          <div class="ct-item">
                            <div class="rank">${zone.key}</div>
                            <ul>
                              <c:forEach items="${zone.value}" var="city">
                                <li> <a class="city city-item" cm="${city.name}" zoneId="${city.zoneId}" spell="${city.spell}" href="javascript:">${city.name}</a></li>
                              </c:forEach>
                            </ul>
                          </div>
                        </c:forEach>
                      </div>
                    </div>
                  </div>
                </div>
                <input type="text" autocomplete="off" id="keyword" placeholder="请输入您要配送的地址" style="padding-left: 60px;">
                <a href="javascript:void(0);" id="search" class="search-btn">搜索</a>
              </div>
              <!--附近门店层-->
              <div style="display: none;" class="shop-dropdown pr-box"></div>
                <%--根据输入地址筛选出的地址列表--%>
              <div class="search-box" id="cityBox" style="display: none;">
                <ul id="search-result"></ul>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="location ">
              <i class="icon-location"></i>
              <span id="addr"></span>
              <a href="${webRoot}/citySend/index.ac" title="切换地址" id="toggleAddress">[切换地址]</a>
            </div>
          </c:otherwise>
        </c:choose>
      </c:otherwise>
    </c:choose>
  </div>
  <c:if test="${param.p != 'index'}">
  <div class="nav-bg">
    <c:set value="${sdk:findAllProductCategory()}" var="allProductCategory"/>
    <c:set value="${sdk:getShopRoot(2)}" var="shopRoot"/>  <%--默认预设商家shopId=2--%>
    <c:set value="${param.shopCategoryId==null ? shopRoot : param.shopCategoryId}" var="categoryId"/>
    <c:set value="${sdk:getChildren(categoryId,2)}" var="shopCategory"/>
    <div class="nav">
      <div class="category" rel="${param.p}">
        <div class="nav-dt"><a href="${webRoot}/productlist-1.html" target="_blank">全部商品分类</a></div>
        <div class="nav-dc dc-inner" <c:if test="${param.p != 'index'}">style="display: none;"</c:if>>
          <c:forEach items="${allProductCategory}" var="category" varStatus="i" end="9">
            <div class="item">
              <div class="menus">
                <div class="menu-top">
                  <div class="menu-icon"><img src="${category.icon['']}"></div>
                  <span onclick="searchMenu(${category.categoryId})">${category.name}</span>
                </div>
                <div class="menu-cont">
                  <c:choose>
                    <c:when test="${category.categoryId == '85'}">
                      <c:forEach items="${category.children}" var="child" varStatus="c">
                        <!-- 找到categoryId为大药房的节点 -->
                        <a href="http://www.sydyf.com/index.ac" target="_blank">${child.name}</a>
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <c:forEach items="${category.children}" var="child" varStatus="c">
                        <a href="${webRoot}/productlist-${child.categoryId}.html" title="${child.name}" target="_blank">${child.name}</a>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>

        <div class="item-sub-inner">
          <c:forEach items="${allProductCategory}" var="category" varStatus="i" end="9">
            <c:set var="sy_index_hotSale_down" value="sy_index_hotSale_down${i.index+1}" />
            <c:set var="sy_index_hotSale_up" value="sy_index_hotSale_up${i.index+1}" />
            <div class="item-sub">
              <div class="sub-lt">
                <c:forEach items="${category.children}" var="child" varStatus="c">
                  <div class="dl">
                    <div class="dt"><a href="${webRoot}/productlist-${child.categoryId}.html" target="_blank">${child.name}</a></div>
                    <div class="dd">
                      <c:choose>
                        <c:when test="${category.categoryId == '85'}">
                          <c:forEach items="${child.children}" var="threeChild" varStatus="s">
                            <!-- 找到categoryId为大药房的节点 -->
                            <a href="http://www.sydyf.com/index.ac" target="_blank">${threeChild.name}</a>
                          </c:forEach>
                        </c:when>
                        <c:otherwise>
                          <c:forEach items="${child.children}" var="threeChild" varStatus="s">
                            <a href="${webRoot}/productlist-${threeChild.categoryId}.html" title="${threeChild.name}" target="_blank">${threeChild.name}</a>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </c:forEach>
              </div>
              <div class="sub-rt">
                <div class="brand frameEdit"  frameInfo="${sy_index_hotSale_up}">
                  <div class="brand-mt">热门品牌</div>
                  <div class="brand-mc">
                    <c:forEach items="${sdk:findPageModuleProxy(sy_index_hotSale_up).advt.advtProxy}" var="hotSale" end="11">
                      ${hotSale.htmlTemplate}
                    </c:forEach>
                  </div>
                </div>
                <div class="rt-ad frameEdit" frameInfo=${sy_index_hotSale_down}>
                  <c:forEach items="${sdk:findPageModuleProxy(sy_index_hotSale_down).advt.advtProxy}" var="hotSale" end="0">
                    ${hotSale.htmlTemplate}
                  </c:forEach>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
      <ul class="main-nav frameEdit" frameInfo="sy_top_menu">
        <c:forEach items="${sdk:findPageModuleProxy('sy_top_menu').links}" var="menu">
          <c:choose>
            <c:when test="${empty menu.description}">
              <li>
                <a href="${menu.link}" class="dt" <c:if test="${menu.newWin}">target="_blank"</c:if> >${menu.title}</a>
              </li>
            </c:when>
            <c:otherwise>
              <li class="more">
                <a href="javascript:void(0);" class="dt" <c:if test="${menu.newWin}">target="_blank"</c:if> >${menu.title}</a>
                <div class="w-block"></div>
                <div class="dd">
                  <c:forEach items="${fn:split(menu.description,';')}" var="titleAndHerf" varStatus="s">
                    <c:set value="${fn:split(titleAndHerf,',')}" var="element"/>
                    <a href="${element[1]}" target="_blank">${element[0]}</a>
                  </c:forEach>
                </div>
              </li>
            </c:otherwise>
          </c:choose>
        </c:forEach>
      </ul>
    </div>
  </div>
</c:if>
</div>

<!--请选择配送地址-->
<div class="overlay" style="display: none;" id="addressLayer">
  <div class="add-box">
    <div class="mt">
      <span>请选择配送地址</span>
      <a href="javascript:void(0);" class="close" id="closeAddrLayer">&times;</a>
    </div>
    <div class="mc">
      <c:if test="${not empty user.addr}">
        <div class="mc-top">
          <ul id="addressList">
            <c:forEach items="${user.addr}" var="userAddr">
              <li class="cur">
                <span class="elli"><em>${userAddr.addressPath}</em>${userAddr.addressStr}</span>
                <a addr="${userAddr.addressPath}${userAddr.addressStr}" lat="${userAddr.lat}" lng="${userAddr.lng}" class="btn btn-org" href="javascript:" title="选择">选择</a>
              </li>
            </c:forEach>
          </ul>
        </div>
        <div style="display: none" id="addMap"></div>
      </c:if>
      <!--点击新增配送地址，这里加class：cur-->
      <div class="mc-md cur">
        <div class="md-th"><span><a href="javascript:void(0);" id="addAddr" style="color: #e5151f;">新增配送地址</a></span></div>
        <div class="md-td" style="display: none" id="addAddressLayer">
          <div class="td-sel elli">
            <span><i style="margin-right: 5px; color: #e5151f;">*</i>所在地区</span>
            <select class="addressSelect" id="province" name="" onchange="proviceSelected(this);">
              <option>请选择</option>
            </select>
            <select class="addressSelect" id="city" name=""onchange="citySelected(this);">
              <option>请选择</option>
            </select>
            <select class="addressSelect" id="zone" name="zoneId" onchange="areaSelected(this);">
              <option>请选择</option>
            </select>
          </div>
          <div class="td-add">
            <span><i style="margin-right: 5px; color: #e5151f;">*</i>配送地址</span>
            <textarea placeholder="无需重复填写省市区，小于50个字" id="address" onblur="locatedAddress();"></textarea>
          </div>
          <div class="td-item">
            <span><i style="margin-right: 5px; color: #e5151f;">*</i>收货人</span>
            <input type="text" name="name" id="name"/>
          </div>
          <div class="td-item" style="height: 50px">
            <span><i style="margin-right: 5px; color: #e5151f;">*</i>手机号码</span>
            <input type="text" name="mobile" id="mobile"/>
          </div>
          <div class="td-btn">
            <a href="javascript:void(0);" class="confirm" id="saveAddrBtn">保存</a>
            <a href="javascript:void(0);" class="cancel" id="cancelBtn">取消</a>
          </div>
        </div>
      </div>
    <%--  <div class="mc-bot"><a href="##" class="disabled">确定</a></div>--%>
    </div>
  </div>
</div>

<c:if test="${param.p != 'index'}">
  <%--购物车--%>
  <c:if test="${param.p == 'storeList' || param.p == 'productList' || param.p == 'prdDetail'}">
    <c:set var="citySendUserCartListProxy" value="${bdw:getCitySendShoppingCartProxy()}"/>
    <c:set var="cartNum" value="${citySendUserCartListProxy.allCartNum}" />
    <%--所有门店的购物车--%>
    <div id="oldCart">
      <!-- 购物车-图标-->
      <div class="cart-toggle" id="cartLayer">
        <i class="icon-cart"></i>
        <span>购物车</span>
        <c:choose>
          <c:when test="${empty user}">
            <em>0</em>
          </c:when>
          <c:otherwise>
            <em>${cartNum}</em>
          </c:otherwise>
        </c:choose>
      </div>
      <!-- 购物车-内容 -->
      <div class="cart-target" id="allStoreCart">
        <div class="cart-content" id="cartContent">
          <h2>淘药店购物车<em>(${cartNum})</em></h2>
          <c:choose>
            <c:when test="${not empty citySendUserCartListProxy.shoppingCartProxyList && citySendUserCartListProxy.allCartNum>0}">
              <c:set value="${citySendUserCartListProxy.shoppingCartProxyList}" var="shoppingCartProxyList"/>
              <%--购物车中有商品--%>
              <ul class="cart-th">
                <li class="th th-chk">
                  <span class="checkbox" aria-disabled="true">
                    <i class="icon lock"></i>&emsp;勾选
                  </span>
                </li>
                <li class="th th-detail">商品信息</li>
                <li class="th th-price">会员价</li>
                <li class="th th-count">数量</li>
                <li class="th th-opera">操作</li>
              </ul>
              <div class="order-list">
                <c:forEach items="${shoppingCartProxyList}" var="shoppingCartProxy">
                  <c:set value="${shoppingCartProxy.orgId}" var="sysorgid"/>
                  <c:set value="${bdw:checkOrgSelected(carttype,shoppingCartProxy.orgId)}" var="isOrgSelected"/>
                  <c:set value="${bdw:checkOrgAllSelected(carttype,shoppingCartProxy.orgId)}" var="isOrgAllSelected"/>
                  ${sdk:clearShoppingCartZoneId(carttype, sysorgid)}
                  <c:if test="${fn:length(shoppingCartProxy.cartItemProxyList)>0}">
                    <div class="order-holder">
                      <div class="shop">
                        <h3>
                          <span class="<c:if test="${isOrgSelected == 'Y'}">active</c:if> checkbox cbox${sysorgid}" carttype="${carttype}" orgid="${sysorgid}" onclick="selectAll(this,'${sysorgid}')">
                            <i class="icon"></i>
                          </span>&emsp;
                          <a href="${webRoot}/citySend/storeDetail.ac?orgId=${sysorgid}" title="${shoppingCartProxy.shopInf.shopNm}">${shoppingCartProxy.shopInf.shopNm}&ensp;<i>&gt;</i></a>
                        </h3>
                      </div>
                      <div class="order-content">
                        <ul class="bundle">
                          <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                            <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                            <c:set var="itemKey" value="${cartItemProxy.itemKey}"/>
                            <c:set var="isSelected" value="${cartItemProxy.itemSelected}"/>
                            <c:set var="promotionType" value="${cartItemProxy.promotionType}"/>
                            <c:choose>
                              <%--失效商品--%>
                              <c:when test="${cartItemProxy.isDisabled == 'Y'}">
                                <c:choose>
                                  <%--赠品--%>
                                  <c:when test="${cartItemProxy.promotionType=='PRESENT' || cartItemProxy.promotionType=='REDEMPTION'}">
                                    <li class="item">
                                        <%--不要显示复选框--%>
                                      <div class="td td-chk" style="color: #bbb;font-size: 13px;">失效</div>
                                        <%--商品名称--%>
                                      <div class="td td-detail">
                                        <div class="item-img">
                                          <a href="javascript:void(0);" title="${cartItemProxy.name}">
                                            <c:choose>
                                              <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                              </c:when>
                                              <c:otherwise>
                                                <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                              </c:otherwise>
                                            </c:choose>
                                          </a>
                                        </div>
                                        <div class="item-info">
                                          <p class="item-base-info"><a href="javascript:void(0);" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                          <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                        </div>
                                      </div>
                                        <%--商品价格--%>
                                      <div class="td td-price">
                                        <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                      </div>
                                        <%--数量显示即可，不需要任何操作--%>
                                      <div class="td td-count">
                                        <div class="amount" style="text-align: center;border: 0px">${cartItemProxy.quantity}</div>
                                        <p>
                                          <c:choose>
                                            <c:when test="${not empty cartItemProxy.disabledReason}">
                                              ${cartItemProxy.disabledReason}
                                            </c:when>
                                            <c:otherwise>
                                              该商品不能购买，请联系卖家
                                            </c:otherwise>
                                          </c:choose>
                                        </p>
                                      </div>
                                      <div class="td td-opera">
                                          <%--<a href="javascript:" title="移到收藏夹">移到收藏夹</a>--%>
                                        <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                      </div>
                                    </li>
                                  </c:when>
                                  <%--单品和套餐--%>
                                  <c:otherwise>
                                    <c:choose>
                                      <%--套餐--%>
                                      <c:when test="${promotionType=='COMBINED_PRODUCT'}">
                                        <li class="item">
                                            <%--复选框--%>
                                          <div class="td td-chk" style="color: #bbb;font-size: 13px;">失效</div>
                                            <%--商品名称--%>
                                          <div class="td td-detail">
                                            <div class="item-img">
                                              <a href="javascript:void(0);" title="${cartItemProxy.name}">
                                                <c:choose>
                                                  <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                  </c:when>
                                                  <c:otherwise>
                                                    <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                  </c:otherwise>
                                                </c:choose>
                                              </a>
                                            </div>
                                            <div class="item-info">
                                              <p class="item-base-info"><a href="javascript:void(0);" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                <%--套餐单项商品--%>
                                              <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                                                <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                  <p class="item-other-info elli">
                                                    <a href="javascript:void(0);"><img width="20" height="20" src="${bdw:getAllStatusProductById(combo.productId).defaultImage['40X40']}"/></a>
                                                    <a href="javascript:void(0);">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span>
                                                  </p>
                                                </c:forEach>
                                              </c:if>
                                                <%--赠品--%>
                                              <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                                <c:forEach items="${cartItemProxy.presents}" var="present">
                                                  <p class="item-other-info elli">赠品：${present.name}<em>× ${present.quantity}</em></p>
                                                </c:forEach>
                                              </c:if>
                                                <%--规格--%>
                                              <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                            </div>
                                          </div>
                                            <%--  <div class="td td-standard">
                                                <span>10ml*10支</span>
                                              </div>--%>
                                            <%--商品价格--%>
                                          <div class="td td-price">
                                            <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                          </div>
                                            <%--数量操作--%>
                                          <div class="td td-count">
                                            <div class="amount" style="text-align: center;border: 0px">${cartItemProxy.quantity}</div>
                                              <%--提示信息--%>
                                            <p>${cartItemProxy.disabledReason}</p>
                                          </div>
                                            <%--订单项操作--%>
                                          <div class="td td-opera">
                                              <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                            <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                          </div>
                                        </li>
                                      </c:when>
                                      <%--单品--%>
                                      <c:otherwise>
                                        <li class="item">
                                            <%--复选框--%>
                                          <div class="td td-chk" style="color: #bbb;font-size: 13px;">失效</div>
                                            <%--商品名称--%>
                                          <div class="td td-detail">
                                            <div class="item-img">
                                              <a href="javascript:void(0);" title="${cartItemProxy.name}">
                                                <c:choose>
                                                  <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                  </c:when>
                                                  <c:otherwise>
                                                    <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                  </c:otherwise>
                                                </c:choose>
                                              </a>
                                            </div>
                                            <div class="item-info">
                                              <p class="item-base-info"><a href="javaScript:void(0);" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                <%--赠品--%>
                                              <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                                <c:forEach items="${cartItemProxy.presents}" var="present">
                                                  <p class="item-other-info elli">赠品：${present.name}<em>× ${present.quantity}</em></p>
                                                </c:forEach>
                                              </c:if>
                                                <%--规格--%>
                                              <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                            </div>
                                          </div>
                                            <%--  <div class="td td-standard">
                                                <span>10ml*10支</span>
                                              </div>--%>
                                            <%--商品价格--%>
                                          <div class="td td-price">
                                            <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                          </div>
                                            <%--数量操作--%>
                                          <div class="td td-count">
                                            <div class="amount" style="text-align: center;border:0px;">${cartItemProxy.quantity}</div>
                                              <%--提示信息--%>
                                            <p>${cartItemProxy.disabledReason}</p>
                                          </div>
                                            <%--订单项操作--%>
                                          <div class="td td-opera">
                                              <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                            <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                          </div>
                                        </li>
                                      </c:otherwise>
                                    </c:choose>
                                  </c:otherwise>
                                </c:choose>
                              </c:when>
                              <%--有效商品--%>
                              <c:otherwise>
                                <c:choose>
                                  <%--订单赠品--%>
                                  <c:when test="${promotionType=='PRESENT' || promotionType=='REDEMPTION'}">
                                    <li class="item">
                                        <%--不要显示复选框--%>
                                      <div class="td td-chk"></div>
                                        <%--商品名称--%>
                                      <div class="td td-detail">
                                        <div class="item-img">
                                          <a href="${webRoot}/product=${cartItemProxy.productId}.html" title="${cartItemProxy.name}">
                                            <img src="${cartItemProxy.productProxy.defaultImage["80X80"]}" alt="${cartItemProxy.name}">
                                          </a>
                                        </div>
                                        <div class="item-info">
                                          <p class="item-base-info"><a href="${webRoot}/product=${cartItemProxy.productId}.html" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                          <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                          <p class="item-other-info elli"><span>订单赠品</span></p>
                                        </div>
                                      </div>
                                        <%--商品价格--%>
                                      <div class="td td-price">
                                        <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                      </div>
                                        <%--数量显示即可，不需要任何操作--%>
                                      <div class="td td-count">
                                        <div class="amount" style="border:0;text-align: center;">${cartItemProxy.quantity}</div>
                                          <%--不要提示信息--%>
                                        <p>${cartItemProxy.cartItemMsg}</p>
                                      </div>
                                        <%--不要订单项操作--%>
                                      <div class="td td-opera">
                                          <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                          <%-- <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>--%>
                                      </div>
                                    </li>

                                  </c:when>
                                  <%--单品和套餐--%>
                                  <c:otherwise>
                                    <c:choose>
                                      <%--套餐--%>
                                      <c:when test="${promotionType=='COMBINED_PRODUCT'}">
                                        <li class="item">
                                            <%--复选框--%>
                                          <div class="td td-chk">
                                          <span class="checkbox item${sysorgid} updateSelect <c:if test="${isSelected}">active</c:if>" autocomplete="off" itemKey="${itemKey}"  carttype="${carttype}" orgid="${sysorgid}">
                                            <i class="icon"></i>
                                          </span>
                                          </div>
                                            <%--商品名称--%>
                                          <div class="td td-detail">
                                            <div class="item-img">
                                              <a href="${webRoot}/product=${cartItemProxy.productId}.html" title="${cartItemProxy.name}">
                                                <img src="${cartItemProxy.productProxy.defaultImage["80X80"]}" alt="${cartItemProxy.name}">
                                              </a>
                                            </div>
                                            <div class="item-info">
                                              <p class="item-base-info"><a href="${webRoot}/product=${cartItemProxy.productId}.html" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                <%--规格--%>
                                              <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                                <%--套餐单项商品--%>
                                              <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                <p class="item-other-info elli">
                                                  <a href="${webRoot}/product-${combo.productId}.html"><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/></a>
                                                  <a href="${webRoot}/product-${combo.productId}.html">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span>
                                                </p>
                                              </c:forEach>
                                                <%--赠品--%>
                                              <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                                <c:forEach items="${cartItemProxy.presents}" var="present">
                                                  <p class="item-other-info elli">赠品：${present.name}<em>× ${present.quantity}</em></p>
                                                </c:forEach>
                                              </c:if>
                                            </div>
                                          </div>
                                            <%--商品价格--%>
                                          <div class="td td-price">
                                            <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                          </div>
                                            <%--数量操作--%>
                                          <div class="td td-count">
                                            <div class="amount">
                                              <c:choose>
                                                <c:when test="${cartItemProxy.quantity>1}">
                                                  <a class="amount-opera subNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}" productId="${cartItemProxy.productId}">&minus;</a>
                                                </c:when>
                                                <c:otherwise>
                                                  <a class="amount-opera btnLock" href="javascript:">&minus;</a>
                                                </c:otherwise>
                                              </c:choose>
                                              <input class="amount-inp cartNum" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}">
                                              <c:choose>
                                                <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                  <a class="amount-opera addNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}">&plus;</a>
                                                </c:when>
                                                <c:otherwise>
                                                  <a class="amount-opera btnLock" href="javascript:" >&plus;</a>
                                                </c:otherwise>
                                              </c:choose>
                                            </div>
                                              <%--提示信息--%>
                                            <p>${cartItemProxy.cartItemMsg}</p>
                                          </div>
                                            <%--订单项操作--%>
                                          <div class="td td-opera">
                                              <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                            <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                          </div>
                                        </li>
                                      </c:when>
                                      <%--单品--%>
                                      <c:otherwise>
                                        <li class="item">
                                            <%--复选框--%>
                                          <div class="td td-chk">
                                          <span class="checkbox item${sysorgid} updateSelect <c:if test="${isSelected}">active</c:if>" autocomplete="off" itemKey="${itemKey}"  carttype="${carttype}" orgid="${sysorgid}">
                                            <i class="icon"></i>
                                          </span>
                                          </div>
                                            <%--商品名称--%>
                                          <div class="td td-detail">
                                            <div class="item-img">
                                              <a href="${webRoot}/product-${cartItemProxy.productId}.html" title="${cartItemProxy.name}">
                                                <img src="${cartItemProxy.productProxy.defaultImage["80X80"]}" alt="${cartItemProxy.name}">
                                              </a>
                                            </div>
                                            <div class="item-info">
                                              <p class="item-base-info"><a href="${webRoot}/product-${cartItemProxy.productId}.html" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                <%--规格--%>
                                              <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                                <%--赠品--%>
                                              <c:forEach items="${cartItemProxy.presents}" var="present">
                                                <p class="item-other-info elli">赠品：${present.name}<em>× ${present.quantity}</em></p>
                                              </c:forEach>
                                            </div>
                                          </div>
                                            <%--  <div class="td td-standard">
                                                <span>10ml*10支</span>
                                              </div>--%>
                                            <%--商品价格--%>
                                          <div class="td td-price">
                                            <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                          </div>
                                            <%--数量操作--%>
                                          <div class="td td-count">
                                            <div class="amount">
                                              <c:choose>
                                                <c:when test="${cartItemProxy.quantity>1}">
                                                  <a class="amount-opera subNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}" productId="${cartItemProxy.productId}">&minus;</a>
                                                </c:when>
                                                <c:otherwise>
                                                  <a class="amount-opera btnLock" href="javascript:">&minus;</a>
                                                </c:otherwise>
                                              </c:choose>
                                              <input class="amount-inp cartNum" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}">
                                              <c:choose>
                                                <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                  <a class="amount-opera addNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}">&plus;</a>
                                                </c:when>
                                                <c:otherwise>
                                                  <a class="amount-opera btnLock" href="javascript:" >&plus;</a>
                                                </c:otherwise>
                                              </c:choose>
                                            </div>
                                              <%--提示信息--%>
                                            <p>${cartItemProxy.cartItemMsg}</p>
                                          </div>
                                            <%--订单项操作--%>
                                          <div class="td td-opera">
                                              <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                            <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                          </div>
                                        </li>
                                      </c:otherwise>
                                    </c:choose>
                                  </c:otherwise>
                                </c:choose>
                              </c:otherwise>
                            </c:choose>
                          </c:forEach>
                        </ul>
                        <div class="total clearfix">
                        <span class="<c:if test="${isOrgAllSelected=='Y'}">active</c:if> checkbox fl" orgid="${sysorgid}" carttype="${carttype}" onclick="selectAll(this,'${sysorgid}')">
                            <i class="icon"></i>&emsp;全选
                        </span>
                          <a class="btn-link fl" href="javascript:" onclick="delSelectedItem(this);" carttype="${carttype}" orgid="${sysorgid}">删除选中的商品</a>
                            <%-- <a class="btn-link fl" href="javascript:">移到收藏夹</a>--%>
                          <a class="btn-link fl" href="${webRoot}/citySend/index.ac">继续购物</a>
                          <c:choose>
                            <c:when test="${shoppingCartProxy.selectedCartItemNum>0}">
                              <a class="btn-checkout fr addCartResult" href="javascript:" carttype="${carttype}" handler="${handler}" orgid="${sysorgid}">确认结算</a>
                            </c:when>
                            <c:otherwise>
                              <a class="btn-checkout fr" href="javascript:" style="background-color: #ccc;" aria-disabled="true">确认结算</a>
                            </c:otherwise>
                          </c:choose>
                          <p class="fr">已选商品&ensp;<em id="allCartNum">${shoppingCartProxy.selectedCartItemNum}</em>&ensp;件；商品金额合计（不含运费）：<strong><small>&yen;&nbsp;</small><em id="allProductTotalAmount"><fmt:formatNumber value="${shoppingCartProxy.realProductTotalAmount}" type="number" pattern="#0.00#" /></em></strong></p>
                        </div>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </div>
            </c:when>
            <c:otherwise>
              <div class="cart-empty">
                <div class="warp">
                  <i class="icon-normal-cart-empty"></i>
                  <p class="text">购物车还是空滴</p>
                  <a class="shop" href="${webRoot}/citySend/index.ac">继续购物&gt;&gt;</a>
                </div>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
    <%--购物车伸缩动画--%>
    <script>
      $(function() {
        var $cartToggle = $('.cart-toggle'),
        $cartTarget = $('.cart-target'),
        $cartContent = $cartTarget.find('.cart-content'),
        iW = $cartContent.width();
        $cartToggle.toggle(function() {
          if($("#cartLayer").css("right")=='1260px'){
            $(this).animate({
              'right': '0'
            }, 1000);

            $cartContent.animate({
              'right': '-1260px'
            }, 1000, function() {
              $cartTarget.hide('slow');

              $('body').css({
                overflow: 'auto'
              });
            });
          }else{
            $('body').css({
              overflow: 'hidden'
            });

            $(this).animate({
              'right': '1260px'
            }, 1000);

            $cartTarget.show('slow');

            $cartContent.animate({
              'right': '0'
            }, 1000);
          }
        }, function() {
          if($("#cartLayer").css("right")=='1260px'){
            $(this).animate({
              'right': '0'
            }, 1000);

            $cartContent.animate({
              'right': '-1260px'
            }, 1000, function() {
              $cartTarget.hide('slow');

              $('body').css({
                overflow: 'auto'
              });
            });
          }else{
            $('body').css({
              overflow: 'hidden'
            });

            $(this).animate({
              'right': '1260px'
            }, 1000);

            $cartTarget.show('slow');

            $cartContent.animate({
              'right': '0'
            }, 1000);
          }
        });
      });
    </script>
  </c:if>

  <c:if test="${param.p == 'storeDetail'}">
    <c:set var="orgId" value="${param.orgId}"/>
    <c:set var="storeCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>
    <c:set var="storeCartNum" value="${storeCartProxy.cartNum}" />
    <%--单门店的购物车--%>
    <div id="storeCart">
      <%--单门店的购物车--%>
      <!-- 购物车入口 -->
      <div class="cart-toggle storeCartToggle" id="storeCartLayer" orgid="${orgId}">
        <a href="javascript:" title="购物车" id="toggleCart" orgid="${orgId}">
          <c:choose>
            <c:when test="${empty user}">
              <span>0</span>
            </c:when>
            <c:otherwise>
              <span>${storeCartNum}</span>
            </c:otherwise>
          </c:choose>
          <i class="icon-cart-lg"></i>
        </a>
      </div>
      <!-- 购物车内容-->
      <c:set value="${bdw:checkOrgSelected(carttype,orgId)}" var="isStoreOrgSelected"/>
      <c:set value="${bdw:checkOrgAllSelected(carttype,orgId)}" var="isStoreOrgAllSelected"/>
      ${sdk:clearShoppingCartZoneId(carttype, orgId)}
      <div class="cart-target storeCartTarget" id="singleStoreCart">
        <div class="cart-content" id="singleCartContent">
          <dl>
            <dt>
              <c:if test="${not empty storeCartProxy && storeCartNum>0}">
                 <span class="<c:if test="${isStoreOrgAllSelected == 'Y'}">active</c:if> checkbox" id="allSelect" carttype="${carttype}" orgid="${orgId}">
                <i class="icon"></i> 全选
              </span>
              </c:if>
              <c:if test="${storeCartNum > 0}">
                <a class="delete-selected" href="javascript:;" onclick="deleSelectedItemInOneMerchant(this);" carttype="${carttype}" orgid="${orgId}">删除选中的商品</a>
              </c:if>

            </dt>
            <dd>
              <ul>
                <c:choose>
                  <c:when test="${empty storeCartProxy || storeCartNum<=0}">
                    <div class="store-cart-empty">
                      <div class="warp">
                        <i class="icon-normal-cart-empty"></i>
                        <p class="text">购物车还是空滴</p>
                        <a class="shop" href="${webRoot}/citySend/index.ac">继续购物&gt;&gt;</a>
                      </div>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <c:forEach items="${storeCartProxy.cartItemProxyList}" var="cartItemProxy">
                      <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                      <c:set var="itemKey" value="${cartItemProxy.itemKey}"/>
                      <c:set var="isSelected" value="${cartItemProxy.itemSelected}"/>
                      <c:set var="promotionType" value="${cartItemProxy.promotionType}"/>
                      <c:choose>
                        <%--失效--%>
                        <c:when test="${cartItemProxy.isDisabled == 'Y'}">
                          <c:choose>
                            <%--订单赠品--%>
                            <c:when test="${promotionType=='PRESENT' || promotionType=='REDEMPTION'}">
                              <li class="media">
                                <span class="checkbox sitem${orgId}" style="color: #bbb;font-size: 12px;">失效</span>
                                <a class="media-left" href="javascript:void(0);">
                                  <c:choose>
                                    <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                      <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                    </c:when>
                                    <c:otherwise>
                                      <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                    </c:otherwise>
                                  </c:choose>
                                </a>
                                <div class="media-body">
                                  <a class="media-heading" href="javascript:void(0);">${cartItemProxy.name}<span style="color: red;;">(订单赠品)</span></a>
                                  <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                  <div class="amount" style="margin-left: 34px;border: 0px;">${cartItemProxy.quantity}</div>
                                  <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                </div>
                                <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.disabledReason}</p>
                              </li>
                            </c:when>
                            <%--单品与套餐--%>
                            <c:otherwise>
                              <c:choose>
                                <%--套餐--%>
                                <c:when test="${promotionType=='COMBINED_PRODUCT'}">
                                  <li class="media">
                                    <span class="checkbox sitem${orgId}" style="color: #bbb;font-size: 12px;">
                                       失效
                                    </span>
                                    <a class="media-left" href="javascript:void(0);">
                                      <c:choose>
                                        <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                          <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                        </c:when>
                                        <c:otherwise>
                                          <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                        </c:otherwise>
                                      </c:choose>
                                    </a>
                                    <div class="media-body">
                                      <p class="media-heading"> <a href="${webRoot}/product-${cartItemProxy.productId}.html">${cartItemProxy.name}</a><a href="javascript:void(0);" class="del" onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a></p>
                                      <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                        <%--套餐单项品--%>
                                      <c:forEach items="${cartItemProxy.combos}" var="combo">
                                        <p>
                                          <a href="javascript:void(0);"><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/></a>
                                          <a href="javascript:void(0);">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span>
                                        </p>
                                      </c:forEach>
                                        <%--赠品--%>
                                      <c:forEach items="${cartItemProxy.presents}" var="present">
                                        <p><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></p>
                                      </c:forEach>
                                      <div class="amount" style="margin-left: 34px;border: 0px;">${cartItemProxy.quantity}</div>
                                      <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                      <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.disabledReason}</p>
                                    </div>
                                  </li>
                                </c:when>
                                <%--单品--%>
                                <c:otherwise>
                                  <li class="media">
                                    <span class="checkbox sitem${orgId}" style="color: #bbb;font-size: 12px;">
                                       失效
                                    </span>
                                    <a class="media-left" href="javascript:void(0);">
                                      <c:choose>
                                        <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                          <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                        </c:when>
                                        <c:otherwise>
                                          <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                        </c:otherwise>
                                      </c:choose>
                                    </a>
                                    <div class="media-body">
                                      <p class="media-heading"> <a href="${webRoot}/product-${cartItemProxy.productId}.html"  class="title" >${cartItemProxy.name}</a><a href="javascript:void(0);" class="del" onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a></p>
                                      <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                        <%--赠品--%>
                                      <c:forEach items="${cartItemProxy.presents}" var="present">
                                        <p><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></p>
                                      </c:forEach>
                                      <div class="amount" style="margin-left: 34px;border: 0px;">${cartItemProxy.quantity}</div>
                                      <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                      <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.disabledReason}</p>
                                    </div>
                                  </li>
                                </c:otherwise>
                              </c:choose>
                            </c:otherwise>
                          </c:choose>
                        </c:when>
                        <%--有效--%>
                        <c:otherwise>
                          <c:choose>
                            <%--订单赠品--%>
                            <c:when test="${promotionType=='PRESENT' || promotionType=='REDEMPTION'}">
                              <li class="media">
                                <span class="checkbox sitem${orgId} supdateSelect"></span>
                                <a class="media-left" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                  <c:choose>
                                    <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                      <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                    </c:when>
                                    <c:otherwise>
                                      <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                    </c:otherwise>
                                  </c:choose>
                                </a>
                                <div class="media-body">
                                  <a class="media-heading" href="${webRoot}/product-${cartItemProxy.productId}.html">${cartItemProxy.name}<span style="color: red;;">(订单赠品)</span></a>
                                  <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                  <div class="amount" style="margin-left: 34px;border: 0px;">${cartItemProxy.quantity}</div>
                                  <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                  <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.cartItemMsg}</p>
                                </div>
                              </li>
                            </c:when>
                            <%--单品与套餐--%>
                            <c:otherwise>
                              <c:choose>
                                <%--套餐--%>
                                <c:when test="${promotionType=='COMBINED_PRODUCT'}">
                                  <li class="media">
                                    <span class="checkbox sitem${orgId} supdateSelect <c:if test="${isSelected}">active</c:if>" autocomplete="off" itemKey="${itemKey}"  carttype="${carttype}" orgid="${orgId}">
                                        <i class="icon"></i>
                                    </span>
                                    <a class="media-left" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                      <c:choose>
                                        <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                          <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                        </c:when>
                                        <c:otherwise>
                                          <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                        </c:otherwise>
                                      </c:choose>
                                    </a>
                                    <div class="media-body">
                                      <p class="media-heading"> <a href="${webRoot}/product-${cartItemProxy.productId}.html" class="title">${cartItemProxy.name}</a><a href="javascript:void(0);" class="del" onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a></p>
                                      <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                      <%--套餐单项品--%>
                                      <c:forEach items="${cartItemProxy.combos}" var="combo">
                                        <p>
                                          <a href="${webRoot}/product-${cartItemProxy.productId}.html"><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/></a>
                                          <a href="${webRoot}/product-${cartItemProxy.productId}.html">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span>
                                        </p>
                                      </c:forEach>
                                      <%--赠品--%>
                                      <c:forEach items="${cartItemProxy.presents}" var="present">
                                        <p><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></p>
                                      </c:forEach>

                                      <div class="amount">
                                        <c:choose>
                                          <c:when test="${cartItemProxy.quantity>1}">
                                            <a class="amount-opera ssubNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">−</a>
                                          </c:when>
                                          <c:otherwise>
                                            <a class="amount-opera storeBtnLock" href="javascript:">−</a>
                                          </c:otherwise>
                                        </c:choose>
                                        <input class="amount-inp scartNum" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">
                                        <c:choose>
                                          <c:when test="${cartItemProxy.btnIsCanAdd}">
                                            <a class="amount-opera saddNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">+</a>
                                          </c:when>
                                          <c:otherwise>
                                            <a class="amount-opera storeBtnLock" href="javascript:">+</a>
                                          </c:otherwise>
                                        </c:choose>
                                      </div>
                                      <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                      <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.cartItemMsg}</p>
                                    </div>
                                  </li>
                                </c:when>
                                <%--单品--%>
                                <c:otherwise>
                                  <li class="media">
                                    <span class="checkbox sitem${orgId} supdateSelect <c:if test="${isSelected}">active</c:if>" autocomplete="off" itemKey="${itemKey}"  carttype="${carttype}" orgid="${orgId}">
                                        <i class="icon"></i>
                                    </span>
                                    <a class="media-left" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                      <c:choose>
                                        <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                          <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                        </c:when>
                                        <c:otherwise>
                                          <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                        </c:otherwise>
                                      </c:choose>
                                    </a>
                                    <div class="media-body">
                                      <p class="media-heading"> <a href="${webRoot}/product-${cartItemProxy.productId}.html" class="title">${cartItemProxy.name}</a><a href="javascript:void(0);" class="del" onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a></p>
                                      <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                        <%--赠品--%>
                                      <c:forEach items="${cartItemProxy.presents}" var="present">
                                        <p><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></p>
                                      </c:forEach>

                                      <div class="amount">
                                        <c:choose>
                                          <c:when test="${cartItemProxy.quantity>1}">
                                            <a class="amount-opera ssubNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">−</a>
                                          </c:when>
                                          <c:otherwise>
                                            <a class="amount-opera storeBtnLock" href="javascript:" >−</a>
                                          </c:otherwise>
                                        </c:choose>
                                        <input class="amount-inp scartNum" id="" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">
                                        <c:choose>
                                          <c:when test="${cartItemProxy.btnIsCanAdd}">
                                            <a class="amount-opera saddNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">+</a>
                                          </c:when>
                                          <c:otherwise>
                                            <a class="amount-opera storeBtnLock" href="javascript:">+</a>
                                          </c:otherwise>
                                        </c:choose>
                                      </div>
                                      <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                      <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.cartItemMsg}</p>
                                    </div>
                                  </li>
                                </c:otherwise>
                              </c:choose>
                            </c:otherwise>
                          </c:choose>
                        </c:otherwise>
                      </c:choose>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </ul>

              <div class="checkout">
                <span><small>&yen;</small>${storeCartProxy.realProductTotalAmount}</span>
                <c:choose>
                  <c:when test="${storeCartProxy.selectedCartItemNum>0}">
                    <a href="javascript:" class="addStoreCartResult" orgid="${orgId}" carttype="${carttype}">去结算</a>
                  </c:when>
                  <c:otherwise>
                    <a href="javascript:" style="background-color: #ccc;" aria-disabled="true">去结算</a>
                  </c:otherwise>
                </c:choose>
              </div>
            </dd>
          </dl>
        </div>
      </div>
    </div>
    <script>
      $(function() {
        var $cartToggle = $('.storeCartToggle'),
        $cartTarget = $('.storeCartTarget');
        $cartToggle.toggle(function () {
          if($("#storeCartLayer").css("right")=='290px'){
            $cartTarget.slideUp(400,function () {
              $cartToggle.animate({
                right: 50
              },300);
            });
          }else{
            $(this).animate({
              right: 290
            },300,function () {
              $cartTarget.slideDown(400);
            });
          }
        },function () {
          if($("#storeCartLayer").css("right")=='290px'){
            $cartTarget.slideUp(400,function () {
              $cartToggle.animate({
                right: 50
              },300);
            });
          }else{
            $(this).animate({
              right: 290
            },300,function () {
              $cartTarget.slideDown(400);
            });
          }
        });
      });
    </script>
  </c:if>
</c:if>
