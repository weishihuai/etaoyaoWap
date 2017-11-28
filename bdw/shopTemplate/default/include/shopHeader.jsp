<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shopInf"/>
<c:set value="${sdk:getUserCartListProxy('normal')}" var="cart"/>
<c:set value="${sdk:findPageModuleProxy('yz_top_web_logo').advt}" var="logoAdv"/>
<c:set value="${sdk:getLoginUser()}" var="user"/>
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
<script type="application/javascript">
    var paramData1 = {
        shopId: "${param.shopId}", webRoot: "${webRoot}", shopCollectCount: "${userProxy.shopCollectCount}"
    };

    var Top_Path = {webUrl: "${webUrl}", webRoot: "${webRoot}", webName: "${webName}"};

</script>
<script type="text/javascript" src="${webRoot}/template/bdw/shopTemplate/default/statics/js/shopHeader.js"></script>
<script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/loginValidate_top.js"></script>
<script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/loginValidateCode.js"></script><%--登录验证插件--%>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.md5.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart_sidebar.js"></script>
<div class="header">
    <div class="shortcut">
        <div class="sh-cont">
            <div class="fl">
                <a href="${webRoot}/index.ac" class="userName">返回首页&nbsp;&nbsp;</a>
                <c:if test="${not empty userProxy}">
                    [&nbsp;<a href="${webRoot}/module/member/index.ac" class="userName">${userProxy.userName}</a>&nbsp;]
                </c:if>
                您好，欢迎来到${sdk:getSysParamValue('webName')}
                <c:choose>
                    <c:when test="${empty userProxy}">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        [<a href="${webRoot}/login.ac" class="login">登录</a>]
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="${webRoot}/checkMobile.ac" class="register">免费注册</a>
                    </c:when>
                    <c:otherwise>
                        [<a style="margin-left: 0px;" href="<c:url value='/member/exit.ac?sysUserId=${userProxy.userId}'/>">退出</a>]
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
                    <a href="##" class="dt">我要代理</a>
                </li>
                <li>|</li>
                <li>
                    <a href="##" class="dt">商家入驻</a>
                </li>
                <li>|</li>
                <li class="more frameEdit" frameInfo="sy_index_navigate">
                    <a href="javascript:void(0);" class="dt">网站导航</a>
                    <div class="w-block"></div>
                    <div class="dd">
                        <c:forEach items="${sdk:findPageModuleProxy('sy_index_navigate').links}" var="navigate">
                            <a href="${navigate.link}" title="${navigate.title}">${navigate.title}</a>
                        </c:forEach>
                    </div>
                </li>
                <li>|</li>
                <li>
                    <a href="${webRoot}/help.ac" class="dt">帮助中心</a>
                </li>
                <li>|</li>
                <li>
                    <a title="${sdk:getSysParamValue('webName')}-${shopInf.shopNm}" href="javascript:void(0);" onClick="CollectShop(${shopInf.shopInfId})" class="dt">收藏我们</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="header-mc">
        <div class="logo">
            <c:forEach items="${sdk:findPageModuleProxy('sy_index_logo').advt.advtProxy}" var="logo" varStatus="s" end="0">
                <a href="${logo.link}"><img src="${logo.advUrl}"></a>
            </c:forEach>
        </div>
        <div class="search">
            <div class="form">
                <form id="searchForm" action="${webRoot}/productlist.ac" method="get">
                    <input type="text" name="keyword" placeholder="请输入搜索关键字" value="${not empty param.keyword ? param.keyword : ''}" id="searchFields">
                    <a href="javascript:void(0);" class="search-btn searchAction" rel="global">搜全站</a>
                    <a href="javascript:void(0);" class="search-btn2 searchAction" rel="shop">搜本店</a>
                </form>
                <form id="searchShopForm" action="${webRoot}/shopTemplate/default/shopProductList.ac" method="get" style="display: none;">
                    <input type="text" name="keyword" placeholder="请输入搜索关键字" id="searchFields2">
                    <input type="hidden" name="shopId" value="${shopInf.shopInfId}" id="shopId">
                </form>
            </div>
            <%--<div class="hotwords elli">
                <span>热门搜索 :</span>
                <a href="">阿莫西林</a>
                <a href="" class="hot">注射液</a>
                <a href="">厂家直供</a>
                <a href="">高毛控销</a>
                <a href="">清开灵</a>
            </div>--%>
        </div>
        </div>
</div>

<div class="shop_adv" style="min-width:1400px;">
    <div class="adv shopEdit" shopInfo="shop_top_custom1">
        <c:set var="defineHtml1" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_top_custom1').pageModuleObjects[0].userDefinedContStr}"/>
        <div style="${empty defineHtml1 ? "display:none" : "display:block"}">
            ${empty defineHtml1 ? "自定义区块":(defineHtml1)}
        </div>
    </div>
</div>
<!--导航菜单-->

<%--2015-03-24,zch,宝得网要求店铺导航链接改为自定义,这里使用店铺中心推荐一个暂时废弃的自定义--%>
<%--<div class="shop_menuBg shopEdit" style="min-width: 1400px;" shopInfo="shop_custom2">
    <c:set var="shopCustom2" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_custom2').pageModuleObjects[0].userDefinedContStr}"/>
    <div style="${empty shopCustom2 ? "display:none" : "display:block"}">
        ${empty shopCustom2 ? "自定义区块":(shopCustom2)}
    </div>
</div>--%>

<!--导航菜单-->
<div class="store-nav shopEdit" shopInfo="shop_navbar">
    <ul class="main-nav">
        <li class="${param.p=='index'?'cur':''}"><a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${param.shopId}">店铺首页</a></li>
        <li class="${param.p=='productList'?'cur':''}"><a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}">所有商品</a></li>
        <%--<li class="${param.p=='message'?'cur':''}"><a href="${webRoot}/shopTemplate/default/shopMsg.ac?shopId=${param.shopId}">供应商资质</a></li>--%>
        <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_navbar').links}" var="pageLinks" end="9">
            <li class=""><a href="${pageLinks.link}" target="${pageLinks.newWin ? '_blank':'_self'}">${sdk:cutString(pageLinks.title,14, "")}</a> </li>
        </c:forEach>
    </ul>
</div>
<!--end 导航菜单-->

<%--收藏店铺成功弹出层 start--%>
<div id="shopCollectLayer" style="display:none; margin-top:-10px;">
    <div class="showTip">
        <div class="close"><a href="javascript:" onclick="closeShopLayer();"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
        <div class="succe">
            <h3>店铺已成功收藏！</h3>
            <div class="tips">已收藏 <b id="shopCollectCount">${userProxy.shopCollectCount}</b> 件店铺。
                <a href="${webRoot}/module/member/shopCollection.ac">查看收藏夹>></a>
            </div>
        </div>
    </div>
    <div class="rShaw"></div>
    <div class="clear"></div>
    <div class="bShaw"></div>
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
<%--收藏店铺成功弹出层 end--%>
