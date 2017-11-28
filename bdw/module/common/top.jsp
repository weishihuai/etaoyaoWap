<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--<c:set value="${sdk:getUserCartListProxy('normal')}" var="cart"/>--%>
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
<script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/loginValidate_top.js"></script>
<script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/loginValidateCode.js"></script><%--登录验证插件--%>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.md5.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart_sidebar.js"></script>
<div class="header" id="header">
    <div class="shortcut">
        <div class="sh-cont">
            <div class="fl">
                <c:if test="${not empty user}">
                    [&nbsp;<a href="${webRoot}/module/member/index.ac" class="userName">${user.userName}</a>&nbsp;]
                </c:if>
                您好，欢迎来到<a href="${webRoot}/index.ac">${sdk:getSysParamValue('webName')}</a>，为您的健康加油！
                <c:choose>
                    <c:when test="${empty user}">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="${webRoot}/login.ac" class="login">请登录</a>
                        &nbsp;&nbsp;&nbsp;
                        <a href="${webRoot}/register.ac" class="register">免费注册</a>
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
                <li>
                    <a href="${webRoot}/shop/register/registerOutletStep01.ac" class="dt">门店入驻</a>
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
                    <a href="${webRoot}/help-60010.html" class="dt">帮助中心</a>
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
        <div class="search">
            <div class="form">
                <div class="search-sel">
                    <c:choose>
                        <c:when test="${param.p eq 'shop' and not empty keyWordStr}">
                            <span>搜店铺</span>
                        </c:when>
                        <c:otherwise>
                            <span>搜商品</span>
                        </c:otherwise>
                    </c:choose>
                    <div class="sel-cont">
                        <a href="javascript:;" id="search-product">搜商品</a>
                        <a href="javascript:;" id="search-shop">搜店铺</a>
                    </div>
                </div>
                <form id="searchProductForm" action="${webRoot}/productlist.ac" method="get">
                    <input type="text" id="searchFields" name="keyword" value="${not empty keyWordStr ? keyWordStr : '请输入批准文号、通用名、商品名'}" onfocus="toFocus()" maxlength="50" placeholder="请输入批准文号、通用名、商品名">
                    <a href="javascript:void(0)" class="search-btn" onclick="productSearchSubmit()">搜索</a>
                </form>

                <%--搜索店铺的暂不使用--%>
                <form id="searchShopForm" action="${webRoot}/shop.ac" method="get"  style="display:none">
                    <input type="text" id="searchFieldshop" name="keyword" value="${not empty keyWordStr ? keyWordStr : ''}" onfocus="toFocus()" maxlength="50" placeholder="请输入店铺关键字">
                    <a href="javascript:void(0)" class="search-btn" onclick="toShopSearchSubmit()">搜索</a>
                </form>
            </div>
            <div class="hotwords elli">
                <span>热门搜索 :</span>
                <c:forEach items="${sdk:findKeywordByCategoryId(1,10)}" var="hotKeyword">
                    <a href="${webRoot}/productlist.ac?keyword=${hotKeyword}" title="${hotKeyword}" target="_blank">${hotKeyword}</a>
                </c:forEach>
            </div>
        </div>
        <div class="security" frameInfo="sy_index_security_logo">
            <div class=" frameEdit" frameInfo="sy_index_security_logo">
                <c:forEach items="${sdk:findPageModuleProxy('sy_index_security_logo').advt.advtProxy}" var="slogan" varStatus="s" end="0">
                    ${slogan.htmlTemplate}
                    <%--<img src="${slogan.advUrl}" alt="${slogan.advtHint}">--%>
                </c:forEach>
            </div>
        </div>
    </div>

    <!--导航菜单-->
    <div class="nav-bg">
        <c:set value="${sdk:findAllProductCategory()}" var="allProductCategory"/>
        <c:set value="${sdk:getShopRoot(2)}" var="shopRoot"/>  <%--默认预设商家shopId=2--%>
        <c:set value="${param.shopCategoryId==null ? shopRoot : param.shopCategoryId}" var="categoryId"/>
        <c:set value="${sdk:getChildren(categoryId,2)}" var="shopCategory"/>
        <div class="nav">
            <div class="category" rel="${param.p}">
                <div class="nav-dt"><a href="${webRoot}/productlist-1.html" target="_blank">全部商品分类</a></div>
                <div class="nav-dc dc-inner" <c:if test="${param.p != 'index'}">style="display: none;"</c:if>>
                    <c:forEach items="${allProductCategory}" var="category" varStatus="i" end="6">
                        <div class="item">
                            <div class="menus">
                                <div class="menu-top">
                                    <div class="menu-icon"><img src="${category.icon['']}"></div>
                                    <span onclick="searchMenu(${category.categoryId})">${category.name}</span>
                                </div>
                                <div class="menu-cont">
                                    <c:choose>
                                        <c:when test="${category.categoryId == '85'}">
                                            <c:forEach items="${category.children}" var="child" varStatus="c">
                                                <!-- 找到categoryId为大药房的节点 -->
                                                <a href="http://www.sydyf.com/index.ac" target="_blank">${child.name}</a>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${category.children}" var="child" varStatus="c">
                                                <a href="${webRoot}/productlist-${child.categoryId}.html" title="${child.name}" target="_blank">${child.name}</a>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="item-sub-inner">
                    <c:forEach items="${allProductCategory}" var="category" varStatus="i" end="9">
                        <c:set var="sy_index_hotSale_down" value="sy_index_hotSale_down${i.index+1}" />
                        <c:set var="sy_index_hotSale_up" value="sy_index_hotSale_up${i.index+1}" />
                        <div class="item-sub">
                            <div class="sub-lt">
                                <c:forEach items="${category.children}" var="child" varStatus="c">
                                    <div class="dl">
                                        <div class="dt"><a href="${webRoot}/productlist-${child.categoryId}.html" target="_blank">${child.name}</a></div>
                                        <div class="dd">
                                            <c:choose>
                                                <c:when test="${category.categoryId == '85'}">
                                                    <c:forEach items="${child.children}" var="threeChild" varStatus="s">
                                                        <!-- 找到categoryId为大药房的节点 -->
                                                        <a href="http://www.sydyf.com/index.ac" target="_blank">${threeChild.name}</a>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${child.children}" var="threeChild" varStatus="s">
                                                        <a href="${webRoot}/productlist-${threeChild.categoryId}.html" title="${threeChild.name}" target="_blank">${threeChild.name}</a>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="sub-rt">
                                <div class="brand frameEdit"  frameInfo="${sy_index_hotSale_up}">
                                    <div class="brand-mt">热门品牌</div>
                                    <div class="brand-mc">
                                        <c:forEach items="${sdk:findPageModuleProxy(sy_index_hotSale_up).advt.advtProxy}" var="hotSale" end="11">
                                            ${hotSale.htmlTemplate}
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="rt-ad frameEdit" frameInfo=${sy_index_hotSale_down}>
                                    <c:forEach items="${sdk:findPageModuleProxy(sy_index_hotSale_down).advt.advtProxy}" var="hotSale" end="0">
                                        ${hotSale.htmlTemplate}
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <ul class="main-nav frameEdit" frameInfo="sy_top_menu">
                <c:forEach items="${sdk:findPageModuleProxy('sy_top_menu').links}" var="menu">
                    <c:choose>
                        <c:when test="${empty menu.description}">
                            <li>
                                <a href="${menu.link}" class="dt" <c:if test="${menu.newWin}">target="_blank"</c:if> >${menu.title}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="more">
                                <a href="javascript:void(0);" class="dt" <c:if test="${menu.newWin}">target="_blank"</c:if> >${menu.title}</a>
                                <div class="w-block"></div>
                                <div class="dd">
                                    <c:forEach items="${fn:split(menu.description,';')}" var="titleAndHerf" varStatus="s">
                                        <c:set value="${fn:split(titleAndHerf,',')}" var="element"/>
                                        <a href="${element[1]}" target="_blank">${element[0]}</a>
                                    </c:forEach>
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- 侧边栏 -->
    <div class="sidebar">
        <div class="sidebar-vip">
            <div class="dt" data-onoff="true" id="sidebar-user"  isLogin = ${not empty user ? "Y" : "N"} ><div class="dt-zz"><em class="icon"></em></div><span class="span-tip">会员</span></div>
            <c:if test="${not empty user}">
                <c:set value="${bdw:getCardPage(1,999,'Y')}" var="cardProxyPage"/>
                <div class="dd" id="sidebar-user-detail">
                    <div class="sidebar-vip-title">
                        <c:set value="${user.icon['80X80']}" var="bigUserIcon"/>
                        <c:choose>
                            <c:when test="${empty bigUserIcon}">
                               <img  class="pic"  src="${webRoot}/template/bdw/module/member/statics/images/member_userPic_80_80.gif" />
                            </c:when>
                            <c:otherwise>
                               <img  class="pic"  id="fileId80" src="${bigUserIcon}" />
                            </c:otherwise>
                        </c:choose>
                        <p id="sidebarUserName">Hi , ${user.userName}<br>欢迎来到易淘药</p>
                    </div>
                    <ul class="sidebar-vip-inner">
                        <li class="item1"><a href="${webRoot}/module/member/myPrestore.ac?pitchOnRow=15"><em></em><span>账户余额</span><span class="number">${user.prestore}</span></a></li>
                        <li class="item2"><a href="${webRoot}/module/member/myIntegral.ac?pitchOnRow=16" ><em></em><span>账户积分</span><span class="number"> ${user.integral} </span></a></li>
                        <li class="item3"><a href="${webRoot}/module/member/myCoupon.ac?pitchOnRow=17&is=N"><em></em><span>优惠券</span><span class="number">${fn:length(user.unusedCoupon)}</span></a></li>
                        <li class="item4"><a href="${webRoot}/module/member/myCard.ac?pitchOnRow=21&isBind=N" ><em></em><span>礼品卡</span><span class="number">${fn:length(cardProxyPage.result)}</span></a></li>
                    </ul>
                </div>
                <div class="icon-lx"></div>
            </c:if>
        </div>

        <div class="sidebar-cart">
            <div class="dt" data-onoff="true" id="sidebar-cart" isLogin = ${not empty user ? "Y" : "N"}><em class="icon"></em><p >购物车</p><i  id="CartTotalNumSidebar">0</i></div>
            <div id="buycart-main" style="display: none">

            </div>



        </div>

        <div class="sidebar-collect">
            <div class="dt" data-onoff="true" id="sidebar-collect" isLogin = ${not empty user ? "Y" : "N"}><div class="dt-zz"><em class="icon"></em></div><span class="span-tip">收藏</span></div>
            <div id="collect-main" style="display: none">
            </div>
        </div>

        <div class="sidebar-message">
            <div class="dt" data-onoff="true"><a class="dt-zz" onclick="messageSidebar(this)" href="javascript:;" isLogin = ${not empty user ? "Y" : "N"} ><em class="icon"></em><i>${empty user.sysMsgCount ? 0 : user.sysMsgCount}</i></a><span class="span-tip">我的消息</span></div>
        </div>

        <div class="sidebar-feedback">
            <div class="dt" data-onoff="true" id="sidebar-feedback" isLogin = ${not empty user ? "Y" : "N"}><div class="dt-zz"><em class="icon"></em></div><span class="span-tip">用户反馈</span></div>
            <div id="feedback-main" style="display: none">
            </div>
        </div>
        <div class="sidebar-back">
            <div class="dt" data-onoff="true"><div class="dt-zz"><em class="icon"></em></div><span class="span-tip">返回顶部</span></div>
        </div>
    </div>

    <!-- 登录框 -->
    <c:if test="${param.pageName != 'login'}">
    <div class="login-fixed" style="display: none;">
        <form method="post"  id="loginForm" name="loginForm" >
            <div class="login-dt">
                <span>会员登录</span>
                <a class="close sideBarUserClose" href="javascript:;"></a>
            </div>
            <div class="login-dd">
                <div class="item item-fore1">
                    <label class="login_name"> <input id="loginId" autocomplete="off" placeholder="请输入手机号" type="text"  onclick="getFocus(this,'请输入手机号')" tabindex="1"><em></em><span class="clear-btn"></span></label>
                </div>
                <div class="item item-fore2">
                    <label class="login_password"><input type="password" autocomplete="off" id="userPsw" name="userPsw" tabindex="2" placeholder="请输入密码"><em></em></label>
                </div>
                <div style="   padding-right: 5px; text-align: right;  width: 315px; ">
                    <div  id="alert" style="display: none; width:235px;height: 27px;float: left;   margin-bottom: 18px;">
                        <div class="l-l"></div>
                        <div class="t-b" id="alerttext"></div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                    <div id="alert2" style="display: none;width:248px;height: 27px;float: left;   margin-bottom: 18px;">
                        <div class="l-l"></div>
                        <div class="t-b" id="alerttext1"></div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                    <div id="alert3" style="display: none;width:248px;height: 27px;float: left;   margin-bottom: 18px;">
                        <div class="l-l"></div>
                        <div class="t-b" id="alerttext2"></div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="item item-fore3">
                    <input name="" value="登录" onclick="$('#loginForm').submit();" type="button">
                </div>
                <div class="item item-fore4">
                    <a href="/fetchPsw/fetchPsw.ac">忘记密码</a>
                    <a href="/register.ac">新用户注册</a>
                </div>
            </div>
        </form>
    </div>
    </c:if>
</div>

