<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="_page" value="${empty param.page?1:param.page}"/>  <%--接受页数--%>
<c:set value="${bdw:getShopCollect(5)}" var="userShopCollectPage"/>   <%--获取收藏商品列表--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-收藏店铺-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/layer.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.DOMWindow.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.cycle.all.min.js"></script>

    <script type="text/javascript">
        <%--初始化参数，供productCollection.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}"  //当前路径
        };
        <%--初始化参数，供productCollection.js调用 end--%>
    </script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/shopCollection.js"></script>
</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> >  <a href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >  收藏店铺 </div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>

    <%--收藏商品列表 start--%>
    <div class="rBox">
        <h2 class="rightbox_h2_border">收藏店铺</h2>
        <div class="getTO right_box_border">
            <c:choose>
                <c:when test="${empty userShopCollectPage.result}">
                    <div class="b_info">
                        <li class="e-none" style="padding-left:360px;width:502px;height: 160px;padding-top: 50px;"><!--，没有搜到商品-->
                            <p><i>没有收藏店铺？</i></p>
                            <p><em>赶紧去首页逛逛吧！</em></p>
                            <a href="${webRoot}/index.html">返回首页>></a>
                        </li>
                    </div>
                </c:when>
                <c:otherwise>
                    <%--收藏商品列表 start--%>
                    <c:forEach items="${userShopCollectPage.result}" var="shopProxy" varStatus="statu">

                        <div class="each">
                            <div class="pic">
                                <%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}" title="${shopProxy.shopNm}">
                                    <img alt="${shopProxy.shopNm}" src="${shopProxy.defaultImage['100X100']}"   width="100" height="100"/>
                                </a>--%>
                                    <%--去二级域名--%>
                                <%--<c:choose>--%>
                                    <%--<c:when test="${not empty shopProxy.subDomain}">--%>
                                        <%--<c:set var="shopUrl" value="http://${shopProxy.subDomain}.bdwmall.com"></c:set>--%>
                                        <%--<a href="${shopUrl}" title="${shopProxy.shopNm}" target="_blank">--%>
                                            <%--<img alt="${shopProxy.shopNm}" src="${shopProxy.defaultImage['100X100']}"   width="100" height="100"/>--%>
                                        <%--</a>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                        <%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}" title="${shopProxy.shopNm}" target="_blank">--%>
                                            <%--<img alt="${shopProxy.shopNm}" src="${shopProxy.defaultImage['100X100']}"   width="100" height="100"/>--%>
                                        <%--</a>--%>
                                    <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                                    <c:choose>
                                        <c:when test="${not empty shopProxy.shopType && shopProxy.shopType == '2'}">
                                            <a href="${webRoot}/citySend/storeDetail.ac?orgId=${shopProxy.sysOrgId}" title="${shopProxy.shopNm}" target="_blank"><img alt="${shopProxy.shopNm}" src="${shopProxy.defaultImage['100X100']}"   width="100" height="100"/></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}" title="${shopProxy.shopNm}" target="_blank"><img alt="${shopProxy.shopNm}" src="${shopProxy.defaultImage['100X100']}"   width="100" height="100"/></a>
                                        </c:otherwise>
                                    </c:choose>

                            </div>
                            <div class="introdu">
                                <div class="title">
                                    <%--取二级域名--%>
                                    <%--<c:choose>--%>
                                        <%--<c:when test="${not empty shopProxy.subDomain}">--%>
                                            <%--<c:set var="shopUrl" value="http://${shopProxy.subDomain}.bdwmall.com"></c:set>--%>
                                            <%--<a href="${shopUrl}" title="${shopProxy.shopNm}" target="_blank">--%>
                                                    <%--${fn:substring(shopProxy.shopNm,0,16)}--%>
                                            <%--</a>--%>
                                        <%--</c:when>--%>
                                        <%--<c:otherwise>--%>
                                            <%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}" title="${shopProxy.shopNm}" target="_blank">--%>
                                                    <%--${fn:substring(shopProxy.shopNm,0,16)}--%>
                                            <%--</a>--%>
                                        <%--</c:otherwise>--%>
                                    <%--</c:choose>--%>
                                    <c:choose>
                                        <c:when test="${not empty shopProxy.shopType && shopProxy.shopType == '2'}">
                                            <a href="${webRoot}/citySend/storeDetail.ac?orgId=${shopProxy.sysOrgId}" title="${shopProxy.shopNm}" target="_blank"> ${fn:substring(shopProxy.shopNm,0,16)}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}" title="${shopProxy.shopNm}" target="_blank"> ${fn:substring(shopProxy.shopNm,0,16)}</a>
                                        </c:otherwise>
                                    </c:choose>

                                </div>
                                <c:set var="caadInf" value="${shopProxy.csadInfList[0]}" />
                                <div class="price">客服：
                                    <c:choose>
                                        <c:when test="${not empty shopProxy.companyQqUrl}">
                                            <a href="${shopProxy.companyQqUrl}" target="_blank">
                                                <img src="${webRoot}/template/bdw/statics/images/qq.png"/>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${shopProxy.csadInfList}" var="caadInf" end="0">
                                                <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${caadInf}&amp;site=qq&amp;menu=yes" target="_blank">
                                                    <img src="http://wpa.qq.com/pa?p=1:${caadInf}:7" />
                                                </a>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="price">在线时间：${shopProxy.csadOnlineDescr}</div>

                            </div>
                            <div class="do">
                                <div class="dele"><a href="javascript:" onclick="deleteSingCollection('${shopProxy.shopInfId}')" title="删除"></a></div>
                                <div class="Empty"><%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}" target="_blank" title="查看${shopProxy.shopNm}">查看店铺</a>--%>
                                    <%--<c:choose>--%>
                                        <%--<c:when test="${not empty shopProxy.subDomain}">--%>
                                            <%--<c:set var="shopUrl" value="http://${shopProxy.subDomain}.bdwmall.com"></c:set>--%>
                                            <%--<a href="${shopUrl}" title="查看${shopProxy.shopNm}" target="_blank">--%>
                                                <%--查看店铺--%>
                                            <%--</a>--%>
                                        <%--</c:when>--%>
                                        <%--<c:otherwise>--%>
                                            <%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}" title="查看${shopProxy.shopNm}" target="_blank">--%>
                                                <%--查看店铺--%>
                                            <%--</a>--%>
                                        <%--</c:otherwise>--%>
                                    <%--</c:choose>--%>
                                    <c:choose>
                                        <c:when test="${not empty shopProxy.shopType && shopProxy.shopType == '2'}">
                                            <a href="${webRoot}/citySend/storeDetail.ac?orgId=${shopProxy.sysOrgId}" title="${shopProxy.shopNm}" target="_blank">查看店铺</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}" title="${shopProxy.shopNm}" target="_blank">查看店铺</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:forEach>
                    <%--收藏商品列表 end--%>
                </c:otherwise>
            </c:choose>



            <%--购物车弹出层 start--%>
            <div id="innerWin" style="display: none;">
                <div id="shoppingCartTip" style="margin:0 auto;position:relative;height:130px"></div>
            </div>
            <%--购物车弹出层 end--%>
            <%--分页 start--%>
            <c:if test="${userShopCollectPage.lastPageNumber > 1}">
                <div class="page"> <div style="float:right">
                   <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/productCollection.ac" totalPages='${userShopCollectPage.lastPageNumber}' currentPage='${_page}'  totalRecords='${userShopCollectPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>

                </div>
            </c:if>
                <%--分页 end--%>
            </div>
        </div>
    </div>
    <%--收藏商品列表 end--%>

    <div class="clear"></div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
