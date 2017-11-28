<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}" /> <%--SEO description优化--%>
    <title>${webName}-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/newIndex.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.corner.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.nivo.slider.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.nivo.slider.pack.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/common.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/index.js"></script>
</head>

<body>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=index"/>
<%--页脚结束--%>

<%--主要板块开始--%>
<div id="index">
<div class="produ-item-part1">
    <%--轮换广告 start--%>
    <div class="adv sorPic" style="position: relative;">
        <div class="banner-pic frameEdit" id="roteAdv"  frameInfo="jvan_roteAdv|740X350/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_roteAdv').advt.advtProxy}" var="advtProxys" varStatus="s">
                <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="740px" height="350px" /></a>
            </c:forEach>
        </div>
    </div>
    <%--轮换广告 end--%>
    <%--商城公告 start--%>
    <div class="m1">
        <h2>安心购物</h2>
        <div class="box">
            <%--<ul>--%>
            <div class="frameEdit" frameInfo="jvan_safeBuy1|79X80/0X0">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_safeBuy1').advt.advtProxy}" var="adv" end="2" varStatus="s">
                    <%--<li>--%><a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="79px" height="88px" /></a><%--</li>--%>
                </c:forEach>
            </div>

            <%--<div class="frameEdit" frameInfo="jvan_safeBuy2|79X80">--%>
            <%--<c:forEach items="${sdk:findPageModuleProxy('jvan_safeBuy2').advt.advtProxy}" var="adv" end="0" varStatus="s">--%>
            <%--&lt;%&ndash;<li>&ndash;%&gt;<a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="78px" height="79px" /></a>&lt;%&ndash;</li>&ndash;%&gt;--%>
            <%--</c:forEach>--%>
            <%--</div>--%>

            <%--<div class="frameEdit" frameInfo="jvan_safeBuy3|79X80">--%>
            <%--<c:forEach items="${sdk:findPageModuleProxy('jvan_safeBuy3').advt.advtProxy}" var="adv" end="0" varStatus="s">--%>
            <%--&lt;%&ndash;<li>&ndash;%&gt;<a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="78px" height="79px" /></a>&lt;%&ndash;</li>&ndash;%&gt;--%>
            <%--</c:forEach>--%>
            <%--</div>--%>
            <%--<li><img src="images/index_ico01.gif" /><br />厂家直销<br />品质保证</li>--%>
            <%--<li><img src="images/index_ico02.gif" /><br />全场<br />免运费</li>--%>
            <%--<li><img src="images/index_ico03.gif" /><br />800城市<br />货到付款</li>--%>
            <%--</ul>--%>
        </div>
    </div>
    <div class="m2">
        <h2>商城公告</h2>
        <div class="box">
            <ul>
                <c:forEach items="${sdk:getArticleCategoryById(54981).top10}" var="article" end="6" >
                    <c:choose>
                        <c:when test="${not empty article.externalLink}">
                            <li><a target="_blank" href="${article.externalLink}" title="${article.title}">·${fn:substring(article.title,0,30)}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a target="_blank" href="${webRoot}/mallNotice-${article.infArticleId}-${article.categoryId}.html" title="${article.title}">·${fn:substring(article.title,0,30)}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="clear"></div>
    <%--商城公告 end--%>

    <%--商城公告广告 start--%>
    <div class="banner frameEdit" frameInfo="jvan_min_adv|200X60/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_min_adv').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <li><a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="200px" height="60px" /></a></li>
        </c:forEach>
    </div>
    <%--商城公告广告 end--%>
