<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLastHalfYearIntegralTransactionLogs(param.pageSize)}" var="integralTransactionLogs"/><%--当前用户积分记录列表--%>

<c:if test="${fn:length(integralTransactionLogs.result) == 0}">
    <div class="row" >
        <div style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
    </div>
</c:if>

<c:forEach items="${integralTransactionLogs.result}" var="transactionLog">
    <a href="${webRoot}/template/bdw/wap/module/member/integralTransactionDetails.jsp?logId=${transactionLog.accountTransactionLogId}">
    <div class="dd-item">
        <div class="middle-box">
            <p class="info">${transactionLog.reason}</p>
        </div>
        <p class="price price-add"><fmt:formatNumber value="${transactionLog.transactionAmount}" pattern="0"/></p>
        <span class="time">${transactionLog.transactionTime}</span>
    </div>
    </a>
</c:forEach>

