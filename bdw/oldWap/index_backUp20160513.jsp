<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale= 1.0, user-scalable=no">
  <title>${webName}-首页</title>
  <link href="${webRoot}/template/bdw/oldWap/statics/css/indexslider.css" rel="stylesheet" media="screen">
  <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
  <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" rel="stylesheet" media="screen">
  <link href="${webRoot}/template/bdw/oldWap/statics/css/scsy.css" rel="stylesheet" media="screen">
  <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">

  <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
  <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.event.drag-1.5.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.touchSlider.js"></script>
  <script src="${webRoot}/template/bdw/oldWap/statics/js/index.js"></script>

</head>
<body style="background: #f7f7f7;">
<div class="container scsy">
  <%--轮换广告START--%>
  <div class="main_visual frameEdit" frameInfo="weixinAdv_mobile|640X240">
    <div class="flicking_con">
      <div class="flicking_inner">
        <c:forEach items="${sdk:findPageModuleProxy('weixinAdv_mobile').advt.advtProxy}" var="advtProxys" varStatus="s" end="5">
          <a></a>
        </c:forEach>

      </div>
    </div>
    <div class="main_image" style="height: 120px;">
      <ul>
        <c:forEach items="${sdk:findPageModuleProxy('weixinAdv_mobile').advt.advtProxy}" var="advtProxys" varStatus="s" end="5">
          <c:choose>
            <c:when test="${advtProxys.displayWayCode == '1'}">
              <li><a href="${advtProxys.link}"><img src="${advtProxys.advUrl}"  class="img-responsive col-xs-12" style="height:120px;"/></a></li>
            </c:when>
            <c:otherwise>
              <li>${advtProxys.htmlTemplate}</li>
            </c:otherwise>
          </c:choose>
        </c:forEach>
      </ul>
      <a href="javascript:" id="btn_prev"></a>
      <a href="javascript:" id="btn_next"></a>
    </div>
  </div>
  <%--轮换广告END--%>

  <div class="row logo">
    <div class="col-xs-4 frameEdit text-center" frameInfo="weixin_logo|160X50" style="height:30px;">
      <c:forEach items="${sdk:findPageModuleProxy('weixin_logo').advt.advtProxy}" var="logo" end="0">
        <img src="${logo.advUrl}"class="img-responsive" />
      </c:forEach>
    </div>

    <%--<div class="col-xs-1"><i class="xian"></i></div>--%>

    <div class="col-xs-8">
      <form id="searchForm" action="${webRoot}/wap/list.ac" method="get">
        <div class="col-xs-12">
          <div class="input-group">
            <input id="put" type="text" name="keyword" class="form-control" placeholder="商品关键字" style="  font-size: 12px;" />
                            <span class="input-group-btn">
                                <button class="btn btn-default btn-danger" type="button" id="search_btn">GO!</button>
                            </span>
          </div>
        </div>
      </form>
    </div>


  </div>
  <div class="row border">
    <div class="col-xs-12 bg"></div>
  </div>

  <div class="row fenl">
    <div class="col-xs-3 m1 frameEdit" frameInfo="weixin_Navigate_1">
      <c:forEach items="${sdk:findPageModuleProxy('weixin_Navigate_1').links}" var="pageLink" end="0">
        <div class="icon">
          <a href="${pageLink.link}">
            <img src="${pageLink.icon['']}" width="35" height="35" />
          </a>
        </div>
        <div class="title text-center"><a href="${pageLink.link}" <c:if test="${pageLink.newWin}">target="_blank" </c:if> >${fn:substring(pageLink.title,0,4)}</a></div>
      </c:forEach>
    </div>
    <div class="col-xs-3 frameEdit" frameInfo="weixin_Navigate_2">
      <c:forEach items="${sdk:findPageModuleProxy('weixin_Navigate_2').links}" var="pageLink" end="0">
        <div class="icon">
          <a href="${pageLink.link}">
            <img src="${pageLink.icon['']}" width="35" height="35" />
          </a>
        </div>
        <div class="title text-center"><a href="${pageLink.link}" <c:if test="${pageLink.newWin}">target="_blank" </c:if> >${fn:substring(pageLink.title,0,4)}</a></div>
      </c:forEach>
    </div>
    <div class="col-xs-3 frameEdit" frameInfo="weixin_Navigate_3">
      <c:forEach items="${sdk:findPageModuleProxy('weixin_Navigate_3').links}" var="pageLink" end="0">
        <div class="icon">
          <a href="${pageLink.link}">
            <img src="${pageLink.icon['']}" width="35" height="35" />
          </a>
        </div>
        <div class="title text-center"><a href="${pageLink.link}" <c:if test="${pageLink.newWin}">target="_blank" </c:if> >${fn:substring(pageLink.title,0,4)}</a></div>
      </c:forEach>
    </div>
    <div class="col-xs-3 frameEdit" frameInfo="weixin_Navigate_4" >
      <c:forEach items="${sdk:findPageModuleProxy('weixin_Navigate_4').links}" var="pageLink" end="0">
        <div class="icon">
          <a href="${pageLink.link}">
            <img src="${pageLink.icon['']}" width="35" height="35" />
          </a>
        </div>
        <div class="title text-center"><a href="${pageLink.link}" <c:if test="${pageLink.newWin}">target="_blank" </c:if> >${fn:substring(pageLink.title,0,4)}</a></div>
      </c:forEach>
    </div>
  </div>
