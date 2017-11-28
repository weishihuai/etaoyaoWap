<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shopInf"/>
<%--<c:set value="${sdk:findKeywordByCategoryId(param.category,5)}" var="hotKeywords"/>--%>
<c:set value="${sdk:getUserCartListProxy('normal')}" var="cart"/>
<c:set value="${sdk:findPageModuleProxy('yz_top_web_logo').advt}" var="logoAdv"/>
<script type="application/javascript">
    var paramData1 = {
        shopId: "${param.shopId}", webRoot: "${webRoot}", shopCollectCount: "${userProxy.shopCollectCount}"
    };

    var Top_Path = {webUrl: "${webUrl}", webRoot: "${webRoot}", webName: "${webName}"};

</script>
<script type="text/javascript" src="${webRoot}/template/bdw/shopTemplate/default/statics/js/shopHeader.js"></script>
<div class="header">
    <div class="topbg">
        <div class="h_top">
            <div class="index_link">
                <a href="${webRoot}/index.ac" title="返回首页" target="_blank">返回首页</a>
            </div>
            <%--<div class="collect">--%>
                <%--<c:set value="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" var="shopUrl"/>--%>
                <%--<a title="${sdk:getSysParamValue('webName')}-${shopInf.shopNm}" href="javascript:" onClick="CollectShop(${shopInf.shopInfId})" class="sc">收藏我们</a>--%>
            <%--</div>--%>
            <%--因为nginx代理问题,所以这里如果不加个时间戳会出现会显示其他用户的登录名--%>
            <div class="welcome">
                <div id="showUserId">
                    <%--您好，欢迎来到${webName}！[<a class="cur" href="${webRoot}/login.ac" title="登录">登录</a>] [<a class="color" href="${webRoot}/register.ac" title="免费注册">免费注册</a>]--%>
                </div>
            </div>
            <div class="top_r" style="width: 400px;">
                <div class="r_item" style=" width:68px;">
                    <div class="tab" style="background:none; width:55px;"><a href="${webRoot}/module/member/orderList.ac?menuId=51511">我的订单</a></div>
                    <i>|</i>
                </div>
                <div class="r_item myAcunnt">
                    <div class="tab"><a href="javascript:">我的${webName}</a></div>
                    <i>|</i>

                    <div class="item_popup" style="display: none;">
                        <p><a href="${webRoot}/module/member/index.ac" show="N">会员首页</a></p>

                        <p><a href="${webRoot}/module/member/myIntegral.ac">我的积分</a></p>

                        <p><a href="${webRoot}/module/member/productCollection.ac">我的收藏</a></p>
                    </div>
                </div>
                <div class="r_item myAcunnt" style=" width:68px;">
                    <div class="tab" style="background:none; width:55px;"><a href="${webRoot}/help.ac">帮助中心</a></div>
                    <i>|</i>
                </div>
                <div class="r_item2 cur2 wechatQr frameEdit" frameInfo="top_wechat_qr|168X174">
                    <div class="tab"><i></i><a href="javascript:">关注我们</a></div>
                    <div class="item_popup2">
                        <%--<c:forEach items="${sdk:findPageModuleProxy('top_wechat_qr').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                            <img src="${advtProxys.advUrl}" width="168" height="174"/>
                        </c:forEach>--%>
                        <div class="e-pic">
                            <c:forEach items="${sdk:findPageModuleProxy('yz_top_code').advt.advtProxy}" var="top_code" varStatus="s" end="0">
                                <img src="${top_code.advUrl}" width="120" height="120">
                            </c:forEach>
                        </div>
                        <span>扫一扫 微信关注${webName}</span>
                    </div>
                </div>
                <div class="collect" style="width: 81px;padding-top: 1px;">
                    <c:set value="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" var="shopUrl"/>
                    <span>|</span>
                    <a style="float: left;width: 50px;color: #666;" title="${sdk:getSysParamValue('webName')}-${shopInf.shopNm}" href="javascript:" onClick="CollectShop(${shopInf.shopInfId})" class="sc">收藏我们</a>
                </div>
            </div>
        </div>
    </div>
    <div class="h_btm">
        <div class="logo frameEdit" frameInfo="yz_top_web_logo|380X80"<c:if test="${logoAdv.width <= 500}">style=" width:${logoAdv.width}px; height: ${logoAdv.height}px"</c:if>  >
            <%--<c:forEach items="${sdk:findPageModuleProxy('yz_top_web_logo').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                ${advtProxys.htmlTemplate}
            </c:forEach>--%>
            <c:forEach items="${logoAdv.advtProxy}" var="web_logo" varStatus="s" end="0">
                <%--${web_logo.htmlTemplate}--%>
                <a href="${web_logo.link}" <c:if test="${logoAdv.width <= 500}">style=" width:${logoAdv.width}px; height: ${logoAdv.height}px"</c:if> ><img src="${web_logo.advUrl}" <c:if test="${logoAdv.width <= 500}"> width="${logoAdv.width}px" height="${logoAdv.height}px"</c:if> /></a>
            </c:forEach>
        </div>
        <div class="shop_search">
            <div class="form">
                <form id="searchForm" action="${webRoot}/productlist.ac" method="get">
                    <div class="se_icon"></div>
                    <input type="text" name="keyword" value="${not empty param.keyword ? param.keyword : '请输入搜索关键字'}" class="put" id="searchFields" style="height: 32px">

                    <div class="search-btn"><a href="javascript:" rel="global" class="searchAction">搜全站</a></div>
                    <div class="search-btn2"><a href="javascript:" rel="shop" class="searchAction">搜本店</a></div>
                    <div class="clear"></div>
                </form>
                <form id="searchShopForm" action="${webRoot}/shopTemplate/default/shopProductList.ac" method="get" style="display: none;">
                    <input type="text" name="keyword" value="请输入搜索关键字" class="put" id="searchFields2">
                    <input type="hidden" name="shopId" value="${shopInf.shopInfId}" id="shopId">
                    <div class="clear"></div>
                </form>
            </div>
        </div>
        <div class="buycar"><a href="${webRoot}/shoppingcart/cart.ac">购物车</a><i></i><em>${cart.allCartNum}</em></div>
        <div class="clear"></div>
    </div>
