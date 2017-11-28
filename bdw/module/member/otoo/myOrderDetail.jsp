<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/login.ac"></c:redirect>
</c:if>

<c:set value="${bdw:findOrderDetailed(param.id)}" var="orderProxy"/><%--查询订单详细--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>订单详情-${webName}-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
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
        <h3>订单详情</h3>
        <c:if test="${param.isPayed == 'N'}">
            <a href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=N&orderStatus=0">
        </c:if>
        <c:if test="${param.isUsed == 'N'}">
            <a href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=Y&used=N">
        </c:if>
        <c:if test="${param.isUsed == 'Y'}">
            <a href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=Y&used=Y">
        </c:if>
        <c:if test="${param.isCanceld == 'Y'}">
            <a href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&orderStatus=2">
        </c:if>
        <c:if test="${param.isDeleted == 'Y'}">
            <a href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isDeleted=Y">
        </c:if>
        <c:if test="${param.isRefund == 'Y'}">
            <a href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=Y&isRefunded=Y">
        </c:if>
            返回我的订单</a>
    </div>
        <div class="con">
            <div class="li01">
                <div class="fl">订单状态：
                    <strong>
                        <c:choose>
                            <c:when test="${orderProxy.isDelete == 'Y'}">
                                已删除
                            </c:when>
                            <c:otherwise>
                               <c:choose>
                                   <c:when test="${orderProxy.orderStatus == '2'}">
                                       已取消
                                   </c:when>
                                   <c:otherwise>
                                       <c:choose>
                                           <c:when test="${orderProxy.isPayed == 'N'}">
                                                未付款
                                           </c:when>
                                           <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${orderProxy.isAllRefund == 'N'}">
                                                            <c:choose>
                                                                <c:when test="${orderProxy.isAllUsed == 'Y'}">
                                                                    已使用
                                                                </c:when>
                                                                <c:otherwise>
                                                                    未使用
                                                                </c:otherwise>
                                                            </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        已退款
                                                    </c:otherwise>
                                                </c:choose>
                                           </c:otherwise>
                                       </c:choose>
                                   </c:otherwise>
                               </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </strong>
                </div>
                <c:choose>
                    <c:when test="${orderProxy.isDelete == 'Y'}">
                        <a href="javascript:void(0)" class="fr" style="color:#2362af;" onclick="returnOrder(${orderProxy.otooOrderId})">还原订单</a>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${param.isUsed == 'N'}">
                            <div class="fr">
                                <a href="javascript:void(0)" title="申请退款" id="applyRefund" onclick="applyRefund();">申请退款</a>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:choose>
                <%-- 未支付 --%>
                <c:when test="${orderProxy.isPayed == 'N'}">
                    <div class="li02">
                    <p class="first">温馨提示：记下或拍下消费券密码后向商家出示即可消费</p>
                    </div>
                </c:when>

                <%-- 已支付 --%>
                <c:when test="${orderProxy.isPayed == 'Y'}">
                    <div class="li02">
                        <p class="first">温馨提示：记下或拍下消费券密码后向商家出示即可消费</p>
                        <c:forEach items="${orderProxy.couponsProxyList}" var="couponsProxy" varStatus="num">
                            <c:choose>
                                <c:when test="${couponsProxy.isRefund == 'N'}">
                                    <c:choose>
                                        <c:when test="${couponsProxy.isApplyRefund == 'N'}">
                                            <c:choose>
                                                <c:when test="${couponsProxy.isUsed == 'N'}">
                                                    <%--<p>
                                                        <span>消费券号：</span><strong>${couponsProxy.couponNumber}</strong>
                                                        <a href="javascript:void(0)" title="申请退款" id="applyRefundItemId${couponsProxy.couponId}" onclick="applyRefund(${couponsProxy.couponId})" productNameData="${couponsProxy.productNm}" couponNumData="${couponsProxy.couponNumber}" productPriceData="${couponsProxy.couponPrice}">申请退款</a>
                                                    </p>--%>
                                                    <p><input type="checkbox" name="refund" style="vertical-align: middle;" class="applyRefundItemId${num.index}" couponId="${couponsProxy.couponId}" productNameData="${couponsProxy.productNm}" couponNumData="${couponsProxy.couponNumber}" productPriceData="${couponsProxy.couponPrice}" onclick="checkCoupon(${num.index});"/><label style="vertical-align: middle;">${couponsProxy.couponNumber}</label></p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p><span>消费券号：</span><strong>${couponsProxy.couponNumber}</strong><i>已使用</i></p>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <p><span>消费券号：</span><strong>${couponsProxy.couponNumber}</strong><i>已申请退款</i></p>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <p><span>消费券号：</span><strong>${couponsProxy.couponNumber}</strong><i>已退款</i></p>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </c:when>
            </c:choose>

            <div class="li03">
                <p class="top">
                    <span class="span01">订单编号：${orderProxy.otooOrderNum}</span>
                    <span class="span02">下单时间：${orderProxy.otooOrderCreateTime}</span>
                    <span class="span03">手机号：${orderProxy.buyUserTel}</span>
                    <c:if test="${orderProxy.isPayed == 'Y'}">
                        <span class="span05">付款时间：${orderProxy.payTime}</span>
                        <span class="span04">付款方式：${orderProxy.payment}</span>
                    </c:if>
                </p>
                <p class="bottom">
                    <a href="${webRoot}/otoo/product.ac?id=${orderProxy.otooProductId}" target="_blank" class="span01" title="${orderProxy.otooProductName}">${orderProxy.otooProductName}</a>
                    <span class="span02">${orderProxy.salePoint}</span>
                    <span class="span03">单价：${orderProxy.unitPrice}</span>
                    <span class="span04">数量：${orderProxy.otooOrderAmount}</span>
                    <span class="span05">金额： <strong>￥${orderProxy.totalPrice}</strong></span>
                </p>
            </div>
            <c:set value="${sdk:getSysParamValue('otooOrderDetailContent')}" var="otooOrderDetailContent"/>
            <c:if test="${otooOrderDetailContent != null || otooOrderDetailContent != ''}">
                <div class="li04">
                    <strong style="color: #333;font-weight: bold;">订单说明：</strong>${otooOrderDetailContent}
                </div>
            </c:if>
        </div>
</div>

<%--申请退款弹出层--%>
<div class="refund" id="refund" style="display: none;">
    <div class="e-tit">
        <h3>申请退款</h3>
        <a href="javascript:void(0)" title="关闭" onclick="hideLayer();">关闭</a>
    </div>
    <div class="e-con">
        <ul>
            <li>
                <span class="label">商品名称</span>
                <span class="val" id="productNameSpan">XXXXXXXXXXX</span>
            </li>
            <li class="sum">
                <span class="label">退款金额</span>
                <span class="val" id="productPriceSpan">XXXXXXXXXXX</span>
            </li>
        </ul>
        <ul>
            <li>
                <span class="label">消费券号</span>
                <span class="val" id="couponNumSpan">XXXXXXXXXXX</span>
            </li>
        </ul>
        <div class="reason">
            <span class="label">退款原因</span>
            <textarea placeholder="字节长度请在5～200字范围之间。" id="otooRefundReason"></textarea>
        </div>
        <a class="btn" href="javascript:void(0)" id="applyRefundBtn" couponIdData="" onclick="applyRefundBtn()">确认提交</a>
    </div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
