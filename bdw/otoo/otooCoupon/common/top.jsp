<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<script type="text/javascript" src="${webRoot}/template/bdw/otoo/otooCoupon/js/top.js"></script>

<div class="l_header_bg">
    <div class="l_header">
        <%--<div class="h-lt"><img src="${webRoot}/template/bdw/otoo/otooCoupon/images/l_logo.png" width="180" height="80" /></div>--%>
        <div class="h-md">

            <span>购物券查询中心</span>
            <!--如果是在已登录的状态该div显示-->
            <div class="hm-btn">
                <a href="${webRoot}/otoo/otooCoupon/couponsSearch.ac" <c:if test="${not empty param && param.p=='couponsSearch'}">class="cur"</c:if>>消费券查询</a>
                <a href="${webRoot}/otoo/otooCoupon/couponsSearchList.ac" <c:if test="${not empty param && param.p=='couponsSearchList'}">class="cur"</c:if>>消费券列表</a>
            </div>
            <%--<a href="javascript:void(0)" onclick="shopExit()">退出</a>--%>
        </div>
        <div class="h-rt">
            <i><c:set value="${sdk:getSysParamValue('webPhone')}" var="webPhone"/></i>
            <span>如需帮助，服务热线：${webPhone}</span>
        </div>
    </div>
</div>
