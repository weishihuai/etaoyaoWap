<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/login.ac"></c:redirect>
</c:if>

<c:set value="${bdw:findRefundDetail(param.refundId)}" var="refundDetail"/><%--查询退款详细--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>退款详情-${webName}-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/otoo/statics/css/order-detail.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript" language="javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/otoo/statics/js/myOrderDetail.js"></script>
</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<div class="main">
    <div class="crumb">
        <span>你所在的位置：&nbsp;</span>
        <a href="${webRoot}/otoo/index.ac" title="首页">首页</a>&nbsp;&gt;
        <span>会员专区</span>
    </div>
    <div class="tit">
        <h3>退款详情</h3>
         <c:if test="${param.isRefund== 'N'}">
            `<a href="${webRoot}/module/member/otoo/otooMyCoupon.ac?pitchOnRow=48&isApplyRefund=Y&isRefund=N">
         </c:if>
         <c:if test="${param.isRefund == 'Y'}">
            <a href="${webRoot}/module/member/otoo/otooMyCoupon.ac?pitchOnRow=48&isApplyRefund=Y&isRefund=Y">
          </c:if>
         返回退款列表</a>
    </div>
        <div class="con">
            <div class="li01">
                <div class="fl">退款状态：
                    <strong>
                        ${refundDetail.otooCouponstuta}
                    </strong>
                </div>
            </div>

            <div class="li02">
                <c:forEach var="item" items="${refundDetail.couponMap}">
                    <c:forEach items="${item.value}" var="couponNum">
                        <p><span style="padding-right: 10px;">券号:</span>${couponNum}</p>
                    </c:forEach>
                </c:forEach>
            </div>

            <div class="li03">
                <p class="top">
                    <span class="span01">订单编号：${refundDetail.otooOrderNum}</span>
                    <span class="span02">下单时间：${refundDetail.strCreateTime}</span>
                    <span class="span03">退款申请时间：${refundDetail.isApplyRefundTime}</span>
                    <c:if test="${param.isRefund == 'Y'}">
                        <span class="span04">退款处理时间：${refundDetail.isRefundTime}</span>
                    </c:if>
                    <span class="span05">退款总金额：<strong>￥${refundDetail.refundTotalPrice}</strong></span>
                </p>
                <p class="bottom">
                    <span style="padding-right: 10px;">退款原因:</span>${refundDetail.refundReadson}
                </p>
            </div>
        </div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
