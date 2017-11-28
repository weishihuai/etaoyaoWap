<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>

<c:set var="_page" value="${empty param.page?1:param.page}"/>
<c:set value="${bdw:CheckShopLogin()}" var="sysShopInf"></c:set>
<c:if test="${empty sysShopInf}">
    <c:redirect url="/otoo/otooCoupon/couponsLogin.ac"></c:redirect>
</c:if>

<c:set value="${bdw:findOtooCouponsSearch(4)}" var="shopCouponsPage"/>
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
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/otooCoupon/js/couponsSearch.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/otooCoupon/js/couponsSearchList.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#status_"+${otooCouponSearchVo.status}).addClass("cur");
        })
    </script>
</head>

<body>

<c:import url="/template/bdw/otoo/otooCoupon/common/top.jsp?p=couponsSearchList"/>

<!--t_index-->
<div class="t_index_bg">
    <div class="t_index">
        <div class="id_top">
            <ul>
                <li id="status_-1">
                    <a href="javascript:void(0)" onclick="StatusSearch(-1)">全部券<em>（<i>${bdw:CouponsCount(-1)}</i>）</em></a>
                </li>
               <li id="status_0">
                    <a href="javascript:void(0)" onclick="StatusSearch(0)">未使用<em>（<i>${bdw:CouponsCount(0)}</i>）</em></a>
                </li>
                <li id="status_1">
                    <a href="javascript:void(0)" onclick="StatusSearch(1)">已使用<em>（<i>${bdw:CouponsCount(1)}</i>）</em></a>
                </li>
                <li  id="status_2">
                    <a href="javascript:void(0)" onclick="StatusSearch(2)">已退款<em>（<i>${bdw:CouponsCount(2)}</i>）</em></a>
                </li>
                <li class="last" id="status_3">
                    <a href="javascript:void(0)" onclick="StatusSearch(3)">已申请退款<em>（<i>${bdw:CouponsCount(3)}</i>）</em></a>
                </li>
            </ul>
        </div>
        <div class="t_search">
            <form action="${webRoot}/otoo/otooCoupon/couponsSearchList.ac" id="searchFrom" method="post">
                <div style="width: 980px;height: 20px;">
                    <ul style="width: 980px; height: 20px; position: relative;">
                        <li class="error" style=" width: 315px; position: absolute; left: 0px; top: 0;;" id="couponsNumber_error"></li>
                        <li class="error" style=" position: absolute; left: 340px; top: 0;" id="userTell_error"></li>
                    </ul>
                </div>
                <input type="hidden" id="status" name="status" value="${otooCouponSearchVo.status}">
                <span>消费券号：</span>
                <input type="text"placeholder="请输入消费券号" id="couponsNumber" name="couponsNumber" value="${otooCouponSearchVo.otooCouponNumber}"/>
                <span>手机号码：</span>
                <input type="text"placeholder="请输入手机号码" maxlength="11" id="userTell" name="userTell"  value="${otooCouponSearchVo.userTellNumber}"/>
                <a href="javascript:" id="search">立即查询</a>
            </form>
        </div>
        <div class="t_result">
            <div class="tr-mt">
                <span style="padding-right: 205px;">消费劵号</span>
                <span style="padding-right: 270px;">购物券信息</span>
                <span style="padding-right: 240px;">手机号码</span>
                <span>使用状态</span>
            </div>
            <c:choose>
                <c:when test="${empty shopCouponsPage.result}">
                    <div class="no-mc">
                        暂无消费券信息<br>
                        请输入消费券号或手机号码进行查询
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="tr-mc">
                        <ul>
                            <c:forEach items="${shopCouponsPage.result}" var="coupons" varStatus="status">
                                <li>
                                    <div class="item01">
                                        <strong>${fn:substring(coupons.otooCouponNumber,0,4)}&nbsp;&nbsp;****&nbsp;&nbsp;****&nbsp;&nbsp;${fn:substring(coupons.otooCouponNumber,12,16)}</strong>
                                        <span>生成时间：<fmt:formatDate value='${coupons.otooCreateTime}' pattern='yyyy-MM-dd HH:mm:ss'/></span>
                                    </div>
                                    <div class="item02">
                                        <span class="name">${coupons.productNm} </span>
                                        <span class="time">有效期截止时间：<fmt:formatDate value='${coupons.otooEndTime}' pattern='yyyy-MM-dd HH:mm:ss'/></span>
                                        <span class="num">订单编号：${coupons.otooOrderNumber}</span>
                                        <span class="pri">￥${coupons.otooCouponPrice}</span>
                                    </div>
                                    <div class="item03">
                                        <span>用户名：${coupons.userName}</span>
                                        <strong>${coupons.userTellNumber}</strong>
                                    </div>
                                    <div class="item04">
                                        <c:choose>
                                            <c:when test="${coupons.otooIsRefund == 'N'}">
                                                <c:choose>
                                                    <c:when test="${coupons.otooIsApplyRefund == 'N'}">
                                                        <c:choose>
                                                            <c:when test="${coupons.otooIsUsed == 'N'}">
                                                                <strong>未使用</strong>
                                                            </c:when>
                                                            <c:when test="${coupons.otooIsUsed == 'Y'}">
                                                            <strong>已使用</strong>
                                                            <span>使用时间：<fmt:formatDate value='${coupons.otooConsumptionTime}' pattern='yyyy-MM-dd HH:mm:ss'/></span>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${coupons.otooIsApplyRefund == 'Y'}">
                                                            <strong>已申请退款</strong>
                                                            <span>申请时间：<fmt:formatDate value='${coupons.otooApplyRefundTime}' pattern='yyyy-MM-dd HH:mm:ss'/></span>
                                                    </c:when>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${coupons.otooIsRefund == 'Y'}">
                                                <strong>已退款</strong>
                                                <span>退款时间：<fmt:formatDate value='${coupons.otooRefundDealTime}' pattern='yyyy-MM-dd HH:mm:ss'/></span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </li>

                            </c:forEach>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${shopCouponsPage.lastPageNumber > 1}">
        <div class="page" style="height: 100px;margin-left: 270px;">
            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/otoo/otooCoupon/couponsSearchList.ac" totalPages='${shopCouponsPage.lastPageNumber}' currentPage='${_page}'  totalRecords='${shopCouponsPage.totalCount}' frontPath='${webRoot}' displayNum='6' />
            </c:if>
        </div>
    </div>
</div>

<c:import url="/template/bdw/otoo/otooCoupon/common/bottom.jsp?p=couponsSearchList"/>


</body>
</html>