</div>
<%--品牌展示 start--%>
<div class="produ-item-part2">
    <div class="sorllMore">
        <div class="sorllPic frameEdit" frameInfo="jvan_brand_show" style="width:870px;height: 58px;overflow: hidden;">
            <div  id="mycarousel" style="width:870px;height: 58px;overflow: hidden;">
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_brand_show').links}" var="pageLinks" end="20" varStatus="s">
                        <li>
                            <div>
                                <div class="pic"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon['']}" width="100px" height="51px" /></a></div>
                                <div class="title"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">·${pageLinks.title}</a></div>
                                <div class="text"><a>${pageLinks.description}</a></div>
                                <div class="clear"></div>
                            </div>
                        </li>
                        <%--<img src="${webRoot}/template/3Cv2/statics/images/index_f1_ico.gif" />--%>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="turn_left"><a id="mycarousel-prev" href="javascript:"></a></div>
        <div class="turn_right"><a id="mycarousel-next" href="javascript:"></a></div>
    </div>
    <div class="min_adv frameEdit" frameInfo="jvan_noticeAdv|240X60/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_noticeAdv').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <li><a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="60px" /></a></li>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
<%--品牌展示 end--%>
<%--商品展示 start--%>
<div class="produ-item-part3">

    <div class="list">
        <div class="t_Menu">
            <ul>
                <li><a class="topTab topTab1 cur" href="javascript:void(0);" onmousemove="topTabHover('.topTab1','.tabItem1')">疯狂抢购</a></li>
                <li><a class="topTab topTab2" href="javascript:void(0);" onmousemove="topTabHover('.topTab2','.tabItem2')">限时抢购</a></li>
                <li><a class="topTab topTab3" href="javascript:void(0);" onmousemove="topTabHover('.topTab3','.tabItem3')">热卖商品</a></li>
                <li><a class="topTab topTab4" href="javascript:void(0);" onmousemove="topTabHover('.topTab4','.tabItem4')">新品上架</a></li>
            </ul>
        </div>
        <div class="item tabItem tabItem1 frameEdit" style="display: block;" frameInfo="jvan_qianggou1">
            <ul>
                <c:forEach items="${sdk:findPageModuleProxy('jvan_qianggou1').recommendProducts}" var="prd" end="9">
                    <li>
                        <div class="pic">
                            <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                        </div>
                        <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                        <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="item tabItem tabItem2 frameEdit" style="display: none;" frameInfo="jvan_qianggou2">
            <ul>
                <c:forEach items="${sdk:findPageModuleProxy('jvan_qianggou2').recommendProducts}" var="prd" end="9">
                    <li>
                        <div class="pic">
                            <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                        </div>
                        <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                        <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="item tabItem tabItem3 frameEdit" style="display: none;" frameInfo="jvan_qianggou3">
            <ul>
                <c:forEach items="${sdk:findPageModuleProxy('jvan_qianggou3').recommendProducts}" var="prd" end="9">
                    <li>
                        <div class="pic">
                            <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                        </div>
                        <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                        <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="item tabItem tabItem4 frameEdit" style="display: none;" frameInfo="jvan_qianggou4">
            <ul>
                <c:forEach items="${sdk:findPageModuleProxy('jvan_qianggou4').recommendProducts}" var="prd" end="9">
                    <li>
                        <div class="pic">
                            <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                        </div>
                        <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                        <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="JD_treamBuy">
        <h2><span>今日团购</span></h2>
        <c:forEach items="${sdk:findTodayGroupBuy(null)}" var="groupBuyProxy"  varStatus="stat" end="1">
            <div class="item">
                <div class="pic">
                    <a target="_blank" href="${webRoot}/tuan.ac?id=${groupBuyProxy.groupBuyId}" title="${groupBuyProxy.title}"><img alt="${groupBuyProxy.title}" src="${groupBuyProxy.pic['220X140']}" width="210px" height="140px"/></a>
                </div>
                <div class="title"><a target="_blank" href="${webRoot}/tuan.ac?id=${groupBuyProxy.groupBuyId}&type=today" title="${groupBuyProxy.title}">${fn:substring(groupBuyProxy.title,0,60)}</a></div>
                <div class="goto">
                    <div class="price">￥<fmt:formatNumber value="${groupBuyProxy.price.unitPrice}" type="number" pattern="#0.00#" /></div>
                    <div class="to"><a href="${webRoot}/tuan.ac?id=${groupBuyProxy.groupBuyId}" target="_blank">去看看</a></div>
                    <div class="clear"></div>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
