<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findOrderDetailed(param.id)}" var="orderProxy"/><%--查询订单详细--%>
<c:set value="${bdw:findByPickedUpId(orderProxy.pickedUpId)}" var="pickedUp"/>

<c:set value="${sdk:getSysParamValue('webName')}" var="webName"/><%--网站名称--%>
<c:set value="${sdk:getSysParamValue('auditGroupBuy')}" var="auditGroupBuy"/><%--团购审核参数--%>
<c:set value="${sdk:getSysParamValue('orderSignDate')}" var="orderSignDate"/><%--自动确认收货时间--%>
<c:set value="${sdk:isAllowShopComment(param.id)}" var="isAllowShopComment"/> <%--判断是否可以对商家评论--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-订单详细-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/payment.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/orderDetail.js"></script>
    <script type="text/javascript" language="javascript">
        var dataValue={
            webRoot:"${webRoot}",
            orderId:"${param.id}",
            logisticsCompany:"${orderProxy.logisticsCompany}",
            logisticsNum:"${orderProxy.logisticsNum}",
            companyHomeUrl:"${orderProxy.companyHomeUrl}",
            isJdOrder:${orderProxy.jdOrder}
        }

    </script>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/" title="首页">首页</a> > <a href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> > 订单详细 </div></div>


<div id="member">

<%--左边菜单栏 start--%>
<c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
<%--左边菜单栏 end--%>

<div class="rBox">
<div class="bnyDetail">
<h3>
    <div class="f">订单查询</div>

    <%--取消订单 start--%>
    <div class="cennl">
        <c:if test="${orderProxy.orderStat=='未确认' && orderProxy.pay == false}">
           <a href="javascript:" onclick="cancelOrder('${orderProxy.orderId}')" title="取消">取消</a>
        </c:if>
        <c:if test="${orderProxy.orderStat=='待买家确认收货' && empty orderProxy.pickedUpId}">
            <a href="javascript:" id="buyerSignedBtn" onclick="buyerSigned('${orderProxy.orderId}')" title="确认收货">确认收货</a>
        </c:if>
        <c:if test="${orderProxy.orderStat=='交易完成'}">
            <c:if test="${isAllowShopComment}">
                <a href="${webRoot}/${templateCatalog}/module/member/newAddComment.jsp?orderId=${orderProxy.orderId}" title="再次评论">再次评论</a>
            </c:if>
        </c:if>
        <c:if test="${orderProxy.orderStat=='已取消'}">
            <c:if test="${orderProxy.orderItemProxyList[0].productProxy.isCanBuy}">
                <a href="${webRoot}/product.ac?id=${orderProxy.orderItemProxyList[0].productProxy.productId}" title="重新购买">重新购买</a>
            </c:if>
        </c:if>
    </div>
    <%--取消订单 end--%>

    <div class="clear"></div>
