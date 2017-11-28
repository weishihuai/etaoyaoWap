<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--取出商品--%>
<c:set var="orderProxy" value="${sdk:findOrderDetailed(param.id)}"/>

<c:set value="${orderProxy.orderComment}" var="orderComment"/>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>评价晒单</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/flexible.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/base.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/swiper.min.css" type="text/css" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/appraisel.css" type="text/css" rel="stylesheet" />

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/main.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/ObjectToJsonUtil.js"></script>
    <c:choose>
        <c:when test="${isWeixin eq 'Y'}"><%--微信端--%>
            <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/jweixin-1.0.0.js"></script>
            <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/weixinJsOperation.js"></script>
        </c:when>
        <c:otherwise>
            <script src="${webRoot}/template/bdw/module/member/statics/js/plupload/plupload.full.min.js" type="text/javascript"></script>
        </c:otherwise>
    </c:choose>
</head>
<body>
    <div class="m-top">
        <a href="javascript:history.go(-1)" class="back"></a>
        <span>评价晒单</span>
    </div>

    <div class="appraisel-main">
        <input type="hidden" name="orderId" id="orderId" value="${orderProxy.orderId}">
        <input type="hidden" name="orderType" id="orderType" value="${orderProxy.orderType}">
        <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItem" varStatus="s">
            <c:set var="productProxy" value="${orderItem.productProxy}"/>
            <c:set var="comment" value="${orderItem.comment}"/>
            <input type="hidden" name="productId" id="productId_${s.index}" value="${productProxy.productId}">

            <div class="product-appraisel">
                <div class="dt">商品评分</div>
                <div class="dd">
                    <div class="dd-item">
                        <c:choose>
                            <c:when test="${orderItem.promotionType eq '团购商品'}">
                                <c:set value="${sdk:findGroupBuyProxy(orderItem.groupBuyId)}" var="groupBuyItem"/>
                                <a class="pic" href="${webRoot}/wap/product.ac?id=${productProxy.productId}"><img src="${groupBuyItem.pic['320X320']}" alt="${groupBuyItem.title}"></a>
                                <a class="name elli" href="javascript:;">${groupBuyItem.title}</a>
                            </c:when>
                            <c:otherwise>
                                <a class="pic" href="${webRoot}/wap/product.ac?id=${productProxy.productId}"><img src="${orderItem.productProxy.defaultImage['320X320']}" alt="${orderItem.productProxy.name}"></a>
                                <a class="name elli" href="javascript:;">${orderItem.productProxy.name}</a>
                            </c:otherwise>
                        </c:choose>
                        <c:set var="grade" value="${empty comment.gradeLevel  ?  '5' : comment.gradeLevel}"></c:set>
                        <p class="star-number"  id="commentGrade_${s.index}" >
                            <span  <c:if test="${comment.gradeLevel>=1}">class="s"</c:if>></span>
                            <span  <c:if test="${comment.gradeLevel>=2}">class="s"</c:if>></span>
                            <span  <c:if test="${comment.gradeLevel>=3}">class="s"</c:if>></span>
                            <span  <c:if test="${comment.gradeLevel>=4}">class="s"</c:if>></span>
                            <span  <c:if test="${comment.gradeLevel>=5}">class="s"</c:if>></span>
                        </p>
                    </div>

                    <div class="appraisel-txt">
                        <textarea disabled class="addCommentTextArea" id="addCommentTextArea_${s.index}" placeholder="评价超过10字有机会获得积分～" value="${comment.content}">${comment.content}</textarea>
                    </div>
                    <div class="add-pic-box add-pic-box1 clearfix">
                        <c:forEach items="${comment.pics}" var="image">
                            <div class="pic-item" style="z-index: 2"  >
                                <img src="${image['100X100']}" alt="">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>


        <div class="shop-appraisel">
            <div class="dt">店铺评分</div>
            <div class="dd">
                <div class="dd-item">宝贝相符
                    <c:set var="grade" value="${empty orderComment.productDescrSame  ?  '0' : orderComment.productDescrSame}"></c:set>
                    <p class="star-number" id="productDescrSame">
                        <span <c:if test="${orderComment.productDescrSame>=1}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.productDescrSame>=2}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.productDescrSame>=3}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.productDescrSame>=4}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.productDescrSame>=5}">class="s"</c:if>></span>
                    </p></div>
                <div class="dd-item">服务态度
                    <c:set var="grade" value="${empty orderComment.sellerServiceAttitude  ?  '0' : orderComment.sellerServiceAttitude}"></c:set>
                    <p class="star-number" id="sellerServiceAttitude">
                        <span <c:if test="${orderComment.sellerServiceAttitude>=1}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.sellerServiceAttitude>=2}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.sellerServiceAttitude>=3}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.sellerServiceAttitude>=4}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.sellerServiceAttitude>=5}">class="s"</c:if>></span>
                    </p></div>
                <div class="dd-item">发货速度
                    <c:set var="grade" value="${empty orderComment.sellerSendOutSpeed  ?  '0' : orderComment.sellerSendOutSpeed}"></c:set>
                    <p class="star-number" id="sendOutSpeed">
                        <span <c:if test="${orderComment.sellerSendOutSpeed>=1}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.sellerSendOutSpeed>=2}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.sellerSendOutSpeed>=3}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.sellerSendOutSpeed>=4}">class="s"</c:if>></span>
                        <span <c:if test="${orderComment.sellerSendOutSpeed>=5}">class="s"</c:if>></span>
                    </p></div>
            </div>
        </div>
    </div>

</body>
</html>