</div>


<div class="container p1">
  <div class="row pic frameEdit" frameInfo="weixin_tittle_F1|25X25">
    <c:forEach items="${sdk:findPageModuleProxy('weixin_tittle_F1').links}" var="pageLink" end="0">
      <%--<div class="col-xs-2"><img src="${pageLink.icon['']}" style="margin-top: 3px;" /></div>--%>
      <div class="col-xs-12" >${pageLink.title}</div>
    </c:forEach>
  </div>

  <%--<div class="row new">
      <div class="col-xs-12 gx frameEdit" frameInfo="weixin_in_tittle_F1|25X25">
         <i> <c:forEach items="${sdk:findPageModuleProxy('weixin_in_tittle_F1').links}" var="pageLink" end="0">
           ${pageLink.title}
          </c:forEach> </i>
      </div>
  </div>--%>
  <div class="frameEdit" frameInfo="weixin_content_F1">
    <div class="row goods"  style="height: 160px;">
      <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F1').recommendProducts}" var="prd" end="2">
        <div class="col-xs-4" >
          <div class="icon">
            <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="90" height="90" /></a>
          </div>
          <div class="title">
            <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>
          </div>
          <div class="pri">￥<b><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b></div>
        </div>
      </c:forEach>
    </div>
    <div class="row goods"  style="height: 160px;" >
      <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F1').recommendProducts}" var="prd" begin="3" end="5">
        <div class="col-xs-4" >
          <div class="icon">
            <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="90" height="90" /></a>
          </div>
          <div class="title">
            <a href="${webRoot}/wap/product.ac?id=${prd.productId}" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a>
          </div>
          <div class="pri">￥<b><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b></div>
        </div>
      </c:forEach>
    </div>
  </div>

</div>


<div class="container p2" >

  <div class="row pic frameEdit" frameInfo="weixin_tittle_F2|25X25">
    <c:forEach items="${sdk:findPageModuleProxy('weixin_tittle_F2').links}" var="pageLink" end="0">
      <%--<div class="col-xs-2"><img src="${pageLink.icon['']}" style="margin-top: 3px;" /></div>--%>
      <div class="col-xs-12">${pageLink.title}</div>
    </c:forEach>
  </div>

  <div class="row pic1" style="height: 100px; margin-bottom:7px; margin-top: 4px; overflow: hidden;">
    <div class="col-xs-12 frameEdit"  frameInfo="weixin_content_F2_1|620X200" >
      <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F2_1').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
        <c:choose>
          <c:when test="${advtProxys.displayWayCode == '1'}">
            <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" class="img-responsive"  height="100"/></a>
          </c:when>
          <c:otherwise>
            ${advtProxys.htmlTemplate}
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>
  </div>

  <div class="row"  style="height: 80px; overflow: hidden;" >
    <div class="col-xs-6 pic2 frameEdit" frameInfo="weixin_content_F2_2|300X160">
      <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F2_2').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">

        <c:choose>
          <c:when test="${advtProxys.displayWayCode == '1'}">
            <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}"class="img-responsive" /></a>                    </c:when>
          <c:otherwise>
            ${advtProxys.htmlTemplate}
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>
    <div class="col-xs-6 pic3 frameEdit" frameInfo="weixin_content_F2_3|300X160">
      <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F2_3').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
        <c:choose>
          <c:when test="${advtProxys.displayWayCode == '1'}">
            <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" class="img-responsive" /></a>
          </c:when>
          <c:otherwise>
            ${advtProxys.htmlTemplate}
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>
  </div>

</div>

<div class="container p1 p3 ">

  <div class="row pic frameEdit" frameInfo="weixin_tittle_F3|25X25">
    <c:forEach items="${sdk:findPageModuleProxy('weixin_tittle_F3').links}" var="pageLink" end="0">
      <%--<div class="col-xs-2"><img src="${pageLink.icon['']}" style="margin-top: 3px;" /></div>--%>
      <div class="col-xs-12">${pageLink.title}</div>
    </c:forEach>
  </div>

  <div class="row new">
    <div class="col-xs-12 gx frameEdit" frameInfo="weixin_in_tittle_F3|25X25">
      <i><c:forEach items="${sdk:findPageModuleProxy('weixin_in_tittle_F3').links}" var="pageLink" end="0">
        ${pageLink.title}
      </c:forEach></i>
    </div>
  </div>

  <div class="row goods frameEdit" frameInfo="weixin_content_F3" style="height:160px;">
    <c:forEach items="${sdk:findPageModuleProxy('weixin_content_F3').recommendProducts}" var="prd" varStatus="s" end="2">
      <div class="col-xs-4 ">
        <div class="icon">
          <a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['150X150'] : prd.images[0]['150X150']}" width="90" height="90" /></a>
        </div>
        <div class="title"><a href="${webRoot}/wap/product.ac?id=${prd.productId}" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></div>
        <div class="pri">￥<b><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#" /></b></div>
      </div>
    </c:forEach>
  </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
<f:FrameEditTag />