<%--商品展示 end--%>

<%--F1 start--%>
<div class="produ-item-part4">
    <div class="list layout-color-chuange-1">
        <div class="nav-pro-l">
            <h2>
                <a class="addItem" href="javascript:void(0);"></a>
                <span  class="frameEdit"  frameInfo="jvan_F1_link">
                     <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_link').links}" var="pageLinks" end="9" varStatus="s">
                         ${pageLinks.title}
                     </c:forEach>
                </span>
            </h2>
            <div class="layout_sbj_list frameEdit"  frameInfo="jvan_F1_catrgory" style="display:none;" >
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_catrgory').links}" var="pageLinks" end="9" varStatus="s">
                        <li><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">·${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>

            <div class="pic frameEdit" frameInfo="jvan_F1_left_adv|210X500/0X0">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_left_adv').advt.advtProxy}" var="adv" end="0" varStatus="s">
                    <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="210px" height="500px" /></a>
                </c:forEach>
            </div>
        </div>
        <div class="nav-pro-r">
            <div class="t_Menu frameEdit"  frameInfo="jvan_F1_prd_recommend1|null|Y">
                <ul>
                    <li><a class="prdTab prdTab1 cur" onmousemove="prdTabHover('.prdTab','.layout_f1','.prdTab1','.layout-A-B-F1')" href="javascript:void(0);">特惠精选</a></li>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_prd_recommend1').tabs}" var="pageLinks" end="2" varStatus="s">
                        <li><a class="prdTab prdTab${s.count+1}" onmousemove="prdTabHover('.prdTab','.layout_f1','.prdTab${s.count+1}','.layout-list-F1-${s.count}')" href="javascript:void(0);">${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="layout_f1 layout-A-B layout-A-B-F1">
                <div class="item itemsHover">
                    <div class="tp">
                        <div class="pic frameEdit" frameInfo="jvan_F1_tehui_adv1|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_tehui_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                        <div class="pic frameEdit" frameInfo="jvan_F1_tehui_adv2|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_tehui_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="bp frameEdit" frameInfo="jvan_F1_tehui_adv3|368X350/0X0">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_tehui_adv3').advt.advtProxy}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" style=" width:368px; height:350px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="368px" height="350px" /></a>
                        </c:forEach>
                    </div>
                </div>
                <div class="item itemsHover">
                    <div class="bp frameEdit" frameInfo="jvan_F1_tehui_adv4|368X350/0X0">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_tehui_adv4').advt.advtProxy}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" style=" width:368px; height:350px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="368px" height="350px" /></a>
                        </c:forEach>
                    </div>

                    <div class="tp">

                        <div class="pic frameEdit" frameInfo="jvan_F1_tehui_adv5|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_tehui_adv5').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>

                        <div class="pic frameEdit" frameInfo="jvan_F1_tehui_adv6|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_tehui_adv6').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_prd_recommend1').tabs}" var="tab" end="2" varStatus="s">
                <div class="layout_f1 layout-list layout-list-F1-${s.count}" style="display: none;">
                    <ul>
                        <c:forEach items="${tab.recommendProducts}" var="prd" end="7">
                            <li>
                                <div class="pic">
                                    <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                                </div>
                                <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                                <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <div class="show_more">
        <div class="m1">
            <h2>推荐品牌</h2>
            <div class="box frameEdit" frameInfo="jvan_F1_right_brank_advs|115X40/0X0">
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_right_brank_advs').advt.advtProxy}" var="adv" end="5" varStatus="s">
                        <li><a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="115px" height="40px" /></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="banner frameEdit" frameInfo="jvan_F1_right_adv1|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_right_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F1_right_adv2|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_right_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F1_right_adv3|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_right_adv3').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div class="produ-item-banner">
    <div class="adv frameEdit" frameInfo="jvan_F1_banner1|950X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_banner1').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="950px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="banner frameEdit" frameInfo="jvan_F1_banner2|240X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F1_banner2').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
<%--F1 end--%>

<%--F2 start--%>
<div class="produ-item-part4">
    <div class="list layout-color-chuange-2">
        <div class="nav-pro-l">

            <h2>
                <a class="addItem" href="javascript:void(0);"></a>
                <span  class="frameEdit"  frameInfo="jvan_F2_link">
                     <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_link').links}" var="pageLinks" end="9" varStatus="s">
                         ${pageLinks.title}
                     </c:forEach>
                </span>
            </h2>

            <div class="layout_sbj_list frameEdit"  frameInfo="jvan_F2_catrgory" style="display:none;" >
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_catrgory').links}" var="pageLinks" end="9" varStatus="s">
                        <li><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">·${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="pic frameEdit" frameInfo="jvan_F2_left_adv|210X500/0X0">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_left_adv').advt.advtProxy}" var="adv" end="0" varStatus="s">
                    <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="210px" height="500px" /></a>
                </c:forEach>
            </div>
        </div>
        <div class="nav-pro-r">
            <div class="t_Menu frameEdit"  frameInfo="jvan_F2_prd_recommend1|null|Y">
                <ul>
                    <li><a class="F2PrdTab F2PrdTab1 cur" onmousemove="prdTabHover('.F2PrdTab','.layout_f2','.F2PrdTab1','.layout-A-B-F2')" href="javascript:void(0);">特惠精选</a></li>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_prd_recommend1').tabs}" var="pageLinks" end="2" varStatus="s">
                        <li><a class="F2PrdTab F2PrdTab${s.count+1}" onmousemove="prdTabHover('.F2PrdTab','.layout_f2','.F2PrdTab${s.count+1}','.layout-list-F2-${s.count}')" href="javascript:void(0);">${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="layout_f2 layout-A-B-C layout-A-B-F2">
                <div class="item itemsHover2">

                    <div class="banner frameEdit" frameInfo="jvan_F2_tehui_adv1">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_tehui_adv1').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}"  class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="banner frameEdit" frameInfo="jvan_F2_tehui_adv2">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_tehui_adv2').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="banner frameEdit" frameInfo="jvan_F2_tehui_adv3">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_tehui_adv3').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="item itemsHover2">

                    <div class="sorll_Banner sorPic" style="position: relative;">
                        <div class="banner-pic frameEdit" id="tehui_roteAdv"  frameInfo="jvan_F2_tehui_roteAdv|245X333/520X350">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_tehui_roteAdv').advt.advtProxy}" var="advtProxys" varStatus="s">
                                <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv1${s.count}" title="${advtProxys.title}" width="245px" height="333px" /></a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="banner frameEdit" frameInfo="jvan_F2_tehui_adv4">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_tehui_adv4').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="item list_item itemsHover2">

                    <div class="banner frameEdit" frameInfo="jvan_F2_tehui_adv6">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_tehui_adv6').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="banner frameEdit" frameInfo="jvan_F2_tehui_adv7">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_tehui_adv7').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="banner frameEdit" frameInfo="jvan_F2_tehui_adv8">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_tehui_adv8').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_prd_recommend1').tabs}" var="tab" end="2" varStatus="s">
                <div class="layout_f2 layout-list layout-list-F2-${s.count}" style="display: none;">
                    <ul>
                        <c:forEach items="${tab.recommendProducts}" var="prd" end="7">
                            <li>
                                <div class="pic">
                                    <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                                </div>
                                <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                                <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <div class="show_more">
        <div class="m1">
            <h2>推荐品牌</h2>
            <div class="box frameEdit" frameInfo="jvan_F2_right_brank_advs|115X40/0X0">
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_right_brank_advs').advt.advtProxy}" var="adv" end="5" varStatus="s">
                        <li><a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="115px" height="40px" /></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="banner frameEdit" frameInfo="jvan_F2_right_adv1|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_right_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F2_right_adv2|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_right_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F2_right_adv3|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_right_adv3').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div class="produ-item-banner">
    <div class="adv frameEdit" frameInfo="jvan_F2_banner1|950X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_banner1').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="950px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="banner frameEdit" frameInfo="jvan_F2_banner2|240X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F2_banner2').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
