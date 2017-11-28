<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${param.tabSelect}"  var="tabSelect"/>
<c:set value="${empty param.dateRange ? 0 : param.dateRange}" var="dateRange"/>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:if test="${empty tabSelect || tabSelect == 'process'}"><c:set value="${sdk:getMarketingActivityProxyList(page,16,'Y','N','N')}" var="processMarketActivity"/>    <%--正在进行的活动--%></c:if>
<c:if test="${empty tabSelect || tabSelect == 'last'}"><c:set value="${sdk:getMarketingActivityProxyList(page,16,'Y','Y','N')}" var="lastMarketActivity"/>  <%--最后一天的活动--%></c:if>
<c:if test="${empty tabSelect || tabSelect == 'already'}"><c:set value="${sdk:getStartMarketingActivity(page,16,dateRange)}" var="alreadyMarketActivity"/>  <%--即将开始的活动--%></c:if>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="易淘药促销活动，果维康促销活动，易淘药，易淘药集团，易淘药大健康，果维康，溯源商城，药食同源，欧意，欧意和，若舒，恩必普，易淘药电商，安沃勤，纯净冰岛，安蜜乐，易淘药贝贝，易淘药健康城" /> <%--SEO keywords优化--%>
    <meta name="description" content="易淘药健康网，易淘药集团官方网站，易淘药促销活动，果维康促销活动" /> <%--SEO description优化--%>
    <title>${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/activityIndex.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <!--[if IE 6]>
    <script type="text/javascript" src="script/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('div,ul,li,a,h1,h2,h3,input,img,span,dl, background');</script><![endif]-->
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/activityIndex.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            tabSelect("${param.at}","${tabSelect}");
        });
    </script>
</head>

<body>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=activityIndex"/>
<%--页脚结束--%>