</div>

<div class="shop_adv" style="min-width:1400px;">
    <div class="adv shopEdit" shopInfo="shop_top_custom1">
        <c:set var="defineHtml1" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_top_custom1').pageModuleObjects[0].userDefinedContStr}"/>
        <div style="${empty defineHtml1 ? "display:none" : "display:block"}">
            ${empty defineHtml1 ? "自定义区块":(defineHtml1)}
        </div>
    </div>
    <%--
        <div class="adv shopEdit" shopInfo="shop_top_custom2">
            <c:set var="defineHtml2" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_top_custom2').pageModuleObjects[0].userDefinedContStr}"/>
            <div style="${empty defineHtml2 ? "display:none" : "display:block"}">
                ${empty defineHtml2? "自定义区块":(defineHtml2)}
            </div>
        </div>

        <div class="adv shopEdit" shopInfo="shop_top_custom3">
            <c:set var="defineHtml3" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_top_custom3').pageModuleObjects[0].userDefinedContStr}"/>
            <div style="${empty defineHtml3 ? "display:none" : "display:block"}">
                ${empty defineHtml3 ? "自定义区块":defineHtml3}
            </div>
        </div>
        <div class="clear"></div>--%>
</div>
<!--导航菜单-->

<%--2015-03-24,zch,宝得网要求店铺导航链接改为自定义,这里使用店铺中心推荐一个暂时废弃的自定义--%>
<div class="shop_menuBg shopEdit" style="min-width: 1400px;" shopInfo="shop_custom2">
    <c:set var="shopCustom2" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_custom2').pageModuleObjects[0].userDefinedContStr}"/>
    <div style="${empty shopCustom2 ? "display:none" : "display:block"}">
        ${empty shopCustom2 ? "自定义区块":(shopCustom2)}
    </div>
</div>
<!--end 导航菜单-->

<%--收藏店铺成功弹出层 start--%>
<div class="AddShopTomyLikeLayer" style="display:none; margin-top:-10px;">
    <div class="showTip">
        <div class="close"><a href="javascript:" onclick="$('.AddShopTomyLikeLayer').hide()"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
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
<%--收藏店铺成功弹出层 end--%>
