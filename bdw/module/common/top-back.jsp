<%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-5-23
  Time: 上午11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:set value="${sdk:findKeywordByCategoryId(param.category,5)}" var="hotKeywords"/>
<script type="text/javascript">
    var goToUrl = function(url){
        setTimeout(function(){window.location.href=url},1)
    };
    var Top_Path = {webRoot:"${webRoot}",topParam:"${param.p}"};
</script>
<link rel="icon" href="${webRoot}/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="${webRoot}/favicon.ico" type="image/x-icon" />
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/top.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/addFavorite.js"></script>
<div id="header">
<div class="t_area_t">
<div class="t_area">
    <div class="addLike"><a href="javascript:void(0);" id="fav"><img src="${webRoot}/template/bdw/statics/images/header_addLike_ico.gif" /> 收藏${webName}</a></div>
    <div class="tips">
        <c:choose>
            <c:when test="${not empty userProxy}">
                您好，<a href="${webRoot}/module/member/index.ac">${fn:substring(userProxy.loginId,0,15)}</a>，欢迎来到${webName}[<a  href="<c:url value='/member/exit.ac?sysUserId=${userProxy.userId}'/>" title="退出">退出</a>]
            </c:when>
            <c:otherwise>
                您好，欢迎来到${webName}！[<a href="${webRoot}/login.ac" title="登录">登录</a>] [<a class="color" href="${webRoot}/register.ac" title="免费注册">免费注册</a>]
            </c:otherwise>
        </c:choose>
    </div>
    <div class="webMap frameEdit" frameInfo="top_right_link">
        <ul>
            <%--<li class="nav" style="background:none;"><a href="#">我的账户 <i>▼</i></a>--%>
            <%--<div class="someshow" style="display:none;">--%>
            <%--<dl>--%>
            <%--<dd><a href="#">餐厨用具</a></dd>--%>
            <%--<dd><a href="#">生活电器</a></dd>--%>
            <%--<dd><a href="#">储物收纳</a></dd>--%>
            <%--</dl>--%>
            <%--</div>--%>
            <%--</li>--%>
            <%--<li><a class="" href="http://www.safemall.com/page/fastAddProduct.ftl">绿色通道</a></li>
            <li><a class="" href="http://www.safemall.com/webunion.htm">销售联盟</a></li>
            <li><a class="" href="${webRoot}/help.ac">帮助中心</a></li>
            <li><a class="" href="http://weibo.com/2379103163">官方微博</a></li>--%>
                <c:forEach items="${sdk:findPageModuleProxy('top_right_link').links}" end="3" var="pageLinks" varStatus="s">
                    <li><a class="" href="${pageLinks.link}">${pageLinks.title}</a></li>
                </c:forEach>
            <%--<li class="nav" >--%>
            <%--<a class="hover" href="#">官方微博 <i>▼</i></a>--%>
            <%--<div class="someshow" style="display:none;">--%>
            <%--<dl>--%>
            <%--<dd><a href="#">餐厨用具</a></dd>--%>
            <%--<dd><a href="#">生活电器</a></dd>--%>
            <%--<dd><a href="#">储物收纳</a></dd>--%>
            <%--</dl>--%>
            <%--</div>--%>
            <%--</li>--%>
        </ul>

    </div>
    <div class="clear"></div>
</div>
</div>
<div class="top_banner frameEdit"  frameInfo="jvan_top_banner|1200X70/960X70">
    <c:set value="${sdk:findPageModuleProxy('jvan_top_banner').advt}" var="wideAdv"/>
    <c:forEach items="${wideAdv.advtProxy}" var="adv" end="0" varStatus="s">
        <a href="${adv.link}" class='commonScreen' title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="1200px" height="57px" /></a>
        <a href="${adv.link}" class='widthScreen' title="${adv.title}" target="_blank"><img  src="${not empty adv.widescreenAdvUrl ? adv.widescreenAdvUrl : adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="${wideAdv.widescreenWidth == 0 ?  '960px' : wideAdv.widescreenWidth}" height="${wideAdv.widescreenHeight == 0 ? '57px' :  wideAdv.widescreenHeight }" /></a>
    </c:forEach>
    <%--<a href="#"><img src="case/index_240_50_01.jpg" /></a>--%>
    <%--<img src="images/footer_dow.gif" />--%>
