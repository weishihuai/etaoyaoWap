<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/sdk" prefix="dk"%>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${pageContext.request.contextPath}" var="webRoot" />
<c:set value="${sdk:getEffectiveCouponPage(5)}" var="unusedCoupon"/>  <%--未使用的--%>
<c:set var="limit" value="5"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>优惠券</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" media="screen" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/coupons.css" media="screen" rel="stylesheet" />
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/myCoupon.js"></script>
    <script>
        var dataValue={
            //myCoupon.js URL前路径引用
            webRoot:"${webRoot}",
            lastPageNumber:"${unusedCoupon.lastPageNumber}"
        };
    </script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1)"></a>
    <span>优惠券</span>
    <a class="bianyi"  onclick="showForm()" href="##">绑定</a>
</div>
<div class="coupons-main">

    <div id="myCouponList" style="padding-bottom: 0;" >
        <c:choose>
            <c:when test="${empty unusedCoupon.result}">
                <div class="none-box">
                    <img class="none-icon" src="${webRoot}/template/bdw/wap/module/member/statics/images/kongyouhuiquan.png" alt="">
                    <p>暂无优惠券</p>
                    <a class="none-btn" href="javascript:;"  onclick="window.location.href='${webRoot}/wap/coupons.ac'">去领券</a>
                </div>
            </c:when>

            <c:otherwise>
                <c:forEach items="${unusedCoupon.result}" var="unusedProxy">
                    <div class="item">
                        <div class="item-l">
                            <p class="price"><span>¥</span>${unusedProxy.amount}</p>
                            <c:forEach items="${unusedProxy.rules}" var="rule">
                                <p class="precondition-price">${rule}</p>
                            </c:forEach>
                        </div>
                        <div class="item-r">
                            <p class="precondition-name">${unusedProxy.batchNm}</p>
                            <p class="date">${unusedProxy.startTimeString}-${unusedProxy.endTimeString}</p>
                            <a class="user-btn" href="javascript:void(0);"   onclick="window.location.href='${webRoot}/wap/productList.ac'">立即使用</a>
                        </div>
                        <c:if test="${unusedProxy.willExpire==true}"><i class="item-tips"></i></c:if>

                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
        <%--<a class="coupons-btn2"  href="javascript:void(0);"   onclick="window.location.href='${webRoot}/wap/product.ac'">更多好券，前往领券中心领券</a>--%>
        <a class="coupons-btn3"  href="javascript:void(0);"   style="margin: 0.46875rem auto 0.78125rem" onclick="window.location.href='${webRoot}/wap/module/member/myInvalidCoupon.ac'">查看失效优惠券></a>
</div>
<div style="display: none;" id="cancelForm" class="user-coupons-layer">
    <div class="user-coupons-box">
        <div class="dt">绑定优惠券</div>
        <div class="dd"><input id="cardNum" maxlength="32" type="text" placeholder="优惠券编号"><input maxlength="20" id="cardPwd" type="text" placeholder="优惠券密码"></div>
        <div class="btn-box"><a href="javascript:;"  onclick="cancelForm()">取消</a><a id="bindCoupon" href="javascript:;">确定</a></div>
    </div>
</div>
    <nav id="page-nav">
        <a href="${webRoot}/wap/module/member/loadMoreInvalidCoupon.ac?&page=2&limit=${limit}"></a>
    </nav>

<div id="tipsDiv" style="z-index: 105;display: none" class="rem-get" style="display: none;" ><span id="tipsSpan"></span></div>

</body>
</html>
