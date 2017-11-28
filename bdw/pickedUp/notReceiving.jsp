<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/bdw" prefix="bdw" %>
<c:set value="${bdw:getAdminPickedUp()}" var="adminPickedUp"/>
<c:if test="${empty adminPickedUp}">
    <c:redirect url="/ziti.ac"></c:redirect>
</c:if>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set var="pickedId" value="${param.pickedUpId}"/>
<c:set var="orderNumSearch" value="${param.orderNum}"/>
<c:set var="mobileSearch" value="${param.Mobile}"/>
<c:set var="receiverNameSearch" value="${param.receiverName}"/>
<c:set value="${bdw:findReceivingList('Y','N','N',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="notReceiving"/>
<c:set value="${bdw:findReceivingList('Y','Y','N',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="receiving"/>
<c:set value="${bdw:findReceivingList('Y','Y','Y',param.orderNum,param.receiverName,param.Mobile,_page,20)}" var="pickedUp"/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-待收货订单</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/pickedUp/style/l_header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/pickedUp/style/take.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
        var pickedid = {pickedUpId: "${pickedId}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/pickedUp/js/notReceiving.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/pickedUp/common/top.jsp"/>
<%--页头开始--%>

<div class="t_index_bg">
    <div class="t_index">
        <div class="id_top">
            <ul>
                <li class="cur">
                    <a href="javascript:;">待收货订单<em>（<i>${not empty notReceiving?notReceiving.totalCount:0}</i>）</em></a>
                </li>
                <li>
                    <a href="${webRoot}/template/bdw/pickedUp/receiving.jsp">已收货订单<em>（<i>${not empty receiving?receiving.totalCount:0}</i>）</em></a>
                </li>
                <li class="last">
                    <a href="${webRoot}/template/bdw/pickedUp/pickedUpList.jsp">已提货订单<em>（<i>${not empty pickedUp?pickedUp.totalCount:0}</i></i>）</em></a>
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
        <div class="id_main" style="position: relative;">
            <div class="m_title">
                <span>订单号</span>
                <em>收货人信息</em>
                <i>操作</i>
            </div>
            <c:choose>
                <c:when test="${notReceiving.totalCount>0}">
                    <ul class="m_cont">
                        <c:forEach items="${notReceiving.result}" var="productProxy" varStatus="s">
                                <li class="myIsReceivingParent">
                                <div class="mc_lt">
                                    <span class="d_num">${productProxy.orderNum}</span>
                                    <span class="d_name">${productProxy.receiverName}</span>
                                    <span class="d_pho">${productProxy.mobile}</span>
                                    <span class="d_time"><em>下单时间：</em><i><fmt:formatDate value="${productProxy.createDate}" pattern="yyyy-MM-dd HH:mm"/></i></span>
                                    <span class="d_add">${productProxy.address}</span>
                                </div>
                                <div class="mc_rt"><a href="javascript:;" class="myIsReceiving">确认收货</a></div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p>没有更多的待收货订单。</p>
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
            <%--分页结束--%>
        </div>

    </div>
</div>


<%--确认收货弹出窗口提示 start--%>
<div class="ys_box" id="myReceivingBox" style="display:none;">
    <div class="yb_title">验证自提点</div>
    <div class="yb_bot">
        <div class="yb_item">
            <span>订单编号：</span>
            <i id="orderNumText"></i>
        </div>
        <div class="yb_item">
            <span>收货人：</span>
            <i id="receiverNameText"></i>
        </div>
        <div class="yb_item">
            <span>电话：</span>
            <em id="mobileText"></em>
        </div>
        <div class="yb_item">
            <span>收货人地址：</span>
            <em id="addressText"></em>
        </div>
        <div class="yb_btn">
            <a href="javascript:;" class="YesReceiving">验收订单</a>
            <a href="javascript:;" style="margin-left: 62px;" class="myCancel">取消</a>
        </div>
    </div>
</div>
<%--确认收货弹出窗口提示 end--%>
<%--页尾开始--%>
<c:import url="/template/bdw/pickedUp/common/bottom.jsp"/>
<%--页尾开始--%>

</body>
</html>