</h3>
<div class="m1">
    <div class="l">
        <h1>
            订单号：${orderProxy.orderNum} &nbsp;&nbsp;&nbsp;
            <c:choose>
                <c:when test="${orderProxy.orderStat=='待买家确认收货' && not empty orderProxy.pickedUpId}">
                    处理状态：<span>待自提点提货</span> &nbsp;&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    处理状态：<span>${orderProxy.orderStat}</span> &nbsp;&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            支付状态：<span>${orderProxy.pay?'已支付':'未支付'}</span>
        </h1>
        
        <c:choose>
            <c:when test="${orderProxy.isCod}">
                 <c:choose>
                     <c:when test="${orderProxy.orderStat=='已取消'}"><p>尊敬的客户！该订单已经被取消。非常感谢您对我们 ${webName} 的支持！祝您购物愉快！</p></c:when>
                     <c:when test="${orderProxy.orderStat=='已发货'}"><p>尊敬的客户！您的订单已发货，请您注意查收！<br/><span style="color:#CC0000;font-weight: bold;">注：订单发货${orderSignDate}天后，如果没有进行确认收货，系统会自动收货！如果货物有问题，请及时联系商家！</span></p></c:when>
                     <c:when test="${orderProxy.orderStat=='交易完成'}"> <p>尊敬的客户！您的订单已支付成功。非常感谢您对我们 ${webName} 的支持！祝您购物愉快！</p></c:when>
                     <c:when test="${orderProxy.orderStat=='买家已确认收货'}"> <p>尊敬的客户！您的订单已确认收货。非常感谢您对我们 ${webName} 的支持！祝您购物愉快！</p></c:when>
                     <c:otherwise><p>尊敬的客户！我们会尽快安排为您发货，请您注意查收</p></c:otherwise>
                 </c:choose>
            </c:when>
            <c:otherwise>
                  <c:choose>
                      <c:when test="${orderProxy.orderStat=='已取消'}"><p>尊敬的客户！该订单已经被取消。非常感谢您对我们 ${webName} 的支持！祝您购物愉快！</p></c:when>
                      <c:when test="${orderProxy.orderStat=='待发货'}"><p>尊敬的客户！您的订单已支付成功，我们会尽快安排为您发货，请您注意查收。非常感谢您对我们 ${webName} 的支持！祝您购物愉快！</p></c:when>
                       <c:when test="${orderProxy.orderStat=='交易完成'}"> <p>尊敬的客户！您的订单已交易成功。非常感谢您对我们 ${webName} 的支持！祝您购物愉快！</p></c:when>
                      <c:otherwise>
                          <c:choose>
                                <c:when test="${orderProxy.orderType=='团购订单'}">
                                    <%--<p>该订单会为您保留${auditGroupBuy}小时，${auditGroupBuy}小时之后如果还未付款，系统将自动取消该订单。</p>--%>
                                    <p>尊敬的客户，我们还未收到该订单款项，请尽快付款，我们会在付款后尽快安排发货,该订单会为您保留${auditGroupBuy}小时，${auditGroupBuy}小时之后如果还未付款，系统将自动取消该订单<br/><span style="color:#CC0000;font-weight: bold;">注：订单发货${orderSignDate}天后，如果没有进行确认收货，系统会自动收货！如果货物有问题，请及时联系商家！</span></p>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${orderProxy.pay == false}">
                                            <p>尊敬的客户，我们还未收到该订单款项，请尽快付款，我们会在付款后尽快安排发货,该订单会为您保留${auditGroupBuy}小时，${auditGroupBuy}小时之后如果还未付款，系统将自动取消该订单<br/><span style="color:#CC0000;font-weight: bold;">注：订单发货${orderSignDate}天后，如果没有进行确认收货，系统会自动收货！如果货物有问题，请及时联系商家！</span></p>
                                        </c:when>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                  </c:choose>
            </c:otherwise>
        </c:choose>
<%--  <p>尊敬的客户，我们还未收到该订单的款项，请您尽快付款（<a href="javascript:;" title="在线支付帮助">在线支付帮助</a>），如果您已经付款，请务必填写<span>付款确认</span>。(银行电汇的表单)</p>
        <p>该订单会为您保留24小时（从下单之日算起），24小时之后如果还未付款，系统将自动取消该订单。</p>--%>
    </div>
    <div class="r">
<%--        <h1>您选择的支付方式：${orderProxy.payment.payWayNm}</h1>
        <div class="pay">
            <div class="w-P"><img src="${orderProxy.payment.icon['100X100']}" width="125" height="38" /></div>
            &lt;%&ndash;<div class="r-M"><a href="#">选择其他</a></div>&ndash;%&gt;
            <div class="clear"></div>
        </div>--%>
        <p>订单总金额：<b>¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></b></p>
        <c:if test="${not orderProxy.pay && orderProxy.orderStat != '已取消'}">
            <c:if test="${!orderProxy.isCod}">
                <div class="btn">
                    <a href="${webRoot}/shoppingcart/cashier.ac?orderIds=${orderProxy.orderId}"></a>
                <%--    <div style="display: none">
                            ${orderProxy.payment.paymentHtml}
                    </div>--%>
                </div>
            </c:if>
        </c:if>

    </div>
    <div class="clear"></div>
</div>

<%--订单流程图 start--%>
<div class="m2">
    <div class="ic">
        <c:choose>
            <c:when test="${orderProxy.orderStat=='未确认'||orderProxy.orderStat=='已取消'}">
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
            </c:when>
            <c:when test="${orderProxy.orderStat=='待发货'||orderProxy.orderStat=='未支付'}">
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
            </c:when>
            <c:when test="${orderProxy.orderStat=='交易完成'}">
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
            </c:when>
            <c:when test="${orderProxy.orderStat=='待买家确认收货'}">
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
            </c:when>
            <c:when test="${orderProxy.orderStat=='买家已确认收货'}">
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon04.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon03.gif"/></div>
                <div class="ico2"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon01.gif"/></div>
                <div class="ico1"><img src="${webRoot}/template/bdw/module/member/statics/images/member_order_icon02.gif"/></div>
            </c:when>
        </c:choose>
    </div>
    <div class="font">
        <ul>
            <li>提交订单<br /></li>
            <li>商品出库<br /></li>
            <li>等待收货</li>
            <li>买家已确认收货</li>
            <li class="last">完成</li>
        </ul>
    </div>
