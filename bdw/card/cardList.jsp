<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${bdw:getCardBatchPage(page,8)}" var="cardBatchProxyPage"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="易淘药礼品卡，易淘药，易淘药集团，易淘药大健康，果维康，溯源商城，药食同源，欧意，欧意和，若舒，恩必普，易淘药电商，安沃勤，纯净冰岛，安蜜乐，易淘药贝贝，易淘药健康城" /> <%--SEO keywords优化--%>
    <meta name="description" content="易淘药健康网，易淘药集团官方网站，易淘药礼品卡 " /> <%--SEO description优化--%>
    <title>${sdk:getSysParamValue('index_title')}</title>


    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/card/statics/css/cardList.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            userId:"${loginUser.userId}"
        }
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/card/statics/js/cardList.js"></script>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=cardList"/>
<%--页头结束--%>
<div class="main-bg">
    <h1>
        <img src="${webRoot}/template/bdw/card/statics/images/gift-cards-title.png" alt="易淘药礼品卡">
    </h1>
    <div class="main">
        <ol class="card-list">
            <c:forEach items="${cardBatchProxyPage.result}" var="batchProxy" varStatus="s">
                <li class="card">
                    <div class="img">
                        <img src="${batchProxy.defaultImage[""]}" width="240px" height="150px">
                    </div>

                    <span class="price"><small>&yen;</small>${batchProxy.cardSellAmount}</span>

                    <p class="name">${batchProxy.cardBatchNm}</p>

                    <div class="amount">
                        <a class="amount-opera subBtn" href="javascript:void(0);" seq="${s.count}">−</a>
                        <input class="amount-inp quantity quantity${s.count}" type="text" value="1" placeholder="" seq="${s.count}">
                        <a class="amount-opera addBtn" href="javascript:void(0);" seq="${s.count}">+</a>
                    </div>

                    <a class="btn buyBtn" href="javascript:void(0);" cardBatchId="${batchProxy.sysCardBatchId}" cardRemainQuantity="${batchProxy.cardRemainQuantity}" seq="${s.count}">立即购买</a>
                </li>
            </c:forEach>

        </ol>
        <div class="pager">
            <div id="infoPage">
                <c:if test="${cardBatchProxyPage.lastPageNumber>1}">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${cardBatchProxyPage.lastPageNumber}' currentPage='${page}' totalRecords='${cardBatchProxyPage.totalCount}' ajaxUrl='${webRoot}/card/cardList.ac' frontPath='${webRoot}' displayNum='6'/>
                </c:if>
            </div>
        </div>
    </div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
