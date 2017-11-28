<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/8/17
  Time: 19:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="systemTime" class="java.util.Date" />
<%--取出活动主题列表--%>
<c:set value="${bdw:getAllMarketingSubjectSection()}" var="marketingSubjectSectionList"/>
<%--<c:set value="${bdw:getAllShowMarketingSubjectSectionInWeiXin()}" var="v"/>--%>
<c:choose>
    <c:when test="${not empty param.subjectSectionId}">
        <c:set value="${param.subjectSectionId}" var="subjectSectionId"/>
    </c:when>
    <c:otherwise>
        <%--默认选中第一个主题--%>
        <c:if test="${not empty marketingSubjectSectionList}">
            <c:forEach items="${marketingSubjectSectionList}" var="marketingSubjectSection" end="0">
                <c:set value="${marketingSubjectSection.marketingSubjectSectionId}" var="subjectSectionId"/>
            </c:forEach>
        </c:if>
    </c:otherwise>
</c:choose>

<%--取出主题下的待执行、执行中的活动--%>
<c:set value="${bdw:getMarketingActivityProxyByExamine(subjectSectionId)}" var="marketingActivityProxyList"/>

<c:choose>
    <c:when test="${not empty param.activityId}">
        <c:set value="${param.activityId}" var="activityId"/>
    </c:when>
    <c:otherwise>
        <%--默认选中第一个活动--%>
        <c:if test="${not empty marketingActivityProxyList}">
            <c:forEach items="${marketingActivityProxyList}" var="marketingActivityProxy" end="0">
                <c:set value="${marketingActivityProxy.marketingActivityId}" var="activityId"/>
            </c:forEach>
        </c:if>
    </c:otherwise>
</c:choose>

<%--取出活动--%>
<c:set value="${sdk:getMarketingActivityById(activityId)}" var="marketingActivity"/>

<%--取出活动下商品--%>
<c:set value="${bdw:getAllMarketingActivitySignUpList(marketingActivity.marketingActivityId)}" var="activitySignUpProxyList"/>

<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no>"/>
    <meta name="format-detection" content="telphone=no, email=no"/>
    <title>限时抢购，巅峰让利！梦想不要打折，只需一点关注！</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/limit-base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/limit-buy.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/js/alertPopShow/common.css" rel="stylesheet" media="screen">

    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"
        };
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/alertPopShow/alertPopShow.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/limit-base.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/wap-countdown.js" type="text/javascript"></script>

</head>
<body>
<%-- 这个图片是分享到微信朋友圈显示的 --%>
<div style='margin:0 auto;width:0px;height:0px;overflow:hidden;'>
    <img src="${webRoot}/template/bdw/oldWap/statics/images/syjkw_share_logo.png" width='700'/>
</div>
<!-- 头部 -->
<c:if test="${isWeixin!='Y'}">
    <header class="header">
        <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
        <span class="title">限时活动</span>
        <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
    </header>
</c:if>

