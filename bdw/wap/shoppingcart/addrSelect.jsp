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
    <link href="${webRoot}/template/bdw/wap/statics/css/ch-address.css" type="text/css" rel="stylesheet" />
</head>
<body>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${loginUser.receiverAddress}" var="addrs"/>
<c:set value="${param.cartType}" var="cartType"/>
<c:set value="${param.handler}" var="handler"/>
<c:set value="${param.isCod}" var="isCod"/>
<c:set value="${param.isIntegral}" var="isIntegral"/>
<c:set value="${param.integralProductId}" var="integralProductId"/>
<c:set var="cartList" value="${sdk:getUserCartListProxy(cartType)}" />
<c:set var="receiverAddr" value="${cartList.receiverAddrVo}" />
<div class="m-top">
    <c:choose>

        <c:when test="${not empty isIntegral && 'Y' == isIntegral}">
            <a class="back" href="${webRoot}/wap/integralDetail.ac?cartType=${cartType}&integralProductId=${integralProductId}&handler=${handler}"></a>
        </c:when>
        <c:when test="${cartType eq 'normal' or cartType eq 'groupBuy'}">
            <a class="back" href="${webRoot}/wap/shoppingcart/orderAdd.ac?carttype=${cartType}&handler=${handler}"></a>
        </c:when>
        <c:when test="${cartType eq 'drug'}">
            <a class="back" href="${webRoot}/wap/shoppingcart/drugOrderAdd.ac?carttype=${cartType}&handler=${handler}"></a>
        </c:when>
    </c:choose>
   <div class="toggle-box">选择收货地址</div>
    <a href="${webRoot}/wap/module/member/addrManage.ac" class="rt-btn">管理</a>
</div>

<div class="ch-main">
    <c:choose>
        <c:when test="${not empty addrs}">
            <c:forEach items="${addrs}" var="addr">
                <div data-receive-addr-id="${addr.receiveAddrId}" class="default-item">
                    <a href="javascript:;" <c:if test="${receiverAddr.receiveAddrId eq addr.receiveAddrId}">
                        class="select selected"</c:if> class="select"></a>
                    <span>${addr.name}</span>
                    <span>${addr.mobile}</span>
                    <c:if test="${addr.isDefault eq 'Y'}">
                        <i class="mr">默认</i>
                    </c:if>
                    <p>${addr.addressPath}&nbsp;${addr.addr}</p>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="none-box">
                <img class="none-icon" src="${webRoot}/template/bdw/wap/module/member/statics/images/kongdizhi.png" alt="">
                <p>暂无收货地址</p>
            </div>
        </c:otherwise>
    </c:choose>

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
                              if (${not empty isIntegral && "Y" == isIntegral}){
                                  window.location.href = "${webRoot}/wap/integralDetail.ac?integralProductId=${integralProductId}&time=" + new Date().getTime();
                              }else if ("normal" == "${cartType}" || "groupBuy" == "${cartType}"){
                                  window.location.href = "${webRoot}/wap/shoppingcart/orderAdd.ac?carttype=${cartType}&handler=${handler}&isCod=${isCod}" + "&time=" + new Date().getTime();
                              }else if ("drug" == "${cartType}"){
                                  window.location.href = "${webRoot}/wap/shoppingcart/drugOrderAdd.ac?time=" + new Date().getTime();
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
