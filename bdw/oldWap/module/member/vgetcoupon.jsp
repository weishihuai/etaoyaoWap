<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="vsdk" %>
<c:set value="${vsdk:getCurrentActivityProxy()}" var="vcouponActivityProxy"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>购物券领取</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/vgetcoupon.js"></script>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">

    <script>
        var dataValue = {
            webRoot: "${webRoot}" //当前路径
        };
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=购物券领取"/>
<%--页头结束--%>
<div class="container gwj_box">
    <c:choose>
        <c:when test="${!vcouponActivityProxy.haveActivity}">
            <div class="row">
                <div class="col-xs-12 "
                     style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">
                    暂无领券活动
                </div>
            </div>
        </c:when>
        <c:when test="${vcouponActivityProxy.haveActivity}">

            <div class="row quan_bg" <c:if test="${!vcouponActivityProxy.bgColorIsAcitve}">style="background:#999999;"</c:if>>
                <div class="col-xs-5">
                    <div class="q_je">
                        <i class="je">${vcouponActivityProxy.amount}</i>
                        <em class="yuan">元</em>
                    </div>
                </div>
            </div>

            <div class="row">
                <c:choose>
                    <c:when test="${vcouponActivityProxy.bgColorIsAcitve}">
                        <div class="col-xs-12 icon_bg"></div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-12 icon_bg2"></div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="row b_layer">
                <div class="col-xs-2"><span class="glyphicon glyphicon-time pull-right time_icon"></span></div>
                <div class="col-xs-10 l_text">活动时间: ${vcouponActivityProxy.startTime}
                    至 ${vcouponActivityProxy.endTime}</div>
            </div>

            <div class="row b_layer" style="margin-bottom:10px; border-radius:0 0 10px 10px;">

                <div class="col-xs-12">

                    <c:choose>
                        <c:when test="${vcouponActivityProxy.btnIsActive}">
                            <div class="col-xs-12" id="lqdiv">
                                <a role="button" class="btn btn-block l_btn" style="background:#e53621; color:#fff; border:#e53621 1px solid;" href="javascript:lingquan('${vcouponActivityProxy.vcouponActivityVoList[0].activityId}');">${vcouponActivityProxy.btnText}</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a role="button" class="btn btn-default btn-block l_btn disabled" href="javascript:void(0);">${vcouponActivityProxy.btnText}</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <c:import url="${webRoot}/template/bdw/oldWap/module/common/vgetcoupon_bottom.jsp"></c:import>
        </c:when>
    </c:choose>
</div>

</body>
</html>