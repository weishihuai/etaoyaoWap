<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/login.ac"></c:redirect>
</c:if>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>  <%--获取页码--%>
<c:set value="${empty param.isApplyRefund ? 'Y' : param.isApplyRefund}" var="isApplyRefund"/>
<c:set value="${empty param.isRefund ? 'N' : param.isRefund}" var="isRefund"/> <%--获取消费券类型--%>
<c:set value="${bdw:getRefundCouponPage(_page,10, param.isApplyRefund,param.isRefund)}" var="otooCouponProxys"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>O2O退款列表-${webName}-${sdk:getSysParamValue('index_title')}</title>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/layer.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/otoo/statics/css/refund-list.css" type="text/css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
        var myValue={
            //消费券类型：已申请退款，已退款
            isApplyRefund:"${isApplyRefund}",
            isRefund:"${isRefund}"
        };
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/otoo/statics/js/otooMyCoupon.js"></script><%--我的购物劵页面js--%>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.ac">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > O2O退款列表</div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="right">
        <div class="tit">
            <ul>
                <li><a <c:if test="${param.isApplyRefund == 'Y' && param.isRefund == 'N'}">class="cur"</c:if> href="${webRoot}/module/member/otoo/otooMyCoupon.ac?pitchOnRow=48&isApplyRefund=Y&isRefund=N">已申请</a></li>
                <li><a <c:if test="${param.isApplyRefund == 'Y' && param.isRefund == 'Y'}">class="cur"</c:if> href="${webRoot}/module/member/otoo/otooMyCoupon.ac?pitchOnRow=48&isApplyRefund=Y&isRefund=Y">已退款</a></li>
            </ul>
        </div>
        <!--tit end-->
        <div class="s-tit">
            <span class="tit01">商品名称</span>
            <span class="tit02">订单编号</span>
            <span class="tit03">退款金额</span>
            <span class="tit04">退款状态</span>
            <c:choose>
                <c:when test="${param.isApplyRefund == 'Y' && param.isRefund == 'N'}">
                    <span class="tit05">申请时间</span>
                </c:when>
                <c:otherwise>
                    <span class="tit05">处理时间</span>
                </c:otherwise>
            </c:choose>
            <span class="tit06">操作</span>
        </div>

        <%--已申请--%>
        <c:if test="${param.isApplyRefund == 'Y' && param.isRefund == 'N'}">
            <c:forEach items="${otooCouponProxys.result}" var="otooCouponProxy">
                <div class="item">
                    <div class="i-tit">
                        下单时间:${otooCouponProxy.strCreateTime}<i></i>
                    </div>
                    <div class="i-con">
                        <div class="con01">
                            <a class="img" href="${webRoot}/otoo/product.ac?id=${otooCouponProxy.otooProductId}" target="_blank"  title="${otooCouponProxy.productNm}"><img src="${fn:replace(otooCouponProxy.productImages,'_50X50','')}"  alt="${otooCouponProxy.productNm}"></a>
                            <em><a href="${webRoot}/otoo/product.ac?id=${otooCouponProxy.otooProductId}" target="_blank"  title="${otooCouponProxy.productNm}">${otooCouponProxy.productNm}</a></em>
                        </div>
                        <div class="con02">${otooCouponProxy.otooOrderNum}</div>
                        <div class="con03">&yen;${otooCouponProxy.refundTotalPrice}</div>
                        <div class="con04">${otooCouponProxy.otooCouponstuta}</div>
                        <div class="con05">${otooCouponProxy.isApplyRefundTime}</div>
                        <div class="con06">
                            <a href="${webRoot}/module/member/otoo/myRefundDetail.ac?refundId=${otooCouponProxy.otooRefundId}&isApplyRefund=Y&isRefund=N" title="查看详情">查看详情</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <%--已退款--%>
        <c:if test="${param.isApplyRefund == 'Y' && param.isRefund == 'Y'}">
            <c:forEach items="${otooCouponProxys.result}" var="otooCouponProxy">
                <div class="item">
                    <div class="i-tit">
                        下单时间:${otooCouponProxy.strCreateTime}<i></i>
                    </div>
                    <div class="i-con">
                        <div class="con01">
                            <a class="img" href="${webRoot}/otoo/product.ac?id=${otooCouponProxy.otooProductId}" target="_blank"  title="${otooCouponProxy.productNm}"><img src="${fn:replace(otooCouponProxy.productImages,'_50X50','')}"  alt="${otooCouponProxy.productNm}"></a>
                            <em><a href="${webRoot}/otoo/product.ac?id=${otooCouponProxy.otooProductId}" target="_blank"  title="${otooCouponProxy.productNm}">${otooCouponProxy.productNm}</a></em>
                        </div>
                        <div class="con02">${otooCouponProxy.otooOrderNum}</div>
                        <div class="con03">&yen;${otooCouponProxy.refundTotalPrice}</div>
                        <div class="con04">${otooCouponProxy.otooCouponstuta}</div>
                        <div class="con05">${otooCouponProxy.isRefundTime}</div>
                        <div class="con06">
                            <a href="${webRoot}/module/member/otoo/myRefundDetail.ac?refundId=${otooCouponProxy.otooRefundId}&isApplyRefund=Y&isRefund=Y" title="查看详情">查看详情</a></div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>
    <c:if test="${otooCouponProxys.lastPageNumber > 1}">
        <div style="width: 770px;height:30px;padding-top:10px;text-align: right;">
            <p:PageTag
                    isDisplayGoToPage="true"
                    isDisplaySelect="false"
                    ajaxUrl="${webRoot}/template/bdw/module/member/otoo/otooMyCoupon.jsp?pitchOnRow=48"
                    totalPages='${otooCouponProxys.lastPageNumber}'
                    currentPage='${_page}'
                    totalRecords='${otooCouponProxys.totalCount}'
                    frontPath='${webRoot}'
                    displayNum='6'/>
        </div>
    </c:if>
    <div class="clear"></div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/otoo/otooCoupon/common/bottom.jsp?p=index"/>
<%--底部 end--%>

</body>
</html>
