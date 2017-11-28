<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:searchShopInfProxy(10)}" var="shopInfPage"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}" /> <%--SEO description优化--%>
    <title>店铺搜索-${param.searchField}-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/shop.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/common-func.js"></script>
    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            page:"${_page}",
            totalCount:"${shopInfPage.lastPageNumber}"
        };
        $(document).ready(function(){
            $("#pageUp").click(function(){
                if(paramData.page==1){
                    alert("当前已是第一页");
                    return;
                }
                var page=parseInt(paramData.page)-1;
                goToUrl(paramData.webRoot+"/shop.ac?page="+page);
            });
            $("#pageDown").click(function(){
                if(paramData.page==paramData.totalCount){
                    alert("当前已是最后一页");
                    return;
                }
                var page=parseInt(paramData.page)+1;
                goToUrl(paramData.webRoot+"/shop.ac?page="+page);
            });

            $(".cert-cont").each(function(){
                var id = $(this).attr("key");
                var em = "#cert-cont"+id;
                TabLT(1,"x",$(em),$(em+" li"),2,$("#prevBt"+id),$("#nextBt"+id),0,"","a",0,"","",1,321,300,0,2500);
            });
        })
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=shop"/>
<%--页头结束--%>
<%--页头开始--%>
<%--<c:import url="/template/bdw/module/common/top.jsp?p=member"/>--%>
<%--页头结束--%>
<div id="list-main">
	<div class="page">
    	<div class="page-l">
        	<h4>找到相关店铺<span>${shopInfPage.totalCount}</span>家</h4>
        </div>
        <div class="page-r">
        	<p>${shopInfPage.thisPageNumber}/${shopInfPage.lastPageNumber}</p>
            <ul>
                <li><a id="pageUp" title="上一页" href="javascript:void(0);"><img src="${webRoot}/template/bdw/statics/images/pic8.jpg" /></a></li>
                <li><a id="pageDown" title="下一页" href="javascript:void(0);"><img src="${webRoot}/template/bdw/statics/images/pic9.jpg" /></a></li>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    <div class="list-box">
        <ul>
            <c:forEach items="${shopInfPage.result}" var="shopInf" varStatus="s">
                <li class="shop-item clearfix">
                    <div class="shop-info fl">
                        <a class="shop-img" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank">
                            <img src="${shopInf.defaultImage["100X100"]}" />
                        </a>
                        <div class="shop-desc">
                            <a class="shop-name elli" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" title="">${shopInf.shopNm}</a>
                            <p class="t">
                                <span>联系人：${shopInf.name}&nbsp;&nbsp;|&nbsp;&nbsp;</span>
                                <!--认证-->
                                <c:forEach var="attesation" items="${shopInf.shopAttesation}">
                                    <img src="${attesation.logo['']}">
                                </c:forEach>
                            </p>
                            <p class="m">
                                <img src="${shopInf.shopLevel.levelIcon['']}" height="16px"/>
                            </p>
                            <p class="b bl">
                                <c:set var="avgVo" value="${shopInf.shopRatingAvgVo}"/>
                                <span>描述相符：<em>${avgVo.productDescrSame}</em>&nbsp;分</span>
                                <span>服务态度：<em>${avgVo.sellerServiceAttitude}</em>&nbsp;分</span>
                                <span>物流速度：<em>${avgVo.sellerSendOutSpeed}</em>&nbsp;分</span>
                            </p>
                            <p class="b br">
                                <span>商品总数： <strong>${shopInf.shopProductTotal}</strong>&nbsp;件</span>
                                <span>累计成交： <i>${shopInf.orderTotalCount}</i>&nbsp;笔</span>
                            </p>
                        </div>
                        <a class="btn-default" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank">进入商家</a>
                    </div>
                    <div class="good-slider fr ">
                        <ul style="width: 400%" class="cert-cont" key="${s.count}" id="cert-cont${s.count}">
                            <c:forEach var="productProxy" items="${shopInf.shopProductList}" >
                                <%--取出商品属性--%>
                                <c:set var="attrDicList" value="${productProxy.dicValues}"/>
                                <li class="good-item">
                                    <a href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}">
                                       <span class="good-img">
                                           <c:set var="proImg" value="${productProxy.defaultImage['100X100']}"/>
                                           <c:if test="${empty productProxy.images}">
                                               <c:set var="proImg" value="${webRoot}/template/default/statics/images/noPic_100X100.jpg"/>
                                           </c:if>
                                            <img src="${proImg}">
                                       </span>
                                        <p class="good-name elli">${productProxy.name}</p>
                                        <p class="good-ex elli">  ${productProxy.factory}</p>
                                        <p class="good-ex elli"><c:if test="${!empty productProxy.specNm}">规格：${productProxy.specNm}</c:if></p>
                                        <p class="good-price"><strong ><i>&yen;</i><fmt:formatNumber value="${productProxy.price.unitPrice}" type="number" pattern="#0.00#"/></strong></p>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                        <c:if test="${not empty shopInf.shopProductList}">
                            <a class="slider-op prev" id="prevBt${s.count}" href="javascript:;">&lt;</a>
                            <a class="slider-op next" id="nextBt${s.count}" href="javascript:;">&gt;</a>
                        </c:if>
                    </div>
                </li>
            </c:forEach>
        </ul>
        <div class="page">
            <div style="float: right;padding-right:30px">
                <c:if test="${shopInfPage.lastPageNumber>1}">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${shopInfPage.lastPageNumber}' currentPage='${_page}'  totalRecords='${shopInfPage.totalCount}' ajaxUrl='${webRoot}/shop.ac' frontPath='${webRoot}' displayNum='6' />
                </c:if>
            </div>
        </div>
    </div>
</div>

<!--			footer-->
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
