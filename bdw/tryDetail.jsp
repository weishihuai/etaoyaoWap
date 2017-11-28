<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%-- 获取报告 --%>
<c:set value="${bdw:getTrialApplyReport(param.id)}" var="applyReport" />
<c:set value="${bdw:findFrialProxy(0,10)}" var="frialProxyPage"></c:set>
<head>
    <meta property="qc:admins" content="3553273717624751446375" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}"/>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}"/>
    <title>${webName}-${sdk:getSysParamValue('index_title')}</title>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/tryDetail.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<!--页头结束-->
<div class="main">
    <div class="past">
        <div class="first">
            <span>乐商医药商城</span>
            <i class="crumbs-arrow"></i>
        </div>
        <a href="${webRoot}/tryOutDetail.ac?id=${applyReport.freeTrialId}" class="cata">${applyReport.productNm}</a>
        <i class="crumbs-arrow"></i>
        <a href="javascript:void(0);" class="cata">${applyReport.repTitle}</a>
        <%--<i class="crumbs-arrow"></i>--%>
    </div>
    <div class="cont clearfix">
        <div class="cont-lt">
            <div class="lt-top">
                <h5>${applyReport.repTitle}</h5>
                <div class="author">
                    <div class="pic"><img src="${applyReport.icon['']}" alt=""></div>
                    <span>${fn:substring(applyReport.loginId,0,4)}****</span>
                    <em><fmt:formatDate value="${applyReport.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/></em>
                </div>
            </div>
            <div class="lt-md">
                ${applyReport.repCont}<br/><br/>
                    <c:forEach items="${fn:split(applyReport.repPict,',' )}" var="pic">
                        <c:if test="${pic != ''}">
                            <img src="${pic}" alt="${applyReport.repTitle}"><br/><br/>
                        </c:if>
                    </c:forEach>
            </div>
            <%--<div class="lt-bot"><a href="javascript:void(0);">--%>
                <%--<img src="${webRoot}/template/bdw/statics/images/zan-icon.png" alt="">--%>
                <%--<p>2个喜欢</p>--%>
            <%--</a>--%>
            <%--</div>--%>
        </div>
        <div class="cont-rt">
            <div class="this">
                <div class="this-mt">本文评测的商品</div>
                <div class="this-mc">
                    <div class="pic"><a href="javascript:void(0);"><img src="${applyReport.productPic['']}" alt="${applyReport.productNm}"></a></div>
                    <a href="javascript:void(0);" class="title">${applyReport.productNm}</a>
                    <a href="${webRoot}/product.ac?id=${applyReport.productId}" class="buy-btn">立即购买</a>
                </div>
            </div>
            <div class="other">
                <div class="other-mt">其他试用商品</div>
                <div class="other-mc">
                    <ul>
                        <c:forEach items="${frialProxyPage.result}" var="frial">
                            <c:if test="${frial.freeTrialId != applyReport.freeTrialId}">
                                <li>
                                    <div class="pic"><a href="${webRoot}/tryOutDetail.ac?id=${frial.freeTrialId}"><img src="${frial.defaultImage['']}" alt="${frial.productNm}"></a></div>
                                    <a href="${webRoot}/tryOutDetail.ac?id=${frial.freeTrialId}" class="title">${frial.productNm}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </div>


            <%--<div class="rt-ad"><a href="javascript:void(0);"><img src="${webRoot}/template/bdw/statics/case/pic300x150.jpg" alt=""></a></div>--%>
        </div>
    </div>
    <div class="toolbar">
        <a href="javascript:void(0);" class="share"></a>
        <div class="ewm">
            <div class="ewm-cont"><img src="${webRoot}/template/bdw/statics/case/pic120x120.jpg" alt="二维码"></div>
        </div>
    </div>
</div>

<!--底部-->
<c:import url="/template/bdw/module/common/bottom.jsp"/>


</body>
</html>
