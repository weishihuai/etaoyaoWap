<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${sdk:getIntegralTransactionLogs(5)}" var="integralTransactionLogs"/><%--当前用户积分记录列表--%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${webName}-我的积分</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <%--<script src="${webRoot}/template/jvan/wap/statics/js/stickUp.min.js" type="text/javascript" ></script>--%>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
        var data = {
            page: "${page}",
            lastPageNumber: "${integralTransactionLogs.lastPageNumber}",
            webRoot: "${webRoot}"
        };
//        jQuery(function($) {
//            $(document).ready( function(){$('.jf_rows').stickUp(); });
//        });
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=我的积分"/>
<%--页头结束--%>

<%--<div>--%>
<%--<a href="${webRoot}/wap/integralList.ac" >--%>
    <%--<div class="row jf_rows" style=" background: #fff; color: #333; box-shadow:1px 4px 5px #DDD;">--%>
        <%--<div class="col-xs-7" style="margin-left:10px;">积分余额：<b style="color: #cc0000;"><fmt:formatNumber value="${loginUser.integral}" pattern="0"/></b></div>--%>
        <%--<div class="col-xs-3 text-right">兑换礼品</div>--%>
        <%--<div class="col-xs-1"><span class="glyphicon glyphicon-chevron-right jf_icon" style="margin-top: 17px;"></span></div>--%>
    <%--</div>--%>
<%--</a>--%>
<a>
    <div class="row jf_rows" style=" background: #fff; color: #333; box-shadow:1px 4px 5px #DDD;">
        <div class="col-xs-7" style="margin-left:10px; font-size: 1.4rem;">积分余额：<b style="color: #cc0000;"><fmt:formatNumber value="${loginUser.integral}" pattern="0"/></b></div>
        <%--<div class="col-xs-3 text-right">兑换礼品</div>--%>
        <%--<div class="col-xs-1"><span class="glyphicon glyphicon-chevron-right jf_icon" style="margin-top: 17px;"></span></div>--%>
    </div>
</a>
<c:choose>
    <c:when test="${empty loginUser||fn:length(integralTransactionLogs.result)==0}">
        <div class="row" >
            <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
        </div>
    </c:when>
    <c:otherwise>
        <%--积分记录列表 start--%>
        <c:forEach items="${integralTransactionLogs.result}" var="transactionLog">
            <div class="container jf_box" style="padding: 10px 0;">
                <div class="row b_rows">
                    <div class="col-xs-12">交易前积分：<fmt:formatNumber value="${transactionLog.startAmount}" pattern="0"/></div>
                </div>
                <div class="row b_rows">
                    <div class="col-xs-12">交易积分：<fmt:formatNumber value="${transactionLog.transactionAmount}" pattern="0"/></div>
                </div>
                <div class="row b_rows">
                    <div class="col-xs-12">交易后积分：<fmt:formatNumber value="${transactionLog.endAmount}" pattern="0"/></div>
                </div>
                <div class="row b_rows">
                    <div class="col-xs-12">时间：${transactionLog.transactionTime}</div>
                </div>
                <div class="row b_rows">
                    <div class="col-xs-12">来源：${transactionLog.reason}</div>
                </div>
            </div>
        </c:forEach>
        <%--积分记录列表分页 start--%>
        <div class="pn-page row text-center" style="padding-bottom: 10px;">
            <form action='${webRoot}/wap/module/member/myIntegral.ac' id="pageForm" method="post" style="display: inline;"
                  totalPages='${integralTransactionLogs.lastPageNumber}' currentPage='${page}'
                  frontPath='${webRoot}' displayNum='6'
                  totalRecords='${integralTransactionLogs.totalCount}'>
                <c:if test="${integralTransactionLogs.lastPageNumber >1}">
                    <c:choose>
                        <c:when test="${integralTransactionLogs.firstPage}">
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${page-1}">上一页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" href="?page=1">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page-1}">上一页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="col-xs-2">
                        <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                                data-toggle="dropdown">
                                ${page}/${integralTransactionLogs.lastPageNumber} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" style="width:50px; height: 160px; overflow-y: scroll;">

                            <c:forEach begin="1" end="${integralTransactionLogs.lastPageNumber}" varStatus="status">

                                <li><a href="?page=${status.index}">第${status.index}页</a></li>

                            </c:forEach>
                        </ul>
                    </div>
                    <c:choose>
                        <c:when test="${integralTransactionLogs.lastPage}">
                            <div class="col-xs-3">

                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${integralTransactionLogs.lastPageNumber}">末页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page+1}">下一页</a>

                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default"
                                   href="?page=${integralTransactionLogs.lastPageNumber}">末页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </form>
        </div>
        <%--积分记录列表分页 end--%>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>

 <%--</div>--%>
</body>
</html>