<%--F2 end--%>

<%--F3 start--%>
<div class="produ-item-part4">
    <div class="list layout-color-chuange-3">
        <div class="nav-pro-l">
            <h2>
                <a class="addItem" href="javascript:void(0);"></a>
                <span  class="frameEdit"  frameInfo="jvan_F3_link">
                     <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_link').links}" var="pageLinks" end="9" varStatus="s">
                         ${pageLinks.title}
                     </c:forEach>
                </span>
            </h2>
            <div class="layout_sbj_list frameEdit"  frameInfo="jvan_F3_catrgory" style="display:none;" >
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_catrgory').links}" var="pageLinks" end="9" varStatus="s">
                        <li><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">·${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>

            <div class="pic frameEdit" frameInfo="jvan_F3_left_adv|210X500/0X0">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_left_adv').advt.advtProxy}" var="adv" end="0" varStatus="s">
                    <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="210px" height="500px" /></a>
                </c:forEach>
            </div>
        </div>
        <div class="nav-pro-r">
            <div class="t_Menu frameEdit"  frameInfo="jvan_F3_prd_recommend1|null|Y">
                <ul>
                    <li><a class="F3prdTab F3prdTab1 cur" onmousemove="prdTabHover('.F3prdTab','.layout_f3','.F3prdTab1','.layout-A-B-F3')" href="javascript:void(0);">特惠精选</a></li>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_prd_recommend1').tabs}" var="pageLinks" end="2" varStatus="s">
                        <li><a class="F3prdTab F3prdTab${s.count+1}" onmousemove="prdTabHover('.F3prdTab','.layout_f3','.F3prdTab${s.count+1}','.layout-list-F3-${s.count}')" href="javascript:void(0);">${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="layout_f3 layout-A-B layout-A-B-F3">
                <div class="item itemsHover">
                    <div class="tp">
                        <div class="pic frameEdit" frameInfo="jvan_F3_tehui_adv1|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_tehui_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                        <div class="pic frameEdit" frameInfo="jvan_F3_tehui_adv2|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_tehui_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="bp frameEdit" frameInfo="jvan_F3_tehui_adv3|368X350/0X0">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_tehui_adv3').advt.advtProxy}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" style=" width:368px; height:350px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="368px" height="350px" /></a>
                        </c:forEach>
                    </div>
                </div>
                <div class="item itemsHover">
                    <div class="bp frameEdit" frameInfo="jvan_F3_tehui_adv4|368X350/0X0">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_tehui_adv4').advt.advtProxy}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" style=" width:368px; height:350px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="368px" height="350px" /></a>
                        </c:forEach>
                    </div>

                    <div class="tp">
                        <div class="pic frameEdit" frameInfo="jvan_F3_tehui_adv5|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_tehui_adv5').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>

                        <div class="pic frameEdit" frameInfo="jvan_F3_tehui_adv6|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_tehui_adv6').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_prd_recommend1').tabs}" var="tab" end="2" varStatus="s">
                <div class="layout_f3 layout-list layout-list-F3-${s.count}" style="display: none;">
                    <ul>
                        <c:forEach items="${tab.recommendProducts}" var="prd" end="7">
                            <li>
                                <div class="pic">
                                    <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                                </div>
                                <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                                <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <div class="show_more">
        <div class="m1">
            <h2>推荐品牌</h2>
            <div class="box frameEdit" frameInfo="jvan_F3_right_brank_advs|115X40/0X0">
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_right_brank_advs').advt.advtProxy}" var="adv" end="5" varStatus="s">
                        <li><a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="115px" height="40px" /></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="banner frameEdit" frameInfo="jvan_F3_right_adv1|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_right_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F3_right_adv2|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_right_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F3_right_adv3|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_right_adv3').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div class="produ-item-banner">
    <div class="adv frameEdit" frameInfo="jvan_F3_banner1|950X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_banner1').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="950px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="banner frameEdit" frameInfo="jvan_F3_banner2|240X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F3_banner2').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
<%--F3 end--%>

<%--F4 start--%>
<div class="produ-item-part4">
    <div class="list layout-color-chuange-4">
        <div class="nav-pro-l">

            <h2>
                <a class="addItem" href="javascript:void(0);"></a>
                <span  class="frameEdit"  frameInfo="jvan_F4_link">
                     <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_link').links}" var="pageLinks" end="9" varStatus="s">
                         ${pageLinks.title}
                     </c:forEach>
                </span>
            </h2>

            <div class="layout_sbj_list frameEdit"  frameInfo="jvan_F4_catrgory" style="display:none;" >
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_catrgory').links}" var="pageLinks" end="9" varStatus="s">
                        <li><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">·${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="pic frameEdit" frameInfo="jvan_F4_left_adv|210X500/0X0">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_left_adv').advt.advtProxy}" var="adv" end="0" varStatus="s">
                    <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="210px" height="500px" /></a>
                </c:forEach>
            </div>
        </div>
        <div class="nav-pro-r">
            <div class="t_Menu frameEdit"  frameInfo="jvan_F4_prd_recommend1|null|Y">
                <ul>
                    <li><a class="F4PrdTab F4PrdTab1 cur" onmousemove="prdTabHover('.F4PrdTab','.layout_f4','.F4PrdTab1','.layout-A-B-F4')" href="javascript:void(0);">特惠精选</a></li>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_prd_recommend1').tabs}" var="pageLinks" end="2" varStatus="s">
                        <li><a class="F4PrdTab F4PrdTab${s.count+1}" onmousemove="prdTabHover('.F4PrdTab','.layout_f4','.F4PrdTab${s.count+1}','.layout-list-F4-${s.count}')" href="javascript:void(0);">${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="layout_f4 layout-A-B-C layout-A-B-F4">
                <div class="item itemsHover2">
                    <div class="banner frameEdit" frameInfo="jvan_F4_tehui_adv1">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_tehui_adv1').links}" var="adv" end="0" varStatus="s">
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                        </c:forEach>
                    </div>
                    <div class="banner frameEdit" frameInfo="jvan_F4_tehui_adv2">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_tehui_adv2').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="banner frameEdit" frameInfo="jvan_F4_tehui_adv3">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_tehui_adv3').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="item itemsHover2">
                    <div class="sorll_Banner sorPic" style="position: relative;">
                        <div class="banner-pic frameEdit" id="tehui_roteAdv2"  frameInfo="jvan_F4_tehui_roteAdv|245X333/520X350">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_tehui_roteAdv').advt.advtProxy}" var="advtProxys" varStatus="s">
                                <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv2${s.count}" title="${advtProxys.title}" width="245px" height="333px" /></a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="banner frameEdit" frameInfo="jvan_F4_tehui_adv4">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_tehui_adv4').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="item list_item itemsHover2">
                    <div class="banner frameEdit" frameInfo="jvan_F4_tehui_adv6">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_tehui_adv6').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="banner frameEdit" frameInfo="jvan_F4_tehui_adv7">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_tehui_adv7').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="banner frameEdit" frameInfo="jvan_F4_tehui_adv8">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_tehui_adv8').links}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" class="img-a-title itemHover2" target="_blank" href="${adv.link}"></a>
                            <div class="p-img">
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.icon['']}" alt="${adv.title}" title="${adv.title}"  width="245px" height="166px" /></a>
                            </div>
                            <div class="p-detail">
                                <div class="p-name"><a title="${adv.title}" target="_blank" href="${adv.link}">${fn:substring(adv.title,0,35)}</a></div>
                                <div class="p-price" >${adv.description}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_prd_recommend1').tabs}" var="tab" end="2" varStatus="s">
                <div class="layout_f4 layout-list layout-list-F4-${s.count}" style="display: none;">
                    <ul>
                        <c:forEach items="${tab.recommendProducts}" var="prd" end="7">
                            <li>
                                <div class="pic">
                                    <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                                </div>
                                <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                                <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <div class="show_more">
        <div class="m1">
            <h2>推荐品牌</h2>
            <div class="box frameEdit" frameInfo="jvan_F4_right_brank_advs|115X40/0X0">
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_right_brank_advs').advt.advtProxy}" var="adv" end="5" varStatus="s">
                        <li><a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="115px" height="40px" /></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="banner frameEdit" frameInfo="jvan_F4_right_adv1|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_right_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F4_right_adv2|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_right_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F4_right_adv3|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_right_adv3').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div class="produ-item-banner">
    <div class="adv frameEdit" frameInfo="jvan_F4_banner1|950X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_banner1').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="950px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="banner frameEdit" frameInfo="jvan_F4_banner2|240X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F4_banner2').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
