<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.iloosen.com/bdw" prefix="sy"%>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${sy:getCardOrderPage(page,4,loginUser.userId)}" var="cardOrderProxyPage"/>

<!DOCTYPE html>
<html>
<head>
	<meta name="renderer" content="webkit">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}"/>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}"/>
    <title>礼品卡订单-${webName}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/cardOrderList.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}"
        };
    </script>
</head>
<body>
<c:import url="/template/bdw/module/common/top.jsp?p=cardOrderList"/>
<div id="position" class="m1-bg">
    <div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> > <a
            href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >礼品卡订单
    </div>
</div>
<div id="member">
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>

	<%--<div style="width: 100%; min-width: 1190px; padding: 50px 0; background-color: #eeeeee;">

    </div>--%>
    <div class="ct-box order-box" style="float: right">
        <div class="ct-mt">
            <span>礼品卡订单</span>
        </div>
        <div class="ct-mc">
            <div class="ct-dt">
                <span style="margin-left: 18px;">商品信息</span>
                <span style="margin-left: 314px;">礼品卡账号</span>
                <span style="margin-left: 117px;">礼品卡密码</span>
                <span style="margin-left: 95px;">绑定用户</span>
                <span style="float: right; margin-right: 38px;">状态</span>
            </div>
            <div class="ct-dc">
                <c:forEach items="${cardOrderProxyPage.result}" var="orderProxy" varStatus="s">
                    <div class="item">
                        <div class="mlt">
                            <div class="pic"><a href="<%--这里配礼品卡详情链接--%>"><img src="${orderProxy.defaultImage["100X100"]}" ></a></div>
                            <a href="<%--这里配礼品卡详情链接--%>" class="title">${orderProxy.carBatchNm}</a>
                            <div class="info">
                                <div class="info-m"><span>数量：</span>${orderProxy.cardNum}</div>
                                <div class="info-m"><span>单价：</span>￥${orderProxy.unitPrice}</div>
                            </div>
                        </div>
                        <div class="mrt">
                            <c:forEach items="${orderProxy.cardProxyList}" var="cardProxy" varStatus="s">
                                <div class="mrt-m">
                                    <span>${cardProxy.cardNum}</span>
                                    <span>${cardProxy.cardPsw}</span>
                                    <span><c:if test="${cardProxy.isBind == 'Y'}">${cardProxy.bindUser}</c:if></span>
                                    <em>
                                        <c:choose>
                                            <c:when test="${cardProxy.isBind == 'Y'}">
                                                已绑定
                                            </c:when>
                                            <c:otherwise>
                                                未绑定
                                            </c:otherwise>
                                        </c:choose>
                                    </em>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${cardOrderProxyPage.totalCount>4}">
                    <div class="pager">
                        <div id="infoPage">
                            <p:PageTag
                                    isDisplayGoToPage="true"
                                    isDisplaySelect="false"
                                    ajaxUrl="${webRoot}/template/bdw/module/member/cardOrderList.jsp"
                                    totalPages='${cardOrderProxyPage.lastPageNumber}'
                                    currentPage='${page}'
                                    totalRecords='${cardOrderProxyPage.totalCount}'
                                    frontPath='${webRoot}'
                                    displayNum='6'/>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
</html>

