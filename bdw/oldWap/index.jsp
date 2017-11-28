<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:findPageModuleProxy('weixin_content_F4_new').recommendPageProductes}" var="recommendProductPage" />
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${webName}</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/headerForIndex.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/index.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/unslider.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/css/zepto.alert.css" rel="stylesheet" type="text/css" >
    <style>
        .swiper-container{height:auto;}
    </style>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
        var paramData = {
            page : '${_page}',
        }
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/base.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.alert.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/tinyAlertDialog.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/statics/js/jquery.lazyload.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/index.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function(){
            //图片预加载：只要img标签中有data-original属性的都需要预加载
            $("img.lazy").lazyload(
                    {
                        effect: "fadeIn",
                        failure_limit : 5,
                        threshold : 150
                    }
            );
//            $("#message").load(webPath.webRoot+"/template/bdw/oldWap/ajaxload/indexMessage.jsp",{},function(){});
//            $("#login_entry").load(webPath.webRoot+"/template/bdw/oldWap/ajaxload/index_bottom.jsp",{},function(){});
            $("#index_row6").load(webPath.webRoot+"/template/bdw/oldWap/ajaxload/bottomLogin.jsp",{},function(){});
           /* $("#index_row7").load(webPath.webRoot+"/template/bdw/oldWap/ajaxload/bottomCopyright.jsp",{},function(){});*/
        });

    </script>
    <%--<script src="${webRoot}/template/bdw/oldWap/statics/js/swiper.min.js"></script>--%>

</head>

<body>
<!--头部-->
<header class="header">
    <div class="index-top">
        <div class="logo frameEdit" frameInfo="weixin_logo_new|65X25">
            <c:forEach items="${sdk:findPageModuleProxy('weixin_logo_new').advt.advtProxy}" var="logo" end="0">
                <i style="display:block;background: url(${logo.advUrl}) no-repeat 0 0 / 65px 25px;" onclick="window.location.href='${logo.link}'"></i>
            </c:forEach>
        </div>
        <form action="${webRoot}/wap/list.ac" method="get" class="yz-search-form" id="searchForm">
            <div class="yz-search-form-box">
                <a href="${webRoot}/wap/newSearch.ac">
                    <span class="yz-search-form-icon" id="search_btn"></span>
                    <div class="yz-search-form-input" style="line-height: 24px;font-size: 14px;padding-left: 3px;color: #A9A9B1;">
                        搜索商品
                        <%--<input id="put" type="text" maxlength="20" name="keyword" value="" placeholder="搜索商品" class="keyword">--%>
                    </div>
                </a>
            </div>
        </form>

        <div id="message"></div>
        <%-- 右上角的消息记录页面 --%>
        <div class="yz-search-login">
            <a href="${webRoot}/wap/mySystemMsg.ac" class="login" >
                <%--<span class="yz-msg">${fn:length(loginUser.userMsgListBySystem)}</span>--%>
            </a>
        </div>
    </div>
