<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:if test="${empty userProxy}">
    <c:redirect url="/login.ac"></c:redirect>
</c:if>

<c:set value="${param.otooQuantity}" var="otooQuantity"/>
<c:set value="${param.otooProductId}" var="otooProductId"/>
<c:set value="${bdw:getOtooProductById(otooProductId)}" var="otooProductProxy"/>
<c:set value="${sdk:getSysParamValue('cancelOtooOrder')}" var="cancelOtooOrderTime"/>

<%--
<c:if test="${empty otooProductProxy}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>填写订单信息-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/otoo/statics/css/base.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/otoo/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/otoo/statics/css/otooorderadd.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}",userMobile:"${userProxy.mobile}"};
        var Top_Path = {webUrl: "${webUrl}", webRoot: "${webRoot}", topParam: "${param.p}", keyword: "${param.keyword}", webName: "${webName}"};
        var orderData = {otooQuantity: "${otooQuantity}", otooProductId: "${otooProductId}", otooProductProxy: "${otooProductProxy}"};
    </script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/top.js"></script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/otooorderadd.js"></script>
</head>
<body>
<c:import url="/template/bdw/otoo/common/orderTop.jsp"/>

<div class="main">
    <div class="info">
        <table>
            <thead>
            <tr>
                <th class="th01">商品</th>
                <th class="th02">单价</th>
                <th class="th03">数量</th>
                <th class="th04">小计</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="td01">
                    <strong>
                        ${otooProductProxy.otooProductNm}
                        <c:if test="${not empty otooProductProxy.otooSellingPoint}">
                            <em>【</em><span style="color: #666">${otooProductProxy.otooSellingPoint}</span>】
                        </c:if>
                    </strong>
                </td>
                <td class="td02">${otooProductProxy.otooDiscountPrice}</td>
                <td class="td03">
                    <a href="javascript:void(0);" class="jian prd_subNum">-</a>
                    <input type="text" value="${empty otooQuantity?'1':otooQuantity}" class="prd_num">
                    <a href="javascript:void(0);" class="jia prd_addNum">+</a>
                </td>
                <td class="td04">&yen;---</td>
            </tr>
            </tbody>
        </table>
        <div class="tip">
            <div class="fl">温馨提示：请在下单后${cancelOtooOrderTime}小时内完成订单支付，逾期未支付将自动取消订单</div>
            <div class="fr">
                应付金额：<em class="otooProductTotalAmount"><i>&yen;</i>---</em>
            </div>
        </div>
        <!--tip end-->
    </div>
    <!--info end-->
    <div class="btns">
        <a class="btn02 fr submitOrder addOrder" href="javascript:" num="${otooQuantity}">确认订单</a>
        <a class="btn01 fr" href="${webRoot}/otoo/product.ac?id=${otooProductProxy.otooProductId}" title="">返回上一步</a>
    </div>

    <form id="orderForm" action="${webRoot}/otoo/orderFlow/addOrder.ac" method="get">
        <input class="otooQuantityInput" name="otooQuantity" value="${otooQuantity}" type="hidden"/>
        <input name="otooProductId" value="${otooProductId}" type="hidden"/>
        <input name="sysUserId" value="${userProxy.userId}" type="hidden"/>
    </form>
</div>
<!--main end-->

<div id="zoomloader">
    <div align="center"><span><img src="${webRoot}/template/bdw/statics/images/zoomloader.gif"/></span><span style="font-size: 18px">正在加载...</span></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>

</html>