</div>
<div class="c_area">

    <div class="logo frameEdit" frameInfo="jvan_logo|210X65">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_logo').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
            <a id="${s.count}" target="_blank" href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="210" height="65" /></a>
        </c:forEach>
    </div>
    <%--<div class="logo"><a href="#"><img src="images/logo.gif" /></a></div>--%>
    <div class="baner frameEdit" frameInfo="jvan_top_adv|180X60">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_top_adv').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
            <a id="${s.count}" target="_blank" href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="180" height="60" /></a>
        </c:forEach>
    </div>
    <%--<div class="baner">--%>
    <%----%>
    <%--</div>--%>
    <div class="searchArea">
        <form id="searchForm" action="${webRoot}/productlist.ac" method="get">
            <div class="search">
                <input type="hidden" name="category" value="1"/>
                <div class="put">
                    <input id="searchFields" value="${hotKeywords[0]}" onfocus="toFocus()" name="keyword" type="text"/>
                </div>
                <div class="btn"><a href="javascript:void(0);"  onclick="toSearchSubmit()"><img src="${webRoot}/template/bdw/statics/images/header_searchIco.gif" /></a></div>
                <div class="clear"></div>
            </div>
        </form>


        <div class="hotFont">
            <c:forEach items="${hotKeywords}" var="hotKeyword">
                <a href="${webRoot}/productlist.ac?keyword=${hotKeyword}" title="${hotKeyword}">${hotKeyword}</a>&nbsp;&nbsp;
            </c:forEach>
        </div>
        <%--<div class="hotFont"><a href="#">iPone 4S</a> <a href="#">除湿机</a> <a href="#">美的</a> <a href="#">豆浆机</a> <a href="#">ThinkPad</a> <a href="#">U盘</a></div>--%>
    </div>
    <div class="myAcunnt">
        <div class="tal_Acunnt">
            <i><img src="${webRoot}/template/bdw/statics/images/header_userpic.gif" /></i>
            <em><img src="${webRoot}/template/bdw/statics/images/header_show_stute_ico.gif" /></em>
            <a href="${webRoot}/module/member/index.ac" title="我的帐户">我的帐户</a>
        </div>
        <div class="Acunnt_info" style="display:none;">
            <h1>
                <c:choose>
                    <c:when test="${not empty userProxy}">
                        <span>您好，${userProxy.loginId},欢迎来到${webName}！</span>
                        <%--您好，<a href="${webRoot}/module/member/index.ac">${userProxy.loginId}</a>，欢迎来到${webName}[<a  href="<c:url value='/member/exit.ac?sysUserId=${userProxy.userId}'/>" title="退出">退出</a>]--%>
                    </c:when>
                    <c:otherwise>

                        <span>您好，欢迎来到${webName}！</span>
                        <a class="login" href="${webRoot}/login.ac">登录乐商E购物</a>
                        <%--您好，欢迎来到${webName}！[<a href="${webRoot}/login.ac" title="登录">登录</a>] [<a class="color" href="${webRoot}/register.ac" title="免费注册">免费注册</a>]--%>
                    </c:otherwise>
                </c:choose>

                <div class="clear"></div>
            </h1>
            <div class="top_sel">
                <ul>
                    <li><a href="${webRoot}/module/member/orderList.ac?menuId=51511" title="待处理订单">待处理订单></a></li>
                    <li><a href="${webRoot}/module/member/orderList.ac?menuId=51511" title="我的订单">我的订单></a></li>
                    <li><a href="${webRoot}/module/member/myIntegral.ac?menuId=51542" title="我的积分">我的积分></a></li>
                    <li><a href="${webRoot}/module/member/productCollection.ac?menuId=51553" title="收藏夹">收藏夹></a></li>
                </ul>
            </div>
            <div class="bottom_sel">
                <h2><span>浏览过的商品</span><a href="javascript:void(0);" onclick="clearHistoryCookie('#history')">清空</a></h2>
                <div class="box" id="history">
                    <c:set value="${sdk:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
                    <c:choose>
                        <c:when test="${not empty productFromCookies}">
                            <ul>
                                <c:forEach items="${productFromCookies}" var="proxy">
                                    <li>
                                        <a href="${webRoot}/product-${proxy.productId}.html" title="${proxy.name}"><img src="${proxy.defaultImage["50X50"]}" alt="${proxy.name}" width="50px" height="50px"/></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <ul><li style="text-align: center;">暂无浏览商品记录</li></ul>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <c:set value="${sdk:getUserCartListProxy('normal')}" var="cart"/>
    <div class="buyCar" id="myCart">
        <i style="display:block;" id="top_myCart_cartNum">${cart.allCartNum}</i>
        <div class="tal_Car" >
            <em ><img src="${webRoot}/template/bdw/statics/images/header_show_stute_ico.gif" /></em>
            <a href="${webRoot}/shoppingcart/cart.ac">去购物车结算</a>
        </div>

        <div class="Car_info showlist" style="display:none;">
            <c:import url="/template/bdw/module/common/cartlayer.jsp"/>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div class="b_area_t">
