
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
<c:set value="${sdk:getUserCartListProxy('normal')}" var="shoppingCartProxy"/>
<%--<link href="${webRoot}/template/jvan/wap/statics/css/menu.css" rel="stylesheet">--%>
<script src="${webRoot}/template/bdw/oldWap/statics/js/prefixfree.min.js"></script>
<%--
<div class="testfield" style="z-index: 9999;">
    <div class="flyout-wrap">
        <a class="flyout-btn" href="javascript:void(0)" title="Toggle"><span>Menu</span></a>
        <ul class="flyout flyout-init">--%>
<c:choose>
    <c:when test="${not empty userProxy}">
        <div class="bottom-item">
            <nav class="bottom-nav">
                <div class="row">
                    <a class="bottom-link col-xs-3" onclick="window.location.href='${webRoot}/wap/index.ac';" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-index.png">
                        <span>首页</span>
                    </a>
                    <a class="bottom-link col-xs-3" onclick="window.location.href='${webRoot}/wap/tuanlist.ac?time='+ new Date().getTime()" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-sale.png">
                        <span>限时活动</span>
                    </a>
                    <a class="bottom-link col-xs-3" onclick="window.location.href='${webRoot}/wap/shoppingcart/cart.ac?time='+ new Date().getTime()" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-cart.png">
                        <span>购物车</span>
                    </a>
                    <a class="bottom-link col-xs-3" onclick="window.location.href='${webRoot}/wap/module/member/index.ac?time='+ new Date().getTime();" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-user.png">
                        <span>个人中心</span>
                    </a>
                </div>
            </nav>
        </div>
    </c:when>
    <c:otherwise>
        <div class="bottom-item">
            <nav class="bottom-nav">
                <div class="row">
                    <a class="bottom-link col-xs-3" onclick="window.location.href='${webRoot}/wap/index.ac';" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-index.png">
                        <span>首页</span>
                    </a>
                    <a class="bottom-link col-xs-3" onclick="window.location.href='${webRoot}/wap/tuanlist.ac?time='+ new Date().getTime();" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-sale.png">
                        <span>限时活动</span>
                    </a>
                    <a class="bottom-link col-xs-3" onclick="window.location.href='${webRoot}/wap/login.ac';" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-cart.png">
                        <span>购物车</span>
                    </a>
                    <a class="bottom-link col-xs-3" onclick="window.location.href='${webRoot}/wap/login.ac';" href="javascript:void(0);">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/icon-user.png">
                        <span>个人中心</span>
                    </a>
                </div>
            </nav>
        </div>
    </c:otherwise>
</c:choose>

<%--        </ul><!-- .flyout -->
    </div><!-- .flyout-wrap -->


</div><!-- #testfield -->--%>



<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/bottom.js"></script>