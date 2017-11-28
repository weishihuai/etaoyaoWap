<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--还未登录跳转跳转--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/integral/integral.ac"></c:redirect>
</c:if>

<%--根据积分商品Id取出积分商品--%>
<c:set value="${sdk:getIntegralProduct(param.integralProductId)}" var="integralProduct"/>
<!--获取瑞环的数量-->
<c:set var="num" value="${param.num}"/>
<!--获取兑换类型-->
<c:set var="integralExchangeType" value="${param.integralExchangeType}"/>
<%--验证是否参数传入--%>
<c:if test="${empty param.integralProductId || empty param.num || empty param.integralExchangeType}">
   <c:redirect url="/integral/integral.ac"></c:redirect>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title> 填写订单信息-${webName}</title>

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/integralOrderadd.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidator-4.1.1.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidatorRegex.js"></script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        function isDigit(s)
        {
            var patrn=/^[0-9]{1,20}$/;
            return patrn.test(s);
        }

    </script>

    <style type="text/css">
        /*自提点样式*/
        .pickedUpListDiv { border-bottom: 1px solid #e5e5e5; background-color: #fff;padding: 5px 0; }
/*        .pickedUpSubDiv { padding-left: 15px; width: 955px;line-height: 25px;color: #333;overflow: hidden; }
        .pickedUpSubRadio { float: left;margin-top: 6px;}
        .pickedUpSubSpan { float: left; padding-right: 70px; }*/
    </style>
    <!--购物劵使用 start-->
    <link href="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${webRoot}/template/bdw/statics/js/jquery-ui-multiselect/jquery.multiselect.css" media="all"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/template/bdw/statics/js/jquery-ui-multiselect/jquery.multiselect.filter.css" media="all"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-multiselect/src/jquery.multiselect.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-multiselect/i18n/jquery.multiselect.zh-cn.js"></script>
    <!--购物劵使用 end-->
</head>

<%--根据积分商品分类Id 取出同类积分商品--%>
<c:set value="${sdk:findIntegralProductsByCategoryId(integralProduct.integralProductCategoryId,4)}" var="similarGoods"/>




<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
${sdk:saveOrderParam(carttype)}
<%--检查购物车配送 优先放在取出购物车之前--%>
${sdk:checkCartDelivery(carttype)}
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr"/>
<c:set value="${isCodStr=='N' ? false :true}" var="isCod"/>
<script type="text/javascript">
    var orderData = {isCod:${isCod}, productTotal:${userCartListProxy.selectCartNum}};
    var invalidCartItems = [];
    <c:forEach items="${userCartListProxy.unSupportDeliveryItemKeys}" var="invalidItemKey" varStatus="s">
    invalidCartItems[${s.index}] = "${invalidItemKey}";
    </c:forEach>
</script>

<script type="text/javascript">
    $(document).ready(function () {
        $(".couponIds").multiselect();
    });
</script>

<body style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>

<div id="orderAdd" style="margin-top:20px;">
    <div class="address">
        <div class="layer">
            <p><a style="text-decoration: none;">确认收货信息</a></p>

            <h3><a target="_blank" href="${webRoot}/module/member/myAddressBook.ac?pitchOnRow=2"><span>管理收货地址</span></a></h3>
        </div>
        <c:forEach items="${userCartListProxy.receiverAddrVoByUserId}" var="receiver" varStatus="status">
            <ul class="selectAddress <c:if test="${receiver.isDefault == 'Y'}">cur </c:if>" id="<c:if test="${receiver.isDefault == 'Y'}">receiveAddrId</c:if>" receiveAddrId="${receiver.receiveAddrId}">
                <li><c:if test="${receiver.isDefault == 'Y'}"><a style="text-decoration: none;">默认地址</a></c:if></li>
                <p>${receiver.addressPath}( ${receiver.name} 收 )</p>

                <h2>${receiver.addr}<span>联系方式：${receiver.mobile}/${receiver.tel}</span></h2>
            </ul>
        </c:forEach>
        <div class="clear"></div>
        <div class="btn">
            <p><a href="javascript:" id="addAddress" isLogin="${empty loginUser ? true :false}">使用新地址</a></p>
        </div>
        <div class="clear"></div>
    </div>

    <form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
        <input name="orderSourceCode" value="0" type="hidden"/>
        <input name="processStatCode" value="0" type="hidden"/>
        <input name="type" id="type" value="${carttype}" type="hidden"/>
        <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="N" type="hidden"/>
        <input id="invoiceTitle" name="invoice.invoiceTitle" class="invoiceTitle" type="hidden"/>
        <input name="isCod" value="${empty param.isCod ?  'N' : param.isCod}" type="hidden"/>

        <%--自提点--%>
        <input name="pickUpId" id="pickUpId" value="" type="hidden"/>
    </form>
    <%--自提中心列表 start--%>
    <div class="layer pickedUpDiv" style="width: 978px;display:none;">
        <span style="display: block; font-size: 14px; line-height: 35px; font-weight: bold; padding-left: 10px; color: #333;">自提点</span>

        <div style="width: 978px; border: 1px solid #e5e5e5;">
            <div class="l_addr pickedUpListDiv">
                <%--这里是通过JS拼装出来的--%>
            </div>
            <div class="l_tips" style="background-color: #fff8d9; width: 978px; color: #333; overflow: hidden; padding: 10px 0;">
                <span style="float: left; line-height: 25px; padding: 0 10px;">注:</span>

                <p style="width: 920px; line-height: 25px; float: left;">
                    <c:set value="${sdk:getSysParamValue('pickedup_info')}" var="pickedup_info"/>
                    ${pickedup_info}
                </p>
            </div>
        </div>

    </div>
    <div class="order">
        <div class="nav">
            <div class="shop" style="width:280px"><span>积分商品</span></div>
            <div class="num"><span>数量</span></div>
            <c:choose>
                <c:when test="${integralExchangeType eq 0}">
                    <div class="price"><span>固定积分</span></div>
                    <div class="price"><span>总积分</span></div>
                </c:when>
                <c:otherwise>
                    <div class="price"><span>部分积分</span></div>
                    <div class="price"><span>部分金额</span></div>
                    <div class="price"><span>总积分</span></div>
                    <div class="price"><span>总金额</span></div>
                </c:otherwise>
            </c:choose>
            <div class="operation"><span>兑换方式</span></div>
        </div>
        <div class="box">
            <div class="info">
                <div class="left" style="width:980px;">
                    <ul style="width:282px">
                        <h2><a href="${webRoot}/product-${integralProduct.integralProductId}.html"><img src="${integralProduct.icon["50X50"]}"/></a></h2>
                        <li style="width:215px">
                            <h3><a href="${webRoot}/product-${integralProduct.integralProductId}.html">${integralProduct.integralProductNm}</a></h3>
                        </li>
                    </ul>
                    <div class="num"><a style="text-decoration: none;">${num}</a></div>
                    <c:choose> <c:when test="${integralExchangeType eq 0}">
                        <div class="price"><a style="text-decoration: none;"><fmt:formatNumber value="${integralProduct.integral}" type="number" pattern="#.##"/></a></div>
                        <div class="price"><a style="text-decoration: none;"><fmt:formatNumber value="${integralProduct.integral * num}" type="number" pattern="#.##"/></a></div>
                    </c:when>
                        <c:otherwise>
                        <div class="price"><a style="text-decoration: none;"><fmt:formatNumber value="${integralProduct.exchangeIntegral}" type="number" pattern="#.##"/></a></div>
                        <div class="price"><a style="text-decoration: none;"><fmt:formatNumber value="${integralProduct.exchangeAmount}" type="number" pattern="#.##"/></a></div>
                            <div class="price"><a style="text-decoration: none;"><fmt:formatNumber value="${integralProduct.exchangeIntegral * num}" type="number" pattern="#.##"/></a></div>
                            <div class="price"><a style="text-decoration: none;"><fmt:formatNumber value="${integralProduct.exchangeAmount * num}" type="number" pattern="#.##"/></a></div>
                        <%--<div class="subtotal"><a style="text-decoration: none;"><fmt:formatNumber value="${integralProduct.integral*num}" type="number" pattern="#.##" /></a></div>--%>
                    </c:otherwise>
                    </c:choose>
                    <div class="subtotal" id="integralExchangeType" integralExchangeType="${integralExchangeType}" style="width:150px;"><a style="text-decoration: none;">
                        <c:choose>
                            <c:when test="${integralExchangeType eq '0'}"> 固定积分 </c:when>
                            <c:when test="${integralExchangeType eq '1'}"> 积分+现金 </c:when>
                        </c:choose>
                    </a></div>
                </div>
            </div>
        </div>
        <div class="submit" style="height:80px;;">
            <div class="return"><a href="${webRoot}/integral/integralDetail.ac?integralProductId=${integralProduct.integralProductId}"><img src="${webRoot}/template/bdw/statics/images/102.PNG"
                                                                                                                                            style="vertical-align:middle"/>返回积分商品</a></div>
            <ul>
                <div class="btn" style="margin-top:2px;">
                    <a class="submitOrder" style="text-decoration: none;" href="javascript:" integralProductId="${integralProduct.integralProductId}" num="${num}"
                       integralPrice="${integralProduct.integral}" exchangeIntegral="${integralProduct.exchangeIntegral}" exchangeAmount="${integralProduct.exchangeAmount}" >提交订单</a></div>
            </ul>
            <div class="clear"></div>
        </div>

    </div>
    <%--页头开始--%>
    <c:import url="/template/bdw/module/common/bottom.jsp"/>
    <%--页头结束--%>


    <div id="myAddress">
        <form id="userAddrForm" method="get">
            <div class="box">
                <div class="new-ad">
                    <h2><a href="javascript:" class="closeMyAddress"><img src="${webRoot}/template/bdw/statics/images/btn_box_close.JPG"></a></h2>

                    <p>使用新地址</p>
                    <ul class="province selT">
                        <li><span>*</span><em>市：</em>
                            <select class="addressSelect" id="province" name="">
                                <option>请选择</option>
                            </select>
                        </li>
                        <li>区：
                            <select class="addressSelect" id="city" name="">
                                <option>请选择</option>
                            </select>
                        </li>
                        <li>街道：
                            <select class="addressSelect" id="zone" name="receiverZoneId">
                                <option>请选择</option>
                            </select>
                        </li>
                        <div id="zoneTip" style="float: left"></div>
                    </ul>
                    <ol class="zip">
                        <li><a style="text-decoration: none;">邮政编码：</a><input type="text" class="put" id="receiverZipcode" name="receiverZipcode" maxlength="6" onblur="removeTheSign(this,'receiverZipcodeTip')">

                            <div id="receiverZipcodeTip" style="float: left"></div>
                        </li>
                    </ol>
                    <div class="clear"></div>
                    <div class="address">
                        <div style="float: left;">
                            <span>*</span>街道地址：<input type="text" id="receiverAddr" name="receiverAddr" maxlength="255">
                        </div>
                        <div id="receiverAddrTip" style="float: left"></div>
                    </div>
                    <ol class="info">
                        <li style="display: inline-block;"><a style="text-decoration: none;"><span>*</span>收货人姓名：</a><input type="text" id="receiverName" name="receiverName">

                            <div id="receiverNameTip" style="float: left"></div>
                        </li>
                        <li><a style="text-decoration: none;"><span>*</span>手机：</a><input type="text" id="receiverMobile" name="receiverMobile">

                            <div id="receiverMobileTip" style="float: left"></div>
                        </li>
                        <li><a style="text-decoration: none;">电话：</a><input type="text" class="code" id="receiverTel" name="receiverTel" onblur="removeTheSign(this,'receiverTelTip')">

                            <div id="receiverTelTip" style="float: left"></div>
                        </li>
                        <div class="btn1"><a style="text-decoration: none;" id="saveAddress" href="javascript:">确定</a></div>
                        <div class="btn2 closeMyAddress"><a style="text-decoration: none;" href="javascript:">取消</a></div>
                    </ol>
                </div>
            </div>
        </form>
    </div>
    <div id="zoomloader">
        <div align="center"><span><img src="${webRoot}/template/bdw/statics/images/zoomloader.gif"/></span><span style="font-size: 18px">正在提交...</span></div>
    </div>
</body>
</html>
