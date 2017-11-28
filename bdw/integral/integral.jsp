<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-积分兑换频道</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/exchange.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript">
        $(function(){
            if($.browser.msie&&($.browser.version === "6.0")){
                $('.main .list ul li').each(function(){
                    if($(this).find('.title').height()>40){
                        $(this).find('.title').css({height:40});
                    }

                });
            }

            /*轮换广告开始*/
            $('#roteAdv').after("<div class='mub'><ul id='nav'>").cycle({
                fx:     'scrollLeft',
                speed:  'fast',
                timeout: 5000,
                pager:  '#nav',
                before: function() { if (window.console) console.log(this.src); },
                pagerAnchorBuilder:function(index,slide){
                    var count=index+1;
                    if(index==0){
                        return '<li><a href="javascript:;" id="c'+count+'" class="cur">'+count+'</a></li>'
                    }else{
                        return '<li><a href="javascript:;" id="c'+count+'">'+count+'</a></li>'
                    }
                },
                after:function(currSlideElement, nextSlideElement, options, forwardFlag){
                    var a= $("#nav").find("a").attr("class","");
                    $("#c"+nextSlideElement.id).attr("class","cur");
                }
            });
        });
    </script>
</head>

<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=integral"/>
<%--页头结束--%>
<div id="position" class="m1-bg"><div class="m1"><a href="${webRoot}/index.html">首页</a> > 积分兑换 </div></div>

<div id="list">
    <div class="l">
        <div class="m1">
<%--
            <h1><a href="${webRoot}/integral/integralList.ac?categoryId=10" title="所有积分商品">积分分类</a></h1>
--%>
            <h1><a href="${webRoot}/jfhg.ac?categoryId=10" title="所有积分商品">积分分类</a></h1>

            <div id="lmenu" class="box">
                <%--列出积分商品分类 开始 --%>
                <c:forEach items="${sdk:queryIntegralCategory()}" var="integralCategory" >
                    <%--<h2><a href="${webRoot}/integral/integralList.ac?categoryId=${integralCategory.categoryId}">${integralCategory.name}</a></h2>--%>
                    <h2><a href="${webRoot}/jfhg.ac?categoryId=${integralCategory.categoryId}">${integralCategory.name}</a></h2>
                    <dl>
                        <c:forEach items="${integralCategory.children}" var="children">
                            <%--<dd><a href="${webRoot}/integral/integralList.ac?categoryId=${children.categoryId}">${children.name}</a></dd>--%>
                            <dd><a href="${webRoot}/jfhg.ac?categoryId=${children.categoryId}">${children.name}</a></dd>
                        </c:forEach>
                    </dl>
                </c:forEach>
                <%--列出积分商品分类 结束--%>
            </div>
        </div>
        <div class="banner frameEdit" frameInfo="integral_adv1|210X255">
            <c:forEach items="${sdk:findPageModuleProxy('integral_adv1').advt.advtProxy}" var="adv" end="0">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" style="width:210px;height:255px;" /></a>
            </c:forEach>
        </div>
        <div class="banner frameEdit" frameInfo="integral_adv2|210X255">
            <c:forEach items="${sdk:findPageModuleProxy('integral_adv2').advt.advtProxy}" var="adv" end="0">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" style="width:210px;height:255px;" /></a>
            </c:forEach>
        </div>
    </div>
    <div class="main">
        <div class="adv">
            <div class="banner-pic frameEdit" id="roteAdv" frameInfo="integral_roteAdv|515X175">
                <c:forEach items="${sdk:findPageModuleProxy('integral_roteAdv').advt.advtProxy}" var="advtProxys" varStatus="s">
                    <a id="${s.count}" target="_blank" href="${advtProxys.link}" title="${advtProxys.title}" style="z-index: 1;"><img style="z-index: 1;" src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="515px" height="175px" /></a>
                </c:forEach>
            </div>
            <%--<div class="mub">
                <ul>
                    <li><a class="cur" href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                </ul>
            </div>--%>
        </div>
        <c:forEach items="${sdk:findIntegralProductTagProxy()}" var="map" >
            <c:if test="${map.key!= null && map.key!=''}">
                <div class="m1">
                    <h2>${map.key}</h2>
                    <div class="list">
                        <ul>
                            <c:forEach items="${map.value}" var="product" >
                            <li >
                                <div class="pic">
                                    <c:choose>
                                        <c:when test="${product.type == 0}">
                                            <a href="${webRoot}/integral/integralDetail.ac?integralProductId=${product.integralProductId}" title="${product.integralProductNm}">
                                                <img src="${product.icon['']}" width="160px" height="160px" />
                                            </a>
                                        </c:when>
                                        <c:otherwise> <img src="${product.icon['']}" width="160px" height="160px" /></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="title" ><a <c:if test="${product.type == 0}">href="${webRoot}/integral/integralDetail.ac?integralProductId=${product.integralProductId}"</c:if> title="${product.integralProductNm}">${product.integralProductNm}</a></div>
                            <c:choose>
                                <c:when test="${product.paymentConvertTypeCode eq '2'}">
                                    <p >固定积分：<b><fmt:formatNumber value="${product.integral}" type="number" pattern="######.##" /></b></p>
                                    <p >  积分+金额：<b  style="width:170px;"><fmt:formatNumber value="${product.exchangeIntegral}" type="number" pattern="######.##"/>分+<fmt:formatNumber value="${product.exchangeAmount}" type="number"  pattern="######.##"/>元</b></p>
                                </c:when>
                        <c:when test="${product.paymentConvertTypeCode eq '1'}">
                            <p >积分+金额：<b style="width:170px;"><fmt:formatNumber value="${product.exchangeIntegral}" type="number" pattern="######.##" />分+<fmt:formatNumber value="${product.exchangeAmount}" type="number" pattern="######.##" />元</b></p>
                        </c:when>
                        <c:when test="${product.paymentConvertTypeCode eq '0'}">
                            <p>固定积分：<b><fmt:formatNumber value="${product.integral}" type="number" /></b></p>
                        </c:when>
                 </c:choose>

                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <div class="warp">
        <div class="new">
            <h2>积分商城公告</h2>
            <div class="box">
                <ul>
                    <c:forEach items="${sdk:getArticleCategoryById(80599).top5}" var="article" end="4" >
                        <c:choose>
                            <c:when test="${not empty article.externalLink}">
                                <li><a target="_blank" href="${article.externalLink}" title="${article.title}">· ${fn:substring(article.title,0,30)}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a target="_blank" href="${webRoot}/mallNotice-${article.infArticleId}-${article.categoryId}.html" title="${article.title}">· ${fn:substring(article.title,0,30)}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <div class="frameEdit" frameInfo="integral_right1|235X125">
            <c:forEach items="${sdk:findPageModuleProxy('integral_right1').advt.advtProxy}" var="adv">
                <div class="banner">
                    <a href="${adv.link}" title="${adv.title}" target="_blank"><img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" style="width:235px;height:125px;" /></a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
