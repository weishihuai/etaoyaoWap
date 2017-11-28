<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/bdw" prefix="bdw" %>
<c:set value="${bdw:getAdminPickedUp()}" var="adminPickedUp"/>
<c:if test="${empty adminPickedUp}">
    <c:redirect url="/ziti.ac"></c:redirect>
</c:if>
<c:set var="orderNumSearch" value="${param.orderNum}"/>
<c:set var="mobileSearch" value="${param.Mobile}"/>
<c:set var="receiverNameSearch" value="${param.receiverName}"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set var="pickedId" value="${param.pickedUpId}"/>
<c:set value="${bdw:findReceivingList('Y','N','N',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="notReceiving"/>
<c:set value="${bdw:findReceivingList('Y','Y','N',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="receiving"/>
<c:set value="${bdw:findReceivingList('Y','Y','Y',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="pickedUp"/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-已提货订单</title>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css"/>
    <link href="${webRoot}/template/bdw/pickedUp/style/l_header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/pickedUp/style/take.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
        var pickedid = {pickedUpId: "${pickedId}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/pickedUp/js/pickedUp.js"></script>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/pickedUp/common/top.jsp"/>
<%--页头开始--%>
<div class="t_index_bg">
    <div class="t_index">
        <div class="id_top">
            <ul>
                <li>
                    <a href="${webRoot}/template/bdw/pickedUp/notReceiving.jsp">待收货订单<em>（<i>${not empty notReceiving?notReceiving.totalCount:0}</i>）</em></a>
                </li>
                <li>
                    <a href="${webRoot}/template/bdw/pickedUp/receiving.jsp">已收货订单<em>（<i>${not empty receiving?receiving.totalCount:0}</i>）</em></a>
                </li>
                <li class="last cur">
                    <a href="javascript:;">已提货订单<em>（<i>${not empty pickedUp?pickedUp.totalCount:0}</i></i>）</em></a>
                </li>
            </ul>
            <a href="${webRoot}/template/bdw/pickedUp/pickedUpVerify.jsp" class="t-btn">提货</a>
        </div>
        <div class="id_search">
            <div class="s_item">
                <span>订单编号：</span>
                <input type="text" id="myOrderNum" value="${orderNumSearch}"/>
            </div>
            <div class="s_item">
                <span>收货人：</span>
                <input type="text" id="myOrderName" value="${receiverNameSearch}"/>
            </div>
            <div class="s_item">
                <span>手机号码：</span>
                <input type="text" id="myOrderMobile" value="${mobileSearch}"/>
                <a href="javascript:;" id="search">搜索</a>
            </div>
        </div>
        <div class="id_main">
            <div class="m_title">
                <span>订单号</span>
                <em>收货人信息</em>
                <i>已提货信息</i>
            </div>
            <c:choose>
                <c:when test="${pickedUp.totalCount>0}">
                    <ul class="m_cont">
                        <c:forEach items="${pickedUp.result}" var="productProxy" varStatus="s">
                            <li>
                                <div class="mc_lt">
                                    <span class="d_num">${productProxy.orderNum}</span>
                                    <span class="d_name">${productProxy.receiverName}</span>
                                    <span class="d_pho">${productProxy.mobile}</span>
                                    <span class="d_time"><em>下单时间:</em><i><fmt:formatDate value="${productProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></i></span>
                                    <span class="d_add">${productProxy.address}</span>
                                </div>
                                <div class="mc_th">
                                    <span>已提货</span>
                                    <em>提货时间：<i><fmt:formatDate value="${productProxy.pickedUpTime}" pattern="yyyy-MM-dd HH:mm:ss"/></i></em>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p>没有更多的已提货订单。</p>
                </c:otherwise>
            </c:choose>
            <c:if test="${notReceiving.lastPageNumber>1}">
                <div class="page">
                        <%--分页开始--%>
                    <p:PageTag isDisplayGoToPage="true"
                               isDisplaySelect="false"
                               ajaxUrl="${webRoot}/template/bdw/pickedUp/notReceiving.jsp"
                               totalPages='${notReceiving.lastPageNumber}'
                               currentPage='${_page}'
                               totalRecords='${notReceiving.totalCount}'
                               frontPath='${webRoot}'
                               displayNum='6'/>
                </div>
            </c:if>
        </div>
    </div>
</div>
<%--页尾开始--%>
<c:import url="/template/bdw/pickedUp/common/bottom.jsp"/>
<%--页尾开始--%>

</body>
</html>