</div>
<%--订单流程图 end--%>

<%--订单物流跟踪 start--%>
<div class="m3">
    <h1>订单跟踪</h1>
    <div class="box" id="tracking"></div>
</div>
<%--订单物流跟踪 end--%>

<%--订单信息 start--%>
<div class="m4">
    <h1>订单信息</h1>
    <div class="box">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td1">订单号</td>
                <td class="td2">${orderProxy.orderNum}</td>
                <td class="td3">订单日期</td>
                <td class="td4"><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
            <tr>
                <td class="td1">订单状态</td>
                <td class="td2">${orderProxy.orderStat}</td>
                <td class="td3">送货方式</td>
                <td class="td4">${orderProxy.deliveryWay}
                    <c:if test="${not empty orderProxy.logisticsNum}">
                        （物流单号：${orderProxy.logisticsNum}）
                    </c:if>
                </td>
            </tr>
            <tr>
                <td class="td1">商品金额</td>
                <td class="td2"><b>¥<fmt:formatNumber value="${orderProxy.productTotalAmount}" type="number" pattern="#0.00#" /></b></td>
                <td class="td3">支付方式</td>
                <td class="td4">${orderProxy.isCod?'货到付款':'在线支付'}</td>
            </tr>
            <tr>
                <td class="td1">运费</td>
                <td class="td2"><b>¥<fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#" /></b></td>
                <td class="td3">支付状态</td>
                <td class="td4">${orderProxy.pay?'已支付':'待支付'}</td>
            </tr>
            <tr>
                <td class="td1">订单优惠</td>
                <td colspan="3" class="less">
                    <ul class="poJ">
                        <%--获取订单优惠 start--%>
                        <c:forEach items="${orderProxy.orderDiscount}" var="favorable">
                            <li>${favorable}</li>
                        </c:forEach>
                        <%--获取订单优惠 end--%>
                    </ul>
                </td>
            </tr>
            <%--<tr>
                <td class="td1">电子币</td>
                <td colspan="3" class="less"><b>￥<fmt:formatNumber value="${orderProxy.useAccountAmount}" type="number" pattern="#0.00#" /></b></td>
            </tr>--%>
            <tr>
                <td class="td1">购物券</td>
                <td colspan="3" class="less"><b>￥<fmt:formatNumber value="${orderProxy.useCouponAmount}" type="number" pattern="#0.00#" /></b></td>
            </tr>
<%--            <tr>
                <td class="td1">订单支付金额</td>
                <td colspan="3" class="less"><b>￥<fmt:formatNumber value="${orderProxy.unpaidAmount}" type="number" pattern="#0.00#" /></b></td>
            </tr>--%>
            <tr>
                <td class="td1">发票</td>
                <td colspan="3" class="less"><p>${orderProxy.invoiceType}<span><c:if test="${not empty orderProxy.invoiceTitle}">( 发票抬头：${fn:substring(orderProxy.invoiceTitle,0 ,50)})</c:if></span></p></td>
            </tr>

            <tr>
                <td class="td1">备注信息</td>
                <td colspan="3" class="less">${fn:substring(orderProxy.remark,0 ,150)}</td>
            </tr>
        </table>
    </div>
</div>
<%--订单信息 end--%>
<%--收货人信息 satrt--%>
<div class="m5">
    <h1>收货人信息</h1>
    <div class="box">
        <table width="100%" border="0" cellspacing="0">
            <tr>
                <td class="td1">收货人</td>
                <td class="td2">${orderProxy.receiverName}</td>
                <td class="td3">邮政编码</td>
                <td class="td4">${orderProxy.zipCode}&nbsp;</td>
            </tr>
            <tr>
                <td class="td1">移动电话</td>
                <td class="td2">${orderProxy.mobile}</td>
                <td class="td3">固定电话</td>
                <td class="td4">${orderProxy.tel}&nbsp;</td>
            </tr>
            <%--<tr>--%>
            <%--<td class="td1">E-mail</td>--%>
            <%--<td class="td2"></td>--%>
            <%--<td class="td3">&nbsp;</td>--%>
            <%--<td class="td4">&nbsp;</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="td1">详细地址</td>
                <td colspan="3" class="less">${orderProxy.province}${orderProxy.address}</td>
            </tr>
        </table>
    </div>
