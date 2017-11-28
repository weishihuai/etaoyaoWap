<%@ taglib prefix="f" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:set value="${sdk:findShopPageModuleProxy(param.shopId,'shop_Head_Slide_adv1').advt}" var="advt"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/shopError.ac"></c:redirect>
</c:if>

<%--店铺的会员账号被删除--%>
<c:if test="${bdw:checkShopIsDeleted(shop.shopInfId)}">
    <c:redirect url="/shopError.ac"></c:redirect>
</c:if>

<c:if test="${shop.shopType eq '2'}"><%--如果是门店的则跳转到同城送门店首页--%>
    <c:redirect url="${webRoot}/citySend/storeDetail.ac?orgId=${shop.sysOrgId}"></c:redirect>
</c:if>

<c:set value="${sdk:isShowAdvAndRecommend()}" var="isShowAdvAndRecommend"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-${shop.shopNm}</title>
    <!--[if IE 6]>
    <script type="text/javascript" src="script/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('div,ul,li,a,h1,h2,h3,input,img,span,dl, background');</script><![endif]-->
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/shopTemplate/default/statics/css/shop_index.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/shopTemplate/default/statics/css/shop_top.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/shopTemplate/default/statics/js/shopIndex.js"></script>
    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}"
        };
        $(function(){
           var windowWidth =  document.body.offsetWidth;
           var roteAdv = $("#roteAdv");
           var width = roteAdv.width();
           if(width > windowWidth){
               $(".shop_banner").width(windowWidth);
               roteAdv.width(windowWidth);
               $('#roteAdv a').width(windowWidth);
               $('#roteAdv a img').attr("width",windowWidth+"px");
               $("#nav").css("margin-left",windowWidth/2);
           }else{
                $("#nav").css("margin-left",width/2);
            }
        });
    </script>

</head>

<body>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:set value="${sdk:getShopCategoryProxy(param.shopId)}" var="shopCategory"/>

<c:import url="/template/bdw/shopTemplate/default/include/shopHeader.jsp?p=index"/>

<div class="shop_banner" <c:if test="${advt.width > 0 && advt.height > 0 }"> style="width:${advt.width}px;height: ${advt.height}px;" </c:if>>
    <%--banner 开始--%>
    <div id="roteAdv" class="banner shopEdit" shopInfo="shop_Head_Slide_adv1||410X1400"<c:if test="${advt.width > 0 && advt.height > 0 }"> style="width:${advt.width}px;height: ${advt.height}px;" </c:if>>
        <c:forEach items="${advt.advtProxy}" var="advtProxys" varStatus="s">
            <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}" style="width:${advt.width}px;height: ${advt.height}px;">
                <img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="1190px" height="410px" style="display: block" ;/>
            </a>
        </c:forEach>
    </div>
    <div id="nav" class="slide-controls">
    </div>
    <%--banner 结束--%>
</div>
<%--<div class="shop_banner">--%>
    <%--&lt;%&ndash;banner 开始&ndash;%&gt;--%>
    <%--<div id="roteAdv" class="banner shopEdit" shopInfo="shop_Head_Slide_adv1" >--%>
        <%--<c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_Head_Slide_adv1').advt.advtProxy}" var="advtProxys" varStatus="s">--%>
            <%--<a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">--%>
                <%--<img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="1400" height="410"/>--%>
            <%--</a>--%>
        <%--</c:forEach>--%>
    <%--</div>--%>
    <%--<div id="nav" class="slide-controls"></div>--%>
   <%--&lt;%&ndash;banner 结束&ndash;%&gt;--%>
<%--</div>--%>

<div class="shop_m1bg">
	<div class="shop_m1">
        <%--2015-03-24,zch,由于下面自定义区,所以这里就没有必要了--%>
        <%--<div class="m1_layer shopEdit" shopInfo="shop_HeadTop_adv1|235X65" id="HeadTopOne">
            <i>
                <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_HeadTop_adv1').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                    <img id="headTopBackground" src="${advtProxys.advUrl}" color-data="${advtProxys.hint}" alt="${advtProxys.title}" title="${advtProxys.title}" width="235" height="65"/>
                </c:forEach>
            </i>
        </div>--%>
        <script>
            $(function(){
                $("#HeadTopOne").css("background-color",$("#headTopBackground").attr("color-data"));
            })
        </script>
        <div class="shopEdit" shopInfo="shop_background" style="width:50px;height:50px;position: absolute;z-index: 99999;">
            <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_background').links}" var="pageLinks" end="0" varStatus="s">
                <a mybackground="${pageLinks.description}" id="aaaaa"></a>
            </c:forEach>
        </div>
        <div class="m1_box" id="HeadTopTwo">
           <!--F1层-->
            <div  class="l_layer  shopEdit" shopInfo="shop_custom1" style="width:1190px;">
                <c:set var="shopCustom1" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_custom1').pageModuleObjects[0].userDefinedContStr}"/>
                <div style="${empty shopCustom1 ? "display:none" : "display:block"}">
                     ${empty shopCustom1 ? "自定义区块":(shopCustom1)}
                </div>
            </div>

           <!--F2层-->
            <%--2015-03-24,zch,宝得网要求只留下一个主推自定义区域--%>
            <%--<div  class="l_layer  shopEdit" shopInfo="shop_custom2" style="width:1190px;height: 345px;float: left;">
                <c:set var="shopCustom2" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_custom2').pageModuleObjects[0].userDefinedContStr}"/>
                <div style="${empty shopCustom2 ? "display:none" : "display:block"}">
                     ${empty shopCustom2 ? "自定义区块":(shopCustom2)}
                </div>
            </div>--%>
    </div>
    <script>
        $(function(){
           $(".shop_m1bg").css("background-color",$("#aaaaa").attr("mybackground"));
        })
    </script>
