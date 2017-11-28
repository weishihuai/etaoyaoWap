<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<jsp:useBean id="systemTime" class="java.util.Date" />
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%-- 获取试用列表 --%>
<c:set value="${bdw:findFrialProxy(0,3)}" var="frialProxyPage"/>
<%-- 获取其它商品 --%>
<c:set var="promotionProductProxies" value="${sdk:findPageModuleProxy('sy_panic_buy').recommendPromotionProducts}"/>
<%--  --%>

<head>
    <meta property="qc:admins" content="3553273717624751446375" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="易淘药免费试用，果维康免费试吃，易淘药，易淘药集团，易淘药大健康，果维康，溯源商城，药食同源，欧意，欧意和，若舒，恩必普，易淘药电商，安沃勤，纯净冰岛，安蜜乐，易淘药贝贝，易淘药健康城"/>
    <meta name="description" content="易淘药健康网，易淘药集团官方网站，易淘药免费试用，果维康免费试吃"/>
    <title>${sdk:getSysParamValue('index_title')}</title>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/tryOutList.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}", systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"};

        $(document).ready(function(){
            var times = $(".countdownTime");
            times.each(function(){
                imallCountdown($(this).attr("endDate"), webPath.systemTime ,$(this));
            })
        });

        function imallCountdown(entTime, systemTime,nowThis) {
            var showCoutdown = nowThis;
            var sh;
            var endtimeStr = entTime.replace(/-/g, "/");
            var endTime = new Date(endtimeStr);
            var nowtime = new Date(systemTime);
            var leftsecond = parseInt((endTime.getTime() - nowtime.getTime()) / 1000);
            if(leftsecond > 0){
                sh = setInterval(function () {
                    if(leftsecond <= 0){
                        showCoutdown.html("剩余时间：<i>过期</i>");
                        clearInterval(sh);
                        window.location.reload();
                    }
                    fresh(showCoutdown, leftsecond);
                    leftsecond -= 1;
                }, 1000);
            }
        }
        function fresh(showCoutdown, leftsecond) {
            var d = parseInt(leftsecond / 3600 / 24);
            var h = parseInt((leftsecond / 3600) % 24);
            var m = parseInt((leftsecond / 60) % 60);
            var s = parseInt(leftsecond % 60);
            showCoutdown.html("<i>剩余时间</i><span>" + d + "</span>天<span>" + h + "</span>时<span> " + m + " </span>分<span> " + s + "</span>秒");
        }
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<!--页头结束-->
<div class="main">
    <div class="past">
        <div class="first">
            <span><a href="${webRoot}/index.ac">首页</a></span>
            <i class="crumbs-arrow"></i>
        </div>
        <a href="#" class="cata">免费试用</a>
    </div>
    <div class="w clearfix">
        <div class="fl">
            <c:forEach  items="${frialProxyPage.result}" var="frial">
                <div class="fl-item">
                    <div class="pic">
                        <img src="${frial.defaultImage['']}" alt="${frial.productNm}">
                        <div class="time countdownTime" endDate="${frial.endDateString}"></div>
                    </div>
                    <a href="${webRoot}/tryOutDetail.ac?id=${frial.freeTrialId}" class="title">${frial.productNm}  </a>
                    <div class="rt-cont">
                        <div class="price">产品价值<span><em>¥</em>${frial.valueAmount}</span></div>
                        <div class="copies">限量试用<span>${frial.stock}</span>份</div>
                        <div class="num"><span>${frial.applyTotal}</span>人已申请，赶紧去申请吧！</div>
                        <c:choose>
                            <c:when test="${systemTime < frial.endDate && systemTime > frial.startDate}">
                                <c:choose>
                                    <c:when test="${frial.stock>frial.applyTotal}">
                                        <a href="${webRoot}/tryOutDetail.ac?id=${frial.freeTrialId}" class="sq-btn">申请试用</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:" class="sq-btn1">申请人数已满</a>
                                    </c:otherwise>
                                </c:choose>



                            </c:when>
                            <c:otherwise>
                                <a href="${webRoot}/tryOutDetail.ac?id=${frial.freeTrialId}" class="sq-btn">查看详情</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="condition">
                        ${frial.applyRule}
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="fr">
            <div class="item">
                <h4>免费试用流程</h4>
                <div class="flow">
                    <ul>
                        <li class="elli">具备试用资格</li>
                        <li class="elli">积分抵押参与免费试用商品申请</li>
                        <li class="elli">提交300字以上试用报告</li>
                        <li class="elli">返还申请时抵押积分</li>
                        <li class="elli">获得免费试用奖励</li>
                    </ul>
                </div>
            </div>
            <div class="item">
                <h4>什么是免费试用？</h4>
                <p>免费试用是专注于消费领域的试用平台，在这里网友们不仅能体验新品，更能通过输出真实客观的试用报告来分享使用心得。</p>
            </div>

            <%-- 其它使用商品 --%>
            <div class="item other">
                <h5>其他商品</h5>
                <ul>
                    <c:forEach items="${promotionProductProxies}" var="pro">
                        <li>
                            <div class="pic"><a href="${webRoot}/product.ac?id=${pro.productId}" target="_blank"><img src="${pro.defaultImage['']}" alt="${pro.name}"></a></div>
                            <a href="${webRoot}/product.ac?id=${pro.productId}" class="title" target="_blank">${pro.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <div class="pager">
        <c:if test="${frialProxyPage.lastPageNumber > 1}">
            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${frialProxyPage.lastPageNumber}' currentPage='${_page}' totalRecords='${frialProxyPage.totalCount}' ajaxUrl='${webRoot}/tryOutList.ac' frontPath='${webRoot}' displayNum='6'/>
        </c:if>
    </div>
</div>

<!--底部-->
<c:import url="/template/bdw/module/common/bottom.jsp"/>


</body>
</html>
