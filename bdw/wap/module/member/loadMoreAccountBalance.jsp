<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLastHalfYeayPrestoreTransactionLogs(param.pageSize)}" var="prestoreTransactionLogs"/>

<c:if test="${fn:length(prestoreTransactionLogs.result) == 0}">
    <div class="row" >
        <div style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
    </div>
</c:if>

<c:forEach items="${prestoreTransactionLogs.result}" var="logs">
    <c:set value="${sdk:abs(logs.transactionAmount)}" var="transactionAmount"/>
    <a href="${webRoot}/template/bdw/wap/module/member/accountTransactionDetails.jsp?logId=${logs.accountTransactionLogId}"><div class="dd-item"><div class="middle-box"><p class="info">${logs.reason}</p></div><p class="price price-add"><c:choose><c:when test="${logs.transactionAmount > 0}">+¥${logs.transactionAmount}</c:when><c:otherwise>-¥${transactionAmount}</c:otherwise></c:choose></p><span class="time">${logs.transactionTime}</span></div></a>
</c:forEach>
