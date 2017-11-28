<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<%--<c:if test="${empty user}">--%>
    <%--<c:redirect url="${webRoot}/index.ac?login=no"></c:redirect>--%>
<%--</c:if>--%>

<%--判断用户是否是供应商--%>
<%--<c:if test="${!bdw:checkUserIsSupplier()}">--%>
    <%--<c:redirect url="${webRoot}/index.ac?user=no"></c:redirect>--%>
<%--</c:if>--%>

<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>

<c:set value="${empty param.stats ? 0 : param.stats}" var="stats"/>
<%--招标列表--%>
<c:set var="forBidPage" value="${bdw:searchForBidPage(4,stats)}"/>
<c:set var="forBidResultList" value="${forBidPage.result}"/>
<%--最新的一条招标信息--%>
<c:set var="mostNewBidProxy" value="${bdw:getMostNewForBid('0')}"/>
<%--中标公告--%>
<c:set var="allWinResponseItemProxy" value="${bdw:findAllWinResponseItemProxyList(6)}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="易淘药集团招标，易淘药，易淘药集团，易淘药大健康，易淘药健康城，恩必普，欧意，易淘药儿童医院，易淘药肿瘤医院"/>
    <%--SEO keywords优化--%>
    <meta name="description" content="易淘药健康网，易淘药集团官方网站，易淘药集团招标"/>
    <%--SEO description优化--%>
    <title>${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/tender.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.vticker.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/tenderList.js"></script>
    <script type="text/javascript">
        var valueData = {
            webRoot: "${webRoot}"
        }
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<%--主体--%>
<div class="main-bg">
    <div class="mt">
        <div class="cont">
            <div class="new">最新<br>招标</div>
            <c:choose>
                <c:when test="${empty mostNewBidProxy}">
                    <div class="no_cont-lt">
                        <h5>当前暂无任何招标信息</h5>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="cont-lt">
                        <h5>${mostNewBidProxy.title}</h5>

                        <div class="lt-bot">
                            <div class="item">
                                <span>发布时间</span>
                                <p><fmt:formatDate value="${mostNewBidProxy.publishTime}" pattern="yyyy-MM-dd"/></p>
                            </div>
                            <div class="item">
                                <span>开始时间</span>

                                <p><fmt:formatDate value="${mostNewBidProxy.startTime}" pattern="yyyy-MM-dd"/></p>
                            </div>
                            <div class="item">
                                <span>结束时间</span>
                                <p><fmt:formatDate value="${mostNewBidProxy.endTime}" pattern="yyyy-MM-dd"/></p>
                            </div>
                        </div>
                    </div>
                    <div class="cont-rt">
                        <%--<c:choose>
                            <c:when test="${empty user}">
                                <a href="${webRoot}/login.ac" class="rt-btn">查看详情</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${webRoot}/tenderDetail.ac?stats=${stats}&tnd=${mostNewBidProxy.invitationForBidId}" class="rt-btn">查看详情</a>
                            </c:otherwise>
                        </c:choose>--%>
                            <!-- 目前所有人都可以进行查看 -->
                            <a href="${webRoot}/tenderDetail.ac?stats=${stats}&tnd=${mostNewBidProxy.invitationForBidId}" class="rt-btn">查看详情</a>
                            <p>当前<span>${mostNewBidProxy.shopCount}</span>位商家参与竞标</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="main clearfix">
        <div class="mlt">
            <div class="nav">
                <ul>
                    <li class="<c:if test="${stats eq '0'}">cur</c:if>"><a href="${webRoot}/tenderList.ac?stats=0">正在招标</a></li>
                    <li class="<c:if test="${stats eq '1'}">cur</c:if>"><a href="${webRoot}/tenderList.ac?stats=1">往期结束</a></li>
                </ul>
            </div>
            <div class="tabpane">
                <div class="pane-cont">
                    <c:if test="${not empty forBidResultList}">
                        <c:forEach var="forBid" items="${forBidResultList}">
                            <div class="pc-item">
                                <div class="cont-lt">
                                    <h5>${forBid.title}</h5>
                                    <div class="lt-bot">
                                        <div class="item">
                                            <span>发布时间</span>

                                            <p><fmt:formatDate value="${forBid.publishTime}" pattern="yyyy-MM-dd"/></p>
                                        </div>
                                        <div class="item">
                                            <span>开始时间</span>

                                            <p><fmt:formatDate value="${forBid.startTime}" pattern="yyyy-MM-dd"/></p>
                                        </div>
                                        <div class="item">
                                            <span>结束时间</span>

                                            <p><fmt:formatDate value="${forBid.endTime}" pattern="yyyy-MM-dd"/></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="cont-rt">
                                    <%--<c:choose>
                                        <c:when test="${stats eq '0'}">
                                            <a href="${webRoot}/tenderDetail.ac?stats=${stats}&tnd=${mostNewBidProxy.invitationForBidId}" class="rt-btn">查看详情</a>
                                            <p>当前<span>${forBid.shopCount}</span>位商家参与竞标</p>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${webRoot}/tenderDetail.ac?tnd=${forBid.invitationForBidId}" class="rt-btn">查看详情</a>
                                            <p>已有<span>${forBid.shopCount}</span>位商家参与竞标</p>
                                        </c:otherwise>
                                    </c:choose>--%>
                                    <!-- 目前所有人都可以进行查看 -->
                                    <a href="${webRoot}/tenderDetail.ac?tnd=${forBid.invitationForBidId}" class="rt-btn">查看详情</a>
                                    <p>已有<span>${forBid.shopCount}</span>位商家参与竞标</p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>

                <div class="pager">
                    <div id="infoPage">
                        <c:if test="${forBidPage.lastPageNumber>1}">
                            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${forBidPage.lastPageNumber}' currentPage='${_page}' totalRecords='${forBidPage.totalCount}' ajaxUrl='${webRoot}/tenderList.ac' frontPath='${webRoot}' displayNum='6'/>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <div class="mrt">
            <h5>最新中标公告</h5>
            <dl>
                <dt>
                    <span>中标供应商</span>
                    <span>中标商品</span>
                </dt>
                <dd>
                    <div class="dowebok">
                        <ul>
                            <c:if test="${not empty allWinResponseItemProxy}">
                                <c:forEach var="winResponseItem" items="${allWinResponseItemProxy}">
                                    <li>
                                        <span class="m1 elli">${winResponseItem.shopName}</span>
                                        <span class="m2 elli">${winResponseItem.productName}</span>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </dd>
            </dl>
        </div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>