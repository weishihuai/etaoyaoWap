<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${empty param.isCod ? false : param.isCod}" var="isCod" />
<%--<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />--%>
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="shoppingCartProxy"/>
<%--根据积分商品Id取出积分商品--%>
<c:set value="${param.integralProductId}" var="integralProductId"/>
<!--获取瑞环的数量-->
<c:set var="num" value="${param.num}"/>
<!--获取兑换类型-->
<c:set var="integralExchangeType" value="${param.integralExchangeType}"/>
<%--验证是否参数传入--%>
<c:if test="${empty param.integralProductId || empty param.num || empty param.integralExchangeType}">
    <c:redirect url="/integralList.ac"></c:redirect>
</c:if>

<!doctype html>
<html>
<head>
    <title>收货地址</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">

    <script type="text/javascript">
        var orderData = {isCod:${isCod}};
        var webPath = {
            webRoot:"${webRoot}",handler:"${handler}",carttype:"${carttype}",pageUrl:"${webRoot}/wap/shoppingcart/orderadd.ac?"
        };
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/orderadd.js"></script>

</head>
<body>

<header class="row header">
    <div class="col-xs-2"><a href="${webRoot}/wap/shoppingcart/integralOrderadd.ac?integralProductId=${integralProductId}&num=${num}&integralExchangeType=${integralExchangeType}"> <span style="position: relative;left: 10px" class="aa glyphicon glyphicon-arrow-left"></span></a></div>
    <div class="col-xs-8">选择收货地址</div>
</header>


<c:forEach items="${shoppingCartProxy.receiverAddrVoByUserId}" var="address">
    <c:if test="${address.isDefault == 'Y'}">
        <c:set value="${address}" var="selectedAddress"/>
    </c:if>
    <c:set value="${address.isDefault == 'Y'}" var="isThisSelect"/>
        <div class="row addrRow" receiveAddrId="${address.receiveAddrId}" zoneId="${address.zoneId}" addressPath="${address.addressPath}" addrname="${address.name}" addrmobile="${address.mobile}" addrzip="${address.zipcode}" address="${address.addr}" addrtel="${address.tel}">
            <div class="col-xs-12 adr_rows" style="cursor: pointer;border-bottom: 1px solid #DCDDDD;border-top: none;">
                <div class="row">
                    <div class="col-xs-12 adr_name">${address.name} ${address.mobile}</div>
                </div>
                <div class="row">
                    <div class="col-xs-11 adr_text">${address.addressPath}</div>
                    <div class="col-xs-1"><span class="glyphicon  <c:if test="${isThisSelect}">glyphicon-ok</c:if>  glyphicon-ok5 slectItem"></span></div>
                </div>
                <div class="row">
                    <div class="col-xs-12 adr_text">${address.addr}</div>
                </div>
            </div>
        </div>
</c:forEach>


<div class="row" style=" margin-top: 8px;">
    <div class="col-xs-10 col-xs-offset-1" >
        <button onclick="window.location.href='${webRoot}/wap/module/member/addressOperate.ac?fromPath=integralAddrSelect&integralProductId=${integralProductId}&num=${num}&integralExchangeType=${integralExchangeType}'"
                class="btn btn-default btn-default_adr btn-block" style="border: 1px solid #CC3333;background: none repeat scroll 0 0 #CC3333; color: #fff; font-weight: bold;" type="button">
            添加收货地址
        </button>
    </div>
</div>

<div class="row" style=" margin-top: 8px;margin-bottom: 70px;">
    <div class="col-xs-10 col-xs-offset-1" >
        <button onclick="window.location.href='${webRoot}/wap/module/member/addressOperate.ac?fromPath=integralAddrSelect&method=edit&receiveAddrId=${selectedAddress.receiveAddrId}&integralProductId=${integralProductId}&num=${num}&integralExchangeType=${integralExchangeType}'"
                class="btn btn-default btn-default_adr btn-block" style="border: 1px solid #CC3333;background: none repeat scroll 0 0 #CC3333; color: #fff; font-weight: bold;" type="button">
            修改收货地址
        </button>
    </div>
</div>

<form id="userAddrForm" method="get">
    <input type="hidden" name="type" value="${carttype}"/>
    <input name="receiverName" id="receiverName" type="hidden"  value="" />
    <input name="receiverAddr"  id="receiverAddr" value="" type="hidden" />
    <input id="receiverMobile" name="receiverMobile" type="hidden" value="" />
    <input id="receiverZipcode" value="" name="receiverZipcode" type="hidden" />
    <input id="receiverTel" name="receiverTel" value=""  type="hidden" />
    <input name="receiverZoneId" id="zoneId"  type="hidden"  value="" />
</form>

<%--menu开始--%>
<c:import url="/template/bdw/oldWap/module/common/menu.jsp"/>
<%--menu结束--%>
</body>
</html>