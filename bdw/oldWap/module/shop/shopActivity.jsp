<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<c:set value="${bdw:getShopBusinessRuleList(param.shopId)}" var="shopActivitys"/>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>店铺活动</title>
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/shop-activity.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript">
        $(function(){
            if(${isWeixin=="Y"}){
                $(".main").css("padding-top","10px");
            }
        });
    </script>
</head>

<body>
    <!--头部-->
    <c:if test="${isWeixin!='Y'}">
    <header class="header">
        <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
        <span class="title">店铺活动</span>
        <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
    </header>
    </c:if>
    <!--中间内容-->
    <div class="main">
        <c:choose>
            <c:when test="${not empty shopActivitys}">
                <ul>
                    <%--<li><a href="#">
                        <div class="pic"><img src="images/qcy.png" alt="全场邮"></div>
                        <span>全场免邮</span>
                    </a></li>--%>
                    <c:forEach items="${shopActivitys}" var="shopActivity" varStatus="status">
                        <c:choose>
                            <%--单品折扣--%>
                            <c:when test="${shopActivity.ruleTypeCode == '0'}">
                                <li>
                                    <a href="javascript:void(0);">
                                        <div class="pic"><img src="${webRoot}/template/bdw/oldWap/module/shop/statics/images/dpzhe.png" alt="单品折扣"></div>
                                        <span>${shopActivity.businessRuleNm}</span>
                                    </a>
                                </li>
                            </c:when>

                            <%--单品赠品--%>
                            <c:when test="${shopActivity.ruleTypeCode == '6'}">
                                <li>
                                    <a href="javascript:void(0);">
                                        <div class="pic"><img src="${webRoot}/template/bdw/oldWap/module/shop/statics/images/dpz.png" alt="单品赠品"></div>
                                        <span>${shopActivity.businessRuleNm}</span>
                                    </a>
                                </li>
                            </c:when>

                            <%--全场满折--%>
                            <c:when test="${shopActivity.ruleTypeCode == '2'}">
                                <li>
                                    <a href="javascript:void(0);">
                                        <div class="pic"><img src="${webRoot}/template/bdw/oldWap/module/shop/statics/images/qcz.png" alt="全场满折"></div>
                                        <span>${shopActivity.businessRuleNm}</span>
                                    </a>
                                </li>
                            </c:when>

                            <%--全场免邮--%>
                            <c:when test="${shopActivity.ruleTypeCode == '5'}">
                                <li>
                                    <a href="javascript:void(0);">
                                        <div class="pic"><img src="${webRoot}/template/bdw/oldWap/module/shop/statics/images/qcy.png" alt="全场免邮"></div>
                                        <span>${shopActivity.businessRuleNm}</span>
                                    </a>
                                </li>
                            </c:when>

                            <%--全场满赠--%>
                            <c:when test="${shopActivity.ruleTypeCode == '8'}">
                                <li>
                                    <a href="javascript:void(0);">
                                        <div class="pic"><img src="${webRoot}/template/bdw/oldWap/module/shop/statics/images/qqz.png" alt="全场满赠"></div>
                                        <span>${shopActivity.businessRuleNm}</span>
                                    </a>
                                </li>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <center>此商家暂无活动</center>
            </c:otherwise>
        </c:choose>
    </div>
</body>

</html>




