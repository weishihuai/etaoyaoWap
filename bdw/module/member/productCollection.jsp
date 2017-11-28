<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="_page" value="${empty param.page?1:param.page}"/>  <%--接受页数--%>
<c:set value="${sdk:getProductCollect(5)}" var="userProductPage"/>   <%--获取收藏商品列表--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-收藏商品-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
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
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/productCollection.js"></script>
</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> >  <a href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >  收藏商品 </div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>

    <%--收藏商品列表 start--%>
    <div class="rBox">
        <h2 class="rightbox_h2_border">收藏商品</h2>
        <div class="getTO right_box_border">
            <c:choose>
                <c:when test="${empty userProductPage.result}">
                    <div class="b_info">
                        <li class="e-none" style="padding-left:360px;width:502px;height: 160px;padding-top: 50px;"><!--，没有搜到商品-->
                            <p><i>没有收藏商品？</i></p>
                            <p><em>赶紧去首页逛逛吧！</em></p>
                            <a href="${webRoot}/index.html">返回首页>></a>
                        </li>
                    </div>
                </c:when>
                <c:otherwise>
                    <%--收藏商品列表 start--%>
                    <c:forEach items="${userProductPage.result}" var="prdProxy" varStatus="statu">
                        <%--  <c:choose>
                              <c:when test="${prdProxy.isOnSale}">--%>
                        <div class="each">
                            <div class="pic">
                                <a href="${webRoot}/product-${prdProxy.productId}.html" title="${prdProxy.name}">
                                    <img alt="${prdProxy.name}" src="${prdProxy.defaultImage['100X100']}"   width="100" height="100"/>
                                </a>
                            </div>
                            <div class="introdu">
                                <div class="title"><a href="${webRoot}/product-${prdProxy.productId}.html" title="${prdProxy.name}">${prdProxy.name}</a></div>
                                <div class="price">商城价：<fmt:formatNumber value="${prdProxy.price.unitPrice}" type="number" pattern="#0.00#" /></div>
                            </div>
                            <div class="do">
                                <div class="dele"><a href="javascript:" onclick="deleteSingCollection('${prdProxy.productId}')" title="删除"></a></div>
                                <div class="Empty"><a href="${webRoot}/product-${prdProxy.productId}.html" target="_blank" title="查看${prdProxy.name}">查看商品</a></div>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <%-- </c:when>
                         <c:otherwise>

                             <div class="each">
                                 <div class="pic">
                                     <a href="${webRoot}/product-${prdProxy.productId}.html" title="${prdProxy.name}">
                                         <img alt="${prdProxy.name}" src="${prdProxy.defaultImage['100X100']}"   width="100" height="100"/>
                                     </a>
                                 </div>
                                 <div class="introdu">
                                     <div class="title"><a href="${webRoot}/product-${prdProxy.productId}.html" title="${prdProxy.name}">${prdProxy.name}</a></div>
                                     <div class="price">商城价：<fmt:formatNumber value="${prdProxy.price.unitPrice}" type="number" pattern="#0.00#" /></div>
                                 </div>
                                 <div class="do">
                                     <div class="dele"><a href="javascript:;" onclick="deleteSingCollection('${prdProxy.productId}')" title="删除"></a></div>
                                     <div class="Empty"><a href="${webRoot}/product-${prdProxy.productId}.html" target="_blank" title="查看${prdProxy.name}">查看商品</a></div>
                                     <div class="clear"></div>
                                 </div>
                                 <div class="clear"></div>
                             </div>
                         </c:otherwise>
                     </c:choose>--%>

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
            <c:if test="${userProductPage.lastPageNumber > 1}">
                <div class="page"> <div style="float:right">

                        <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/productCollection.ac" totalPages='${userProductPage.lastPageNumber}' currentPage='${_page}'  totalRecords='${userProductPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>

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
