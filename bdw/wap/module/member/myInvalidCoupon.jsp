<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/sdk" prefix="dk"%>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${pageContext.request.contextPath}" var="webRoot" />
<c:set value="${sdk:getInvalidCouponPage(5)}" var="invalid"/>  <%--失效 优惠券--%>
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
            lastPageNumber:"${invalid.lastPageNumber}"
        };
    </script>
</head>
<body>
    <div class="m-top">
        <a class="back" href="javascript:history.go(-1)"></a>
        <span>失效券</span>

    </div>

    <div id="couponList" class="coupons-main lapse-coupons">
    <c:choose>
        <c:when test="${empty invalid.result}">
            <div class="row" >
                <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
            </div>
        </c:when>

        <c:otherwise>
            <c:forEach items="${invalid.result}" var="invalidProxy">
                <div class="item">
                    <div class="item-l">
                        <p class="price"><span>¥</span>${invalidProxy.amount}</p>
                        <c:forEach items="${invalidProxy.rules}" var="rule">
                            <p class="precondition-price">${rule}</p>
                        </c:forEach>
                    </div>
                    <div class="item-r">
                        <p class="precondition-name">${invalidProxy.batchNm}</p>
                        <p class="date">${invalidProxy.startTimeString}-${invalidProxy.endTimeString}</p>
                    </div>
                    <c:if test="${invalidProxy.invalidState=='USED'}"><i class="yishiyong"></i></c:if>
                    <c:if test="${invalidProxy.invalidState=='expire'}"><i class="guoqi"></i></c:if>

                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

 </div>

    <nav id="page-nav">
        <a href="${webRoot}/wap/module/member/loadMoreCoupon.ac?&page=2&limit=${limit}"></a>
    </nav>
</body>
</html>
