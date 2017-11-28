<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="user"/>
<c:if test="${empty user}">
    <c:redirect url="${webRoot}/index.ac"/>
</c:if>
<c:set value="${param.cardBatchId}" var="cardBatchId"/>
<c:set value="${param.quantity}" var="quantity"/>
<c:if test="${empty cardBatchId || empty quantity}">
    <c:redirect url="${webRoot}/card/cardList.ac"/>
</c:if>
<c:set value="${bdw:getCardBatchById(cardBatchId)}" var="batch"/>
<c:if test="${empty batch || batch.isFreeze == 'Y' || batch.cardRemainQuantity < 1}">
    <c:redirect url="${webRoot}/card/cardList.ac"/>
</c:if>
<c:set value="${quantity > batch.cardRemainQuantity ? batch.cardRemainQuantity : quantity}" var="quantity"/>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${webName}" /> <%--SEO description优化--%>
    <title>结算页-${webName}</title>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/card/statics/css/cardBalance.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}",
            cardBatchId:"${param.cardBatchId}",
            quantity:"${param.quantity}"
        }
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/card/statics/js/cardBalance.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=cardBalance"/>
<%--页头结束--%>

	<!--主体-->
	<div class="main-bg">
        <div class="main">
            <div class="mt">确认商品清单</div>
            <div class="list-cont">
                <div class="th">
                    <span style="float: left; margin-left: 180px;">商品信息</span>
                    <span style="margin-right: 120px;">小计（元）</span>
                    <span style="margin-right: 140px;">数量</span>
                    <span style="margin-right: 115px;">单价</span>
                    <span style="margin-right: 116px;">库存</span>
                </div>
                <div class="td">
                    <div class="pic"><img src="${batch.defaultImage[""]}" alt="${batch.cardBatchNm}" width="120px" height="75px"></div>
                    <div class="info">
                        <span class="title">${batch.cardBatchNm}</span>
                    </div>
                    <div class="m1">${batch.cardRemainQuantity}</div>
                    <div class="m1"><fmt:formatNumber value="${batch.cardSellAmount}" pattern="##.##" minFractionDigits="2" /></div>
                    <div class="m1">${quantity}</div>
                    <div class="price"><i>￥</i><fmt:formatNumber value="${batch.cardSellAmount * quantity}" pattern="##.##" minFractionDigits="2" /></div>
                </div>
            </div>
            <div class="mt">支付平台</div>
            <div class="pay-cont">
                <div class="pay-top">
                    <span>请选择您的支付网关</span>
                    <span>需支付：<i><fmt:formatNumber value="${batch.cardSellAmount * quantity}" pattern="##.##" minFractionDigits="2" /></i> 元</span>
                </div>
                <div class="pay-bot">
                    <%--<ul>
                        <li><a href="##"><img src="case/pic180x45.jpg" alt=""></a></li>
                        <li class="cur"><a href="##"><img src="case/pic180x45.jpg" alt=""></a></li>
                        <li><a href="##"><img src="case/pic180x45.jpg" alt=""></a></li>
                        <li><a href="##"><img src="case/pic180x45.jpg" alt=""></a></li>
                        <li><a href="##"><img src="case/pic180x45.jpg" alt=""></a></li>
                        <li><a href="##"><img src="case/pic180x45.jpg" alt=""></a></li>
                        <li><a href="##"><img src="case/pic180x45.jpg" alt=""></a></li>
                        <li><a href="##"><img src="case/pic180x45.jpg" alt=""></a></li>
                    </ul>--%>
                    <ul class="payWayUl">
                        <c:forEach items="${sdk:getPayWayList()}" var="payWay" varStatus="s">
                            <li class="<%--<c:if test="${s.first}">cur</c:if>--%> payWay" payWayId="${payWay.payWayId}"><a href="javascript:void(0);" class="useBank" name="payWayId"><img src="${payWay.fileUrl}" height="45px" width="180px" alt="${payWay.payWayNm}"/></a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="mb">
                <div class="amount">商品总金额：<i><fmt:formatNumber value="${batch.cardSellAmount * quantity}" pattern="##.##" minFractionDigits="2" /></i></div>
                <p><em>待支付金额：</em><i>￥</i><fmt:formatNumber value="${batch.cardSellAmount * quantity}" pattern="##.##" minFractionDigits="2" /></p>
                <%--<span>可获得积分169点</span>--%>
                <a href="javascript:void(0);" class="mb-btn goToPay" payWayId="">立即付款</a>
            </div>
        </div>
        <form action="${webRoot}/cashier/goBankOfCard.ac" method="post" id="goBankOfCard" style="display: none;">
            <input type="hidden" value="${cardBatchId}" name="syCardBatchId"/>
            <input type="hidden" value="${quantity}" name="quantity"/>
            <input type="hidden" name="payWayId" id="payWayId"/>
        </form>
	</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>