</div>
<%--收货人信息 end--%>
<%--自提点信息--%>
    <c:if test="${not empty pickedUp}">
           <div class="m5">
               <h1>自提点信息</h1>
               <div class="box">
                   <table width="100%" border="0" cellspacing="0">
                       <tr>
                           <td class="td1">自提点名称</td>
                           <td colspan="3" class="less">${pickedUp.pickedUpName}</td>
                       </tr>
                       <tr>
                           <td class="td1">自提点地址</td>
                           <td colspan="3" class="less">${pickedUp.pickedUpAddress}</td>
                       </tr>
                       <tr>
                           <td class="td1">提货码</td>
                           <td class="td2"><span style="color: red;">${orderProxy.deliveryCode}</span></td>
                           <td class="td3">自提点手机号码</td>
                           <td class="td4">${pickedUp.pickedUpMobile}</td>
                       </tr>
                       <tr>
                           <td class="td1">自提点是否收货</td>
                           <c:choose>
                               <c:when test="${orderProxy.pickedUpIsReceiving=='N'}">
                                   <td class="td2">未收货</td>
                               </c:when>
                               <c:otherwise>
                                   <td class="td2">已收货</td>
                               </c:otherwise>
                           </c:choose>
                           <td class="td3">自提点收货时间</td>
                           <td class="td4"><fmt:formatDate value="${orderProxy.pickedUpReceivingTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                       </tr>
                       <tr>
                           <td class="td1">买家是否已自提</td>
                           <c:choose>
                               <c:when test="${orderProxy.isPickedUp=='N'}">
                                   <td class="td2">未自提</td>
                               </c:when>
                               <c:otherwise>
                                   <td class="td2">已自提</td>
                               </c:otherwise>
                           </c:choose>
                           <td class="td3">买家提货时间</td>
                           <td class="td4"><fmt:formatDate value="${orderProxy.pickedUpTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                       </tr>

                   </table>
               </div>
           </div>
    </c:if>
<%--自提点信息 end--%>
<div class="mm_list">
    <table width="100%" border="0" cellspacing="0">
        <tr class="tr1">
            <td class="td1">商品编码</td>
            <td class="td1" style="width: 215px;">商品名称</td>
            <td class="td3">规格</td>
            <td class="td4">商品金额</td>
            <%--<td class="td5">赠送积分</td>--%>
            <td class="td6">数量</td>
            <td class="td7">小计</td>
        </tr>
        <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" varStatus="status">
            <tr <c:if test="${status.count mod 2 !=0}"> class="bg"</c:if>>
                <td class="td1">${orderItemProxy.productProxy.productCode}</td>
                <td class="td1" style="width: 215px;"><a href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html" target="_blank">${orderItemProxy.productProxy.name}</a><c:if test="${orderItemProxy.promotionType eq '赠品商品'}"><span style="color:#a80000; ">【赠品】</span></c:if></td>
                <td class="td3">${orderItemProxy.productSpecNm}</td>
                <td class="td4">￥<fmt:formatNumber value="${orderItemProxy.productUnitPrice}" type="number" pattern="#0.00#" /></td>
                <%--<td class="td5">${orderItemProxy.obtainIntegral}</td>--%>
                <td class="td6">${orderItemProxy.num}</td>
                <td class="td7"><fmt:formatNumber value="${orderItemProxy.productTotalAmount}" type="number" pattern="#0.00#" /></td>
            </tr>
        </c:forEach>
    </table>
</div>
<div class="orderDetailAmout">
    <p class="fT">商品金额总计：<b><fmt:formatNumber value="${orderProxy.productTotalAmount}" type="number" pattern="#0.00#" /></b> 元 + 运费：<b><fmt:formatNumber value="${orderProxy.freightAmount}" type="number" pattern="#0.00#" /></b> 元 + 优惠金额：<b><fmt:formatNumber value="${orderProxy.discountAmount}" type="number" pattern="#0.00#" /></b> 元 + 物流优惠：<b><fmt:formatNumber value="${orderProxy.logisticsDiscountAmount}" type="number" pattern="#0.00#" /></b> 元 <%--+ 额外折扣：<b><fmt:formatNumber value="${orderProxy.pmtTotalAmount}" type="number" pattern="#0.00#" /></b> 元 --%> </p>
    <p class="fB">赠送积分：<span>${orderProxy.obtainTotalIntegral}</span> 分&nbsp;&nbsp;&nbsp;&nbsp;订单商品总金额：<span>¥<fmt:formatNumber value="${orderProxy.orderTotalAmount}" type="number" pattern="#0.00#" /></span> 元</p>
</div>
</div>
</div>
<div class="clear"></div>
</div>
<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
