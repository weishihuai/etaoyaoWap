<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getSysParamValue('sousuo')}" var="paramNm" /> <%--搜索字段--%>
<c:set value="${sdk:findKeywordByCategoryId(param.categoryPath==null ? 1 : param.categoryPath,5)}" var="hotKeywords"/>  <%--热门搜索--%>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?9781eeadda233d8e366b87735b4feb80";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/indexTop.js"></script>
<script type="text/javascript">
    var goToUrl = function(url){
        setTimeout(function(){window.location.href=url},1)
    };
</script>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<div id="header">
    <%--顶部导航开始--%>
    <div class="top_h">
        <div class="marg">
            <%--用户登录状态显示开始--%>
            <div class="l">
                <c:choose>
                    <c:when test="${not empty userProxy}">
                        您好，${userProxy.loginId}，欢迎来到${webName}  [<a href="${webRoot}/module/member/index.ac" title="用户中心">用户中心</a>] [<a  href="<c:url value='/member/exit.ac?sysUserId=${userProxy.userId}'/>" title="退出">退出</a>] [<a class="color" target="_blank" href="${webRoot}/register.ac" title="新用户注册">新用户注册</a>]
                    </c:when>
                    <c:otherwise>
                        您好，欢迎来到美云谷！[<a href="${webRoot}/login.ac" title="登录">登录</a>] [<a class="color" href="${webRoot}/register.ac" title="新用户注册">新用户注册</a>]
                    </c:otherwise>
                </c:choose>
            </div>
            <%--用户登录状态显示结束--%>

            <%--用户信息查询开始--%>
            <div class="r"><a href="${webRoot}/module/member/myPrestore.ac?menuId=51541" title="我的帐户">我的帐户</a>  |  <a href="javascript:void(0);" title="购物车">购物车</a>  |  <a href="${webRoot}/module/member/productCollection.ac?menuId=51553" title="收藏夹">收藏夹</a>  |  <a href="${webRoot}/module/member/orderList.ac?menuId=51511" title="订单查询">订单查询</a>  |  <a href="${webRoot}/help.html" title="帮助中心">帮助中心</a></div>
            <%--用户信息查询结束--%>
            <div class="clear"></div>
        </div>
    </div>
    <%--顶部导航结束--%>

    <%--高级搜索开始--%>
    <div class="b_Area">
        <div class="logo"><a title="便捷生活 快乐到家" href="${webRoot}/index.html"><img alt="logo" src="${webRoot}/template/bdw/statics/images/logo.gif" /></a></div>
        <div class="searchBox">
            <form id="searchForm" action="${webRoot}/productlist.ac" method="get">
                <%--<input type="hidden" name="isOnSale" value="Y"/>--%>
                <input type="hidden" name="category" value="1"/>
                <%--<input type="hidden" name="type" value="search"/>--%>
                <div class="search">
                    <div class="put"><input id="searchFields" name="keyword" type="text" value="${paramNm}" maxlength="50" onfocus="if(this.value=='${paramNm}'){this.value=''}"/></div>
                    <div class="btn"><a href="javascript:void(0);" onclick="submitForm()" title="搜索">搜索</a></div>
                    <div class="clear"></div>
                </div>
            </form>
            <div class="hotFont">
                <label>热门搜索：</label>
                <c:forEach items="${hotKeywords}" var="hotKeyword">
                    <a href="${webRoot}/productlist.ac?keyword=${hotKeyword}" title="${hotKeyword}">${hotKeyword}</a>
                </c:forEach>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <%--高级搜索结束--%>

    <%--首页菜单导航开始--%>
    <div class="menu_Area">
        <div class="nav">
            <%--分类菜单开始--%>
            <div class="l_btn" id="l_btn"><a href="javascript:void(0);" class="a1"  title="所有商品分类">所有商品分类</a>
                <div  class="t1" id="t1" style="display:none;"  >
                    <%--一级分类开始--%>
                    <c:forEach items="${sdk:findAllProductCategory()}" var="category" varStatus="s">
                        <div class="item" id="item" >
                            <span><a  href="${webRoot}/productlist.ac?category=${category.categoryId}" title="${category.name}" >·${category.name}</a></span>
                            <div class="i-m" id="i-m" style="z-index:4;" >
                                <div class="l">
                                        <%--二级分类开始--%>
                                    <c:forEach items="${category.children}" var="child" end="9">
                                        <div class="fixBox">
                                            <label><a href="${webRoot}/productlist-${child.categoryId}.html" title="${child.name}">${child.name}</a></label>
                                            <div class="linkList">
                                                    <%--三级分类开始--%>
                                                <c:forEach items="${child.children}" var="tchild" varStatus="s">
                                                    <a href="${webRoot}/productlist-${tchild.categoryId}.html" title="${tchild.name}">${tchild.name}</a><c:if test="${!s.last}">| </c:if>
                                                </c:forEach>
                                                    <%--三级分类结束--%>
                                            </div>
                                            <div class="clear"></div>
                                        </div>
                                    </c:forEach>
                                        <%--二级分类结束--%>
                                </div>
                                <div class="r">
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </c:forEach>
                    <%--一级分类结束--%>
                    <p><a <%--href="${webRoot}/brandZone.ac?type=category&number=10002" --%>title="全部商品分类">&nbsp;全部商品分类>></a></p>
                </div>
            </div>
            <%--分类菜单结束--%>

            <%--主要菜单导航开始--%>
            <div class="c_menu">
                <ul>
                    <li><a class="cur" href="${webRoot}/" title="首页">首页</a></li>
                    <li><a href="${webRoot}/" title="品牌专区">品牌专区</a></li>
                    <li><a href="${webRoot}/" title="积分活动">积分活动</a></li>
                    <li><a href="${webRoot}/template/bdw/panicbuylist.jsp?type=today" title="促销活动">促销活动</a></li>
                    <li><a href="${webRoot}/template/bdw/tuanlist.jsp?type=today" title="团购活动">团购活动</a></li>
                </ul>
            </div>
            <%--主要菜单导航结束--%>

            <%--购物车开始--%>
            <div class="MybuyCar">
                <div class="l mybuyCar">购物车 <b>0</b> 件 <a href="javascript:void(0);"><img alt="我的购物车" src="${webRoot}/template/bdw/statics/images/header_mybuyCar.gif" /></a></div>
                <div class="r"><a href="javascript:void(0);">去结算>></a></div>
                <div class="clear"></div>
            </div>
            <%--购物车结束--%>

            <div class="clear"></div>
        </div>
        <div id="cartDiv" class="buyLayer" style="z-index: 100; margin-left:800px; margin-top:-10px;height: 50px;position: absolute;display: none;">
            <div align="center" style="color: #ccc;padding: 20px">您的购物车中暂无商品，赶快选择心爱的商品吧！</div>
        </div>
    </div>
    <%--首页菜单导航结束--%>

</div>
