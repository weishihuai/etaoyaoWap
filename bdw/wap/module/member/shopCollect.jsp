<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysUser" %><%--
  店铺收藏
  Created by IntelliJ IDEA.
  User: pjx
  Date: 2017/10/24
  Time: 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/sdk" prefix="dk"%>
<c:set var="pageSize" value="7"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${bdw:getShopCollect(pageSize)}" var="userShopCollectPage"/>   <%--获取收藏店铺列表--%>
<html>
<head lang="en">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>店铺收藏</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" media="screen" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/collect.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/statics/js/shopCollect.js"></script>
    <script type="text/javascript">
        <%--初始化参数，供productCollect.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}", //当前路径
            lastPageNumber: ${userShopCollectPage.lastPageNumber}
        };
        <%--初始化参数，供productCollect.js调用 end--%>
    </script>

</head>
<%
    SysUser user = WebContextFactory.getWebContext().getFrontEndUser();
    if(user == null){
        response.sendRedirect("/wap/login.ac");
    }
%>
<body>
<div class="m-top">
    <a class="back" href="${webRoot}/wap/module/member/index.ac"></a>
    <span>店铺收藏</span>
    <a class="bianyi" href="javascript:;" onclick="collectEdit()">编辑</a>
</div>

<div class="collect-main shop-collect" id="main">
    <c:choose>
        <c:when test="${empty userShopCollectPage.result}">
            <div class="none-box">
                <img class="none-icon" src="${webRoot}/template/bdw/wap/module/member/statics/images/kongsoucang.png" alt="">
                <p>您还没收藏任何店铺</p>
            </div>
        </c:when>
        <c:otherwise>
            <%--收藏商品列表 start--%>
                <c:forEach items="${userShopCollectPage.result}" var="prdProxy" varStatus="statu">
                    <div class="item">
                        <em class="checkbox" onclick="collect(${prdProxy.shopInfId})" id="shop_${prdProxy.shopInfId}"style="display:none;" shopInfId="${prdProxy.shopInfId}"></em>
                        <a class="pic" href="${webRoot}/wap/outlettemplate/default/storeDetail.ac?shopId=${prdProxy.shopInfId}">
                            <img src="${prdProxy.defaultImage['100X100']}" alt="" />
                        </a>
                        <a class="name" href="${webRoot}/wap/outlettemplate/default/storeDetail.ac?shopId=${prdProxy.shopInfId}">${prdProxy.shopNm}</a>
                        <p class="delivery">
                            <span class="collect-number">${prdProxy.collectdByUserNum}人收藏</span>
                        </p>
                        <em class="cancel" onclick="cancelCellect(${prdProxy.shopInfId})"></em>
                    </div>
                </c:forEach>
                <div style="display: none;" class="cancel-collect-box">
                    <a href="javascript:;" onclick="closeCancelCollect()" class="close"></a>
                    <a class="cancel-collect-btn" href="javascript:;"  onclick="cancelOne()">取消收藏</a>
                </div>
                <div class="btn-box" style="display: none;"><p class="btn-box-l" onclick="selectAll()"><em class="checkboxAll" ></em>全选</p><p class="btn-box-r"><a href="javascript:;" onclick="cancelAll()">取消收藏</a></p></div>
        </c:otherwise>
    </c:choose>

    <nav id="page-nav">
        <a href="${webRoot}/wap/module/member/loadMoreShopCollect.ac?page=2&pageSize=${pageSize}"></a>
    </nav>
</div>
</body>
</html>

