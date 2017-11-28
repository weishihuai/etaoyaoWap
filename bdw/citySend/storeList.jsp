<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/17
  Time: 8:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${empty param.zoneId ? null : param.zoneId}" var="zoneId"/>
<c:set value="${empty param.lat ? null : param.lat}" var="lat"/>
<c:set value="${empty param.lng ? null : param.lng}" var="lng"/>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<%--门店列表--%>
<c:set value="${bdw:findShopPage(20, zoneId)}" var="shops"/>
<c:set var="orgIds" value="${bdw:findAllOrgIds(zoneId)}"/>
<c:set value="${shops.result}" var="shopList"/>
<%
  String lat = request.getParameter("lat");
  String lng = request.getParameter("lng");
  if(lat != null && lng != null){
    int t = 60 * 60 * 24 * 365 * 1;

    Cookie cookie2 = new Cookie("lat", lat);
    cookie2.setMaxAge(t);
    cookie2.setPath("/");
    response.addCookie(cookie2);

    Cookie cookie3 = new Cookie("lng", lng);
    cookie3.setMaxAge(t);
    cookie3.setPath("/");
    response.addCookie(cookie3);
  }
%>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title>淘药店-${webName}-门店列表</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="${webRoot}/template/bdw/citySend/statics/css/allStoreCarts.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/citySend/statics/css/storeList.css">

  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script type="text/javascript">
    var paramData={
      webRoot:"${webRoot}",
      q:"${param.q}",
      keyword:"${param.keyword}",
      order:"${param.order}",
      totalCount:"${shops.lastPageNumber}",
      page:"${_page}",
      cookieNum:0,
      sort:"${param.sort}",
      startPrice:"${param.startPrice}",
      lat:"${lat}",
      lng:"${lng}",
      endPrice:"${param.endPrice}",
      orgIds:'${orgIds}'
    }

  </script>
  <script type="text/javascript" src="${webRoot}/template/bdw/citySend/statics/js/storeList.js"></script>

<body>
<%--同城送头部--%>
<c:import url="/template/bdw/citySend/common/citySendTop.jsp?p=storeList"/>

<!--主体-->
<div class="main-bg">
  <div class="main">
    <!-- 路径导航 -->
    <ol class="breadcrumb">
      <li>
        <a href="${webRoot}/index.ac">易淘药健康网</a>
      </li>
      <li>
        <a href="${webRoot}/citySend/index.ac">淘药店首页</a>
      </li>
      <li style="color: #e5151f;">门店列表</li>
    </ol>

    <!-- 筛选 -->
    <div class="filter">
      <div class="form fl">
        <div class="select">
          <span class="select-tit sShop" id="search">搜门店</span>
          <div class="select-cont">
            <a href="javascript:void(0);" id="searchShop">搜门店</a>
            <a href="javascript:void(0);" id="searchProduct">搜商品</a>
          </div>
        </div>
        <input class="inp-txt" id="shopKeyWord" type="text" placeholder="请输入搜索关键字">
        <button class="btn" type="button" id="searchShopBtn">搜索</button>
      </div>

      <div class="page fr">
        <span>共&nbsp;${shops.totalCount}&nbsp;家门店</span>
        <a href="javascript:" id="pageUp" title="上一页">&lt;</a>
        <em><i>${shops.thisPageNumber}</i>/${shops.lastPageNumber}</em>
        <a href="javascript:" id="pageDown" title="下一页">&gt;</a>
      </div>
    </div>

    <div>
      <c:choose>
        <c:when test="${empty shopList}">
          <div class="notice-search">
            <span class="ns-icon"></span>
            <c:choose>
              <c:when test="${empty param.keyword}">
                <span class="ns-content">抱歉，没有找到相关的门店</span>
              </c:when>
              <c:otherwise>
                <span class="ns-content">抱歉，没有找到与“<em>${param.keyword}</em>”相关的门店</span>
              </c:otherwise>
            </c:choose>
          </div>
        </c:when>
        <c:otherwise>
          <!-- 列表 -->
          <ul class="store-list">
            <c:forEach items="${shopList}" var="shopProxy">
              <li>
                <div class="img">
                  <c:set var="img230" value="${webRoot}/template/bdw/statics/images/noPic_230X230.jpg"/>
                  <a href="javascript:void(0);" isSupport="${shopProxy.isSupportBuy}" shopName="${shopProxy.shopNm}" distinct="${shopProxy.distinct}" orgId="${shopProxy.sysOrgId}" onclick="checkShopIsSupport(this);"><%--distinct单位为米--%>
                    <c:choose>
                      <c:when test="${not empty shopProxy.shopPicUrl}">
                        <img src="${webRoot}/upload/${shopProxy.shopPicUrl}" width="240px" height="180px">
                      </c:when>
                      <c:otherwise>
                        <img src="${img230}" width="240px" height="180px">
                      </c:otherwise>
                    </c:choose>
                  </a>
                </div>
                <p class="name elli">
                  <a href="javascript:void(0);" isSupport="${shopProxy.isSupportBuy}" shopName="${shopProxy.shopNm}" distinct="${shopProxy.distinct}"  orgId="${shopProxy.sysOrgId}" onclick="checkShopIsSupport(this);">${shopProxy.shopNm}</a>
                </p>
                <div class="commit">
              <span class="grade">
                  <span style="width: ${shopProxy.goodRate}%;"></span>
              </span>
                  <span class="fl">订单成交量<em>&nbsp;${shopProxy.orderTotalCount}&nbsp;</em>笔</span>
                </div>
                <div class="count">
                  <span>商品数量&emsp;&emsp;<em>${shopProxy.productTotalCount}</em></span>
              <span>好评率&emsp;&emsp;
                <strong>
                  <c:choose>
                    <c:when test="${empty shopProxy.goodRate}">
                      0.0%
                    </c:when>
                    <c:otherwise>
                      <fmt:formatNumber value="${shopProxy.goodRate}" pattern="#0.0#"/>%
                    </c:otherwise>
                  </c:choose>
                </strong>
              </span>
                </div>
              </li>
            </c:forEach>
          </ul>
          <!-- 分页 -->
          <div class="pager">
            <div id="infoPage">
              <c:if test="${shops.lastPageNumber>1}">
                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${shops.lastPageNumber}' currentPage='${_page}' totalRecords='${shops.totalCount}' ajaxUrl='${webRoot}/citySend/storeList.ac' frontPath='${webRoot}' displayNum='6'/>
              </c:if>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>


<c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
</html>
