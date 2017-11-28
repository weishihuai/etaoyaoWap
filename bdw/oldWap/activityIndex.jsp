<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${param.tabSelect}"  var="tabSelect"/>
<c:set value="${empty param.dateRange ? 1 : param.dateRange}" var="dateRange"/>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:if test="${empty tabSelect || tabSelect == 'process'}"><c:set value="${sdk:getMarketingActivityProxyList(page,16,'Y','N','N')}" var="processMarketActivity"/>    <%--正在进行的活动--%></c:if>
<c:if test="${empty tabSelect || tabSelect == 'last'}"><c:set value="${sdk:getMarketingActivityProxyList(page,16,'Y','Y','N')}" var="lastMarketActivity"/>  <%--最后一天的活动--%></c:if>
<c:if test="${empty tabSelect || tabSelect == 'already'}"><c:set value="${sdk:getStartMarketingActivity(page,16,dateRange)}" var="alreadyMarketActivity"/>  <%--即将开始的活动--%></c:if>

<!DOCTYPE html>
<html>
<head>
    <title>${webName}-活动首页-${sdk:getSysParamValue('index_title')}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/buying.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/activityIndex.js"></script>
  </head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=促销活动"/>
<%--页头结束--%>
<div class="row t-nav">
	<div class="col-xs-4 <c:if test="${empty tabSelect || tabSelect == 'process'}">cur</c:if>"><a class="process" href="${webRoot}/wap/activityIndex.ac?tabSelect=process">正在进行</a></div>
    <div class="col-xs-4 <c:if test="${empty tabSelect || tabSelect == 'last'}">cur</c:if>"><a class="last" href="${webRoot}/wap/activityIndex.ac?tabSelect=last">最后一天</a></div>
    <div class="col-xs-4 <c:if test="${empty tabSelect || tabSelect == 'already'}">cur</c:if>"><a class="already" href="${webRoot}/wap/activityIndex.ac?tabSelect=already&at=fTab">即将开始</a></div>
</div>

<div class="container processActivity" style="display: ${empty processMarketActivity.result ? 'none' : 'block'}">
    <c:forEach items="${processMarketActivity.result}" var="activity" varStatus="num">
        <div class="row g-box">
            <div class="col-xs-6 g-lf">
                <div class="col-xs-12 g-title"><a href="${webRoot}/wap/activityList.ac?tabSelect=process&activityId=${activity.marketingActivityId}">${activity.activityNm}</a></div>
                <div class="col-xs-4"><span>倒计时：</span></div>
                <div class="col-xs-8 g-time">
                    <input type="hidden"  value="${activity.activityEndTimeStr}" name="time"/>
                    <p class="time"><a class="lastTime"></a></p>
                </div>
                <div class="zk"><i><span>${activity.discountRequirement}</span>折</i>起</div>
            </div>
            <div class="col-xs-6 g-rf">
                <a href="${webRoot}/wap/activityList.ac?tabSelect=process&activityId=${activity.marketingActivityId}">
                    <c:if test="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')!=''}" >
                        <img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')}" width="130px" height="130px"/>
                    </c:if>
                    <c:if test="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')==''}">
                        <img src="${webRoot}/template/bdw/statics/images/noPic_130X130.jpg">
                    </c:if>
                </a>
            </div>
        </div>
    </c:forEach>
</div>

<div class="container lastActivity" style="display: ${empty lastMarketActivity.result ? 'none' : 'block'}">
    <c:forEach items="${lastMarketActivity.result}" var="activity" varStatus="num">
        <div class="row g-box">
            <div class="col-xs-6 g-lf">
                <div class="col-xs-12 g-title"><a href="${webRoot}/wap/activityList.ac?tabSelect=process&activityId=${activity.marketingActivityId}">${activity.activityNm}</a></div>
                <div class="col-xs-4"><span>倒计时：</span></div>
                <div class="col-xs-8 g-time">
                    <input type="hidden"  value="${activity.activityEndTimeStr}" name="time"/>
                    <p class="time"><a class="lastTime"></a></p>
                </div>
                <div class="zk"><i><span>${activity.discountRequirement}</span>折</i>起</div>
            </div>
            <div class="col-xs-6 g-rf">
                <a href="${webRoot}/wap/activityList.ac?tabSelect=process&activityId=${activity.marketingActivityId}">
                    <c:if test="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')!=''}" >
                        <img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')}" width="130px" height="130px"/>
                    </c:if>
                    <c:if test="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')==''}">
                        <img src="${webRoot}/template/bdw/statics/images/noPic_130X130.jpg">
                    </c:if>
                </a>
            </div>
        </div>
    </c:forEach>
</div>

<div class="container alreadyActivity" style="display: ${empty alreadyMarketActivity.result ? 'none' : 'block'}">
    <c:forEach items="${alreadyMarketActivity.result}" var="activity" varStatus="num">
        <div class="row g-box">
            <div class="col-xs-6 g-lf">
                <div class="col-xs-12 g-title"><a href="${webRoot}/wap/activityList.ac?tabSelect=process&activityId=${activity.marketingActivityId}">${activity.activityNm}</a></div>
                <div class="col-xs-4"><span>倒计时：</span></div>
                <div class="col-xs-8 g-time">
                    <input type="hidden"  value="${activity.activityEndTimeStr}" name="time"/>
                    <p class="time"><a class="lastTime"></a></p>
                </div>
                <div class="zk"><i><span>${activity.discountRequirement}</span>折</i>起</div>
            </div>
            <div class="col-xs-6 g-rf">
                <a href="${webRoot}/wap/activityList.ac?tabSelect=process&activityId=${activity.marketingActivityId}">
                    <c:if test="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')!=''}" >
                        <img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')}" width="130px" height="130px"/>
                    </c:if>
                    <c:if test="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'130X130')==''}">
                        <img src="${webRoot}/template/bdw/statics/images/noPic_130X130.jpg">
                    </c:if>
                </a>
            </div>
        </div>
    </c:forEach>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
