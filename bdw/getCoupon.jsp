<%@ taglib prefix="p" uri="/iMallTag" %>
<%--<%@ taglib prefix="sdk" uri="http://www.iloosen.com/sdk" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取登录的用户--%>
<jsp:useBean id="nowDate" class="java.util.Date"/>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${webName}- 领券 </title>
    <link href="${webRoot}/template/bdw/statics/css/base.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/statics/css/header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/coupon.css" type="text/css">

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/getCoupon.js"></script>

    <script type="text/javascript">
        var webParam = {
            webRoot: '${webRoot}'
        }
    </script>

</head>

<body>

<!--start 页头-->
<c:import url="/template/bdw/module/common/top.jsp?p=getCoupon"/>
<!--end 页头-->

<!--主体-->
<div style="width: 100%; min-width: 1190px; padding: 30px 0 1px; background-color: #f2f2f2;">
    <div class="cp-box">
        <div class="section section-detail frameEdit" frameInfo="getCoupon_middle_adv1|200X360">
            <div class="cp-top">
                <c:forEach items="${sdk:findPageModuleProxy('getCoupon_middle_adv1').advt.advtProxy}" var="advProxy"
                           varStatus="s" end="5">
                    <c:set value="${bdw:getCouponRuleByRuleLinke(advProxy.link)}" var="couponsRuleProxy"/>
                    <c:if test="${not empty couponsRuleProxy && couponsRuleProxy.endTime.time > nowDate.time}">
                        <div class="item">
                            <div class="pic"><a href=""><img src="${advProxy.advUrl}" height="200" width="360" alt="${advProxy.title}"></a></div>
                            <div class="mrt">
                                <a href="" class="title">${couponsRuleProxy.title}</a>
                                <div class="validity">优惠券效期 <fmt:formatDate value="${couponsRuleProxy.couponBatchProxy.startTime}" pattern="yyyy-MM-dd"/>--
                                    <fmt:formatDate value="${couponsRuleProxy.couponBatchProxy.endTime}" pattern="yyyy-MM-dd"/></div>
                                <p>${couponsRuleProxy.descr}</p>
                                <div class="mr-bot">
                                    <a class="getCoupon" href="javascript:;"
                                       data-batchId="${couponsRuleProxy.couponBatchId}"
                                       data-ruleLinke="${couponsRuleProxy.ruleLinke}"
                                       data-target-bindAmount=".batch-${couponsRuleProxy.couponBatchId}"><span style="padding-left: 2px; color: #fff;">立即领取</span><i></i></a>
                                    <span>领券时间至<fmt:formatDate value="${couponsRuleProxy.endTime}" pattern="yyyy-MM-dd"/></span>
                                    <span><em>已领:</em><span class="batch-${couponsRuleProxy.couponBatchId}" style="padding-left: 2px;">${couponsRuleProxy.couponBatchProxy.bindCouponAmount}</span></span>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="cp-bot">
            <div class="section section-brief frameEdit" frameInfo="getCoupon_middle_adv2">

                <ul class="clearfix">
                    <c:forEach items="${sdk:findPageModuleProxy('getCoupon_middle_adv2').advt.advtProxy}" var="advProxy2" varStatus="s">
                        <c:set value="${bdw: getCouponRuleByRuleLinke(advProxy2.link)}" var="couponsRuleProxy2"/>
                        <c:if test="${not empty couponsRuleProxy2 && couponsRuleProxy2.endTime.time > nowDate.time}">
                            <li>
                                <div class="cont">
                                    <a href="" class="title">${couponsRuleProxy2.title}</a>
                                    <p>优惠券效期 <fmt:formatDate value="${couponsRuleProxy2.couponBatchProxy.startTime}" pattern="yyyy-MM-dd"/>--
                                        <fmt:formatDate value="${couponsRuleProxy2.couponBatchProxy.endTime}" pattern="yyyy-MM-dd"/></p>
                                    <div class="ct-bot">
                                        <div class="pic"><a href=""><img src="${advProxy2.advUrl}" height="100" width="180" alt="${advProxy2.title}"></a></div>
                                        <div class="ct-rt">
                                            <span>领券时间至<em><fmt:formatDate value="${couponsRuleProxy2.endTime}" pattern="yyyy-MM-dd"/></em></span><br>
                                            <span><em>已领:</em><span class="batch-${couponsRuleProxy2.couponBatchId}">${couponsRuleProxy2.couponBatchProxy.bindCouponAmount}</span></span>
                                            <a class="getCoupon" href="javascript:;"
                                               data-batchId="${couponsRuleProxy2.couponBatchId}"
                                               data-target-bindAmount=".batch-${couponsRuleProxy2.couponBatchId}"
                                               data-ruleLinke="${couponsRuleProxy2.ruleLinke}"><span style="font-size: 15px;">立即领取</span><i></i></a>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>

<!--end 菜单导航-->
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<!--end 菜单导航-->

</body>
</html>