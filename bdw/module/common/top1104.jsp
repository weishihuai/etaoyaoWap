<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findKeywordByCategoryId(param.category,5)}" var="hotKeywords"/>
<c:set value="${sdk:getUserCartListProxy('normal')}" var="cart"/>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<c:set value="${sdk:findPageModuleProxy('yz_top_web_logo').advt}" var="logoAdv"/>
<c:set value="${bdw:getKeyWord()}" var="keyWordStr"></c:set>
<jsp:useBean id="dataTime" class="java.util.Date" />
<script type="text/javascript">
    var goToUrl = function (url) {
        setTimeout(function () {
            window.location.href = url
        }, 1)
    };
    var Top_Path = {webUrl: "${webUrl}", webRoot: "${webRoot}", topParam: "${param.p}", keyword: "${param.keyword}", webName: "${webName}"};
    var top_searchField = "${param.searchField}"
</script>

<link rel="icon" href="${webRoot}/favicon.ico" type="image/x-icon"/>
<link rel="shortcut icon" href="${webRoot}/favicon.ico" type="image/x-icon"/>

<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/top.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/addFavorite.js"></script>

<div class="header">
    <div class="shortcut">
        <div class="sh-cont">
            <div class="fl">
                <c:if test="${not empty user}">
                    [<a href="${webRoot}/module/member/index.ac" class="cur" style="font-size: 14px; background: white;"> ${user.userName} </a>]
                </c:if>
                您好，欢迎来到${sdk:getSysParamValue('webName')}！
                <c:choose>
                    <c:when test="${empty user}">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        [<a href="${webRoot}/login.ac" class="cur" style="background-color: #fff;"> 登录 </a>]
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        [<a href="${webRoot}/register.ac"> 免费注册 </a>]
                    </c:when>
                    <c:otherwise>
                        [<a  href="<c:url value='/member/exit.ac?sysUserId=${user.userId}'/>" title="退出">退出</a>]
                    </c:otherwise>
                </c:choose>

            </div>
            <ul class="fr">
                <li class="item"><a href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">我的订单</a></li>
                <li class="spacer"></li>
                <li class="item" id="member_item"><!--鼠标经过加 class:cur -->
                    <div class="dt">
                        <i class="arr"></i>
                        <a title="会员中心" href="javascript:void(0)">会员中心</a>
                    </div>
                    <span class="blank" style="width: 81px;"></span>
                    <div class="fore-box">
                        <a href="${webRoot}/module/member/index.ac" target="_blank">会员首页</a>
                        <a href="${webRoot}/module/member/myIntegral.ac" target="_blank">我的积分</a>
                        <a href="${webRoot}/module/member/productCollection.ac?pitchOnRow=3" target="_blank">我的收藏</a>
                    </div>
                </li>
                <li class="spacer"></li>
                <li class="item" id="service"><!--鼠标经过加 class:cur -->
                    <div class="dt">
                        <i class="arr"></i>
                        <a title="客户服务" href="javascript:void(0)">客户服务</a>
                    </div>
                    <span class="blank" style="width: 81px;"></span>
                    <div class="fore-box">
                        <a href="${webRoot}/help.ac" target="_blank">帮助中心</a>
                        <a href="${webRoot}/module/member/returnedPurchase.ac" target="_blank">售后服务</a>
                        <a href="tencent://message/?uin=${sdk:getSysParamValue('webEmail')}">在线客服</a>
                        <a href="${webRoot}/suggest.ac" target="_blank">意见建议</a>
                    </div>
                </li>
                <li class="spacer"></li>
                <li class="item frameEdit" frameInfo="yz_top_code|120X120" id="top_code" style="z-index: 105"><!--鼠标经过加 class:cur2 -->
                    <div class="dt">
                        <i class="arr"></i>
                        <span style="color: rgb(102, 102, 102);">关注我们</span>
                    </div>
                    <div class="ewm-box">
                        <i class="m-icon"></i>
                        <div class="e-pic">
                            <c:forEach items="${sdk:findPageModuleProxy('yz_top_code').advt.advtProxy}" var="top_code" varStatus="s" end="0">
                                <img src="${top_code.advUrl}" width="120" height="120">
                            </c:forEach>
                        </div>
                        <span>扫一扫 微信关注${webName}</span>
                    </div>
                </li>

                <li class="item"  id="top_code2" style="z-index: 105"><!--鼠标经过加 class:cur2 -->
                    <div class="dt">
                        <i class="arr"></i>
                        <span style="color: rgb(102, 102, 102);">${webName}APP下载</span>
                    </div>
                    <div class="ewm-box" style="height: 310px">
                        <i class="m-icon"></i>
                        <div class="e-pic frameEdit" frameInfo="yz_top_app_code|120X120">
                            <c:forEach items="${sdk:findPageModuleProxy('yz_top_app_code').advt.advtProxy}" var="yz_top_app_code" varStatus="s" end="0">
                                <img src="${yz_top_app_code.advUrl}" width="120" height="120">
                            </c:forEach>
                        </div>
                        <span style="color: red;">${webName}用户版APP</span>
                        <div class="e-pic frameEdit" frameInfo="yz_top_ios_code|120X120" style="margin-top: 10px">
                            <c:forEach items="${sdk:findPageModuleProxy('yz_top_ios_code').advt.advtProxy}" var="yz_top_ios_code" varStatus="s" end="0">
                                <img src="${yz_top_ios_code.advUrl}" width="120" height="120">
                            </c:forEach>
                        </div>
                        <span style="color: red;">${webName}商家版APP</span>
                    </div>
                </li>
                <%--<li class="item"  id="top_code3" style="z-index: 105"><!--鼠标经过加 class:cur2 -->--%>
                    <%--<div class="dt">--%>
                        <%--<i class="arr"></i>--%>
                        <%--<span style="color: rgb(102, 102, 102);">${webName}商家APP下载</span>--%>
                    <%--</div>--%>
                    <%--<div class="ewm-box" style="height: 310px">--%>
                        <%--<i class="m-icon"></i>--%>
                        <%--<div class="e-pic frameEdit" frameInfo="yz_shop_top_app_code|120X120">--%>
                            <%--<c:forEach items="${sdk:findPageModuleProxy('yz_shop_top_app_code').advt.advtProxy}" var="yz_shop_top_app_code" varStatus="s" end="0">--%>
                                <%--<img src="${yz_shop_top_app_code.advUrl}" width="120" height="120">--%>
                            <%--</c:forEach>--%>
                        <%--</div>--%>
                        <%--<span style="color: red;">${webName}商家APP</span>--%>

                        <%--<div class="e-pic frameEdit" frameInfo="yz_shop_top_ios_code|120X120" style="margin-top: 10px">--%>
                            <%--<c:forEach items="${sdk:findPageModuleProxy('yz_shop_top_ios_code').advt.advtProxy}" var="yz_shop_top_ios_code" varStatus="s" end="0">--%>
                                <%--<img src="${yz_shop_top_ios_code.advUrl}" width="120" height="120">--%>
                            <%--</c:forEach>--%>
                        <%--</div>--%>
                        <%--<span style="color: red;">${webName}商家IOS</span>--%>
                    <%--</div>--%>
                <%--</li>--%>
            </ul>
        </div>
    </div>
    <div class="header-mc">
        <div class="logo frameEdit" frameInfo="yz_top_web_logo" <c:if test="${logoAdv.width <= 500}">style=" width:${logoAdv.width}px; height: ${logoAdv.height}px;float: left; margin-left: -8px;"</c:if>  >
            <c:forEach items="${logoAdv.advtProxy}" var="web_logo" varStatus="s" end="0">
                <%--${web_logo.htmlTemplate}--%>
                <a href="${web_logo.link}" <c:if test="${logoAdv.width <= 500}">style=" width:${logoAdv.width}px; height: ${logoAdv.height}px"</c:if> ><img src="${web_logo.advUrl}" <c:if test="${logoAdv.width <= 500}"> width="${logoAdv.width}px" height="${logoAdv.height}px"</c:if> /></a>
            </c:forEach>
        </div>
        <div class="my-cars">
            <div class="buy-car">
                <a href="${webRoot}/shoppingcart/cart.ac" class="mt" target="_blank">购物车</a>
                <span class="num" id="top_myCart_cartNum">${cart.allCartNum}</span>
                <div class="mc"></div>
            </div>
        </div>
        <div class="search">
            <div class="form">
                <form id="searchShopForm" action="${webRoot}/productlist.ac" method="get">
                    <input type="text" id="searchFields" name="keyword" value="${not empty keyWordStr ? keyWordStr : '请输入搜索关键字'}" onfocus="toFocus()" maxlength="50" placeholder="请输入搜索关键字">
                    <a href="javascript:void(0)" class="sub" onclick="tokeywordSearchSubmit()">搜索</a>
                </form>
            </div>
            <div class="hotwords">
                <c:forEach items="${hotKeywords}" var="hotKeyword">
                    <a href="${webRoot}/productlist.ac?keyword=${hotKeyword}" title="${hotKeyword}" target="_blank">${hotKeyword}</a>
                </c:forEach>
                <%--<a href="javascript:void(0)" class="hot">伊利</a>--%>
            </div>
        </div>
    </div>
    <!--导航菜单-->
    <div class="nav-bg">
        <c:set value="${sdk:findAllProductCategory()}" var="allProductCategory"/>

        <c:set value="${sdk:getShopRoot(2)}" var="shopRoot"/>  <%--默认预设商家shopId=2--%>
        <c:set value="${param.shopCategoryId==null ? shopRoot : param.shopCategoryId}" var="categoryId"/>
        <%--这里传1是因为shopAdmin是1--%>
        <c:set value="${sdk:getChildren(categoryId,2)}" var="shopCategory"/>
        <div class="nav">
            <div class="category" rel="${param.p}">
                <div class="dt"><a href="javascript:void(0)">全部商品分类</a></div>
                <div class="dc" style="z-index:101;">
                    <div class="dc-inner" <c:if test="${param.p != 'index'}">style="display: none;"</c:if> >
                        <c:forEach items="${allProductCategory}" var="category" varStatus="i" end="16">
                            <div class="show">
                                <div class="item fore${i.count}">
                                    <a href="${webRoot}/productlist-${category.categoryId}.html" title="${category.name}" target="_blank">${fn:substring(category.name, 0,13)}</a><!-- 这里最多显示13个字，多的话字会和下一行重叠影响样式 -->
                                </div>
                                <div class="dropdown-layer">
                                    <div class="p_left">
                                        <c:forEach items="${category.children}" var="child" varStatus="c">
                                            <div class="l_rows">
                                                <div class="rows_title">
                                                    <a href="${webRoot}/productlist-${child.categoryId}.html" title="${child.name}">${child.name}</a>
                                                </div>
                                                <div class="rows_text">
                                                    <c:forEach items="${child.children}" var="threeChild" varStatus="s">
                                                        <a href="${webRoot}/productlist-${threeChild.categoryId}.html" title="${threeChild.name}">${threeChild.name}</a>${s.last?'':'<i>|</i>'}
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <c:set value="top_right_brand${i.count}" var="top_right_brand"/>
                                    <div class="p_right frameEdit" frameInfo="${top_right_brand}|88X38">
                                        <div class="right_t">
                                            <div class="top_title">推荐品牌</div>
                                            <div class="top_info">
                                                <c:forEach items="${sdk:findPageModuleProxy(top_right_brand).links}" var="brandLink">
                                                    <div class="info_tab">
                                                        <a href="${brandLink.link}">
                                                            <img src="${brandLink.icon['']}" width="88" height="38" alt="${brandLink.title}" title="${brandLink.title}"/>
                                                        </a>
                                                    </div>
                                                </c:forEach>
                                                <div class="clear"></div>
                                            </div>
                                        </div>
                                        <c:set value="index_category_adv${i.count}" var="categoryAdv"/>
                                        <div class="right_b frameEdit" frameInfo="${categoryAdv}|197X291">
                                            <c:forEach items="${sdk:findPageModuleProxy(categoryAdv).advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                                                ${advtProxys.htmlTemplate}
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>

                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="main-nav frameEdit" frameInfo="yz_top_menu">
                <a href="${webRoot}/index.ac" title="首页">首页</a>
                <c:forEach items="${sdk:findPageModuleProxy('yz_top_menu').links}" var="menu_link">
                    <a href="${menu_link.link}" target="_blank" title="${menu_link.title}">${menu_link.title}</a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
