<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/sdk" prefix="dk"%>

<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<%--<c:set value="${empty param.page ? 1 : param.page}" var="page"/>--%>
<%--<c:set value="${pageContext.request.contextPath}" var="webRoot" />--%>
<%--<c:set value="${sdk:getEffectiveCouponPage(5)}" var="unusedCoupon"/>  &lt;%&ndash;未使用的&ndash;%&gt;--%>
<%--<c:set var="limit" value="5"/>--%>
<c:set var="limit" value="5"/>
<%--获取可以领的券--%>
<c:set value="${bdw:pageEffectiveGivenCouponRule(limit)}" var="effectiveGivenCouponRule"/>
<c:set value="${effectiveGivenCouponRule.result}" var="effectiveGivenCouponRuleList"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>优惠券</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" media="screen" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/coupons-s.css" media="screen" rel="stylesheet" />
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/coupons.js"></script>
    <script>
        var webPath={
            //myCoupon.js URL前路径引用
            webRoot:"${webRoot}",
            lastPageNumber:"${effectiveGivenCouponRule.lastPageNumber}"
        };
    </script>
</head>
<body>
    <div class="m-top">
        <a class="back" href="${webRoot}/wap/index.ac"></a>
        <span>领券爽</span>
        <a class="bianyi" href="${webRoot}/wap/module/member/myCoupon.ac" >我的券</a>
    </div>

    <div id="couponList" class="coupons-s-main">
        <c:choose>
            <c:when test="${empty effectiveGivenCouponRuleList}">
                <div class="row" >
                    <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无优惠券</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${effectiveGivenCouponRuleList}" var="sysGivenCouponProxy" varStatus="status">
                    <div class="item">
                        <div class="item-l">
                            <p class="price"><span>¥</span>${sysGivenCouponProxy.amount}</p>
                            <c:forEach items="${sysGivenCouponProxy.rules}" var="rule">
                                <p class="precondition-price">${rule}</p>
                            </c:forEach>
                        </div>
                        <div class="item-r">
                            <p class="precondition-name">
                                <c:choose>
                                    <c:when test="${fn:length(sysGivenCouponProxy.title) > 34}">
                                        ${fn:substring(sysGivenCouponProxy.title,0 , 34)}......
                                    </c:when>
                                    <c:otherwise>
                                        ${sysGivenCouponProxy.title}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <p class="date">${sysGivenCouponProxy.startTimeString}-${sysGivenCouponProxy.endTimeString}</p>
                            <c:choose>
                                <c:when test="${ sysGivenCouponProxy.receiveOrNot== true}">
                                    <a class="btn2" href="javascript:void(0);"  onclick="window.location.href='${webRoot}/wap/productList.ac'">立即使用</a>
                                </c:when>
                                <c:otherwise>
                                    <a class="btn1" href="javascript:void(0);"
                                       onclick="receiveCoupon('${sysGivenCouponProxy.ruleLinke}',this)">立即领取</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </div>
    <nav id="page-nav">
        <a href="${webRoot}/wap/module/member/loadMoreUnReceiveCoupon.ac?page=2&limit=${limit}"></a>
    </nav>
    <div id="tipDiv" style="z-index: 1;display: none" class="rem-get" style="display: none;" ><span id="tipSpan"></span></div>

</body>
</html>
