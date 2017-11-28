<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="now" class="java.util.Date" />

<%--&lt;%&ndash;取出当前在做活动的商品&ndash;%&gt;--%>
<%--<c:forEach items="${sdk:getMarketingActivityProxyList(1,100000,'Y','N','N').result}" var="activityProxy" varStatus="s" end="0">--%>
    <%--<c:choose>--%>
        <%--<c:when test="${not empty activityProxy.marketingActivityId}">--%>
            <%--<c:set value="${activityProxy.marketingActivityId}" var="marketActivityId"/>--%>
        <%--</c:when>--%>
        <%--<c:otherwise>--%>
            <%--<c:set value="37" var="marketActivityId"/>--%>
        <%--</c:otherwise>--%>
    <%--</c:choose>--%>
<%--</c:forEach>--%>
<%--<c:set value="${sdk:getMarketingActivityById(marketActivityId)}" var="marketActivity"/>--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}" /> <%--SEO description优化--%>
    <title>${webName}-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/wjf.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/anythingslider.css">

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script src="${webRoot}/template/bdw/statics/js/jquery.anythingslider.js"></script>

    <!--轮换广告 start-->
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/scrollimage.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/wjfIndex.js"></script>
    <script type="text/javascript">
        var pageData={
            webRoot:"${webRoot}",
            nowTime:"<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"
        };

        <%--$(function(){--%>
            <%--$(".endTimes").imallCountdown('${marketActivity.activityEndTimeStr}','values',pageData.nowTime);--%>

            <%--$('#activityList').anythingSlider({--%>
                <%--resizeContents: false, // If true, solitary images/objects in the panel will expand to fit the viewport--%>
                <%--buildArrows: true,      // 显示左右轮换按钮--%>
                <%--buildNavigation: false,      // 显示div下的a链接--%>
                <%--buildStartStop: false      // 显示自动轮播的开始按钮--%>

            <%--});--%>
        <%--});--%>

    </script>

</head>

<body>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=channel"/>
<%--页脚结束--%>

    <!--页头大广告-->
    <div class="ch_banner">
        <%--banner 开始--%>
        <div class="banner frameEdit" style="overflow: hidden;" frameInfo="wjf_Head_Slide_Recommend">
            <div id="roteAdv" style="position: relative;" >
            <c:forEach items="${sdk:findPageModuleProxy('wjf_Head_Slide_Recommend').advt.advtProxy}" var="advtProxys" varStatus="s">
                <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}" color-data="${advtProxys.hint}" style="width: 760px;">
                    <img src="${advtProxys.advUrl}" id="adv${s.count}" title="${advtProxys.title}" width="760" height="360" />
                </a>
            </c:forEach>
            </div>
        </div>
       <%--banner 结束--%>

        <div class="b_right_layer">
            <div id="nav" class="slide-controls"></div>
            <div class="layer_r frameEdit" frameInfo="wjf_Head_Recommend">
                <c:forEach items="${sdk:findPageModuleProxy('wjf_Head_Recommend').advt.advtProxy}" var="adv" end="0" varStatus="s">
                    <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="240" height="360" alt="" /></a>
                </c:forEach>
            </div>
        </div>
    </div>

    <!--ch_m1 -->
    <div class="ch_m1 frameEdit" frameInfo="wjf_Head_slide" >
        <c:set value="${fn:length(sdk:findPageModuleProxy('wjf_Head_slide').links)}" var="count"/>

        <div class="turn_l"><a id="prevHead_1" href="javascript:"></a></div>
        <div class="turn_m" id="wjf_Head_slide_box" style="margin-left: 3px;">
            <c:forEach items="${sdk:findPageModuleProxy('wjf_Head_slide').links}" var="pageLinks" end="14" varStatus="s">
                <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon}" width="236" height="183" /></a>
            </c:forEach>
        </div>
        <div class="turn_r"><a id="nextHead_1" href="javascript:"></a></div>
        <c:if test="${fn:length('wjf_Head_slide')>5}">
            <script type = text/javascript>
                var scrollPic_02 = new ScrollPic();
                scrollPic_02.scrollContId = "wjf_Head_slide_box";
                scrollPic_02.arrLeftId = "prevHead_1";
                scrollPic_02.arrRightId = "nextHead_1";
                scrollPic_02.frameWidth = 1185;
                scrollPic_02.pageWidth = 237;
                scrollPic_02.speed = 10;
                scrollPic_02.space = 10;
                scrollPic_02.autoPlay = false;
                scrollPic_02.autoPlayTime = 7;
                scrollPic_02.initialize();
            </script>
        </c:if>
    </div>
    <!--end ch_m1 -->

<!--end ch_m1 -->