<div class="b_area">
    <div class="l_btn">
        <div class="all"><a href="javascript:void(0);">所有商品分类</a></div>
        <div class="me_Layer" style="<c:choose><c:when test="${param.p == 'index'}">display:block;</c:when><c:otherwise>display: none</c:otherwise></c:choose>">

            <input type="hidden" id="isIndex" value="<c:if test="${param.p == 'index'}">Y</c:if>"/>
            <%--一级分类开始--%>
            <c:set value="${sdk:findAllProductCategory()}" var="allProductCategory"/>
            <div class="backg">
                <c:forEach items="${allProductCategory}" var="category" varStatus="s" end="7">
                    <div class="layer_father">
                        <div class="item layer_item">
                            <h1><a  href="${webRoot}/productlist-${category.categoryId}.html" title="${category.name}" >${category.name}</a></h1>
                                <%--<h2><c:forEach items="${category.children}" end="2" var="child" varStatus="c"><a  href="${webRoot}/productlist.ac?category=${child.categoryId}" title="${child.name}" >${child.name}</a><c:if test="${!c.last}">、</c:if></c:forEach></h2>--%>
                        </div>
                        <div class="layer_show" style="display:none; ">
                            <div class="linfo">
                                    <%--<ul>--%>
                                <c:forEach items="${category.children}" var="child" varStatus="c">
                                    <div class="fixBox">
                                        <label>${child.name}</label>
                                        <div class="thisList">
                                            <c:forEach items="${child.children}" var="threeChild" varStatus="s">
                                                <a href="${webRoot}/productlist-${threeChild.categoryId}.html" title="${threeChild.name}">${threeChild.name}</a>${!s.last ? '&nbsp;&nbsp;|&nbsp;&nbsp;' : ''}
                                            </c:forEach>
                                        </div>
                                        <div class="clear"></div>
                                    </div>
                                    <%--<li>--%>
                                    <%--<div class="fixBox">--%>
                                    <%--<label>${child.name}</label>--%>
                                    <%--<div class="thisList">--%>
                                    <%--<c:forEach items="${child.children}" var="threeChild">--%>
                                    <%--<a href="${webRoot}/productlist-${threeChild.categoryId}.html" title="${threeChild.name}">${threeChild.name}</a> |   --%>
                                    <%--</c:forEach></div>--%>
                                    <%--<div class="clear"></div>--%>
                                    <%--</div>--%>
                                    <%--</li>--%>
                                </c:forEach>
                                    <%--</ul>--%>
                            </div>
                                <%--<div class="rinfo">--%>
                            <div class="pro_More">
                                <dl>
                                    <dt>推荐品牌</dt>
                                    <c:forEach items="${category.brands}" var="brand" begin="4">
                                        <dd><a href="${webRoot}/productlist.ac?category=${category.categoryId}&q=brandId:${brand.brandId}">${brand.name}</a></dd>
                                    </c:forEach>
                                </dl>
                                <dl class="icondt">
                                    <c:forEach items="${category.brands}" var="brand" end="3">
                                        <dd class="icon"><a href="${webRoot}/productlist.ac?category=${category.categoryId}&q=brandId:${brand.brandId}"><img alt="${brand.name}" src="${brand.logo['']}" width="115px" height="40px" /></a></dd>
                                    </c:forEach>
                                </dl>
                            </div>
                                <%--<h1>推荐品牌</h1>--%>
                                <%--<div class="pp_list">--%>
                                <%--<ul>--%>
                                <%--<c:forEach items="${category.brands}" var="brand">--%>
                                <%--<li><a href="${webRoot}/productlist.ac?category=${category.categoryId}&q=brandId:${brand.brandId}">${brand.name}</a></li>--%>
                                <%--</c:forEach>--%>
                                <%--</ul>--%>
                                <%--</div>--%>
                                <%--<div class="benner frameEdit" frameInfo="adv100|185X70">--%>
                                <%--<c:forEach items="${sdk:findPageModuleProxy('adv100').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">--%>
                                <%--<a id="${s.count}" target="_blank" href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="185" height="70" /></a>--%>
                                <%--</c:forEach>--%>
                                <%--</div>--%>
                                <%--</div>--%>
                            <div class="clear"></div>
                        </div>
                    </div>
                </c:forEach>
                     <div>
                             <h1 style="padding-left: 15px;padding-top:2px;border-top: 1px solid #FFFFFF;background: #FDF1DE;"><a  href="${webRoot}/brandZone.html?t=all" title="查看全部分类" style="color:#CC0000">查看全部分类</a></h1>
                             <%--<h2><c:forEach items="${category.children}" end="2" var="child" varStatus="c"><a  href="${webRoot}/productlist.ac?category=${child.categoryId}" title="${child.name}" >${child.name}</a><c:if test="${!c.last}">、</c:if></c:forEach></h2>--%>
                     </div>
                <%--<div class="itemBox" style="display: none;">--%>
                <%--<c:forEach items="${allProductCategory}" var="category" varStatus="s" begin="5">--%>
                <%--<div class="item itemHide">--%>
                <%--<h1><a  href="${webRoot}/productlist-${category.categoryId}.html" title="${category.name}" >${category.name}</a></h1>--%>
                <%--<h2><c:forEach items="${category.children}" end="2" var="child" varStatus="c"><a  href="${webRoot}/productlist.ac?category=${child.categoryId}" title="${child.name}" >${child.name}</a><c:if test="${!c.last}">、</c:if></c:forEach></h2>--%>
                <%--</div>--%>
                <%--<div class="layer_show layer_show_more" style="display:none; ">--%>
                <%--<div class="linfo">--%>
                <%--<ul>--%>
                <%--<c:forEach items="${category.children}" var="child" varStatus="c">--%>
                <%--<li>--%>
                <%--<div class="fixBox">--%>
                <%--<label>${child.name}</label>--%>
                <%--<div class="thisList">--%>
                <%--<c:forEach items="${child.children}" var="threeChild">--%>
                <%--<a href="${webRoot}/productlist-${threeChild.categoryId}.html" title="${threeChild.name}">${threeChild.name}</a> |   </c:forEach></div>--%>
                <%--<div class="clear"></div>--%>
                <%--</div>--%>
                <%--</li>--%>
                <%--</c:forEach>--%>
                <%--</ul>--%>
                <%--</div>--%>
                <%--<div class="rinfo">--%>
                <%--<h1>推荐品牌</h1>--%>
                <%--<div class="pp_list">--%>
                <%--<ul>--%>
                <%--<c:forEach items="${category.brands}" var="brand">--%>
                <%--<li><a href="${webRoot}/productlist.ac?category=${category.categoryId}&q=brandId:${brand.brandId}">${brand.name}</a></li>--%>
                <%--</c:forEach>--%>
                <%--</ul>--%>
                <%--</div>--%>
                <%--<div class="benner frameEdit" frameInfo="adv100|185X70">--%>
                <%--<c:forEach items="${sdk:findPageModuleProxy('adv100').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">--%>
                <%--<a id="${s.count}" target="_blank" href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="185" height="70" /></a>--%>
                <%--</c:forEach>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="clear"></div>--%>
                <%--</div>--%>
                <%--</c:forEach>--%>
                <%--</div>--%>
            </div>
            <%--<c:forEach items="${allProductCategory}" var="category" varStatus="s" end="4">--%>
            <%----%>
            <%--</c:forEach>--%>

            <%--<c:forEach items="${allProductCategory}" var="category" varStatus="s" begin="5">--%>
            <%----%>
            <%--</c:forEach>--%>
        </div>
    </div>
    <div class="menu">
        <ul>
            <li><h1><a class="${param.p=='index'?'cur':''}" href="${webRoot}/index.html">首页</a></h1></li>
            <li><h1><a class="${param.p=='brand'?'cur':''}" href="${webRoot}/brandZone.html" title="品牌专区">品牌专区</a></h1></li>
            <li><h1><a class="${param.p=='activityIndex'?'cur':''}" href="${webRoot}/activityIndex.ac" title="抢购活动">抢购活动</a></h1></li>
            <li><h1><a class="${param.p=='tuan'?'cur':''}" href="${webRoot}/tuanlist.html" title="团购">团购</a></h1></li>
            <%--<li><h1><a class="${param.p=='activityZone'?'cur':''}" href="${webRoot}/activityZone.ac">活动专题</a></h1></li>--%>
            <%--<li><h1><a class="${param.p=='activityIndex'?'cur':''}"href="${webRoot}/activityIndex.ac">活动专区</a></h1></li>--%>
            <li><h1><a class="${param.p=='integral'?'cur':''}" href="${webRoot}/integral.html" title="积分兑换">积分兑换</a></h1></li>
        </ul>
    </div>
    <div class="tel_mub frameEdit" frameInfo="jvan_hot_link|240X40">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_hot_link').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
            <a id="${s.count}" target="_blank" href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="240" height="40" /></a>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
</div>
</div>
