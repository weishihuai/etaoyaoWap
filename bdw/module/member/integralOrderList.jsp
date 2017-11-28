<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findAllIntegralOrder(loginUser.userId,pageNum,8)}" var="orderProxyPage"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}"/>
    <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}"/>
    <%--SEO description优化--%>
    <title>${webName}-积分订单-${sdk:getSysParamValue('index_title')}</title><%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/integralOrderDetail.js"></script>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<div id="position" class="m1-bg">
    <div class="m1">您现在的位置：<a href="${webRoot}/">首页</a> > <a href="${webRoot}/module/member/index.ac">会员专区</a> > 订单列表</div>
</div>

<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>

    <div class="rBox">
        <div class="seachOb">
            <div class="m1">
                <h2 class="rightbox_h2_border">积分订单</h2>

                <div class="box">
                    <div style="border: 1px solid #E4E4E4;border-bottom: none;">
                        <%--订单显示列表 start--%>
                        <table width="100%" border="0" cellspacing="0">
                            <tr class="tr1">
                                <td class="td1" style="width:192px;">订单商品</td>
                                <td class="td2">单件</td>
                                <td class="td3" style="text-align:right;width: 68px;padding-right:20px;">数量</td>
                                <td class="td4">总计</td>
                                <td class="td4">兑换方式</td>
                                <td class="td5">订单状态</td>
                                <td class="td6">操作</td>
                            </tr>
                        </table>
                    </div>
                    <div id="orderInfo_div">
                        <c:choose>
                            <c:when test="${empty orderProxyPage.result}">
                                <div>
                                    <ul>
                                    <li class="e-none" style="padding-left:338px;width:502px;height: 160px;padding-top: 50px;"><!--，没有搜到商品-->
                                        <p><i>没有积分订单订单？</i></p>
                                        <p><em>赶紧去积分商城逛逛吧！</em></p>
                                        <a href="${webRoot}/integral.html">去积分商城>></a>
                                    </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                        <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
                            <div class="item_div" style="margin-bottom: 0px;">
                                <div class="item_div_info" style="padding-left: 20px; width: 918px;">
                                    订单编号：<span style="margin-right: 20px">${orderProxy.orderNum}</span>
                                    下单时间：<span style="margin-right: 20px"><fmt:formatDate value="${orderProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                </div>
                                <div class="item_div_cont">
                                    <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy" end="0">
                                        <div class="proItem" style="width:408px;">
                                            <div class="proItem_item" style="width:408px;">
                                                <div class="proItem_item_d" style="width:190px;">
                                                    <div class="proItem_item_d_d1"><a href="${webRoot}/integral/integralDetail.ac?integralProductId=${orderItemProxy.integralProductId}"><img
                                                            src="${orderItemProxy.productImage["50X50"]}" width="48px" height="48px" alt="${orderItemProxy.integralProductNm}"/></a></div>
                                                    <div class="proItem_item_d_d2" sty;e="width:120px;"><a href="${webRoot}/integral/integralDetail.ac?integralProductId=${orderItemProxy.integralProductId}"
                                                                                                           title="${orderItemProxy.integralProductNm}">${sdk:cutString(orderItemProxy.integralProductNm, 30, "...")}</a>
                                                    </div>
                                                </div>
                                                <div class="proItem_item_price" style="width: 142px; text-align: center;">
                                                    <c:choose>
                                                        <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                                            <fmt:formatNumber value="${orderItemProxy.totalIntegral}" type="number" pattern="######.##"/>分
                                                        </c:when>
                                                        <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                                            <fmt:formatNumber value="${orderItemProxy.exchangeIntegral}" type="number" pattern="######.##"/>分 +
                                                            <fmt:formatNumber value="${orderItemProxy.exchangeAmount}" type="number" pattern="######.##"/>元

                                                        </c:when>
                                                    </c:choose>
                                                </div>


                                                <div class="proItem_item_num" style="width:68px;">
                                                    <span class="s1">${orderItemProxy.num}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="operator_d" style="width: 529px;">
                                            <div class="infoItem1" style="width: 240px;">
                                                <div class="infoItem1_d"><b style="color: #a80000;">
                                                    <c:choose>
                                                        <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                                            <fmt:formatNumber value="${orderProxy.totalIntegral}" type="number" pattern="######.##"/>分
                                                        </c:when>
                                                        <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">
                                                            <fmt:formatNumber value="${orderProxy.totalExchangeIntegral}" type="number" pattern="######.##"/>分 +
                                                            <fmt:formatNumber value="${orderProxy.totalExchangeAmount}" type="number" pattern="######.##"/>元
                                                        </c:when>
                                                    </c:choose>
                                                </b>
                                                </div>

                                                <div class="infoItem1_d"><b style="color: #a80000;">
                                                    <c:choose>
                                                        <c:when test="${orderProxy.paymentConvertTypeCode eq '0'}">
                                                            固定积分
                                                        </c:when>
                                                        <c:when test="${orderProxy.paymentConvertTypeCode eq '1'}">部分积分+金额
                                                        </c:when>
                                                    </c:choose>
                                                </b>
                                                </div>
                                            </div>
                                            <div class="infoItem2" style="width: 165px;">
                                                <div class="infoItem2_d"><b style="color: #a80000;">
                                                        ${orderProxy.orderStat}
                                                </b></div>
                                            </div>
                                            <div class="infoItem3">
                                                <div class="infoItem3_d">
                                                    <a class="infoItem3_detail" href="${webRoot}/module/member/integralOrderDetail.ac?id=${orderProxy.integralOrderId}" title="查看详细">查看详细</a>
                                                    <c:if test="${orderProxy.isBuyerSigned=='N'&&orderProxy.orderStat=='已发货'}">
                                                        <p style="padding-left: 30px;"><a class="isSing" href="javascript:" onclick="buyerSigned('${orderProxy.integralOrderId}')">确认 </a></p>
                                                        <script type="text/javascript">$(".infoItem3_detail").css("margin-top", "8px");</script>
                                                    </c:if>
                                                    <c:if test="${orderProxy.isPayed eq 'N' && orderProxy.orderStat eq '未支付'}">
                                                        <p style="padding-left: 30px;"><a class="isSing" href="javascript:" onclick="goToPay('${orderProxy.integralOrderId}')">在线支付</a></p>
                                                        <script type="text/javascript">$(".infoItem3_detail").css("margin-top", "8px");</script>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                        </c:choose>

                        <script type="text/javascript">
                            $(document).ready(function () {
                                $(".proItem").each(function () {
                                    $(this).parent().find(".infoItem1").css("height", $(this).height() - 1);
                                    $(this).parent().find(".infoItem2").css("height", $(this).height() - 2);
                                    $(this).parent().find(".infoItem3").css("height", $(this).height() - 2);
                                });
                            });
                        </script>
                    </div>
                </div>
                <%--分页 start--%>
                <div class="page">
                    <div style="float:right">
                        <c:if test="${orderProxyPage.lastPageNumber >1}">
                            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/integralOrderList.ac" totalPages='${orderProxyPage.lastPageNumber}' currentPage='${pageNum}'
                                       totalRecords='${orderProxyPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>
                        </c:if>
                    </div>
                </div>
                <%--分页 end--%>
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
