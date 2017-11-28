<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>

<c:set var="_page" value="${empty param.page?1:param.page}"/>  <%--接受页数--%>
<c:set value="${bdw:CheckShopLogin()}" var="sysShopInf"></c:set>
<c:if test="${empty sysShopInf}">
    <c:redirect url="/otoo/otooCoupon/couponsLogin.ac"></c:redirect>
</c:if>

<c:set var="otooCouponVo" value="${bdw:findOtooCouponsSearchVo()}"/>
<c:set value="${bdw:CouponsSearchParams()}" var="otooCouponSearchVo" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>自提服务中心</title>
    <meta charset="utf-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="${webRoot}/template/bdw/otoo/otooCoupon/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/otoo/otooCoupon/css/couponsSearch.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/otooCoupon/js/couponsSearch.js"></script>
</head>

<body>
<c:import url="/template/bdw/otoo/otooCoupon/common/top.jsp?p=couponsSearch"/>
<!--t_index-->
<div class="t_index_bg">
    <div class="t_index">

        <div class="t_search">
            <form action="${webRoot}/otoo/otooCoupon/couponsSearch.ac" id="searchFrom" method="post">
                <%--错误提示--%>
                <div style="width: 980px;height: 20px;">
                   <ul>
                       <li class="error" style=" float: left;width: 315px;" id="couponsNumber_error"></li>
                       <%--<li class="error" style=" float: left; margin-left: 340px;" id="code_error"></li>--%>
                   </ul>
                </div>
                <input type="hidden" value="${otooCouponVo.errorMsg}" id="errorMsg">
                <span>消费券号：</span>
                <input type="text"placeholder="请输入消费券号" id="couponsNumber" name="couponsNumber" value="${otooCouponVo.otooCouponNumber}" maxlength="16"/>
                <%--<span>验证码：</span>
                <input type="text"placeholder="请输入验证码" maxlength="4" id="code" name="code"/><img id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode' onclick="changValidateCode();return false;" style="width:89px;height:38px">--%>
                <a href="javascript:" id="search">立即查询</a>
            </form>
        </div>

        <div class="showNumClass" id="showNumDiv">
            <span></span>
        </div>

        <div class="t_result">
            <div class="tr-mt">
                <span style="padding-right: 205px;">消费劵号</span>
                <span style="padding-right: 270px;">购物券信息</span>
                <span style="padding-right: 240px;">手机号码</span>
                <span>使用状态</span>
            </div>
            <c:choose>
                <c:when test="${empty otooCouponVo.otooCouponId}">
                    <div class="no-mc" id="showErrorInfoDiv">
                        暂无消费券信息
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="tr-mc">
                        <ul>
                            <li>
                                <div class="item01">
                                    <strong>${fn:substring(otooCouponVo.otooCouponNumber,0,4)}&nbsp;&nbsp;${fn:substring(otooCouponVo.otooCouponNumber,4,8)}&nbsp;&nbsp;${fn:substring(otooCouponVo.otooCouponNumber,8,12)}&nbsp;&nbsp;${fn:substring(otooCouponVo.otooCouponNumber,12,16)}</strong>
                                    <span>生成时间：<fmt:formatDate value='${otooCouponVo.otooCreateTime}' pattern='yyyy-MM-dd HH:mm:ss'/></span>
                                </div>
                                <div class="item02">
                                    <span class="name">${otooCouponVo.productNm} </span>
                                    <span class="time">有效期截止时间：<fmt:formatDate value='${otooCouponVo.otooEndTime}' pattern='yyyy-MM-dd HH:mm:ss'/></span>
                                    <span class="num">订单编号：${otooCouponVo.otooOrderNumber}</span>
                                    <span class="pri">￥${otooCouponVo.otooCouponPrice}</span>
                                </div>
                                <div class="item03">
                                    <span>用户名：${otooCouponVo.userName}</span>
                                    <strong>${otooCouponVo.userTellNumber}</strong>
                                </div>
                                <div class="item04">
                                    <c:choose>
                                        <c:when test="${otooCouponVo.otooIsUsed == 'N'}">
                                            <a class="submitBtn" href="javascript:" onclick="useCouponFunction(this)" otooCouponId="${otooCouponVo.otooCouponId}"></a>
                                        </c:when>
                                        <c:when test="${otooCouponVo.otooIsUsed == 'Y'}">
                                            <strong>已使用</strong>
                                            <span>使用时间：${otooCouponVo.otooConsumptionTime}</span>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<c:import url="/template/bdw/otoo/otooCoupon/common/bottom.jsp?p=couponsSearch"/>


</body>
</html>

