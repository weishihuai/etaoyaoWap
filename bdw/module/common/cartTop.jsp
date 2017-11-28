<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<c:set value="${bdw:getKeyWord()}" var="keyWordStr"></c:set>
<jsp:useBean id="dataTime" class="java.util.Date" />
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?9781eeadda233d8e366b87735b4feb80";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
<script type="text/javascript">
    var goToUrl = function (url) {
        setTimeout(function () {
            window.location.href = url
        }, 1)
    };
    //isLogin=no 和 isSupplierUser=no 是为了招标管理使用的
    var Top_Path = {webUrl: "${webUrl}", webRoot: "${webRoot}", topParam: "${param.p}", keyword: "${param.keyword}", webName: "${webName}",isLogin:'${param.login}',isSupplierUser:'${param.user}'};
    var top_searchField = "${param.searchField}"
</script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/top.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/addFavorite.js"></script>

<div class="header">
    <div class="shortcut">
        <div class="sh-cont">
            <div class="fl">
                <c:if test="${not empty user}">
                    [&nbsp;<a href="${webRoot}/module/member/index.ac" class="userName">${user.userName}</a>&nbsp;]
                </c:if>
                您好，欢迎来到<a href="${webRoot}/index.ac">${sdk:getSysParamValue('webName')}</a>，开启智赢新机遇！
                <c:choose>
                    <c:when test="${empty user}">
                        &nbsp;&nbsp;&nbsp;&nbsp;<a href="${webRoot}/login.ac" class="login">请登录</a>
                        &nbsp;&nbsp;&nbsp;<a href="${webRoot}/register.ac" class="register">免费注册</a>
                    </c:when>
                    <c:otherwise>
                        <a style="margin-left: 0px;" href="<c:url value='/member/exit.ac?sysUserId=${user.userId}'/>">退出</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <ul class="fr">
                <li class="more">
                    <a href="${webRoot}/module/member/index.ac" class="dt">会员中心</a>
                    <div class="w-block"></div>
                    <div class="dd">
                        <a href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">我的订单</a>
                        <a href="${webRoot}/module/member/productCollection.ac?pitchOnRow=3">我的收藏夹</a>
                        <a href="${webRoot}/module/member/myCoupon.ac?pitchOnRow=17">我的优惠券</a>
                    </div>
                </li>
                <li>|</li>
                <li class="sp-cart">
                    <a href="${webRoot}/shoppingcart/cart.ac" class="dt">购物车</a>
                </li>
                <li>|</li>
                <li>
                    <a href="${webRoot}/attractAgentList.ac" class="dt">我要代理</a>
                </li>
                <li>|</li>
                <li>
                    <a href="${webRoot}/shop/register/registerShopStep01.ac" class="dt">商家入驻</a>
                </li>
                <li>|</li>
                <li class="more frameEdit" frameInfo="sy_index_navigate">
                    <a href="javascript:void(0);" class="dt">网站导航</a>
                    <div class="w-block"></div>
                    <div class="dd">
                        <c:forEach items="${sdk:findPageModuleProxy('sy_index_navigate').links}" var="navigate">
                            <a href="${navigate.link}" title="${navigate.title}" <c:if test="${navigate.newWin}">target="_blank"</c:if> >
                                    ${navigate.title}</a>
                        </c:forEach>
                    </div>
                </li>
                <li>|</li>
                <li>
                    <a href="${webRoot}/help.ac" class="dt">帮助中心</a>
                </li>
            </ul>

        </div>
    </div>
    <div class="header-mc">
        <div class="logo frameEdit"  frameInfo="sy_index_logo" >
            <c:forEach items="${sdk:findPageModuleProxy('sy_index_logo').advt.advtProxy}" var="logo" varStatus="s" end="0">
                ${logo.htmlTemplate}
            </c:forEach>
        </div>
        <c:if test="${param.p == 'cart'}">
            <div class="header-shop-cart">
                <div class="icon">
                    <span class="wire"></span>
                    <span class="dot dot1 ${param.sta > 0?'dot-cur':''}"></span>
                    <span class="dot ${param.sta > 1?'dot-cur':''}"></span>
                    <span class="dot ${param.sta > 2?'dot-cur':''}"></span>
                </div>
                <div class="txt"><span class="cur">我的购物车</span><span>填写订单信息</span><span>提交订单</span></div>
            </div>
        </c:if>
        <c:if test="${param.p == 'drug'}">
            <div class="header-shop-cart header-shop-cart2">
                <div class="icon">
                    <span class="wire"></span>
                    <span class="dot dot1 ${param.sta > 0?'dot-cur':''}"></span>
                    <span class="dot ${param.sta > 1?'dot-cur':''}"></span>
                    <span class="dot ${param.sta > 2?'dot-cur':''}"></span>
                    <span class="dot ${param.sta > 3?'dot-cur':''}"></span>
                </div>
                <div class="txt"><span class="cur">提交预定需求</span><span>药师回拨</span><span>线下付款</span><span>结束流程</span></div>
            </div>
        </c:if>
        <c:if test="${empty param.p}">
            <div class="header-shop-cart">
                <div class="icon">
                    <span class="wire" style="width: 100%"></span>
                    <span class="dot dot1 ${param.sta > 0?'dot-cur':''}"></span>
                    <span class="dot ${param.sta > 1?'dot-cur':''}"></span>
                    <span class="dot ${param.sta > 2?'dot-cur':''}"></span>
                </div>
                <div class="txt"><span >我的购物车</span><span>填写订单信息</span><span class="cur">提交订单</span></div>
            </div>
        </c:if>
    </div>
</div>

