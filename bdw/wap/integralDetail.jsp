<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<!DOCTYPE html>

<%--根据积分商品Id取出积分商品--%>
<c:set value="${sdk:getIntegralProduct(param.integralProductId)}" var="integralProduct"/>
<%--登陆--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--收货地址列表--%>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="isCod" value="${empty param.isCod ? 'N' : param.isCod}"/>
<c:set var="cartList" value="${sdk:getUserCartListProxy('normal')}" />
<c:set var="receiverAddr" value="${cartList.receiverAddrVo}" />
<%--<!--获取兑换类型-->--%>
<c:set var="integralExchangeType" value="${integralProduct.paymentConvertTypeCode}"/>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>积分详情</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
	<script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"  type="text/javascript"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
	<link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet"  />
	<link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
	<link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
	<link href="${webRoot}/template/bdw/wap/statics/css/integral-detail.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/integralDetail.js"></script>
	<script type="text/javascript">
        var webPath = {
            webRoot: '${webRoot}',
            handler: '${handler}',
            isCod: '${isCod}',
            isSelectAddress: ${not empty receiverAddr},
        	integralProductId: ${integralProduct.integralProductId},
            paymentConvertTypeCode: ${integralProduct.paymentConvertTypeCode}
        }
	</script>
</head>
<body>
	<div class="m-top">
        <a class="back" href="${webRoot}/wap/integralList.ac"></a>
        <span>积分详情</span>
    </div>

	<div class="integral-detail-main">
		<div class="sp-info">
			<a class="pic" href="#"><img src="${integralProduct.icon['320X320']}" alt=""></a>
			<p class="integral-number"><span><fmt:formatNumber value="${integralProduct.integral}" type="number" pattern="######.##" /></span>积分</p>
			<div class="add-subtract">
	            <a class="add" href="javascript:;"  >-</a>
	            <input type="text" id="prd_num" name="prd_num" value="1" class="prd_num">
	            <a class="subtract" href="javascript:;"  >+</a>
	        </div>
	        <p class="name">${integralProduct.integralProductNm}</p>
	    </div>
        <div class="site-box"  id="receiveAddrId" receiveAddrId="${receiverAddr.receiveAddrId}">
			<p class="name-phone"><span class="name">${receiverAddr.name}</span><span class="phone">${receiverAddr.mobile}</span></p>
			<p class="site">${receiverAddr.addressPath}${receiverAddr.addr}</p>
        </div>
        <div class="detail-info">
			<div class="dt">详细信息</div>
			<div class="dd">
				${integralProduct.desc}
			</div>
        </div>
		<c:choose>
			<%--已经删除或积分兑换类型非全积分--%>
			<c:when test="${empty integralProduct || integralProduct.isDelete eq 'Y' ||integralExchangeType != '0'}">
				<a class="integral-detail-btn no-click" href="javascript:;">对不起，不支持兑换该商品</a>
			</c:when>
			<c:otherwise>
				<c:if test="${integralProduct.integral * 1 > loginUser.integral * 1}">
					<a  class="integral-detail-btn no-click"    >积分不足</a>
				</c:if>
				<c:if test="${integralProduct.integral * 1 <= loginUser.integral * 1}">
					<a  class="integral-detail-btn " id="integralSubmit"  productIntegral="${integralProduct.integral}"  userIntegral="${loginUser.integral} "num="${integralProduct.num}" integralProductId="${integralProduct.integralProductId}" integralProductNum="${integralProduct.num}" objectid="${integralProduct.integralProductId}" productInventory="${integralProduct.num}" userIntegral="${loginUser.integral}" carttype="integral" isLogin="${empty loginUser ? true :false}" price="${integralProduct.integral}" exchangeIntegral="${integralProduct.exchangeIntegral}"  handler="integral" href="javascript:" type="${integralProduct.type}">立即兑换</a>
				</c:if>
			</c:otherwise>
		</c:choose>

	</div>
</body>
</html>
