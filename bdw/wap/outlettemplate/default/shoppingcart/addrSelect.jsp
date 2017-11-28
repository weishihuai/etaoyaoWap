<html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<head lang="en">
    <meta charset="utf-8">
    <title>选择收货地址</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/ch-address.css" type="text/css" rel="stylesheet" />
</head>
<body>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${loginUser.receiverAddress}" var="addrs"/>
<c:set value="${param.cartType}" var="cartType"/>
<c:set value="${param.handler}" var="handler"/>
<c:set value="${param.isCod}" var="isCod"/>
<c:set var="cartList" value="${sdk:getUserCartListProxy(cartType)}" />
<c:set value="${cartList.receiveAddrId}" var="receiveAddrId"/>
<div class="m-top">
    <c:choose>
        <c:when test="${not empty cartType && cartType eq 'store_drug'}">
            <a class="back" href="${webRoot}/wap/outlettemplate/default/shoppingcart/drugOrderAdd.ac"></a>
        </c:when>
        <c:otherwise>
            <a class="back" href="${webRoot}/wap/outlettemplate/default/shoppingcart/orderAdd.ac"></a>
        </c:otherwise>
    </c:choose>

    <div class="toggle-box">选择收货地址</div>
    <a href="${webRoot}/wap/module/member/addrManage.ac" class="rt-btn">管理</a>
</div>

<div class="ch-main">
    <c:forEach items="${addrs}" var="addr">
        <c:if test="${sdk:checkInDeliveryScope(addr.lat, addr.lng, cartList)}">
            <div data-receive-addr-id="${addr.receiveAddrId}" class="default-item">
                <a href="javascript:;" class="select <c:if test="${receiveAddrId eq addr.receiveAddrId}"> selected</c:if>"></a>
                <span>${addr.name}</span>
                <span>${addr.mobile}</span>
                <c:if test="${addr.isDefault eq 'Y'}">
                    <i class="mr">默认</i>
                </c:if>
                <p>${fn:replace(addr.addressPath, '-中国-', '')}${addr.addr}</p>
            </div>
        </c:if>
    </c:forEach>
        <div class="exceed">
            <h5>以下地址超出配送范围</h5>
            <c:forEach items="${addrs}" var="addr">
                <c:if test="${not sdk:checkInDeliveryScope(addr.lat, addr.lng, cartList)}">
                    <div class="ex-item">
                        <span>${addr.name}</span>
                        <span>${addr.mobile}</span>
                        <p>${fn:replace(addr.addressPath, '-中国-', '')}${addr.addr}</p>
                    </div>
                </c:if>
            </c:forEach>
        </div>
</div>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript">
    $(function () {
          $(".default-item").click(function () {
              var receiveAddrId = $(this).attr("data-receive-addr-id");
              $.ajax({
                  url:"${webRoot}/cart/updateReceiver.json",
                  data:({type: '${cartType}', receiveAddrId: receiveAddrId,isCod:false}),
                  success:function(data){
                      if(data.success == "true"){
                          setTimeout(function () {
                              if ("store_drug" == "${cartType}"){
                                  window.location.href = "${webRoot}/wap/outlettemplate/default/shoppingcart/drugOrderAdd.ac?time=" + new Date().getTime();
                              }else {
                                  window.location.href = "${webRoot}/wap/outlettemplate/default/shoppingcart/orderAdd.ac?carttype=${cartType}&handler=${handler}&isCod=${isCod}" + "&time=" + new Date().getTime();
                              }
                          }, 100);
                      }
                  },
                  error:function(XMLHttpRequest, textStatus) {
                      if (XMLHttpRequest.status == 500) {
                          var result = eval("(" + XMLHttpRequest.responseText + ")");
                          alert(result.errorObject.errorText);
                      }
                  }
              });
          });
    })
</script>
</body>
</html>