</header>
<!--中间内容-->
<div class="main">
    <!--焦点图-->
    <div class="focus-wrapper swiper-container frameEdit" frameInfo="weixinAdv_mobile_new|640X300">
        <ul class="focus swiper-wrapper">
            <c:forEach items="${sdk:findPageModuleProxy('weixinAdv_mobile_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="5">
                <c:choose>
                    <c:when test="${advtProxys.displayWayCode == '1'}">
                        <li class="slide-li cur swiper-slide"><a href="${advtProxys.link}"><img src="${advtProxys.advUrl}"/></a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="slide-li cur swiper-slide">${advtProxys.htmlTemplate}</li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
        <!-- Add Pagination -->
        <div class="swiper-pagination focus-slider"></div>
    </div>
    <!--快速入口-->
    <div class="nav-item frameEdit" frameInfo="weixin_Navigate_new|89X89">
        <nav class="quick-entry-nav">
            <c:forEach items="${sdk:findPageModuleProxy('weixin_Navigate_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="9">
                <a class="quick-entry-link" href="${advtProxys.link}">
                    <img class="lazy" data-original="${advtProxys.advUrl}">
                    <span>${fn:substring(advtProxys.title,0,4)}</span>
                </a>
            </c:forEach>
        </nav>
    </div>

    <%--<c:if test="${fn:length(sdk:findPageModuleProxy('weixin_gg_glock').advt.advtProxy) > 0}">--%>
        <div class="ggBlock frameEdit" frameInfo="weixin_gg_block">
            <%--<img src="${webRoot}/template/bdw/oldWap/statics/images/success-bg.png" alt="">--%>
            <c:forEach items="${sdk:findPageModuleProxy('weixin_gg_block').advt.advtProxy}" var="advt" varStatus="s" end="0">
              <a href="${advt.link}"><img class="lazy" data-original="${advt.advUrl}"></a>
            </c:forEach>
        </div>
    <%--</c:if>--%>

    <!--淘快讯-->
    <div class="fast-news frameEdit" frameInfo="weixin_message_new">
        <div class="row">
            <div class="col-xs-3">
                <a href="#"><span class="fast-icon"></span></a>
            </div>
            <div class="mes-wrapper">
                <div class="taoMes">
                    <ul>
                        <c:forEach items="${sdk:findPageModuleProxy('weixin_message_new').links}" var="sale_link">
                            <li style="line-height: 30px;">
                                <a href="${sale_link.link}"><span style="margin-top: 2px;color: red">${sale_link.title}</span></a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!--楼层内容-->
    <div class="floor">
        <!--1楼好货推荐-->
        <div class="floor-01">
            <div class="floor01-title frameEdit" frameInfo="weixin_title_F1_new">
                <c:forEach items="${sdk:findPageModuleProxy('weixin_title_F1_new').advt.advtProxy}" var="advt" varStatus="s" end="0">
                    <img src="${advt.advUrl}" alt="">
                </c:forEach>
            </div>
            <div class="floor01-cont frameEdit" frameInfo="weixin_content_F1_new">
                <ul class="floor01-list">
                    <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F1_new').recommendProducts}" var="prd" end="2">
                        <li class="floor01-item" >
                            <c:if test="${prd.isJoinActivity && not empty prd.activityPlateImageUrl}">
                                <div class="ac_image"><img src="${webRoot}/upload/${prd.activityPlateImageUrl}" alt=""/></div>
                            </c:if>
                            <div class="g-pic" align="center">
                                <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}"><img alt="${prd.name}" class="lazy" data-original="${empty prd.images ? prd.defaultImage['220X220'] : prd.images[0]['220X220']}"/></a>
                            </div>
                            <div class="g-title">
                                <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}"> ${fn:substring(prd.name,0,40)}</a>
                            </div>
                            <div class="g-price">￥<span>${prd.price.unitPrice}</span></div>
                            <%-- 这里如果加原价在小屏幕的手机会强制换行破坏样式，所以暂时不显示 --%>
                            <%--<div class="g-old-price"><del>¥<span>${prd.marketPrice}</span></del></div>--%>
                            <div style="clear: both;"></div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--楼层广告-->
        <div class="focus-ad-wrapper swiper-container frameEdit" frameInfo="weixinAdv_floor_new|640X200">
            <ul class="focus-ad swiper-wrapper">
                <c:forEach items="${sdk:findPageModuleProxy('weixinAdv_floor_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="4">
                    <c:choose>
                        <c:when test="${advtProxys.displayWayCode == '1'}">
                            <li class="slide-li swiper-slide"><a href="${advtProxys.link}"><img src="${advtProxys.advUrl}"/></a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="slide-li swiper-slide">${advtProxys.htmlTemplate}</li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
            <!-- Add Pagination -->
            <div class="swiper-pagination ad-slider"></div>
        </div>
        <!--2楼特色市场-->
        <div class="floor-02">
            <div class="floor02-title frameEdit" frameInfo="weixin_title_F2_new">
                <c:forEach items="${sdk:findPageModuleProxy('weixin_title_F2_new').advt.advtProxy}" var="advt" varStatus="s" end="0">
                    <img src="${advt.advUrl}" alt="">
                </c:forEach>
            </div>
            <div class="floor02-cont">
                <ul class="floor02-list1 frameEdit" frameInfo="weixin_content_F2_1_new|320X215" >
                    <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F2_1_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="1">
                        <li class="floor02-item">
                            <c:choose>
                                <c:when test="${advtProxys.displayWayCode == '1'}">
                                    <a href="${advtProxys.link}">
                                        <div class="g-pic"><img class="lazy" data-original="${advtProxys.advUrl}"/></div>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    ${advtProxys.htmlTemplate}
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
                <ul class="floor02-list2 frameEdit" frameInfo="weixin_content_F2_2_new|210X280">
                    <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F2_2_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="5">
                        <li class="floor02-item">
                            <c:choose>
                                <c:when test="${advtProxys.displayWayCode == '1'}">
                                    <a href="${advtProxys.link}">
                                        <div class="g-pic"><img class="lazy" data-original="${advtProxys.advUrl}"/></div>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    ${advtProxys.htmlTemplate}
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--3楼大牌入驻-->
        <div class="floor-03">
            <div class="floor03-title frameEdit" frameInfo="weixin_title_F3_new">
                <c:forEach items="${sdk:findPageModuleProxy('weixin_title_F3_new').advt.advtProxy}" var="advt" varStatus="s" end="0">
                    <img src="${advt.advUrl}" alt="">
                </c:forEach>
            </div>
            <div class="floor03-cont">
                <ul class="floor03-list1">
                    <li class="floor03-item">
                        <div class="item-col01 border-bf-r frameEdit" frameInfo="weixin_content_F3_1_new|315X340">
                            <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F3_1_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                                <c:choose>
                                    <c:when test="${advtProxys.displayWayCode == '1'}">
                                        <a href="${advtProxys.link}">
                                            <div class="g-pic"><img class="lazy" data-original="${advtProxys.advUrl}"/></div>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        ${advtProxys.htmlTemplate}
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <div class="item-col01 frameEdit" frameInfo="weixin_content_F3_2_new|315X170">
                            <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F3_2_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="1">
                                <c:choose>
                                    <c:when test="${advtProxys.displayWayCode == '1'}">
                                        <c:choose>
                                            <c:when test="${s.count eq 1}">
                                                <div class="item-col02">
                                                    <a href="${advtProxys.link}">
                                                        <div class="g-pic"><img class="lazy" data-original="${advtProxys.advUrl}"/></div>
                                                    </a>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="item-col02-1">
                                                    <a href="${advtProxys.link}">
                                                        <div class="g-pic"><img class="lazy" data-original="${advtProxys.advUrl}"/></div>
                                                    </a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        ${advtProxys.htmlTemplate}
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </li>
                    <%--<li class="floor03-item frameEdit" frameInfo="weixin_content_F3_3_new|315X170">--%>
                        <%--<c:forEach items="${sdk:findPageModuleProxy('weixin_content_F3_3_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="1">--%>
                            <%--<c:choose>--%>
                                <%--<c:when test="${advtProxys.displayWayCode == '1'}">--%>
                                    <%--<div class="item-col03">--%>
                                        <%--<a href="${advtProxys.link}">--%>
                                            <%--<div class="g-pic"><img class="lazy" data-original="${advtProxys.advUrl}"/></div>--%>
                                        <%--</a>--%>
                                    <%--</div>--%>
                                <%--</c:when>--%>
                                <%--<c:otherwise>--%>
                                    <%--${advtProxys.htmlTemplate}--%>
                                <%--</c:otherwise>--%>
                            <%--</c:choose>--%>
                        <%--</c:forEach>--%>
                    <%--</li>--%>

                </ul>
                <div class="frameEdit"frameInfo="weixin_content_F3_4_new|640X135" >
                    <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F3_4_new').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                        <c:choose>
                            <c:when test="${advtProxys.displayWayCode == '1'}">
                                <a class="big-goods" href="${advtProxys.link}">
                                    <div class="g-pic"><img class="lazy" data-original="${advtProxys.advUrl}"/></div>
                                </a>
                            </c:when>
                            <c:otherwise>
                                ${advtProxys.htmlTemplate}
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!--4楼单品推荐-->
        <div class="floor-04">
            <div class="floor04-title frameEdit" frameInfo="weixin_title_F4_new">
                <c:forEach items="${sdk:findPageModuleProxy('weixin_title_F4_new').advt.advtProxy}" var="advt" varStatus="s" end="0">
                    <img src="${advt.advUrl}" alt="">
                </c:forEach>
            </div>
            <div class="floor04-cont">
                <ul class="floor04-list frameEdit" frameInfo="weixin_content_F4_new">
                    <c:forEach items="${recommendProductPage.result}" var="prd" varStatus="s" end="9">
                        <li class="floor04-item">
                            <c:if test="${prd.isJoinActivity && not empty prd.activityPlateImageUrl}">
                                <div class="ac_image"><img src="${webRoot}/upload/${prd.activityPlateImageUrl}" alt=""/></div>
                            </c:if>
                            <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}">
                                <div class="g-pic">
                                    <img alt="${prd.name}" class="lazy" data-original="${empty prd.images ? prd.defaultImage['320X320'] : prd.images[0]['320X320']}" />
                                </div>
                                <div class="g-title">
                                    <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}"> ${fn:substring(prd.name,0,40)}</a>
                                </div>
                            </a>
                            <div class="g-price">￥<span>${prd.price.unitPrice}</span></div>
                            <div class="g-old-price"><del>¥<span>${prd.marketPrice}</span></del></div>
                            <div style="clear: both;"></div>
                            <a class="star ${prd.collect ? 'cur' : ''}" href="javascript:" productId="${prd.productId}" isCollect="${prd.collect}"></a>
                        </li>
                    </c:forEach>
                </ul>
                <c:if test="${recommendProductPage.totalCount > recommendProductPage.pageSize}">
                    <a href="javascript:;" class="more" style="position: relative;left: 40%;display: inline-block;margin: 10px;background-color: #fff;padding: 4px 15px;border-radius: 5px;">查看更多</a>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%--页脚开始--%>
    <%--<c:if test="${isWeixin!='Y'}">--%>
        <%--登录红条--%>
    <div class="row" id="index_row6">

    </div>
    <%-- 版权Div --%>
    <div class="row" style="background: #fff;">
        <%--cnzz站长统计--%>
        <%--<div class="col-xs-12" style="height: 30px; line-height: 30px; text-align: center;">
            <script type="text/javascript">
                var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
                document.write(unescape("%3Cspan id='cnzz_stat_icon_1257056943'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1257056943' type='text/javascript'%3E%3C/script%3E"));
            </script>
        </div>--%>
    </div>
    <div class="row" id="index_row7" >
        <div class="col-xs-12 frameEdit" frameInfo="bottom_link1_mobile" style="height: 30px; line-height: 30px; text-align: center;">

            <c:forEach items="${sdk:findPageModuleProxy('bottom_link1_mobile').links}" var="pageLinks" end="0" varStatus="s">
                <a href="${pageLinks.link}" class="cur">${pageLinks.title}</a>
            </c:forEach>
            <c:forEach items="${sdk:findPageModuleProxy('bottom_link1_mobile').links}" var="pageLinks" begin="1" end="1" varStatus="s">
                <a href="${pageLinks.link}">${pageLinks.title}</a>
            </c:forEach>
            <%--<a href="#" class="cur">触摸版</a>--%>
            <%--<a href="#">电脑版</a>--%>

        </div>
        <div class="col-xs-12 frameEdit" frameInfo="bottom_link2_mobile" style="height: 30px; line-height: 30px; text-align: center;">
            <c:forEach items="${sdk:findPageModuleProxy('bottom_link2_mobile').links}" var="pageLinks" end="0" varStatus="s">
                ${pageLinks.title}
            </c:forEach>
        </div>
        <div class="col-xs-12 frameEdit" frameInfo="bottom_link3_mobile" style="height: 30px; line-height: 30px; text-align: center;height: 30px;">
            <c:forEach items="${sdk:findPageModuleProxy('bottom_link3_mobile').links}" var="pageLinks" end="0" varStatus="s">
                ${pageLinks.title}
            </c:forEach>
        </div>
    </div>
    <%--</c:if>--%>

<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始1--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>

</body>

<f:FrameEditTag />

</html>

<script src="${webRoot}/template/bdw/oldWap/statics/js/swiper.min.js" ></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/unslider.js" ></script>
<script>
    //        轮播图
    var swiper01 = new Swiper('.focus-wrapper', {
        pagination: '.swiper-pagination',/*分页器*/
        slidesPerView: 1,
        paginationClickable: true,/*点击那几个小点*/
        autoplay : 2500,
        loop : true
    });
    //        楼层广告
    var swiper02 = new Swiper('.focus-ad-wrapper', {
        pagination: '.swiper-pagination',/*分页器*/
        slidesPerView: 1,
        paginationClickable: true,/*点击那几个小点*/
        autoplay : 2500,
        loop : true
    });

    /*var swiper03 = new Swiper('.mes-wrapper', {
        direction : 'vertical',
        //!*mode: 'vertical',
        autoplay : 2500,
        loop : true
    });*/

    jQuery(document).ready(function($) {
        $('.taoMes').unslider({
            animation:'vertical',
            autoplay:true,
            delay:2500,
            keys:false,
            arrows:false
           }
        );
    });


</script>