<!-- 主体 -->
<div class="main">

    <c:choose>
        <%--没有主题--%>
        <c:when test="${empty marketingSubjectSectionList}">
            <div style="text-align: center;padding-top: 30px;font-size: 17px;font-weight: bold;">
                暂无任何主题活动!
            </div>
        </c:when>
        <c:otherwise>
            <c:choose>
                <%--没有活动--%>
                <c:when test="${empty marketingActivityProxyList}">
                    <div style="text-align: center;padding-top: 30px;font-size: 17px;font-weight: bold;">
                        主题暂无任何活动
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="top-banner">
                        <img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(activityId,'580X216')}"/>
                    </div>
                    <ul class="m-time clearfix" id="activityTab">
                        <c:forEach items="${marketingActivityProxyList}" var="activityProxy" end="4" varStatus="status">
                            <li class="<c:if test="${activityProxy.marketingActivityId eq activityId}">cur</c:if>" marketingActivityId="${activityProxy.marketingActivityId}" progress="${activityProxy.progress}">
                                <a href="${webRoot}/wap/limitActivity.ac?activityId=${activityProxy.marketingActivityId}&subjectSectionId=${subjectSectionId}">
                                    <em><fmt:formatDate value="${activityProxy.activityStartTime}" pattern="HH:mm"/></em>
                                    <c:choose>
                                        <c:when test="${activityProxy.progress}">
                                            <span>抢购中</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>即将开始</span>
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    <c:choose>
                        <c:when test="${not empty activitySignUpProxyList}">
                            <div class="cont">
                                <div class="cont-m">
                                    <div class="mt">
                                        <c:choose>
                                            <c:when test="${marketingActivity.progress}">
                                                <div class="mt"><span>限时限量抢购中...</span></div>
                                            </c:when>
                                            <c:otherwise>
                                                <span>距离本场开始</span>
                                                <div class="time" id="fnTimeCountDown" data-end="${marketingActivity.activityStartTime}">
                                                    <%--<i class="hour">00</i>:<i class="mini">00</i>:<i class="sec">00</i>--%>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <ul class="mc">
                                        <c:if test="${not empty activitySignUpProxyList}">
                                            <c:forEach items="${activitySignUpProxyList}" var="signUpActivity">
                                                <c:set var="productProxy" value="${sdk:getProductById(signUpActivity.productId)}"/>
                                                <c:choose>
                                                    <%--抢购中--%>
                                                    <c:when test="${marketingActivity.progress}">
                                                        <c:choose>
                                                            <c:when test="${signUpActivity.signUpNum eq 0}">
                                                                <%--已经抢完--%>
                                                                <li>
                                                                    <div class="pic">
                                                                        <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}"><img
                                                                                class="img-rounded" src="${productProxy.defaultImage["200X200"]}" width="180" height="180"></a>
                                                                        <span>已抢完</span>
                                                                    </div>
                                                                    <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="title">${productProxy.name}</a>

                                                                    <div class="price">
                                                                        抢购价￥<span><fmt:formatNumber value="${signUpActivity.price}" type="number" pattern="#0.00#"/></span>
                                                                        <del>市场价￥${productProxy.marketPrice}</del>
                                                                    </div>
                                                                    <div class="mc-bot">
                                                                        <div class="amount">仅剩0件<span style="width: 100%;"></span></div>
                                                                        <a href="javascript:void(0);" class="bot-btn01 moreDiscountBtn" subjectSectionId="${subjectSectionId}" activityId="${signUpActivity.marketingActivityId}">更多优惠</a>
                                                                    </div>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <%--正在热抢--%>
                                                                <li>
                                                                    <div class="pic">
                                                                        <a href="${webRoot}/wap/product-${productProxy.productId}.html"><img
                                                                                class="img-rounded" src="${productProxy.defaultImage["200X200"]}" width="180" height="180"></a>
                                                                    </div>
                                                                    <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="title">${productProxy.name}</a>
                                                                    <div class="price">
                                                                        抢购价￥<span><fmt:formatNumber value="${signUpActivity.price}" type="number" pattern="#0.00#"/></span>
                                                                        <del>市场价￥${productProxy.marketPrice}</del>
                                                                    </div>
                                                                    <div class="mc-bot">
                                                                        <c:choose>
                                                                            <c:when test="${signUpActivity.saleVolumn eq 0}">
                                                                                <div class="amount">限量${signUpActivity.signUpNum}件<span style="width: 0;"></span></div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="amount">仅剩${signUpActivity.signUpNum}件<span style="width: ${signUpActivity.proportion}%;"></span></div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                        <a href="${webRoot}/wap/product-${productProxy.productId}.html" class="bot-btn02" id="goCart">立即抢购</a>
                                                                    </div>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%--即将开始--%>
                                                        <li>
                                                            <div class="pic">
                                                                <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}"><img
                                                                        class="img-rounded" src="${productProxy.defaultImage["200X200"]}" width="180" height="180"></a>
                                                                <span>即将开始</span>
                                                            </div>
                                                            <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="title">${productProxy.name}</a>

                                                            <div class="price">
                                                                抢购价￥<span><fmt:formatNumber value="${signUpActivity.price}" type="number" pattern="#0.00#"/></span>
                                                                <del>市场价￥${productProxy.marketPrice}</del>
                                                            </div>
                                                            <div class="mc-bot">
                                                                <div class="amount">限量${signUpActivity.signUpNum}件<span style="width: 0;"></span></div>
                                                                <a href="javascript:void(0);" class="bot-btn01 remindBtn" productId="${productProxy.productId}" marketingActivityId="${signUpActivity.marketingActivityId}">即将开始</a>
                                                            </div>
                                                            <div class="start-date"><fmt:formatDate value="${marketingActivity.activityStartTime}" pattern="MM月dd日"/></div>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </c:if>

                                    </ul>
                                    <div class="mb">
                                            <%--活动说明--%>
                                        <h5>限时购说明：<c:if test="${empty marketingActivity.activityCont}"><span style="color:#333;font-size: 12px;margin-left: 10px;">暂无任何说明</span></c:if></h5>
                                        <c:if test="${not empty marketingActivity.activityCont}">
                                            <p style="line-height: 20px;">
                                                ${marketingActivity.activityCont}
                                            </p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="cont" style="text-align: center;padding-top: 30px;font-size: 20px;font-weight: bold;padding-bottom: 50px;">
                                暂无任何商品参加活动!
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
    <div style="width: 100%; /*height: 100px;*/ "></div>
</div>

<div style="display: none;">
    <script type="text/javascript">
        var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        document.write(unescape("%3Cspan id='cnzz_stat_icon_1257056943'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1257056943' type='text/javascript'%3E%3C/script%3E"));
    </script>
</div>

<script type="text/javascript">
    $("#fnTimeCountDown").imallCountdown('${marketingActivity.progress ? marketingActivity.activityEndTimeStr : marketingActivity.activityStartTimeStr}','wapPromotion',webPath.systemTime);
//    $("#fnTimeCountDown").fnTimeCountDown();
</script>

<!-- 底部 -->
<c:import url="/template/bdw/oldWap/module/common/activityBottom.jsp"/>

</body>
</html>