</div>

    <div class="shop_m2">
    <c:import url="/template/bdw/shopTemplate/default/include/shopLeftMenu.jsp?p=shopIndex"/>

    <div class="m2_r">
        <!--新品上架-->
        <div class="r_box01">
            <!--<div class="b_layer">新品上架</div>-->
            <div class="b_layer shopEdit" shopInfo="shop_f3_Title">
                <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_f3_Title').links}" var="pageLinks" end="0" varStatus="s">
                    <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                </c:forEach>
            </div>

            <div  class="b_box  shopEdit" shopInfo="shop_f3_recommend" style="width:976px;height: 321px;">
                <ul class="b_info">
                    <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_f3_recommend').recommendProducts}" var="prd" end="3">
                        <li>
                            <c:if test="${prd.isJoinActivity && not empty prd.activityPlateImageUrl}">
                                <div class="shop_activity_pic"><img src="${webRoot}/upload/${prd.activityPlateImageUrl}"/></div>
                            </c:if>

                            <div class="i_pic"><a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['200X200'] : prd.images[0]['200X200']}" width="200px" height="200px" /></a></div>
                            <div class="i_title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                            <div class="i_price">
                                <i>￥</i><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" />
                                <em><fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></em>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--end 新品上架-->

        <!--促销商品-->
        <div class="r_box01">
            <!--
        	<div class="b_layer">促销商品</div>
        	-->
            <div class="b_layer shopEdit" shopInfo="shop_f4_Title">
                <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_f4_Title').links}" var="pageLinks" end="0" varStatus="s">
                    <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                </c:forEach>
            </div>
            <div  class="b_box  shopEdit" shopInfo="shop_f4_recommend" style="width:976px;/*height: 963px;*/">
                <ul class="b_info">
                    <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_f4_recommend').recommendProducts}" var="prd" end="3" varStatus="status">
                        <li>
                            <c:if test="${prd.isJoinActivity && not empty prd.activityPlateImageUrl}">
                                <div class="shop_activity_pic"><img src="${webRoot}/upload/${prd.activityPlateImageUrl}"/></div>
                            </c:if>
                            <div class="i_pic"><a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['200X200'] : prd.images[0]['200X200']}" width="200px" height="200px" /></a></div>
                            <div class="i_title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                            <div class="i_price">
                                <i>￥</i><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" />
                                <em><fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></em>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <ul class="b_info">
                    <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_f4_recommend').recommendProducts}" var="prd" begin="4" end="7" varStatus="status">
                        <li>
                            <c:if test="${prd.isJoinActivity && not empty prd.activityPlateImageUrl}">
                                <div class="shop_activity_pic"><img src="${webRoot}/upload/${prd.activityPlateImageUrl}"/></div>
                            </c:if>
                            <div class="i_pic"><a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['200X200'] : prd.images[0]['200X200']}" width="200px" height="200px" /></a></div>
                            <div class="i_title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                            <div class="i_price">
                                <i>￥</i><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" />
                                <em><fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></em>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <ul class="b_info">
                    <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_f4_recommend').recommendProducts}" var="prd" begin="8" end="11" varStatus="status">
                        <li>
                            <c:if test="${prd.isJoinActivity && not empty prd.activityPlateImageUrl}">
                                <div class="shop_activity_pic"><img src="${webRoot}/upload/${prd.activityPlateImageUrl}"/></div>
                            </c:if>
                            <div class="i_pic"><a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['200X200'] : prd.images[0]['200X200']}" width="200px" height="200px" /></a></div>
                            <div class="i_title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
                            <div class="i_price">
                                <i>￥</i><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" />
                                <em><fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></em>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div class="clear"></div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
</div>



<c:import url="/template/bdw/module/common/bottom.jsp"/>
</body>
<f:ShopEditTag/>
</html>
