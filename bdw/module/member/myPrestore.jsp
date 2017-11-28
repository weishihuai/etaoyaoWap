<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %><%--分页引用--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:set value="${sdk:getPrestoreTransactionLogs(10)}" var="prestoreTransactionLogs"/><%--当前用户账户余额交易记录列表--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-账户余额 - ${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.ac">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > 账户余额</div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>

    <%--帐户余额显示 start--%>
    <div class="rBox">
        <div class="myMn">
            <h2 class="rightbox_h2_border">帐户余额</h2>
            <div class="box right_box_border">
                <%--<h6>帐户余额：<b>¥${loginUser.prestore}</b></h6>--%>
                <h6 >帐户余额：<b>¥<fmt:formatNumber value="${loginUser.prestore}" type="number" pattern="#0.00#" /></b></h6>
                <%--帐户余额列表显示 start--%>
                <div class="m2">
                    <div class="t_Menu">
                        <ul>
                            <li><a class="cur" href="javascript:void(0)">预存款交易记录</a></li>
                        </ul>
                    </div>
                    <table width="100%" border="0" cellspacing="0">
                        <tr class="tr1">
                            <td class="td1">操作日期</td>
                            <td class="td2">交易前金额</td>
                            <td class="td4">交易后金额</td>
                            <td class="td6">原因</td>
                        </tr>
                        <%--预存款交易记录 start--%>
                        <c:forEach items="${prestoreTransactionLogs.result}" var="transactionLog" varStatus="s">
                            <tr>
                                <td class="td1">${transactionLog.transactionTime}</td>
                                <td class="td2">￥<fmt:formatNumber value="${transactionLog.startAmount}" type="number" pattern="#0.00#" /></td>
                                <td class="td4">￥<fmt:formatNumber value="${transactionLog.endAmount}" type="number" pattern="#0.00#" /></td>
                                <td class="td6">${transactionLog.reason}</td>
                            </tr>
                        </c:forEach>
                        <%--预存款交易记录 end--%>
                        <c:if test="${empty prestoreTransactionLogs.result}">
                            <tr>
                                <td colspan="6" class="col">没有交易记录</td>
                            </tr>
                        </c:if>
                    </table>
                </div>

                <%--帐户余额列表显示 end--%>

                <%--帐户余额列表分页 start--%>
                <div class="page">
                    <div style="float:right">
                        <c:if test="${prestoreTransactionLogs.lastPageNumber > 1}">
                        <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/myPrestore.ac"   totalPages='${prestoreTransactionLogs.lastPageNumber}' currentPage='${prestoreTransactionLogs.thisPageNumber}' totalRecords='${prestoreTransactionLogs.totalCount}' frontPath='${webRoot}'  displayNum='6'/>
                        </c:if>
                    </div>
                </div>
                <%--帐户余额列表分页 send--%>
            </div>
        </div>
    </div>
    <%--帐户余额显示 end--%>
    <div class="clear"></div>
</div>


<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
