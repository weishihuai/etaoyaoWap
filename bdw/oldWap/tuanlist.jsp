<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%--取今日正在热卖团购--%>
<c:set value="${sdk:findTodayGroupBuy(null)}" var="groupBuyList"/>
<%--未开始--%>
<c:set value="${sdk:findPreviewGroupBuy(null)}" var="comingGroupBuyList"/>  <%--团购预告--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<jsp:useBean id="systemTime" class="java.util.Date" />
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-团购活动-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" type="text/css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" type="text/css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/grouplist.css" type="text/css" rel="stylesheet">

    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/stickUp.min.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/imall-countdown.js"></script>
    <script type="text/javascript">
        var webPath = {
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"
        };
        jQuery(function($) {
            $(document).ready( function() {
                //enabling stickUp on the '.navbar-wrapper' class
                $('.sort').stickUp();
            });
        });
    </script>
</head>
<body>

<%--<div class="container" id="index">--%>
    <%--<!--     轮换广告    -->--%>
    <%--<div class="row frameEdit" frameInfo="roteAdv_mobile|320X140" style="min-width: 30px; min-height: 30px;">--%>
        <%--<div class="col-xs-12">--%>
            <%--<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">--%>
                <%--<!-- Wrapper for slides -->--%>
                <%--<div class="carousel-inner">--%>
                    <%--<c:forEach items="${sdk:findPageModuleProxy('roteAdv_mobile').advt.advtProxy}" var="advtProxys" varStatus="s" end="5">--%>
                    <%--<c:choose>--%>
                    <%--<c:when test="${s.first}"><div class="item active"></c:when>--%>
                    <%--<c:otherwise><div class="item"></c:otherwise>--%>
                        <%--</c:choose>--%>
                        <%--<a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" width="320" height="140" alt="${advtProxys.hint}" style="height:140px;"></a>--%>
                            <%--&lt;%&ndash; <span class="carousel-caption"></span>&ndash;%&gt;--%>
                    <%--</div>--%>
                    <%--</c:forEach>--%>
                <%--</div>--%>

                    <%--<!-- Controls -->--%>
                    <%--<a class="left carousel-control" href="#carousel-example-generic" data-slide="prev" id="banner_turn">--%>
                        <%--<span class="glyphicon glyphicon-chevron-left"></span>--%>
                    <%--</a>--%>
                    <%--<a class="right carousel-control" href="#carousel-example-generic" data-slide="next" id="banner_turn">--%>
                        <%--<span class="glyphicon glyphicon-chevron-right"></span>--%>
                    <%--</a>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<!--end     轮换广告-->--%>

    <%--<div class="row">--%>
        <%--<div class="col-xs-12 frameEdit" id="logo" frameInfo="logo_mobile|97X33">--%>
            <%--<c:forEach items="${sdk:findPageModuleProxy('logo_mobile').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">--%>
                <%--<a id="${s.count}"  href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="97" height="33" /></a>--%>
            <%--</c:forEach>--%>
        <%--</div>--%>
    <%--</div>--%>

<%--</div>--%>


