
<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-25
  Time: 下午5:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>

<div style="height:55px"></div>
·
<div class="bottom-item">
    <nav class="bottom-nav">
        <div class="row frameEdit" frameInfo="wap_bottom_menu">
            <c:choose>
                <c:when test="${not empty sdk:findPageModuleProxy('wap_bottom_menu').links}">
                    <c:set value="${fn:length(sdk:findPageModuleProxy('wap_bottom_menu').links)}" var="amount"/>
                    <c:set value="${100/(amount)}" var="width"/>
                    <c:forEach items="${sdk:findPageModuleProxy('wap_bottom_menu').links}" var="menu_link" end="${amount-1}">
                        <a class="bottom-link <%--col-xs-3--%>" style="width: ${width}%" onclick="window.location.href='${menu_link.link}'" href="javascript:void(0);">
                            <img src="${menu_link.icon['']}" alt=""/>
                            <span>${fn:substring(menu_link.title,0,4)}</span>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <%--默认显示这几个--%>
                    <a class="bottom-link<%-- col-xs-3--%>" style="width: 25%" onclick="window.location.href='${webRoot}/wap/index.ac';" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-index.png">
                        <span>首页</span>
                    </a>
                    <a class="bottom-link<%-- col-xs-3--%>" style="width: 25%" style="width: 20%" onclick="window.location.href='${webRoot}/wap/limitActivity.ac?time='+ new Date().getTime()" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/activity.gif">
                        <span>限时活动</span>
                    </a>
                    <a class="bottom-link<%-- col-xs-3--%>" style="width: 25%" onclick="window.location.href='${webRoot}/wap/shoppingcart/cart.ac?time='+ new Date().getTime()" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-cart.png">
                        <span>购物车</span>
                    </a>
                    <a class="bottom-link<%-- col-xs-3--%>" style="width: 25%" onclick="window.location.href='${webRoot}/wap/module/member/index.ac?time='+ new Date().getTime();" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-user.png">
                        <span>个人中心</span>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</div>
<script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
