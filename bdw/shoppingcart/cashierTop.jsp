<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<div class="header">
    <div class="shortcut">
        <div class="sh-cont">
            <div class="fl">
                <c:if test="${not empty user}">
                    [&nbsp;<a href="${webRoot}/module/member/index.ac" class="userName">${user.userName}</a>&nbsp;]
                </c:if>
                您好，欢迎来到<a href="${webRoot}/index.ac">${sdk:getSysParamValue('webName')}</a>
                <c:choose>
                    <c:when test="${empty user}">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        [<a href="${webRoot}/login.ac" class="login">登录</a>]
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="${webRoot}/checkMobile.ac" class="register">免费注册</a>
                    </c:when>
                    <c:otherwise>
                        [<a style="margin-left: 0px;" href="<c:url value='/member/exit.ac?sysUserId=${user.userId}'/>">退出</a>]
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
                <li>|</li>
                <li class="more frameEdit" frameInfo="sy_shiyao_brand">
                    <a href="javascript:void(0);" class="dt">易淘药品牌</a>
                    <div class="w-block"></div>
                    <div class="dd">
                        <c:forEach items="${sdk:findPageModuleProxy('sy_shiyao_brand').links}" var="brand">
                            <a href="${brand.link}" title="${brand.title}" <c:if test="${brand.newWin}">target="_blank"</c:if> >${brand.title}</a>
                        </c:forEach>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="hd-header">
    <div class="hd-top">
        <div class="logo frameEdit"  frameInfo="sy_index_logo">
            <c:forEach items="${sdk:findPageModuleProxy('sy_index_logo').advt.advtProxy}" var="logo" varStatus="s" end="0">
                <a href="${logo.link}"><img src="${logo.advUrl}"></a>
            </c:forEach>
        </div>
        <div class="hd-rt step3">
            <c:if test="${orderType eq 'integralOrder'}">
                <span class="m1"><i>兑换积分商品</i></span>
            </c:if>
            <c:if test="${orderType eq 'order'}">
                <span class="m1"><i>我的购物车</i></span>
            </c:if>
            <span class="m2"><i>填写订单信息</i></span>
            <span class="m3"><i>提交订单</i></span>
        </div>
    </div>
</div>