<%--F4 end--%>

<%--F5 start--%>
<div class="produ-item-part4">
    <div class="list layout-color-chuange-5">
        <div class="nav-pro-l">
            <h2>
                <a class="addItem" href="javascript:void(0);"></a>
                <span  class="frameEdit"  frameInfo="jvan_F5_link">
                     <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_link').links}" var="pageLinks" end="9" varStatus="s">
                         ${pageLinks.title}
                     </c:forEach>
                </span>
            </h2>
            <div class="layout_sbj_list frameEdit"  frameInfo="jvan_F5_catrgory" style="display:none;" >
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_catrgory').links}" var="pageLinks" end="9" varStatus="s">
                        <li><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">·${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>

            <div class="pic frameEdit" frameInfo="jvan_F5_left_adv|210X500/0X0">
                <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_left_adv').advt.advtProxy}" var="adv" end="0" varStatus="s">
                    <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="210px" height="500px" /></a>
                </c:forEach>
            </div>
        </div>
        <div class="nav-pro-r">
            <div class="t_Menu frameEdit"  frameInfo="jvan_F5_prd_recommend1|null|Y">
                <ul>
                    <li><a class="F5prdTab F5prdTab1 cur" onmousemove="prdTabHover('.F5prdTab','.layout_f5','.F5prdTab1','.layout-A-B-F5')" href="javascript:void(0);">特惠精选</a></li>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_prd_recommend1').tabs}" var="pageLinks" end="2" varStatus="s">
                        <li><a class="F5prdTab F5prdTab${s.count+1}" onmousemove="prdTabHover('.F5prdTab','.layout_f5','.F5prdTab${s.count+1}','.layout-list-F5-${s.count}')" href="javascript:void(0);">${pageLinks.title}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="layout_f5 layout-A-B layout-A-B-F5">
                <div class="item itemsHover">
                    <div class="tp">
                        <div class="pic frameEdit" frameInfo="jvan_F5_tehui_adv1|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_tehui_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                        <div class="pic frameEdit" frameInfo="jvan_F5_tehui_adv2|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_tehui_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="bp frameEdit" frameInfo="jvan_F5_tehui_adv3|368X350/0X0">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_tehui_adv3').advt.advtProxy}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" style=" width:368px; height:350px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="368px" height="350px" /></a>
                        </c:forEach>
                    </div>
                </div>
                <div class="item itemsHover">
                    <div class="bp frameEdit" frameInfo="jvan_F5_tehui_adv4|368X350/0X0">
                        <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_tehui_adv4').advt.advtProxy}" var="adv" end="0" varStatus="s">
                            <a title="${adv.title}" style=" width:368px; height:350px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="368px" height="350px" /></a>
                        </c:forEach>
                    </div>
                    <div class="tp">
                        <div class="pic frameEdit" frameInfo="jvan_F5_tehui_adv5|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_tehui_adv5').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                        <div class="pic frameEdit" frameInfo="jvan_F5_tehui_adv6|184X150/0X0">
                            <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_tehui_adv6').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                <a title="${adv.title}" style=" width:184px; height:150px;"  class="img-a-title itemHover" target="_blank" href="${adv.link}"></a>
                                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="184px" height="150px" /></a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_prd_recommend1').tabs}" var="tab" end="2" varStatus="s">
                <div class="layout_f5 layout-list layout-list-F5-${s.count}" style="display: none;">
                    <ul>
                        <c:forEach items="${tab.recommendProducts}" var="prd" end="7">
                            <li>
                                <div class="pic">
                                    <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="150px" height="150px"/></a>
                                </div>
                                <div class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                                <div class="price">销售价:<b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b><%--<br /><span>市场价：<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></span>--%></div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <div class="show_more">
        <div class="m1">
            <h2>推荐品牌</h2>
            <div class="box frameEdit" frameInfo="jvan_F5_right_brank_advs|115X40/0X0">
                <ul>
                    <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_right_brank_advs').advt.advtProxy}" var="adv" end="5" varStatus="s">
                        <li><a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="115px" height="40px" /></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="banner frameEdit" frameInfo="jvan_F5_right_adv1|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_right_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F5_right_adv2|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_right_adv2').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>

        <div class="banner frameEdit" frameInfo="jvan_F5_right_adv3|240X120/0X0">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_right_adv3').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="120px" /></a>
            </c:forEach>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div class="produ-item-banner">
    <div class="adv frameEdit" frameInfo="jvan_F5_banner1|950X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_banner1').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="950px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="banner frameEdit" frameInfo="jvan_F5_banner2|240X50/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_F5_banner2').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="50px" /></a>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
