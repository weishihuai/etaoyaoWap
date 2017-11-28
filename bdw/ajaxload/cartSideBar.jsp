
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.BdwShoppingCart" %>
<%@ page import="com.iloosen.imall.commons.helper.ServiceManagerSafemall" %>
<%@ page import="com.iloosen.imall.client.constant.bdw.IBdwShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="java.util.List" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="user"/>

<%
  //2015-11-30 lhw 因购物车只有在登录的时候才填充，为了避免不同浏览器购物车不同步的情况，当刷新页面时需要重新加载购物车
  Integer loginUserId = WebContextFactory.getWebContext().getFrontEndUserId();
  if(loginUserId != null){
    List<BdwShoppingCart> bdwShoppingCartList = ServiceManagerSafemall.bdwShoppingCartService.findByKey(IBdwShoppingCart.USER_ID, loginUserId);

    UserCartList normalCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.NORMAL, loginUserId);
    UserCartList drugCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.DRUG, loginUserId);
    ServiceManager.shoppingCartStoreService.removeUserCartList(normalCartList);
    ServiceManager.shoppingCartStoreService.removeUserCartList(drugCartList);

    if(!bdwShoppingCartList.isEmpty()){
      ServiceManagerSafemall.bdwShoppingCartService.addCart(CartTypeEnum.NORMAL.toCode());
      ServiceManagerSafemall.bdwShoppingCartService.addCart(CartTypeEnum.DRUG.toCode());
    }
  }
%>

<c:if test="${not empty user}">
  <c:set value="${sdk:getUserCartListProxy('normal')}" var="userCartListProxy"/>
  <c:set value="${userCartListProxy.allDiscount}" var="allDiscount" />
  <c:set value="${userCartListProxy.allDeliveryDiscount}" var="allDeliveryDiscount" />

  <c:if test="${not empty user}">
    <c:set value="${sdk:getUserCartListProxy('drug')}" var="userCartListProxyDrug"/>
    <c:set value="${userCartListProxyDrug.allDiscount}" var="allDiscountDrug" />
    <c:set value="${userCartListProxyDrug.allDeliveryDiscount}" var="allDeliveryDiscountDrug" />
  </c:if>

</c:if>

  <div class="dd" style="display: block" id="scrollTopDiv" onscroll="setSidebarH(this)">
    <div class="title" >购物车<em id="titleOnclick"></em></div>
    <div class="cart-reservation">
      <p class="active" id="normalCartP">购物车<span id="normalCartTotalNumSidebar"> </span></p>
      <p>预定清单<span id="drugCartTotalNumSidebar"></span></p>
      <em class="icon-b"></em>
    </div>


    <div id="normalSidebar" style="height: 100%;width: 100%" ></div>


    <div id="drugSidebar"  style="height: 100%;width: 100%"></div>



  </div>
  <div class="icon-lx icon-lx2" style="display: block"></div>



<c:set value="${sdk:getUserCartListProxy('normal')}" var="normalProxy"/>
<c:set value="${sdk:getUserCartListProxy('drug')}" var="drugProxy"/>
<script>
  var normalCartTotalNumSidebar = "${normalProxy.allCartNum}";
  var drugCartTotalNumSidebar = "${drugProxy.allCartNum}";
  $("#normalCartTotalNumSidebar").html(normalCartTotalNumSidebar == 0?'':normalCartTotalNumSidebar);
  $("#drugCartTotalNumSidebar").html(drugCartTotalNumSidebar == 0?'':drugCartTotalNumSidebar);
  $("#CartTotalNumSidebar").html(parseInt(normalCartTotalNumSidebar)+parseInt(drugCartTotalNumSidebar)== 0? 0:parseInt(normalCartTotalNumSidebar)+parseInt(drugCartTotalNumSidebar));
</script>
