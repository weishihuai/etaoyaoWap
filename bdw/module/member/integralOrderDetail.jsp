<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getIntegralOrderProxyById(param.id)}" var="orderProxy"/><%--查询订单详细--%>
<c:set value="${sdk:getSysParamValue('webName')}" var="webName"/><%--网站名称--%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}"/>
    <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}"/>
    <%--SEO description优化--%>
    <title>${webName}-积分订单详细-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <link href="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/integralOrderDetail.js"></script>
    <script type="text/javascript" language="javascript">
        var dataValue = {
            webRoot: "${webRoot}",
            orderId: "${param.id}"
        }
    </script>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<div id="position" class="m1-bg">
    <div class="m1">您现在的位置：<a href="${webRoot}/" title="首页">首页</a> > <a href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> > 积分订单详细</div>
</div>


<div id="member">

    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>

    <div class="rBox">
        <div class="bnyDetail">
            <h3>
                <div class="f">积分订单查询</div>
                <%--确认收货 start--%>
                <div class="cennl">
                    <c:if test="${orderProxy.orderStat == '未支付' && orderProxy.isPayed == false}">
                        <a href="javascript:" onclick="cancelIntegralOrder('${orderProxy.integralOrderId}')" title="取消">取消</a>
                    </c:if>
                    <c:if test="${orderProxy.isBuyerSigned=='N'&&orderProxy.orderStat=='已发货'}">
                        <a href="javascript:" onclick="buyerSigned('${orderProxy.integralOrderId}')" title="确认收货">确认收货</a>
                    </c:if>
                </div>
                <%--确认收货 end--%>
                <div class="clear"></div>
            </h3>
            <div class="m1">
                <div class="l">
                    <h1>订单号：${orderProxy.orderNum} &nbsp;&nbsp;&nbsp; 处理状态：<span>${orderProxy.orderStat}</span> &nbsp;&nbsp;&nbsp;支付状态：<span>
                        <c:choose>
                            <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                已支付
                            </c:when>
                            <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                <c:if test="${orderProxy.isPayed eq 'Y'}">
                                    已支付
                                </c:if>
                                <c:if test="${orderProxy.isPayed eq 'N'}">
                                    未支付
                                </c:if>
                            </c:when>
                        </c:choose></span></h1>
                    <c:if test="${orderProxy.orderStat=='未发货'}"><p style="font-size: 14px;">尊敬的客户！该订单还未发货，我们会尽快为您发货。非常感谢您对我们 ${webName} 的支持！祝您购物愉快！</p></c:if>
                    <c:if test="${orderProxy.orderStat=='已发货'}"><p style="font-size: 14px;">尊敬的客户！您的订单已发货，请您注意查收</p></c:if>
                    <c:if test="${orderProxy.orderStat=='已完成'}"><p style="font-size: 14px;">尊敬的客户！您的订单已完成。非常感谢您对我们 ${webName} 的支持！祝您购物愉快！</p></c:if>
                </div>
                <div class="r">
                    <p style="font-size: 14px;font-weight: bold;">订单所需积分：<b>
                        <c:choose>
                        <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                            <fmt:formatNumber value="${orderProxy.totalIntegral}" type="number" pattern="######.##"/>分
                        </c:when>
                        <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                            <fmt:formatNumber value="${orderProxy.totalExchangeIntegral}" type="number" pattern="######.##"/>分
                        </c:when>
                        </c:choose></b></p>
                            <c:if test="${orderProxy.isPayed eq 'N' && orderProxy.orderStat eq '未支付' }">
                            <div class="btn">
                            <a href="${webRoot}/integral/integralCashier.ac?integralOrderId=${orderProxy.integralOrderId}"></a>
                                </div>

                            </c:if>
                </div>
                <div class="clear"></div>
            </div>

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
                            <td class="td4">${orderProxy.deliveryWay}</td>
                        </tr>
                        <tr>
                            <td class="td1">商品积分</td>
                            <td class="td2"><b>
                                <c:choose>
                                <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                    <fmt:formatNumber value="${orderProxy.totalIntegral}" type="number" pattern="######.##"/>分
                                </c:when>
                                <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                    <fmt:formatNumber value="${orderProxy.totalExchangeIntegral}" type="number" pattern="######.##"/>分 +
                                    <fmt:formatNumber value="${orderProxy.totalExchangeAmount}" type="number" pattern="######.##"/>元
                                </c:when>
                                </c:choose></b></td>
                                <td class="td3">支付方式</td>
                                <td class="td4"><c:choose>
                                    <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                        固定积分
                                    </c:when>
                                    <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                        部分积分+部分现金
                                    </c:when>
                                </c:choose></td>
                        </tr>
                        <tr>
                            <td class="td1">运费</td>
                            <td class="td2"><b>¥ &nbsp;<fmt:formatNumber value="0" type="number" pattern="#0.00#"/></b></td>
                            <td class="td3">支付状态</td>
                            <td class="td4">
                                <c:choose>
                                    <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                        已支付
                                    </c:when>
                                    <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                        <c:if test="${orderProxy.isPayed eq 'Y'}">
                                            已支付
                                        </c:if>
                                        <c:if test="${orderProxy.isPayed eq 'N'}">
                                            未支付
                                        </c:if>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">物流公司</td>
                            <td class="td2"> <c:if test="${not empty orderProxy.logisticsCompany}">${orderProxy.logisticsCompany}</c:if></td>
                            <td class="td3">物流单号</td>
                            <td class="td4"><c:if test="${not empty orderProxy.logisticsNum}">${ orderProxy.logisticsNum}</c:if> </td>
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
                        <tr>
                            <td class="td1">详细地址</td>
                            <td colspan="3" class="less">${orderProxy.address}</td>
                        </tr>
                    </table>
                </div>
            </div>
            <%--收货人信息 end--%>
            <%--<div class="mm_list">--%>
            <%--<table width="100%" border="0" cellspacing="0">--%>
            <%--<tr class="tr1">--%>
            <%--<td class="td1" style="width: 215px;">商品名称</td>--%>
            <%--<td class="td4">商品积分</td>--%>
            <%--<td class="td6">数量</td>--%>
            <%--<td class="td7">总积分</td>--%>
            <%--</tr>--%>
            <%--<c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" varStatus="status" end="0">--%>
            <%--<tr <c:if test="${status.count mod 2 !=0}"> class="bg"</c:if>>--%>
            <%--<td class="td1" style="width: 215px;"><a href="${webRoot}/integral/integralDetail.ac?integralProductId=${orderItemProxy.integralProductId}" target="_blank">${orderItemProxy.integralProductNm}</a></td>--%>
            <%--<td class="td4">--%>
            <%--<c:choose>--%>
            <%--<c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">--%>
            <%--<fmt:formatNumber value="${orderItemProxy.totalIntegral}" type="number" pattern="##" />分--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">--%>
            <%--<fmt:formatNumber value="${orderItemProxy.exchangeIntegral}" type="number" pattern="##" />分   +--%>
            <%--<fmt:formatNumber value="${orderItemProxy.exchangeAmount}" type="number" pattern="##" />元--%>
            <%--</c:when>--%>
            <%--</c:choose>--%>
            <%--</td>--%>
            <%--<td class="td6">${orderItemProxy.num}</td>--%>
            <%--<td class="td7">--%>
            <%--<c:choose>--%>
            <%--<c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">--%>
            <%--<fmt:formatNumber value="${orderProxy.totalIntegral}" type="number" pattern="##" />分--%>
            <%--</c:when>--%>
            <%--<c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">--%>
            <%--<fmt:formatNumber value="${orderProxy.totalExchangeIntegral}" type="number" pattern="##" />分   +--%>
            <%--<fmt:formatNumber value="${orderProxy.totalExchangeAmount}" type="number" pattern="##" />元--%>
            <%--</c:when>--%>
            <%--</c:choose>--%>
            <%--</td>--%>
            <%--</tr>--%>
            <%--</c:forEach>--%>
            <%--</table>--%>
            <%--</div>--%>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
