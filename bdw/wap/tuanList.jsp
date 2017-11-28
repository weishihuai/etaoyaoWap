<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<jsp:useBean id="systemTime" class="java.util.Date" />
<c:set value="${sdk:queryGroupBuyCategoryById(15)}" var="category"/>
<c:set value="${empty param.categoryId? 15:param.categoryId}" var="categoryId"/>
<c:set value="${empty param.type? 'groupBuyIN':param.type}" var="type"/>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>

<c:set value="${sdk:findGroupBuyPage(page,6,categoryId,type)}" var="group"/>  <%--团购--%>


<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}-团促销</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/tuanList.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/swiper.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/tuanList.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>

    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            categoryId:${categoryId},
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"
        };
    </script>
</head>
<body>
<c:if test="${isWeixin ne 'Y'}">
    <div class="m-top">
        <a class="back" href="${webRoot}/wap/index.ac"></a>
        <div class="toggle-box">${webName}团促销</div>
    </div>
</c:if>

<div class="group-promotions-main"  id="commentDiv">
        <div class="group-promotions-toggle" <c:if test="${isWeixin eq 'Y'}">style='margin-top: 0rem;'</c:if>>
            <div>
                <div class="swiper-container">
                    <ul class="swiper-wrapper">
                            <li class="swiper-slide <c:if test="${categoryId eq 15}">cur</c:if>">
                                <a href="${webRoot}/wap/tuanList.ac" <c:if test="${categoryId eq 15}">style="color: #FF6B00"</c:if> rel="15">
                                    全部药团购
                                </a>
                            </li>
                        <c:forEach items="${category.children}" var="node" varStatus="s">
                            <li class="swiper-slide <c:if test="${node.categoryId eq categoryId}">cur</c:if>">
                                <a rel="${node.categoryId}" href="${webRoot}/wap/tuanList.ac?type=${type}&categoryId=${node.categoryId}&s=${s.count}" <c:if test="${node.categoryId eq categoryId}">style="color: #FF6B00"</c:if>>
                                    ${node.name}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
        </div>
    </div>
    <c:forEach items="${group.result}" var="groupProxy">
        <c:if test="${groupProxy.stockQuantity>0}">
            <div class="item">
                <a class="pic" href="${webRoot}/wap/tuanDetail.ac?id=${groupProxy.groupBuyId}"><img src="${groupProxy.pic[""]}" alt=""></a>
                <c:if test="${type eq 'groupBuyIN'}">
                    <label>距团购结束：</label>
                    <span id="countdownTime_${groupProxy.groupBuyId}" class="time"></span>
                    <script type="text/javascript">
                        $("#countdownTime_"+"${groupProxy.groupBuyId}").imallCountdown('${groupProxy.isStart ? groupProxy.endTimeString : groupProxy.startTimeString}','default',webPath.systemTime);
                    </script>
                </c:if>
                <c:if test="${type eq 'previewGroupBuy'}">
                    <label>距团购开始：</label>
                    <div id="countdownTime_${groupProxy.groupBuyId}" class="time" itemNm="li_${groupProxy.groupBuyId}"></div>
                    <script type="text/javascript">
                        $("#countdownTime_"+"${groupProxy.groupBuyId}").imallCountdown('${groupProxy.isStart ? groupProxy.endTimeString : groupProxy.startTimeString}','previewdefault',webPath.systemTime);
                    </script>
                </c:if>
                <p class="name elli" onclick="window.location.href='${webRoot}/wap/tuanDetail.ac?id=${groupProxy.groupBuyId}'">${groupProxy.title}</p>
                <p class="group-number">${groupProxy.soldQuantity}人已参团</p>
                <p class="price">￥<fmt:formatNumber  value="${groupProxy.price.unitPrice}" type="number"  pattern="#0.00#"/>
                <span class="old-price">￥<fmt:formatNumber  value="${groupProxy.orgPrice}" type="number"  pattern="#0.00#"/></span></p>
            </div>
        </c:if>
        <c:if test="${groupProxy.stockQuantity<=0}">
            <div class="item disabled">
                <a class="pic" href="javascript:void(0);"><img data-original="${groupProxy.pic[""]}" alt=""></a>
                <c:if test="${type eq 'groupBuyIN'}">
                    <label>距团购结束：</label>
                    <div id="countdownTime_${groupProxy.groupBuyId}" class="time"></div>
                    <script type="text/javascript">
                        $("#countdownTime_"+"${groupProxy.groupBuyId}").imallCountdown('${groupProxy.isStart ? groupProxy.endTimeString : groupProxy.startTimeString}','default',webPath.systemTime);
                    </script>
                </c:if>
                <c:if test="${type eq 'previewGroupBuy'}">
                    <label>距团购开始：</label>
                    <div id="countdownTime_${groupProxy.groupBuyId}" class="time" itemNm="li_${groupProxy.groupBuyId}"></div>
                    <script type="text/javascript">
                        $("#countdownTime_"+"${groupProxy.groupBuyId}").imallCountdown('${groupProxy.isStart ? groupProxy.endTimeString : groupProxy.startTimeString}','previewdefault',webPath.systemTime);
                    </script>
                </c:if>
                <p class="name elli">${groupProxy.title}</p>
                <p class="group-number">${groupProxy.soldQuantity}人已参团</p>
                <p class="price">￥<fmt:formatNumber  value="${groupProxy.price.unitPrice}" type="number"  pattern="#0.00#"/>
                    <span class="old-price">￥<fmt:formatNumber  value="${groupProxy.orgPrice}" type="number"  pattern="#0.00#"/></span></p>
            </div>
        </c:if>
    </c:forEach>
</div>

<nav id="page-nav">
    <a href="${webRoot}/wap/tuanList.ac?page=2&type=${type}"></a>
</nav>

<script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
<script>
    var swiper04 = new Swiper('.group-promotions-toggle .swiper-container',{
        freeMode : true,
        slidesPerView : 'auto'
    });
</script>
</body>
</html>
