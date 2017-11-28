<%--
  Created by IntelliJ IDEA.
  User: zcj
  Date: 2016/12/19
  Time: 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${sdk:findCpsOfflineMemberOrders(page,3)}" var="offlineMemberOrders"/>

<c:if test="${offlineMemberOrders.totalCount > 0}">
<dl class="member-detal-list">
    <c:forEach items="${offlineMemberOrders.result}" var="offlineMemberOrder" varStatus="s">
        <c:choose>
            <c:when test="${offlineMemberOrder.isCashBack == 'Y'}"><dt>已返现</dt></c:when>
            <c:otherwise><dt class="stress">待返现</dt></c:otherwise>
        </c:choose>
        <dd>
            <ul>
                <li>
                    <span class="lab">成交金额</span>
                    <p class="val">
                        <small>&yen;</small>
                        <fmt:formatNumber value="${offlineMemberOrder.orderTotalAmount}" type="number" pattern="#" />
                        .<small>${offlineMemberOrder.orderTotalAmountDecimal}</small>
                    </p>
                </li>
                <c:choose>
                    <c:when test="${offlineMemberOrder.isCashBack == 'Y'}">
                        <li>
                            <span>已返现金额</span>
                            <p class="val stress">
                                <small>&yen;</small>
                                <fmt:formatNumber value="${offlineMemberOrder.cashbackAmount}" type="number" pattern="#"/>.<small>${offlineMemberOrder.cashbackAmountDecimal}</small>
                            </p>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <span>待返现金额</span>
                            <p class="val stress">
                                <small>&yen;</small>
                                <fmt:formatNumber value="${offlineMemberOrder.waitCashbackAmount}" type="number" pattern="#"/>.<small>${offlineMemberOrder.waitCashbackAmountDecimal}</small>
                            </p>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="order-info">
                <p class="fl">订单号：${offlineMemberOrder.orderNum}</p>
                <span class="fr"><fmt:formatDate value="${offlineMemberOrder.creeateTime}" pattern="yyyy.MM.dd" type="date" /></span>
            </div>
        </dd>
    </c:forEach>
</dl>
</c:if>
