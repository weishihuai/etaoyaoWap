<%--
  Created by IntelliJ IDEA.
  User: zcj
  Date: 2016/12/16
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>我的下线会员详情</title>
    <meta name="viewport"
          content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width">

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">

    <c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
    <c:set value="${empty param.page ? 1 : param.page}" var="page"/>
    <c:set value="${sdk:getUser(param.sysUserId)}" var="sysUser"/>
    <c:set value="${sdk:calcOfflineMemberOrderClearing(param.sysUserId)}" var="offlineMemberClearing"/>
    <c:set value="${sdk:findCpsOfflineMemberOrders(page,3)}" var="offlineMemberOrders"/>
</head>
<body>
<!--判断用户是否登录-->
<c:choose>
    <c:when test="${empty loginUser}">
        <c:redirect url="${webUrl}/cps/cpsPromote.ac?unid=${param.unid}&target=${webUrl}?1=1"/>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${loginUser.isPopularizeMan eq 'Y'}">
                <c:set value="${sdk:getPromoteMemberByLoginUserId()}" var="memberInfo"/><!--会员信息，通过登录用户的id获得推广员对象-->
                <div class="main m-my-member-drawal" id="main">
                    <div class="my-info">
                        <span class="my-img">
                            <img src="${offlineMemberClearing.icon["100X100"]}" alt="">
                        </span>
                        <div class="my-property">
                            <em>${offlineMemberClearing.loginId}</em>

                            <p>姓名：${offlineMemberClearing.userNm}&emsp;</p>

                            <p>手机：${offlineMemberClearing.mobile}</p>

                            <p>
                                <c:choose>
                                    <c:when test="${offlineMemberClearing.isExpiration == 'Y'}">
                                        已过期
                                    </c:when>
                                </c:choose>
                            </p>
                        </div>
                    </div>
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
                                            ${fn:substring(offlineMemberOrder.orderTotalAmount, 0, fn:indexOf(offlineMemberOrder.orderTotalAmount,'.'))}.<small>${offlineMemberOrder.orderTotalAmountDecimal}</small>
                                        </p>
                                    </li>
                                    <c:choose>
                                        <c:when test="${offlineMemberOrder.isCashBack == 'Y'}">
                                            <li>
                                                <span>已返现金额</span>
                                                <p class="val stress">
                                                    <small>&yen;</small>
                                                        ${fn:substring(offlineMemberOrder.cashbackAmount, 0, fn:indexOf(offlineMemberOrder.cashbackAmount,'.'))}.<small>${offlineMemberOrder.cashbackAmountDecimal}</small>
                                                </p>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <span>待返现金额</span>
                                                <p class="val stress">
                                                    <small>&yen;</small>
                                                    ${fn:substring(offlineMemberOrder.waitCashbackAmount, 0, fn:indexOf(offlineMemberOrder.waitCashbackAmount,'.'))}.<small>${offlineMemberOrder.waitCashbackAmountDecimal}</small>
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
                    <nav id="page-nav">
                        <a href="${webRoot}/wap/module/member/cps/loadCpsMyMemberDrawal.ac?page=2&sysUserId=${param.sysUserId}"></a>
                    </nav>
                </div>

            </c:when>
            <c:otherwise>
                <!--不是推广员，跳回首页-->
                <c:redirect url="${webUrl}/cps/cpsPromote.ac?unid=${param.unid}&target=${webUrl}?1=1"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
</body>
</html>

<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
<script type="text/javascript">
    var webPath = {
        lastPageNumber:${offlineMemberOrders.lastPageNumber},
        webRoot: "${webRoot}"
    };
    var readedpage = 1;//当前滚动到的页数
    var lastPageNumber = webPath.lastPageNumber;
    $(document).ready(function () {
        $("#main").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".member-detal-list",
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function (newElements) {
            readedpage++;
            if (readedpage > lastPageNumber) {//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#main").infinitescroll({state: {isDone: true}, extraScrollPx: 50});
            } else {
                $("#page-nav a").attr("href", webPath.webRoot + "${webRoot}/wap/module/member/cps/loadCpsMyMemberDrawal.ac?sysUserId=${param.sysUserId}&page=" + readedpage);
            }
        });
    });
</script>