<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=团购活动"/>
<%--页头结束--%>
<div class="row sort" style="background:#FFF;">
    <div class="col-xs-12">
        <div class="navtabs">
            <ul class="nav nav-tabs">
                <li class="active" style="width:50%;"><a role="button" class="btn btn-default btn-block" href="#defaut" data-toggle="tab">今日团购</a></li>
                <li style="width:50%;"><a role="button" class="btn btn-default btn-block" href="#sell" data-toggle="tab">团购预告</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="tab-content">
    <div class="tab-pane active" id="defaut" >
        <c:if test="${empty groupBuyList}">
            <div class="container">
                <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                    <div class="col-xs-12">
                        <%--<span class="glyphicon glyphicon-ok glyphicon-ok2"></span>--%>
                        商城还没有此类型的商品，请您先
                        <a href="${webRoot}/wap/list.ac">选购其他商品?</a>
                    </div>
                </div>
                <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                    <div class="col-xs-12">
             <%--           <button onclick="window.location.href='${webRoot}/wap/index.ac'"
                                class="btn btn-danger btn-danger2" type="button">返回首页
                        </button>--%>
                    </div>
                </div>
            </div>
        </c:if>
        <c:forEach items="${groupBuyList}" var="groupBuy" varStatus="s">
            <div class="row tg_rows">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12"><a href="${webRoot}/wap/tuanDetail.ac?id=${groupBuy.groupBuyId}" title="${groupBuy.title}"><img src="${groupBuy.pic["420X420"]}"  alt="${groupBuy.title}" style="width: 100%;height: 100%;"></a></div>
                    </div>
                    <div class="row tg_rows2">
                        <div class="col-xs-12">
                            <div class="row">
                                <div class="col-xs-12 tg_title">
                                    <a href="${webRoot}/wap/tuanDetail.ac?id=${groupBuy.groupBuyId}" title="${groupBuy.title}">${groupBuy.title}</a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 list_rice">团购价:<em>￥<fmt:formatNumber value="${groupBuy.price.unitPrice}" type="number" pattern="#0.00#" /></em></div>
                                <div class="col-xs-6 list_rice">￥<fmt:formatNumber value="${groupBuy.orgPrice}" type="number" pattern="#0.00#" />(<fmt:formatNumber  value="${groupBuy.discount/10}"  pattern="#,###,###,###"/>折)</div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12 tg_time" id="countdownTime${s.count}">剩余时间：2天6时34分 24秒</div>
                            </div>
                            <script type="text/javascript">
                                $(function(){
                                    $("#countdownTime${s.count}").imallCountdown('${groupBuy.endTimeString}','none',webPath.systemTime);
                                });
                            </script>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 box_bottom"></div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="tab-pane" id="sell">
        <c:if test="${empty comingGroupBuyList}">
            <div class="container">
                <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                    <div class="col-xs-12">
                        <%--<span class="glyphicon glyphicon-ok glyphicon-ok2"></span>--%>
                        商城还没有此类型的商品，请您先
                        <a href="${webRoot}/wap/list.ac">选购其他商品?</a>
                    </div>
                </div>
                <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                    <div class="col-xs-12">
          <%--              <button onclick="window.location.href='${webRoot}/wap/index.ac'"
                                class="btn btn-danger btn-danger2" type="button">返回首页
                        </button>--%>
                    </div>
                </div>
            </div>
        </c:if>
        <c:forEach items="${comingGroupBuyList}" var="groupBuy" varStatus="s">
            <div class="row tg_rows">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12"><a href="${webRoot}/wap/tuanDetail.ac?id=${groupBuy.groupBuyId}" title="${groupBuy.title}"><img src="${groupBuy.pic[""]}"  alt="${groupBuy.title}" width="100%"></a></div>
                    </div>
                    <div class="row tg_rows2">
                        <div class="col-xs-12">
                            <div class="row">
                                <div class="col-xs-12 tg_title">
                                    <a href="${webRoot}/wap/tuanDetail.ac?id=${groupBuy.groupBuyId}" title="${groupBuy.title}">${groupBuy.title}</a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 list_rice">团购价:<em>￥<fmt:formatNumber value="${groupBuy.price.unitPrice}" type="number" pattern="#0.00#" /></em></div>
                                <div class="col-xs-6 list_rice">￥<fmt:formatNumber value="${groupBuy.orgPrice}" type="number" pattern="#0.00#" />(<fmt:formatNumber  value="${groupBuy.discount/10}"  pattern="#,###,###,###"/>折)</div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12 tg_time" id="countdownTimeS${s.count}"></div>
                            </div>
                            <script type="text/javascript">
                                $(function(){
                                    $("countdownTimeS${s.count}").imallCountdown('${groupBuy.endTimeString}','none',webPath.systemTime);
                                });
                            </script>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 box_bottom"></div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>
</body>
</html>
<f:FrameEditTag />