<!--ch_m2 -->
<div class="ch_m2">
 	<div class="m2_layer">
    	<div class="layer_l frameEdit" frameInfo="wjf_Head_Top_favorable|450X45">
            <c:forEach items="${sdk:findPageModuleProxy('wjf_Head_Top_favorable').advt.advtProxy}" var="adv" end="0" varStatus="s">
               ${adv.htmlTemplate}
            </c:forEach>
        </div>
        <div class="layer_r frameEdit" frameInfo="panic_bottom_link">
            <c:forEach items="${sdk:findPageModuleProxy('panic_bottom_link').links}" var="pageLinks" end="0" varStatus="s">
                <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}" class="advId">${pageLinks.title}</a>
            </c:forEach>
        </div>
    </div>

    <div class="m2_box">
        <div class="frameEdit" frameInfo="channel_recommend" style="width: 1189px;height: 328px;float: left;">
            <c:forEach items="${sdk:findPageModuleProxy('channel_recommend').recommendProducts}" var="prd" end="4">
                <ul class="b_info">
                    <li class="i_pic">
                        <a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}">
                            <img src="${prd.images[0]['200X200']}" width="200" height="200" target="_blank" alt="${prd.name}"/>
                        </a>
                    </li>
                    <li class="i_title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank">${prd.name}</a></li>
                    <li class="i_price"><i>￥</i><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#"/></li>
                    <li class="i_text">￥<fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#"/></li>
                    <%--<li class="i_jian">减</li>--%>
                </ul>
            </c:forEach>
        </div>




        <%--<ul class="b_right">--%>
        	<%--<li class="r_layer">限时抢购</li>--%>
            <%--<li class="r_info">--%>
                <%--<div class="left_adv">--%>
                    <%--<c:set value="${sdk:getMarketingActivitySignUpProxyList(1,16,marketActivityId)}" var="marketActivityProduct"/>--%>

                    <%--&lt;%&ndash;<input type="hidden" value="${marketActivity.activityEndTimeStr}" name="endTimeStr"/>&ndash;%&gt;--%>
                    <%--<ul id="activityList">--%>
                        <%--<c:forEach items="${marketActivityProduct.result}" var="activity"  varStatus="stat">--%>
                            <%--<c:set var="panic" value="${sdk:getProductById(activity.productId)}"/>--%>
                            <%--<li class="turn_m">--%>
                                <%--<div class="m_pic">--%>
                                    <%--<a title="${panic.name}" target="_blank" href="${webRoot}/product-${panic.productId}.html">--%>
                                        <%--<img alt="${panic.name}" src="${panic.defaultImage['160X160']}" width="160" height="160"/>--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                                <%--<div class="m_title">--%>
                                    <%--<a title="${panic.name}" target="_blank" href="${webRoot}/product-${panic.productId}.html">--%>
                                    <%--${panic.name}<span style="color: #F26B02;">${fn:substring(panic.salePoint,0,18)}</span>--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                                <%--<div class="m_time endTimes" name="endTime"></div>--%>
                            <%--</li>--%>
                        <%--</c:forEach>--%>
                    <%--</ul>--%>

                <%--</div>--%>
            <%--</li>--%>
        <%--</ul>--%>
    </div>
</div>
<!--end ch_m2 -->

<div class="ch_adv">

	<div class="adv_l frameEdit" frameInfo="wjf_HeadLeft_favorable_adv1|594X60">
        <c:forEach items="${sdk:findPageModuleProxy('wjf_HeadLeft_favorable_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
            ${adv.htmlTemplate}
        </c:forEach>
    </div>
    <div class="adv_r frameEdit" frameInfo="wjf_HeadRight_favorable_adv1|594X60">
        <c:forEach items="${sdk:findPageModuleProxy('wjf_HeadRight_favorable_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
            ${adv.htmlTemplate}
        </c:forEach>
    </div>

