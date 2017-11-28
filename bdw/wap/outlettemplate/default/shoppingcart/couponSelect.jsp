<html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<head lang="en">
    <meta charset="utf-8">
    <title>使用优惠券</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/coupons.css" type="text/css" rel="stylesheet" />
</head>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
    <c:redirect url="/wap/login.ac" />
</c:if>
<c:set value="${param.cartType}" var="cartType" />
<c:set value="${param.sysOrgId}" var="sysOrgId" />
<c:set value="${sdk:findUserCouponList(cartType, sysOrgId)}" var="userCouponList"/> <%--可以使用的购物劵--%>
<c:set value="${sdk:getCurrSelectCoupons(cartType, sysOrgId)}" var="useCoupons"/>     <%--已经选择的购物劵--%>
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1);"></a>
    <div class="toggle-box">使用优惠券</div>
</div>

<div class="coupons-main">
    <c:forEach items="${useCoupons}" var="coupon">
        <div class="item">
            <div class="item-l">
                <p class="price"><span>¥</span>${coupon.amount}</p>
                <c:forEach items="${coupon.rules}" var="rule">
                    <p class="precondition-price">${rule}</p>
                </c:forEach>
            </div>
            <div class="item-r">
                <p class="precondition-name">${coupon.batchNm}</p>
                <p class="date"><fmt:formatDate value="${coupon.startTime}" pattern="yyyy.MM.dd"/>-<fmt:formatDate value="${coupon.endTime}" pattern="yyyy.MM.dd"/></p>
                <em data-coupon-id="${coupon.couponId}" class="checkbox checkbox-active"></em>
            </div>
        </div>
    </c:forEach>
    <c:forEach items="${userCouponList}" var="coupon">
        <div class="item">
            <div class="item-l">
                <p class="price"><span>¥</span>${coupon.amount}</p>
                <c:forEach items="${coupon.rules}" var="rule">
                    <p class="precondition-price">${rule}</p>
                </c:forEach>
            </div>
            <div class="item-r">
                <p class="precondition-name">${coupon.batchNm}</p>
                <p class="date"><fmt:formatDate value="${coupon.startTime}" pattern="yyyy.MM.dd"/>-<fmt:formatDate value="${coupon.endTime}" pattern="yyyy.MM.dd"/></p>
                <em data-coupon-id="${coupon.couponId}" class="checkbox"></em>
            </div>
        </div>
    </c:forEach>
    <a class="coupons-btn" href="javascript:;">确定</a>
</div>
<script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("em.checkbox").click(function () {
            if($(this).hasClass("checkbox-active")){
                $(this).removeClass("checkbox-active");
            }else {
                $("em.checkbox").removeClass("checkbox-active");
                $(this).addClass("checkbox-active");
            }
        });

        $(".coupons-btn").click(function () {
            selectCoupon($("em.checkbox-active").attr("data-coupon-id"))
        });
    });

    function selectCoupon(couponId){
        $.ajax({
            type:"POST",
            url:"${webRoot}/member/couponFront/useOneCouponOnly.json",
            data:{couponId: couponId, orgId: ${sysOrgId}, type:"${cartType}"},
            success:function(data) {
                if(data.success=="true"){
                    if("store_drug" == "${cartType}"){
                        window.location.href = "${webRoot}/wap/outlettemplate/default/shoppingcart/drugOrderAdd.ac";
                    }else {
                        window.location.href = "${webRoot}/wap/outlettemplate/default/shoppingcart/orderAdd.ac?carttype=${cartType}";
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    }
</script>
</body>
</html>