<div id="main">
    <%--首页 banner 开始--%>
    <div class="layer frameEdit" frameInfo="activityIndexBannerAdv|1190X100">
        <c:forEach items="${sdk:findPageModuleProxy('activityIndexBannerAdv').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="1190px" height="100px" /></a>
        </c:forEach>
    </div>
    <%--首页 banner 结束--%>

    <%--导航栏 开始--%>
    <div class="menu">
      <%--  <a class="cur" href="${webRoot}/activityIndex.ac?at=fTab">品牌折扣特卖</a>--%>
        <a class="process" href="${webRoot}/activityIndex.ac?tabSelect=process">正在进行</a>
        <a class="last" href="${webRoot}/activityIndex.ac?tabSelect=last">最后一天</a>
        <a class="already" href="${webRoot}/activityIndex.ac?tabSelect=already&at=fTab">即将开始</a>
    </div>
    <%--导航栏结束--%>

    <%--轮换广告 开始--%>
    <div class="banner sorPic" style="position: relative;width: 1190px;height: 290px;">
        <div class="pic frameEdit" id="roteAdv"  frameInfo="activityIndexRoteAdv|1190X290" style="position: relative;width: 1190px;height: 290px;">
            <c:forEach items="${sdk:findPageModuleProxy('activityIndexRoteAdv').advt.advtProxy}" var="advtProxys" varStatus="s">
                <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="1190px" height="290px" /></a>
            </c:forEach>
        </div>
    </div>
    <%--轮换广告 结束--%>

    <%--正在进行的活动  开始--%>
    <div class="processActivity" style="display: ${empty processMarketActivity.result ? 'none' : 'block'}">
        <div class="now"><a>正在进行的活动</a></div>
        <div class="list">
            <c:forEach items="${processMarketActivity.result}" var="activity" varStatus="num">
                <c:set value="${bdw:getMarketingSubjectSectionById(activity.marketingSubjectSectionId)}" var="marketingSubjectSection" />
                <c:if test="${marketingSubjectSection.isShowInWeiXin != 'Y'}">
                    <ul>
                        <h2><a href="${webRoot}/activityList.ac?tabSelect=process&activityId=${activity.marketingActivityId}"><img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'280X360')}" width="280px" height="360px"/></a></h2>
                        <h3><a href="${webRoot}/activityList.ac?tabSelect=process&activityId=${activity.marketingActivityId}">${activity.activityNm}</a></h3>
                        <li>
                            <div class="discount"><span><span>${activity.discountRequirement}</span>折起</span></div>
                            <div class="time">
                                <input type="hidden"  value="${activity.activityEndTimeStr}" name="time"/>
                                <p>距活动结束还有</p>
                                <h4 class="time"><a class="lastTime"></a></h4>
                            </div>
                        </li>
                    </ul>
                </c:if>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <%--正在进行的活动 结束--%>

    <%--最后一天  开始--%>
    <div class="lastActivity"  style="display: ${empty lastMarketActivity.result ? 'none' : 'block'}">
        <div class="now"><a>最后一天</a></div>
        <div class="list">
            <c:forEach items="${lastMarketActivity.result}" var="activity" varStatus="num">
                <c:set value="${bdw:getMarketingSubjectSectionById(activity.marketingSubjectSectionId)}" var="marketingSubjectSection" />
                <c:if test="${marketingSubjectSection.isShowInWeiXin != 'Y'}">
                    <ul>
                        <h2><a href="${webRoot}/activityList.ac?tabSelect=last&activityId=${activity.marketingActivityId}"><img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'280X360')}" width="280px" height="360px"/></a></h2>
                        <h3><a href="${webRoot}/activityList.ac?tabSelect=last&activityId=${activity.marketingActivityId}">${activity.activityNm}</a></h3>
                        <li>
                            <div class="discount"><span><span>${activity.discountRequirement}</span>折起</span></div>
                            <div class="time">
                                <input type="hidden"  value="${activity.activityEndTimeStr}" name="time"/>
                                <p>距活动结束还有</p>
                                <h4 class="time"><a class="lastTime"></a></h4>
                            </div>
                        </li>
                    </ul>
                </c:if>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <%--最后一天 结束--%>

    <%--即将开始的活动 开始--%>
    <div class="alreadyActivity" style="display: ${empty alreadyMarketActivity.result ? 'none' : 'block'}">
        <div class="now"><a>即将开始活动</a></div>
        <div class="nav">
            <a class="alreadyTab cur" id="fTab" href="${webRoot}/activityIndex.ac?tabSelect=already&at=fTab&dateRange=0">${sdk:getFormatDate(0)}</a>
            <a class="alreadyTab" id="sTab"  href="${webRoot}/activityIndex.ac?tabSelect=already&at=sTab&dateRange=1">${sdk:getFormatDate(1)}</a>
            <a class="alreadyTab" id="tTab"  href="${webRoot}/activityIndex.ac?tabSelect=already&at=tTab&dateRange=2">${sdk:getFormatDate(2)}</a>
            <a class="alreadyTab" id="foTab"  href="${webRoot}/activityIndex.ac?tabSelect=already&at=foTab&dateRange=3">${sdk:getFormatDate(3)}</a>
            <div class="clear"></div>
        </div>
        <div class="list">
            <c:forEach items="${alreadyMarketActivity.result}" var="activity" varStatus="num">
                <c:set value="${bdw:getMarketingSubjectSectionById(activity.marketingSubjectSectionId)}" var="marketingSubjectSection" />
                <c:if test="${marketingSubjectSection.isShowInWeiXin != 'Y'}">
                    <ul>
                        <h2><a href="${webRoot}/activityList.ac?tabSelect=already&activityId=${activity.marketingActivityId}"><img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'280X360')}" width="280px" height="360px"/></a></h2>
                        <h3><a href="${webRoot}/activityList.ac?tabSelect=already&activityId=${activity.marketingActivityId}">${activity.activityNm}</a></h3>
                        <li>
                            <div class="discount"><span><span>${activity.discountRequirement}</span>折起</span></div>
                            <div class="time">
                                <input type="hidden"  value="${activity.activityStartTimeStr}" name="time"/>
                                <p>距活动开始还有</p>
                                <h4 class="time"><a class="lastTime"></a></h4>
                            </div>
                        </li>
                    </ul>
                </c:if>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <%--即将开始的活动 结束--%>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