<%--F5 end--%>
<div class="produ-item-part5">
    <div class="info_pro">
        <div class="say_cp">
            <h2>网友评论</h2>
            <div class="box "  style="overflow: hidden; height: 175px">
                <div class="newComment"  style="overflow: hidden;height: 173px">
                    <c:forEach items="${sdk:findAllProductComments(10).result}" var="comment">
                        <c:set value="${sdk:getProductById(comment.objectId)}" var="product"/>
                        <c:if test="${product.onSale}">
                            <div class="item jvf_index_dianp_con">
                                <div class="pic">
                                    <a target="_blank" href="${webRoot}/product-${product.productId}.html" title="${product.name}"><img src="${product.defaultImage["50X50"]}" alt="${product.name}" width="60px" height="53px" /></a>
                                </div>
                                <div class="info">
                                    <div class="title"><a target="_blank" href="${webRoot}/product-${product.productId}.html" title="${product.name}">${product.name}</a></div>
                                    <p>${comment.content}</p>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="hot_cp">
            <h2>热门活动</h2>
            <div class="box"  style="overflow: hidden; height: 175px">
                <div class="newComment frameEdit" frameInfo="jvan_hot_activity"  style="overflow: hidden;height: 173px">

                    <c:forEach items="${sdk:findPageModuleProxy('jvan_hot_activity').links}" var="pageLinks" end="2" varStatus="s">
                        <div class="item jvf_index_dianp_con">
                            <div class="pic"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon['']}" width="60px" height="53px" /></a></div>
                            <div class="info">
                                <div class="title"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a></div>
                                <p>${pageLinks.description}</p>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="banner frameEdit" frameInfo="jvan_bottom_adv|240X210/0X0">
        <c:forEach items="${sdk:findPageModuleProxy('jvan_bottom_adv').advt.advtProxy}" var="adv" end="0" varStatus="s">
            <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="240px" height="210px" /></a>
        </c:forEach>
    </div>
    <div class="clear"></div>
</div>
</div>
<%--主要板块结束--%>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