</div>
<!--粮油调味 -->
<div class="ch_m3">
	<div class="m3_layer">
        <div class="layer_l frameEdit" frameInfo="wjf_f1_leftTop_adv1|200X34">
            <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_leftTop_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="200" height="34" alt="" /></a>
            </c:forEach>
        </div>
        <div class="layer_r frameEdit"  frameInfo="wjf_f1_Top_TitleAdv1">
                <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_Top_TitleAdv1').links}" var="pageLinks" end="8" varStatus="s">
                  <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                        <c:if test="${!s.last}">
                            <i>|</i>
                        </c:if>

                </c:forEach>
        </div>
    </div>
    <div class="m3_box">
    	<div class="b_top">
        	<div class="top_l">
            	<div class="l_rows">
                	<div class="rows_left">

                        <div class="left_list frameEdit"  frameInfo="wjf_f1_leftCenter_adv1">
                            <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_leftCenter_adv1').links}" var="pageLinks" end="9" varStatus="s">
                                <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}" class="advId">${pageLinks.title}</a>
                            </c:forEach>
                        </div>
                        <%--F1_left_adv1--%>
                       <div class="left_adv frameEdit" frameInfo="wjf_f1_left_adv1|198X128">
                                                 <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_left_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                                     <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt="" /></a>
                                                  </c:forEach>
                                             </div>
                                          </div>

                    <!--粮油调味轮换广告 start-->
                    <div class = "r_picbox  frameEdit slideshow" frameInfo="wjf_f1_Center_slide_adv1" >
                        <div id="wjf_f1_Center_slide_adv1">
                            <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_Center_slide_adv1').advt.advtProxy}" var="advtProxys" varStatus="s">
                                <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                                    <img src="${advtProxys.advUrl}" target="_blank" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="750" height="300" />
                                </a>
                            </c:forEach>
                        </div>
                        <div id="wjf_f1_Center_slide_adv1_btn" class="slide-controls"></div>
                    </div>
                    <!--粮油调味轮换广告 end-->

                 </div>
                <div  class="l_layer  frameEdit" frameInfo="wjf_f1_CenterBottom_recommend">

                    <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_CenterBottom_recommend').recommendProducts}" var="prd" end="4">
                        <ul  class="layer_info">
                            <li class="pic">
                                <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X160'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                            </li>
                            <li class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></li>
                            <li class="price"><b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b>
                        </ul>
                    </c:forEach>
                </div>
             </div>
             <div class="top_r">
                 <div class="r_title frameEdit" frameInfo="wjf_f1_RightTop_link">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_RightTop_link').advt.advtProxy}" var="adv" end="0" varStatus="s">
                         <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="240" height="48" alt=""/></a>
                     </c:forEach>
                 </div>

                 <div  class="r_box  frameEdit" frameInfo="wjf_f1_RightCenter_recommend">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_RightCenter_recommend').recommendProducts}" var="prd" end="7">
                         <div class="b_info">
                             <div class="i_pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['110X110'] : prd.images[0]['110X110']}" width="110px" height="110px"/></a>
                             </div>
                             <div class="i_popup">
                                                       <div class="p_title">
                                                           <a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>
                                                       </div>
                             </div>
                         </div>
                     </c:forEach>
                 </div>

             </div>
         </div>
        <!---幻灯片
        当count<=10  visible=${count} 这样写的原因是，比如说数据个数为5，我visible写10，则它只会显示4个,这问题不知道怎么解决，所以多写了点代码
        -->
        <div class="b_btm frameEdit" frameInfo="wjf_f1_slide">
            <c:set value="${fn:length(sdk:findPageModuleProxy('wjf_f1_slide').links)}" var="count"/>


                    <div class="turn_l"><a id="prev1_1" href="javascript:"></a></div>
                    <ul class="turn_m" style="overflow: hidden" id="wjf_f1_slide_box">
                        <c:forEach items="${sdk:findPageModuleProxy('wjf_f1_slide').links}" var="pageLinks" end="20" varStatus="s">
                            <li style="margin:10px"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon}" width="90" height="50" /></a></li>
                        </c:forEach>
                    </ul>
                    <div class="turn_r"><a id="next1_1" href="javascript:"></a></div>
                     <c:if test="${fn:length('wjf_f1_slide')>10}">
                         <script type = text/javascript>
                             var scrollPic_02 = new ScrollPic();
                             scrollPic_02.scrollContId = "wjf_f1_slide_box";
                             scrollPic_02.arrLeftId = "prev1_1";
                             scrollPic_02.arrRightId = "next1_1";
                             scrollPic_02.frameWidth = 1100;
                             scrollPic_02.pageWidth = 110;
                             scrollPic_02.speed = 10;
                             scrollPic_02.space = 10;
                             scrollPic_02.autoPlay = false;
                             scrollPic_02.autoPlayTime = 2;
                             scrollPic_02.initialize();
                         </script>
                     </c:if>
        </div>
     </div>
 </div>
 <!--end 粮油调味 -->

 <!--食品饮料 -->
 <div class="ch_m3">
     <div class="m3_layer" style="border-bottom:#2abff7 1px solid;">
         <div class="layer_l frameEdit" frameInfo="wjf_f2_leftTop_adv1|200X34">
         <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_leftTop_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
             <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="200" height="34" alt="" /></a>
         </c:forEach>
     </div>
         <div class="layer_r frameEdit"  frameInfo="wjf_f2_Top_TitleAdv1">
                 <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_Top_TitleAdv1').links}" var="pageLinks" end="8" varStatus="s">
                     <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                         <c:if test="${!s.last}">
                             <i>|</i>
                         </c:if>
                 </c:forEach>
         </div>
     </div>
     <div class="m3_box">
         <div class="b_top">
             <div class="top_l">
                 <div class="l_rows">
                     <div class="rows_left">

                         <div class="left_list frameEdit"  frameInfo="wjf_f2_leftCenter_adv1">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_leftCenter_adv1').links}" var="pageLinks" end="9" varStatus="s">
                                 <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}" class="advId">${pageLinks.title}</a>
                             </c:forEach>
                         </div>

                         <div class="left_adv frameEdit" frameInfo="wjf_f2_left_adv1|198X128">
                             <!--  <a href="#"><img src="${webRoot}/template/bdw/statics/case/ch_pic13.jpg" width="198" height="128" alt="" /></a>-->
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_left_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                 <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt="" /></a>
                             </c:forEach>
                         </div>
                     </div>

                     <!--食品饮料轮换广告 start-->
                     <div class = "r_picbox frameEdit slideshow" frameInfo="wjf_f2_Center_slide_adv1">
                         <div id="wjf_f2_Center_slide_adv1">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_Center_slide_adv1').advt.advtProxy}" var="advtProxys" varStatus="s">
                                 <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                                     <img src="${advtProxys.advUrl}" target="_blank" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="750" height="300" />
                                 </a>
                             </c:forEach>
                         </div>
                         <div id="wjf_f2_Center_slide_adv1_btn" class="slide-controls"></div>
                     </div>
                     <!--食品饮料轮换广告 end-->
                 </div>

                 <!--推荐页面-->
                 <div  class="l_layer  frameEdit" frameInfo="wjf_f2_CenterBottom_recommend">

                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_CenterBottom_recommend').recommendProducts}" var="prd" end="4">
                         <ul  class="layer_info">
                             <li class="pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X11600'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                             </li>
                             <li class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></li>
                             <li class="price"><b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b>
                         </ul>
                     </c:forEach>
                 </div>
                 <!--原型-->


             </div>
             <div class="top_r">
                 <div class="r_title frameEdit" frameInfo="wjf_f2_RightTop_link">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_RightTop_link').advt.advtProxy}" var="adv" end="0" varStatus="s">
                         <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="240" height="48" alt="" /></a>
                     </c:forEach>
                 </div>
                 <div  class="r_box  frameEdit" frameInfo="wjf_f2_RightCenter_recommend">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_RightCenter_recommend').recommendProducts}" var="prd" end="7">
                         <div class="b_info">
                             <div class="i_pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank">
                                     <img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['110X110'] : prd.images[0]['110X110']}" width="110px" height="110px"/>
                                 </a>
                             </div>
                             <div class="i_popup">
                                 <div class="p_title">
                                     <a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>
                                 </div>
                             </div>
                         </div>
                     </c:forEach>
                 </div>
             </div>
         </div>
         <!---幻灯片-->
         <div class="b_btm frameEdit" frameInfo="wjf_f2_slide">

             <c:set value="${fn:length(sdk:findPageModuleProxy('wjf_f2_slide').links)}" var="count"/>


                     <div class="turn_l"><a id="prev2_1" href="javascript:"></a></div>
                     <ul class="turn_m" style="overflow: hidden" id="wjf_f2_slide_box">
                         <c:forEach items="${sdk:findPageModuleProxy('wjf_f2_slide').links}" var="pageLinks" end="20" varStatus="s">
                             <li style="margin:10px"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon}" width="90" height="50" /></a></li>
                         </c:forEach>
                     </ul>
                     <div class="turn_r"><a id="next2_1" href="javascript:"></a></div>
                     <c:if test="${fn:length('wjf_f2_slide')>10}">
                         <script type = text/javascript>
                             var scrollPic_02 = new ScrollPic();
                             scrollPic_02.scrollContId = "wjf_f2_slide_box";
                             scrollPic_02.arrLeftId = "prev2_1";
                             scrollPic_02.arrRightId = "next2_1";
                             scrollPic_02.frameWidth = 1100;
                             scrollPic_02.pageWidth = 110;
                             scrollPic_02.speed = 10;
                             scrollPic_02.space = 10;
                             scrollPic_02.autoPlay = false;
                             scrollPic_02.autoPlayTime = 2;
                             scrollPic_02.initialize();
                         </script>
                     </c:if>

         </div>
     </div>
 </div>
 <!--end 食品饮料 -->

 <!--母婴用品 -->
 <div class="ch_m3">
     <div class="m3_layer" style="border-bottom:#fe7a65 1px solid;">
         <div class="layer_l frameEdit" frameInfo="wjf_f3_leftTop_adv1|200X34">
             <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_leftTop_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                 <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="200" height="34" alt="" /></a>
             </c:forEach>
         </div>

         <div class="layer_r frameEdit"  frameInfo="wjf_f3_Top_TitleAdv1">
                 <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_Top_TitleAdv1').links}" var="pageLinks" end="8" varStatus="s">
                    <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                         <c:if test="${!s.last}">
                             <i>|</i>
                         </c:if>
                 </c:forEach>

         </div>
     </div>
     <div class="m3_box">
         <div class="b_top">
             <div class="top_l">
                 <div class="l_rows">
                     <div class="rows_left">

                         <div class="left_list frameEdit"  frameInfo="wjf_f3_leftCenter_adv1">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_leftCenter_adv1').links}" var="pageLinks" end="9" varStatus="s">
                                 <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}" class="advId">${pageLinks.title}</a>
                             </c:forEach>
                         </div>

                         <div class="left_adv frameEdit" frameInfo="wjf_f3_left_adv1|198X128">
                             <!--  <a href="#"><img src="${webRoot}/template/bdw/statics/case/ch_pic13.jpg" width="198" height="128" alt="" /></a>-->
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_left_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                 <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt="" /></a>
                             </c:forEach>
                         </div>
                     </div>

                     <!--母婴用品轮换广告 start-->
                     <div class = "r_picbox  frameEdit slideshow" frameInfo="wjf_f3_Center_slide_adv1">
                         <div id="wjf_f3_Center_slide_adv1">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_Center_slide_adv1').advt.advtProxy}" var="advtProxys" varStatus="s">
                                 <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                                     <img src="${advtProxys.advUrl}" target="_blank" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="750" height="300" />
                                 </a>
                             </c:forEach>
                         </div>
                         <div id="wjf_f3_Center_slide_adv1_btn" class="slide-controls"></div>
                     </div>
                     <!--母婴用品轮换广告 end-->
                 </div>
                 <div  class="l_layer  frameEdit" frameInfo="wjf_f3_CenterBottom_recommend">

                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_CenterBottom_recommend').recommendProducts}" var="prd" end="4">
                         <ul  class="layer_info">
                             <li class="pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X11600'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                             </li>
                             <li class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></li>
                             <li class="price"><b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b>
                         </ul>
                     </c:forEach>
                 </div>
             </div>
             <div class="top_r">
                 <div class="r_title frameEdit" frameInfo="wjf_f3_RightTop_link">
                     <!--  <a href="#"><img src="${webRoot}/template/bdw/statics/case/ch_pic13.jpg" width="198" height="128" alt="" /></a>-->
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_RightTop_link').advt.advtProxy}" var="adv" end="0" varStatus="s">
                         <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="240" height="48" alt="" /></a>
                     </c:forEach>
                 </div>
                 <div class="r_box  frameEdit" frameInfo="wjf_f3_RightCenter_recommend">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_RightCenter_recommend').recommendProducts}" var="prd" end="7">
                         <div class="b_info">
                             <div class="i_pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank">
                                     <img alt="${prd.name}" target="_blank" src="${empty prd.images ? prd.defaultImage['110X110'] : prd.images[0]['110X110']}" width="110px" height="110px"/>
                                 </a>
                             </div>
                             <div class="i_popup">
                                 <div class="p_title">
                                     <a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>
                                 </div>
                             </div>
                         </div>
                     </c:forEach>
                 </div>
             </div>
         </div>
         <!---幻灯片-->
         <div class="b_btm frameEdit" frameInfo="wjf_f3_slide">

             <c:set value="${fn:length(sdk:findPageModuleProxy('wjf_f3_slide').links)}" var="count"/>


                     <div class="turn_l"><a id="prev3_1" href="javascript:"></a></div>
                     <ul class="turn_m" style="overflow: hidden" id="wjf_f3_slide_box">
                         <c:forEach items="${sdk:findPageModuleProxy('wjf_f3_slide').links}" var="pageLinks" end="20" varStatus="s">
                             <li style="margin:10px"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon}" width="90" height="50" /></a></li>
                         </c:forEach>
                     </ul>
                     <div class="turn_r"><a id="next3_1" href="javascript:"></a></div>
                    <c:if test="${fn:length('wjf_f3_slide')>10}">
                        <script type = text/javascript>
                            var scrollPic_02 = new ScrollPic();
                            scrollPic_02.scrollContId = "wjf_f3_slide_box";
                            scrollPic_02.arrLeftId = "prev3_1";
                            scrollPic_02.arrRightId = "next3_1";
                            scrollPic_02.frameWidth = 1100;
                            scrollPic_02.pageWidth = 110;
                            scrollPic_02.speed = 10;
                            scrollPic_02.space = 10;
                            scrollPic_02.autoPlay = false;
                            scrollPic_02.autoPlayTime = 2;
                            scrollPic_02.initialize();
                        </script>
                    </c:if>

         </div>
     </div>
 </div>
 <!--end 母婴用品 -->

 <!--居家生活 -->
 <div class="ch_m3">
     <div class="m3_layer" style="border-bottom:#c97bff 1px solid;">
         <div class="layer_l frameEdit" frameInfo="wjf_f4_leftTop_adv1|200X34">
             <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_leftTop_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                 <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="200" height="34" alt="" /></a>
             </c:forEach>
         </div>

         <div class="layer_r frameEdit"  frameInfo="wjf_f4_Top_TitleAdv1">
                 <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_Top_TitleAdv1').links}" var="pageLinks" end="8" varStatus="s">
                     <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                         <c:if test="${!s.last}">
                             <i>|</i>
                         </c:if>

                 </c:forEach>
         </div>
     </div>
     <div class="m3_box">
         <div class="b_top">
             <div class="top_l">
                 <div class="l_rows">
                     <div class="rows_left">

                         <div class="left_list frameEdit"  frameInfo="wjf_f4_leftCenter_adv1">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_leftCenter_adv1').links}" var="pageLinks" end="9" varStatus="s">
                                 <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}" class="advId">${pageLinks.title}</a>
                             </c:forEach>
                         </div>

                         <div class="left_adv frameEdit" frameInfo="wjf_f4_left_adv1|198X128">
                             <!--  <a href="#"><img src="${webRoot}/template/bdw/statics/case/ch_pic13.jpg" width="198" height="128" alt="" /></a>-->
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_left_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                 <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt="" /></a>
                             </c:forEach>
                         </div>
                     </div>

                     <!--居家生活轮换广告 start-->
                     <div class = "r_picbox  frameEdit slideshow" frameInfo="wjf_f4_Center_slide_adv1">
                         <div id="wjf_f4_Center_slide_adv1">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_Center_slide_adv1').advt.advtProxy}" var="advtProxys" varStatus="s">
                                 <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                                     <img src="${advtProxys.advUrl}" target="_blank" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="750" height="300" />
                                 </a>
                             </c:forEach>
                         </div>
                         <div id="wjf_f4_Center_slide_adv1_btn" class="slide-controls"></div>
                     </div>
                     <!--居家生活轮换广告 end-->
                 </div>
                 <div  class="l_layer  frameEdit" frameInfo="wjf_f4_CenterBottom_recommend">

                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_CenterBottom_recommend').recommendProducts}" var="prd" end="4">
                         <ul  class="layer_info">
                             <li class="pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X11600'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                             </li>
                             <li class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></li>
                             <li class="price"><b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b>
                         </ul>
                     </c:forEach>
                 </div>
             </div>
             <div class="top_r">
                 <div class="r_title frameEdit" frameInfo="wjf_f4_RightTop_link">
                     <!--  <a href="#"><img src="${webRoot}/template/bdw/statics/case/ch_pic13.jpg" width="198" height="128" alt="" /></a>-->
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_RightTop_link').advt.advtProxy}" var="adv" end="0" varStatus="s">
                         <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="240" height="48" alt="" /></a>
                     </c:forEach>
                 </div>

                 <div class="r_box  frameEdit" frameInfo="wjf_f4_RightCenter_recommend">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_RightCenter_recommend').recommendProducts}" var="prd" end="7">
                         <div class="b_info">
                             <div class="i_pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank">
                                     <img alt="${prd.name}" target="_blank" src="${empty prd.images ? prd.defaultImage['110X110'] : prd.images[0]['110X110']}" width="110px" height="110px"/>
                                 </a>
                             </div>
                             <div class="i_popup">
                                 <div class="p_title">
                                     <a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>
                                 </div>
                             </div>
                         </div>
                     </c:forEach>
                 </div>
             </div>
         </div>
         <!---幻灯片-->
         <div class="b_btm frameEdit" frameInfo="wjf_f4_slide">

             <c:set value="${fn:length(sdk:findPageModuleProxy('wjf_f4_slide').links)}" var="count"/>


                     <div class="turn_l"><a id="prev4_1" href="javascript:"></a></div>
                     <ul class="turn_m" style="overflow: hidden" id="wjf_f4_slide_box">
                         <c:forEach items="${sdk:findPageModuleProxy('wjf_f4_slide').links}" var="pageLinks" end="20" varStatus="s">
                             <li style="margin:10px"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon}" width="90" height="50" /></a></li>
                         </c:forEach>
                     </ul>
                     <div class="turn_r"><a id="next4_1" href="javascript:"></a></div>
                     <c:if test="${fn:length('wjf_f4_slide')>10}">
                         <script type = text/javascript>
                             var scrollPic_02 = new ScrollPic();
                             scrollPic_02.scrollContId = "wjf_f4_slide_box";
                             scrollPic_02.arrLeftId = "prev4_1";
                             scrollPic_02.arrRightId = "next4_1";
                             scrollPic_02.frameWidth = 1100;
                             scrollPic_02.pageWidth = 110;
                             scrollPic_02.speed = 10;
                             scrollPic_02.space = 10;
                             scrollPic_02.autoPlay = false;
                             scrollPic_02.autoPlayTime = 2;
                             scrollPic_02.initialize();
                         </script>
                     </c:if>
         </div>
     </div>
 </div>
 </div>

 <!--end 居家生活 -->

 <!--美容护理 -->
 <div class="ch_m3">
     <div class="m3_layer" style="border-bottom:#ff909f 1px solid;">
        <!-- <div class="layer_l"><img src="${webRoot}/template/bdw/statics/images/ch_icon11.png" width="200" height="34" alt="" /></div>-->
         <div class="layer_l frameEdit" frameInfo="wjf_f5_leftTop_adv1|200X34">
             <!--  <a href="#"><img src="${webRoot}/template/bdw/statics/case/ch_pic13.jpg" width="198" height="128" alt="" /></a>-->
             <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_leftTop_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                 <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="200" height="34" alt="" /></a>
             </c:forEach>
         </div>
     <div class="layer_r frameEdit"  frameInfo="wjf_f5_Top_TitleAdv1">

             <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_Top_TitleAdv1').links}" var="pageLinks" end="8" varStatus="s">
                <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                     <c:if test="${!s.last}">
                         <i>|</i>
                     </c:if>

             </c:forEach>
     </div>
     </div>
     <div class="m3_box">
         <div class="b_top">
             <div class="top_l">
                 <div class="l_rows">
                     <div class="rows_left">

                         <div class="left_list frameEdit"  frameInfo="wjf_f5_leftCenter_adv1">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_leftCenter_adv1').links}" var="pageLinks" end="9" varStatus="s">
                                 <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}" class="advId">${pageLinks.title}</a>
                             </c:forEach>
                         </div>

                         <div class="left_adv frameEdit" frameInfo="wjf_f5_left_adv1|198X128">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_left_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">
                                 <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt="" /></a>
                             </c:forEach>
                         </div>
                     </div>

                     <!--美容护理轮换广告 start-->
                     <div class = "r_picbox  frameEdit slideshow" frameInfo="wjf_f5_Center_slide_adv1">
                         <div id="wjf_f5_Center_slide_adv1">
                             <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_Center_slide_adv1').advt.advtProxy}" var="advtProxys" varStatus="s">
                                 <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">
                                     <img src="${advtProxys.advUrl}" target="_blank" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="750" height="300" />
                                 </a>
                             </c:forEach>
                         </div>
                         <div id="wjf_f5_Center_slide_adv1_btn" class="slide-controls"></div>
                     </div>
                     <!--美容护理轮换广告 end-->
                 </div>
                 <div  class="l_layer  frameEdit" frameInfo="wjf_f5_CenterBottom_recommend">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_CenterBottom_recommend').recommendProducts}" var="prd" end="4">
                         <ul  class="layer_info">
                             <li class="pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X11600'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                             </li>
                             <li class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></li>
                             <li class="price"><b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b>
                         </ul>
                     </c:forEach>
                 </div>
             </div>
             <div class="top_r">
                 <div class="r_title frameEdit" frameInfo="wjf_f5_RightTop_link">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_RightTop_link').advt.advtProxy}" var="adv" end="0" varStatus="s">
                         <a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="240" height="48" alt="" /></a>
                     </c:forEach>
                 </div>
                 <div class="r_box  frameEdit" frameInfo="wjf_f5_RightCenter_recommend">
                     <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_RightCenter_recommend').recommendProducts}" var="prd" end="7">
                         <div class="b_info">
                             <div class="i_pic">
                                 <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank">
                                     <img alt="${prd.name}" target="_blank" src="${empty prd.images ? prd.defaultImage['110X110'] : prd.images[0]['110X110']}" width="110px" height="110px"/>
                                 </a>
                             </div>
                             <div class="i_popup">
                                 <div class="p_title">
                                     <a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>
                                 </div>
                             </div>
                         </div>
                     </c:forEach>
                 </div>

                 </div>
         </div>
                 <!---幻灯片-->
                 <div class="b_btm frameEdit" frameInfo="wjf_f5_slide">

                     <c:set value="${fn:length(sdk:findPageModuleProxy('wjf_f5_slide').links)}" var="count"/>

                             <div class="turn_l"><a id="prev5_1" href="javascript:"></a></div>
                             <ul class="turn_m" style="overflow: hidden" id="wjf_f5_slide_box">
                                 <c:forEach items="${sdk:findPageModuleProxy('wjf_f5_slide').links}" var="pageLinks" end="20" varStatus="s">
                                     <li style="margin:10px"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon}" width="90" height="50" /></a></li>
                                 </c:forEach>
                             </ul>
                             <div class="turn_r"><a id="next5_1" href="javascript:"></a></div>
                     <c:if test="${fn:length('wjf_f5_slide')>10}">
                         <script type = text/javascript>
                             var scrollPic_02 = new ScrollPic();
                             scrollPic_02.scrollContId = "wjf_f5_slide_box";
                             scrollPic_02.arrLeftId = "prev5_1";
                             scrollPic_02.arrRightId = "next5_1";
                             scrollPic_02.frameWidth = 1100;
                             scrollPic_02.pageWidth = 110;
                             scrollPic_02.speed = 10;
                             scrollPic_02.space = 10;
                             scrollPic_02.autoPlay = false;
                             scrollPic_02.autoPlayTime = 2;
                             scrollPic_02.initialize();
                         </script>
                     </c:if>
                 </div>
     </div>

 </div>
 <!--end 美容护理 -->

 <!--文体类 -->
 <%--<div class="ch_m3">--%>
     <%--<div class="m3_layer" style="border-bottom:#6adea6 1px solid;">--%>
         <%--<div class="layer_l frameEdit" frameInfo="wjf_f6_leftTop_adv1|200X34">--%>
             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_leftTop_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">--%>
                 <%--<a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="200" height="34" alt="" /></a>--%>
             <%--</c:forEach>--%>
         <%--</div>--%>

         <%--<div class="layer_r frameEdit"  frameInfo="wjf_f6_Top_TitleAdv1">--%>

                 <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_Top_TitleAdv1').links}" var="pageLinks" end="8" varStatus="s">--%>
                    <%--<a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>--%>
                         <%--<c:if test="${!s.last}">--%>
                             <%--<i>|</i>--%>
                         <%--</c:if>--%>
                 <%--</c:forEach>--%>
         <%--</div>--%>
     <%--</div>--%>
     <%--<div class="m3_box">--%>
         <%--<div class="b_top">--%>
             <%--<div class="top_l">--%>
                 <%--<div class="l_rows">--%>
                     <%--<div class="rows_left">--%>

                         <%--<div class="left_list frameEdit"  frameInfo="wjf_f6_leftCenter_adv1">--%>
                             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_leftCenter_adv1').links}" var="pageLinks" end="9" varStatus="s">--%>
                                 <%--<a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}" class="advId">${pageLinks.title}</a>--%>
                             <%--</c:forEach>--%>
                         <%--</div>--%>

                         <%--<div class="left_adv frameEdit" frameInfo="wjf_f6_left_adv1|198X128">--%>
                             <%--<!--  <a href="#"><img src="${webRoot}/template/bdw/statics/case/ch_pic13.jpg" width="198" height="128" alt="" /></a>-->--%>
                             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_left_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">--%>
                                 <%--<a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt="" /></a>--%>
                             <%--</c:forEach>--%>
                         <%--</div>--%>
                     <%--</div>--%>

                     <%--&lt;%&ndash;文体类轮换广告 start&ndash;%&gt;--%>
                     <%--<div class = "r_picbox frameEdit slideshow" frameInfo="wjf_f6_Center_slide_adv1">--%>
                         <%--<div id="wjf_f6_Center_slide_adv1">--%>
                             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_Center_slide_adv1').advt.advtProxy}" var="advtProxys" varStatus="s">--%>
                                 <%--<a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">--%>
                                     <%--<img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="750" height="300" />--%>
                                 <%--</a>--%>
                             <%--</c:forEach>--%>
                         <%--</div>--%>
                         <%--<div id="wjf_f6_Center_slide_adv1_btn" class="slide-controls"></div>--%>
                     <%--</div>--%>
                     <%--&lt;%&ndash;文体类轮换广告 end&ndash;%&gt;--%>

                 <%--</div>--%>

                 <%--<div  class="l_layer  frameEdit" frameInfo="wjf_f6_CenterBottom_recommend">--%>
                     <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_CenterBottom_recommend').recommendProducts}" var="prd" end="4">--%>
                         <%--<ul class="layer_info">--%>
                             <%--<li class="pic">--%>
                                 <%--<a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X11600'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>--%>
                             <%--</li>--%>
                             <%--<li class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></li>--%>
                             <%--<li class="price"><b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b>--%>
                         <%--</ul>--%>
                     <%--</c:forEach>--%>
                 <%--</div>--%>
             <%--</div>--%>
             <%--<div class="top_r">--%>
                 <%--<div class="r_title frameEdit" frameInfo="wjf_f6_RightTop_link">--%>
                     <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_RightTop_link').advt.advtProxy}" var="adv" end="0" varStatus="s">--%>
                         <%--<a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt="" /></a>--%>
                     <%--</c:forEach>--%>
                 <%--</div>--%>
                 <%--<div class="r_box  frameEdit" frameInfo="wjf_f6_RightCenter_recommend">--%>
                     <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_RightCenter_recommend').recommendProducts}" var="prd" end="7">--%>
                         <%--<div class="b_info">--%>
                             <%--<div class="i_pic">--%>
                                 <%--<a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank">--%>
                                     <%--<img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['110X110'] : prd.images[0]['110X110']}" width="110px" height="110px"/>--%>
                                 <%--</a>--%>
                             <%--</div>--%>
                             <%--<div class="i_popup">--%>
                                 <%--<div class="p_title">--%>
                                     <%--<a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>--%>
                                 <%--</div>--%>
                             <%--</div>--%>
                         <%--</div>--%>
                     <%--</c:forEach>--%>
                 <%--</div>--%>

         <%--<!---幻灯片-->--%>

     <%--</div>--%>
 <%--</div>--%>
         <%--<!---幻灯片-->--%>
         <%--<div class="b_btm frameEdit" frameInfo="wjf_f6_slide">--%>

             <%--<c:set value="${fn:length(sdk:findPageModuleProxy('wjf_f6_slide').links)}" var="count"/>--%>

                     <%--<div class="turn_l"><a id="prev6_1" href="javascript:;"></a></div>--%>
                     <%--<ul class="turn_m" style="overflow: hidden" id="wjf_f6_slide_box">--%>
                         <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f6_slide').links}" var="pageLinks" end="20" varStatus="s">--%>
                             <%--<li style="margin:10px"><a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}"><img src="${pageLinks.icon}" width="90" height="50" /></a></li>--%>
                         <%--</c:forEach>--%>
                     <%--</ul>--%>
                     <%--<div class="turn_r"><a id="next6_1" href="javascript:;"></a></div>--%>
                     <%--<c:if test="${fn:length('wjf_f6_slide')>10}">--%>
                         <%--<script type = text/javascript>--%>
                             <%--var scrollPic_02 = new ScrollPic();--%>
                             <%--scrollPic_02.scrollContId = "wjf_f6_slide_box";--%>
                             <%--scrollPic_02.arrLeftId = "prev6_1";--%>
                             <%--scrollPic_02.arrRightId = "next6_1";--%>
                             <%--scrollPic_02.frameWidth = 1100;--%>
                             <%--scrollPic_02.pageWidth = 110;--%>
                             <%--scrollPic_02.speed = 10;--%>
                             <%--scrollPic_02.space = 10;--%>
                             <%--scrollPic_02.autoPlay = false;--%>
                             <%--scrollPic_02.autoPlayTime = 2;--%>
                             <%--scrollPic_02.initialize();--%>
                         <%--</script>--%>
                     <%--</c:if>--%>
         <%--</div>--%>
         <%--</div>--%>

 <!--end 文体类 -->

 <!--服饰鞋包 -->
 <%--<div class="ch_m3">--%>
     <%--<div class="m3_layer" style="border-bottom:#2362af 1px solid;">--%>
         <%--<div class="layer_l frameEdit" frameInfo="wjf_f7_leftTop_adv1|200X34">--%>
             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_leftTop_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">--%>
                 <%--<a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="200" height="34" alt="" /></a>--%>
             <%--</c:forEach>--%>
         <%--</div>--%>


         <%--<div class="layer_r frameEdit"  frameInfo="wjf_f7_Top_TitleAdv1">--%>
                 <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_Top_TitleAdv1').links}" var="pageLinks" varStatus="s">--%>
                    <%--<a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a> <c:if test="${!s.last}"> <i>|</i> </c:if>--%>
                 <%--</c:forEach>--%>
         <%--</div>--%>
     <%--</div>--%>
     <%--<div class="m3_box">--%>
         <%--<div class="b_top">--%>
             <%--<div class="top_l">--%>
                 <%--<div class="l_rows">--%>
                     <%--<div class="rows_left">--%>

                         <%--<div class="left_list frameEdit"  frameInfo="wjf_f7_leftCenter_adv1">--%>
                             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_leftCenter_adv1').links}" var="pageLinks" end="9" varStatus="s">--%>
                                 <%--<a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}" class="advId">${pageLinks.title}</a>--%>
                             <%--</c:forEach>--%>
                         <%--</div>--%>

                         <%--<div class="left_adv frameEdit" frameInfo="wjf_f7_left_adv1|198X128">--%>
                             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_left_adv1').advt.advtProxy}" var="adv" end="0" varStatus="s">--%>
                                 <%--<a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt="" /></a>--%>
                             <%--</c:forEach>--%>
                         <%--</div>--%>
                     <%--</div>--%>

                     <%--&lt;%&ndash;服装鞋包轮换 start&ndash;%&gt;--%>
                     <%--<div class = "r_picbox frameEdit slideshow" frameInfo="wjf_f7_Center_slide_adv1">--%>
                         <%--<div id="wjf_f7_Center_slide_adv1">--%>
                             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_Center_slide_adv1').advt.advtProxy}" var="advtProxys" varStatus="s">--%>
                                 <%--<a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}">--%>
                                     <%--<img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="750" height="300" />--%>
                                 <%--</a>--%>
                             <%--</c:forEach>--%>
                         <%--</div>--%>
                         <%--<div id="wjf_f7_Center_slide_adv1_btn" class="slide-controls"></div>--%>
                     <%--</div>--%>
                     <%--&lt;%&ndash;服装鞋包轮换 end&ndash;%&gt;--%>

                 <%--</div>--%>
                 <%--<div  class="l_layer frameEdit" frameInfo="wjf_f7_CenterBottom_recommend">--%>

                     <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_CenterBottom_recommend').recommendProducts}" var="prd" end="4">--%>
                         <%--<ul  class="layer_info">--%>
                             <%--<li class="pic">--%>
                                 <%--<a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X11600'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>--%>
                             <%--</li>--%>
                             <%--<li class="title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></li>--%>
                             <%--<li class="price"><b>￥<fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b>--%>
                         <%--</ul>--%>
                     <%--</c:forEach>--%>
                 <%--</div>--%>
             <%--</div>--%>
             <%--<div class="top_r">--%>
                 <%--<div class="r_title frameEdit" frameInfo="wjf_f7_RightTop_link">--%>
                     <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_RightTop_link').advt.advtProxy}" var="adv" end="0" varStatus="s">--%>
                         <%--<a href="${adv.link}" title="${adv.title}" target="_blank" id="advA"><img src="${adv.advUrl}" width="198" height="128" alt=""/></a>--%>
                     <%--</c:forEach>--%>
                 <%--</div>--%>
                 <%--<div class="r_box  frameEdit" frameInfo="wjf_f7_RightCenter_recommend">--%>
                     <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_RightCenter_recommend').recommendProducts}" var="prd" end="7">--%>
                         <%--<div class="b_info">--%>
                             <%--<div class="i_pic">--%>
                                 <%--<a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank">--%>
                                     <%--<img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['110X110'] : prd.images[0]['110X110']}" width="110px" height="110px"/>--%>
                                 <%--</a>--%>
                             <%--</div>--%>
                             <%--<div class="i_popup">--%>
                                 <%--<div class="p_title">--%>
                                     <%--<a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>--%>
                                 <%--</div>--%>
                             <%--</div>--%>
                         <%--</div>--%>
                     <%--</c:forEach>--%>
                 <%--</div>--%>
             <%--</div>--%>

     <%--</div>--%>

     <%--<div class="b_btm frameEdit" frameInfo="wjf_f7_slide">--%>
         <%--<c:set value="${fn:length(sdk:findPageModuleProxy('wjf_f7_slide').links)}" var="count"/>--%>
         <%--<div class="turn_l"><a id="prev7_1" href="javascript:;"></a></div>--%>
         <%--<ul class="turn_m" style="overflow: hidden" id="wjf_f7_slide_box">--%>
             <%--<c:forEach items="${sdk:findPageModuleProxy('wjf_f7_slide').links}" var="pageLinks" end="20" varStatus="s">--%>
                 <%--<li style="margin:10px">--%>
                     <%--<a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">--%>
                         <%--<img src="${pageLinks.icon}" width="90" height="50" />--%>
                     <%--</a>--%>
                 <%--</li>--%>
             <%--</c:forEach>--%>
         <%--</ul>--%>
             <%--<div class="turn_r"><a id="next7_1" href="javascript:;"></a></div>--%>
             <%--<c:if test="${fn:length('wjf_f7_slide')>10}">--%>
                <%--<script type = text/javascript>--%>
                    <%--var scrollPic_02 = new ScrollPic();--%>
                    <%--scrollPic_02.scrollContId = "wjf_f7_slide_box";--%>
                    <%--scrollPic_02.arrLeftId = "prev7_1";--%>
                    <%--scrollPic_02.arrRightId = "next7_1";--%>
                    <%--scrollPic_02.frameWidth = 1100;--%>
                    <%--scrollPic_02.pageWidth = 110;--%>
                    <%--scrollPic_02.speed = 10;--%>
                    <%--scrollPic_02.space = 10;--%>
                    <%--scrollPic_02.autoPlay = false;--%>
                    <%--scrollPic_02.autoPlayTime = 2;--%>
                    <%--scrollPic_02.initialize();--%>
                <%--</script>--%>
             <%--</c:if>--%>
     <%--</div>--%>
     <%--<!---幻灯片-->--%>

 <%--</div>--%>
 <!--end 服饰鞋包 -->


 <%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
