<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>账户明细</title>
        <meta content="yes" name="apple-mobile-web-app-capable" />
        <meta content="yes" name="apple-touch-fullscreen" />
        <meta content="telephone=no,email=no" name="format-detection" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">
        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/myRebateAccount.css">

        <%-- 获取当前时间 --%>
        <jsp:useBean id="systemTime" class="java.util.Date" />
        <fmt:formatDate value="${systemTime}" var="currentDate" pattern="yyyy-MM-dd HH:mm:ss" type="date"/>
        <fmt:formatDate value="${systemTime}" var="currentYear" pattern="yyyy" />
        <fmt:formatDate value="${systemTime}" var="currentMonth" pattern="MM" />
        <fmt:formatDate value="${systemTime}" var="currentDay" pattern="dd" />

        <%-- 判断要查看的类型 收支明细|提现记录 --%>
        <c:set value="${param.rebateAccountType}" var="rebateAccountType"/>
        <c:set var="indexMonth" value="${empty param.indexMonth ? '' : param.indexMonth}"/>
        <c:set var="indexYear" value="${empty param.indexYear ? '' : param.indexYear}"/>

        <c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
        <c:choose>
            <%-- 收支明细 --%>
            <c:when test="${empty rebateAccountType}">
                <c:set value="${sdk:getMyRebateAccountLogPage(_page,10,monthRange)}" var="rebateAccountLogs"/><%--账户收支明细--%>
                <c:set value="${rebateAccountLogs.lastPageNumber}" var="lastPageNumber"/>
            </c:when>

            <%-- 提现记录 --%>
            <c:when test="${rebateAccountType == 'withdraw'}">
                <c:set value="${sdk:getRebateApprovePage(_page,10,monthRange)}" var="rebateApprovePage"/><%--提现记录--%>
                <c:set value="${rebateApprovePage.lastPageNumber}" var="lastPageNumber"/>
            </c:when>
        </c:choose>

        <script type="text/javascript">
            var webPath = {webRoot:"${webRoot}"};
            var webParams  = {
                webRoot:"${webRoot}",
                lastPageNumber: ${lastPageNumber},          /* 最后一页，按情况而定 */
                rebateAccountType: "${rebateAccountType}" ,    /* 类型 */
                indexMonth:"${indexMonth}",
                indexYear:"${indexYear}"
            };
        </script>
    </head>

    <body style="background-color: #f8f8f8;">
        <%--<header class="header">
            <a href="${webRoot}/wap/module/member/cps/cpsMe.ac" class="back"></a>
            <div class="header-title">账户明细</div>
        </header>--%>

        <div class="main m-account-detail" id="main">
            <ul class="tab-nav">
                <li class="li-tab <c:if test='${empty rebateAccountType}'>active</c:if>" id="detail">
                    <a href="${webRoot}/wap/module/member/cps/myRebateAccount.ac">收支明细</a>
                </li>
                <li class="li-tab <c:if test='${not empty rebateAccountType}'>active</c:if>" id="record">
                    <a href="${webRoot}/wap/module/member/cps/myRebateAccount.ac?rebateAccountType=withdraw">提现记录</a>
                </li>
            </ul>

            <div class="tab-content">
                <c:choose>
                    <%-- 账户收支明细 --%>
                    <c:when test="${empty rebateAccountType}">
                        <div class="tabpanel">
                            <dl class="record">
                                <c:forEach items="${rebateAccountLogs.result}" var="log" varStatus="status">
                                    <fmt:parseDate value="${log.transactionTimeString}" var="trans" pattern="yyyy-MM-dd HH:mm:ss" type="date"/>
                                    <fmt:formatDate value="${trans}" var="year" pattern="yyyy" />
                                    <fmt:formatDate value="${trans}" var="month" pattern="MM" />
                                    <fmt:formatDate value="${trans}" var="day" pattern="dd" />
                                    <fmt:formatDate value="${trans}" var="time" pattern="HH:mm" />
                                    <fmt:formatDate value="${trans}" var="fullDate" type="date" dateStyle="full"/>
                                    <c:set var="fullDateLen" value="${fn:length(fullDate)}"/>
                                    <c:set var="week" value="周${fn:substring(fullDate, fullDateLen - 1, fullDateLen)}"/>
                                    <c:set var="money" value="${log.transactionEndAmount - log.transactionStartAmount}"/>

                                    <c:choose>
                                        <c:when test="${currentYear eq year}"><%--当前年--%>
                                            <c:choose>
                                                <c:when test="${currentMonth eq month}"><%--当前月--%>
                                                    <c:if test="${indexMonth != month}"><%--切换月份--%>
                                                        <dt>本月</dt>
                                                        <c:set var="indexMonth" value="${month}"/>
                                                    </c:if>
                                                    <dd>
                                                        <span class="lab">
                                                            <c:choose>
                                                                <c:when test="${currentDay eq day}"><%--当前天--%>
                                                                    今天
                                                                    <small>${time}</small>
                                                                </c:when>
                                                                <c:otherwise><%--非当前天--%>
                                                                    <c:choose>
                                                                        <c:when test="${currentDay eq (day + 1)}"><%--昨天--%>
                                                                            昨天
                                                                            <small>${time}</small>
                                                                        </c:when>
                                                                        <c:otherwise><%--非昨天--%>
                                                                            ${week}
                                                                            <small>${month}-${day}</small>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                        <p>
                                                            <c:choose>
                                                                <c:when test="${money < 0}"><%--支出--%>
                                                                    <fmt:formatNumber value="${money}"  type="number" pattern="#0.00#"/>
                                                                </c:when>
                                                                <c:otherwise><%--收入--%>
                                                                    &plus;<fmt:formatNumber value="${money}"  type="number" pattern="#0.00#"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                        <p>${log.reason}</p>
                                                    </dd>
                                                </c:when>
                                                <c:otherwise><%--非当前月--%>
                                                    <c:if test="${indexMonth != month}"><%--切换月份--%>
                                                        <dt>${month}月</dt>
                                                        <c:set var="indexMonth" value="${month}"/>
                                                    </c:if>
                                                    <dd>
                                                        <span class="lab">
                                                            ${week}
                                                            <small>${month}-${day}</small>
                                                        </span>
                                                        <p>
                                                            <c:choose>
                                                                <c:when test="${money < 0}"><%--支出--%>
                                                                    <fmt:formatNumber value="${money}"  type="number" pattern="#0.00#"/>
                                                                </c:when>
                                                                <c:otherwise><%--收入--%>
                                                                    &plus;<fmt:formatNumber value="${money}"  type="number" pattern="#0.00#"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                        <p>${log.reason}</p>
                                                    </dd>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise><%--非当前年--%>
                                            <c:if test="${indexYear != year || indexMonth != month}"><%--切换月份--%>
                                                <dt>${year}年${month}月</dt>
                                                <c:set var="indexYear" value="${year}"/>
                                                <c:set var="indexMonth" value="${month}"/>
                                            </c:if>
                                            <dd>
                                                <span class="lab">
                                                    ${week}
                                                    <small>${month}-${day}</small>
                                                </span>
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${money < 0}"><%--支出--%>
                                                            <fmt:formatNumber value="${money}"  type="number" pattern="#0.00#"/>
                                                        </c:when>
                                                        <c:otherwise><%--收入--%>
                                                            &plus;<fmt:formatNumber value="${money}"  type="number" pattern="#0.00#"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p>${log.reason}</p>
                                            </dd>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </dl>
                        </div>
                    </c:when>
                    <%-- 提现记录 --%>
                    <c:otherwise>
                        <div class="tabpanel">
                            <ul class="record">
                                <c:forEach items="${rebateApprovePage.result}" var="rebateApprove" varStatus="status">
                                    <fmt:formatDate value="${rebateApprove.applyDate}" var="applyDate" pattern="yyyy-MM-dd HH:mm:ss" type="date"/>
                                    <li>
                                        <p>
                                          <c:choose>
                                              <c:when test="${rebateApprove.isPayMoney == 'Y'}"> <span class="lab fl">已提现</span> </c:when>
                                              <c:otherwise> <span class="lab stress fl">${rebateApprove.approveStatString}</span> </c:otherwise>
                                          </c:choose>
                                           <span class="val fr">-￥<fmt:formatNumber value="${rebateApprove.cashBackAmount}" type="number" pattern="#0.00#"/></span>
                                        </p>
                                        <p>
                                            <span class="fl">${applyDate}</span>
                                            <span class="fr">&yen;${rebateApprove.aftercCashAmount}</span>
                                        </p>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>

                <%-- 分页滚动加载 --%>
                <nav id="page-nav">
                    <a href="${webRoot}/wap/module/member/cps/myRebateAccount.ac?rebateAccountType=${rebateAccountType}&page=2&indexMonth=${indexMonth}&indexYear=${indexYear}"></a>
                </nav>
            </div>
        </div>

        <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/base.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/myRebateAccount.js" type="text/javascript"></script>
    </body>
</html>
