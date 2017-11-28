<%@ page import="com.iloosen.imall.commons.util.MapDistanceUtils" %>
<%@ page import="com.iloosen.imall.commons.util.StringUtils" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysShopInf" %>
<%@ page import="java.math.BigDecimal" %>
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
<%--取出门店信息--%>
<c:set value="${bdw:getShopInfProxyByOrgId(param.orgId)}" var="shopProxy"/>
<c:if test="${empty shopProxy || shopProxy.isFreeze == 'Y'}">
  <c:redirect url="${webRoot}/citySend/storeError.ac"></c:redirect>
</c:if>

<c:if test="${shopProxy.shopType != '2'}"><%--如果不是门店则跳转到普通店铺首页--%>
  <c:redirect url="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopProxy.shopInfId}"></c:redirect>
</c:if>
<c:set value="${bdw:searchStoreHotSaleProducts(shopProxy.sysOrgId,1,9,'salesVolume,desc')}" var="hotSaleProducts"/>

<%
  request.setAttribute("orgId",request.getParameter("orgId"));                //机构ID
  String lat = request.getParameter("lat");
  String lng = request.getParameter("lng");
  if(StringUtils.isNotBlank(lat) && StringUtils.isNotBlank(lng)){
    int t = 60 * 60 * 24 * 365 * 1;

    Cookie cookie2 = new Cookie("lat", lat);
    cookie2.setMaxAge(t);
    cookie2.setPath("/");
    response.addCookie(cookie2);

    Cookie cookie3 = new Cookie("lng", lng);
    cookie3.setMaxAge(t);
    cookie3.setPath("/");
    response.addCookie(cookie3);

    SysShopInf shopInf = ServiceManager.sysShopInfService.getByOrgId(Integer.valueOf(request.getParameter("orgId")));
    Double distinct = MapDistanceUtils.distance(shopInf.getOutletLng(), shopInf.getOutletLat(), Double.valueOf(lng), Double.valueOf(lat));//单位：米
    request.setAttribute("distinct", new BigDecimal(distinct/1000).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
  }else {
    String distinct = request.getParameter("distinct");
    if (StringUtils.isNotBlank(distinct)) {
      Double dbDistinct = Double.parseDouble(distinct);

      request.setAttribute("distinct", new BigDecimal(dbDistinct/1000).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
    }
  }
%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%--取出门店的店铺分类--%>
<c:set value="${sdk:getShopCategoryProxy(param.shopId)}" var="storeCategory"/>
<c:set value="${sdk:getShopRoot(param.orgId)}" var="shopRoot"/>
<c:set value="${empty param.shopCategoryId ? shopRoot : param.shopCategoryId}" var="storeCategoryId"/>

<%--取出门店的所有商品--%>
<c:set value="${bdw:searchProductInCitySend(14)}" var="productProxys"/>
<c:set value="${sdk:getFacet()}" var="facetProxy"/>

<c:set value="${sdk:getSysParamValue('webUrl')}" var="webUrl"/>
<%--用于门店分享--%>
<c:set value="${webUrl}/wap/citySend/shopIndex.ac?orgId=${shopProxy.sysOrgId}" var="prdHref"/>

<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title>同城送-${webName}-${shopProxy.shopNm}</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="${webRoot}/template/bdw/citySend/statics/css/store-detail.css">

  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript">
    var paramData={
      webRoot:"${webRoot}",
      shopCategoryId:"${storeCategoryId}",
      q:"${param.q}",
      keyword:"${param.keyword}",
      order:"${param.order}",
      totalCount:"${productProxys.lastPageNumber}",
      page:"${_page}",
      cookieNum:0,
      sort:"${param.sort}",
      lat:"${param.lat}",
      lng:"${param.lng}",
      orgId:"${param.orgId}",
      distinct:'${param.distinct}',
      orgLat:'${shopProxy.outletLat}',
      orgLng:'${shopProxy.outletLng}',
      shopCollectCount:${shopProxy.collectdByUserNum == null ? 0:shopProxy.collectdByUserNum}
    }
  </script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
  <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&libraries=geometry"></script><%--两个经纬度之间的距离计算--%>
  <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1338866268911669" charset="utf-8"></script>
  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/citySend/statics/js/storeDetail.js"></script>
</head>
<body>
<%--同城送头部--%>
<c:import url="${webRoot}/template/bdw/citySend/common/citySendTop.jsp?p=storeDetail&orgId=${param.orgId}"/>
<!--主体-->
<div class="main-bg">
  <div class="main">
    <!-- 门店详细信息 -->
    <div class="store">
      <div class="media">
        <c:set var="img230" value="${webRoot}/template/bdw/statics/images/noPic_230X230.jpg"/>
        <div class="media-left" href="javascript:">
          <c:choose>
            <c:when test="${not empty shopProxy.shopPicUrl}">
              <img src="${webRoot}/upload/${shopProxy.shopPicUrl}" width="240px" height="160px">
            </c:when>
            <c:otherwise>
              <img src="${img230}" width="240px" height="160px">
            </c:otherwise>
          </c:choose>
        </div>
        <div class="media-body">
          <h3>${shopProxy.shopNm}<span></span></h3>
          <p>
              <span class="grade">
                  <span style="width: <c:choose><c:when test="${empty shopProxy.goodRate || shopProxy.goodRate == 0}">100</c:when><c:otherwise>${shopProxy.goodRate}</c:otherwise></c:choose>%;"></span>
              </span>
              <a href="javascript:">${shopProxy.commentCount}条店铺评论</a>
          </p>

          <dl>
            <dt>门店地址：</dt>
            <dd>${shopProxy.outStoreAddress}</dd>
            <dt>联系电话：</dt>
            <dd>
              <c:choose>
                <c:when test="${not empty shopProxy.tel}">
                  ${shopProxy.tel}
                </c:when>
                <c:otherwise>
                  ${shopProxy.mobile}
              </c:otherwise>
              </c:choose>
            </dd>
          </dl>
        </div>
      </div>

      <div class="sub">
        <ol>
          <li class="count">
            <span class="li-lab">商品数量(件)</span>
            <strong class="li-val">${shopProxy.productTotalCount}</strong>
          </li>
          <li class="evaluate">
            <span class="li-lab">店铺好评率(%)</span>
            <strong class="li-val">
              <c:choose>
                <c:when test="${empty shopProxy.goodRate || shopProxy.goodRate eq 0}">
                  0.0
                </c:when>
                <c:otherwise>
                  <fmt:formatNumber value="${shopProxy.goodRate}" pattern="#0.0#"/>
                </c:otherwise>
              </c:choose>
            </strong>
          </li>
          <%--如果距离为空，则重新计算当前客户端IP与客户端的距离--%>
          <li class="distance">
            <c:choose>
              <c:when test="${not empty distinct}">
                <span class="li-lab">商家距离(km)</span>
              </c:when>
              <c:otherwise>
                <span class="li-lab">距中心市县(km)</span>
              </c:otherwise>
            </c:choose>

            <c:choose>
              <c:when test="${not empty distinct}">
                <strong class="li-val"><fmt:formatNumber value="${distinct}" pattern="#0.00"/></strong>
              </c:when>
              <c:otherwise>
                <strong class="li-val" id="defaultDistance"></strong>
              </c:otherwise>
            </c:choose>
          </li>
        </ol>
        <p>
          <a href="javascript:" id="collectStore" onclick="collectStore('${shopProxy.shopInfId}')"><i class="icon-collectl"></i>&ensp;收藏(<em class="user_num">${shopProxy.collectdByUserNum}</em>)</a>
          <a href="javascript:" id="shareShop"><i class="icon-share"></i>&ensp;分享</a>
        </p>
      </div>
    </div>

    <div class="tab-nav-wrap">
      <ul class="tab-nav">
        <li class="tabLabel active" rel="1">
          <a href="javascript:" title="全部商品">全部商品</a>
        </li>
        <li class="tabLabel" rel="2" orgid="${orgId}">
          <a href="javascript:" title="商品评价">商品评价</a>
        </li>
        <li class="tabLabel" rel="3">
          <a href="javascript:" title="门店信息">门店信息</a>
        </li>
      </ul>

      <div class="form-search">
        <input class="inp-txt" id="searchTxt" type="text" placeholder="搜索门店商品">
        <button class="btn" type="button" id="searchPrd">搜索</button>
      </div>
    </div>

    <div class="main-content">
      <div class="tabpanel info1">
        <%--全部商品--%>
        <c:if test="${not empty facetProxy && empty param.keyword}">
          <div class="selector">
            <%--已选--%>
            <c:if test="${not empty facetProxy.selections}">
              <div class="item">
                <div class="item-tit">已选择：</div>
                <div class="item-cont">
                  <ul>
                    <c:forEach items="${facetProxy.selections}" var="selections">
                      <li>
                        <a href="${selections.url}" title="${selections.name}">
                          <em>${fn:substring(selections.title,0,4)}：${sdk:cutString(selections.name,16,"...")}</em><i></i>
                        </a>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </c:if>
            <%--未选--%>
            <c:if test="${not empty productProxys.result}">
              <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="s">
                <c:if test="${fn:length(unSelections.couts) > 0}">
                  <div class="item">
                    <div class="item-tit">${fn:substring(unSelections.title,0,6)}：</div>
                    <div class="item-cont">
                      <ul>
                        <c:forEach items="${unSelections.couts}" var="count" varStatus="kk">
                          <c:if test="${not empty count.name}">
                            <li style="display:${kk.count > 8?'none':'inline-block'}"  class="${kk.count > 8 ? 'extraAttr':''}">
                              <a  href="${webRoot}/citySend/storeDetail.ac${count.url}" title="${count.name}">${fn:substring(count.name,0,10)}</a>
                            </li>
                          </c:if>
                        </c:forEach>
                      </ul>
                    </div>
                    <c:if test="${fn:length(unSelections.couts) > 10}">
                      <a class="opera row_m" href="javascript:" onclick="showMoreAttrs()">更多&ensp;<i class="icon-angel-down"></i></a>
                      <a class="opera row_h" style="display:none;" href="javascript:" onclick="hideTheAttr()">收起&ensp;<i class="icon-angel-up"></i></a>
                    </c:if>
                  </div>
                </c:if>
              </c:forEach>
            </c:if>
          </div>
        </c:if>
        <div class="filter">
          <ul>
            <li class="<c:if test="${empty param.order}">active</c:if>">
              <a href="${webRoot}/citySend/storeDetail.ac?orgId=${param.orgId}&lat=${param.lat}&lng=${param.lng}&shopCategoryId=${storeCategoryId}&q=${param.q}&keyword=${param.keyword}">默认排序</a>
            </li>
            <li class="<c:if test="${fn:contains(param.order,'salesVolume')}">active</c:if>">
              <a href="javascript:" onclick="changeSortBySalesVolumn(this);">销量&ensp;
                <c:choose>
                  <c:when test="${param.order == 'salesVolume,asc'}">
                    <i class="icon-arrow-up"></i>
                  </c:when>
                  <c:otherwise>
                    <i class="icon-arrow-down"></i>
                  </c:otherwise>
                </c:choose>
              </a>
            </li>
            <li class="<c:if test="${fn:contains(param.order,'minPrice')}">active</c:if>">
              <a href="javascript:" onclick="changeSortByPrice(this);">价格&ensp;
                <c:choose>
                  <c:when test="${param.order == 'minPrice,asc'}">
                    <i class="icon-arrow-up"></i>
                  </c:when>
                  <c:otherwise>
                    <i class="icon-arrow-down"></i>
                  </c:otherwise>
                </c:choose>
              </a>
            </li>
          </ul>
        </div>
        <div class="good-list">
          <c:choose>
            <c:when test="${empty productProxys.result}">
              <div class="notice-search">
                <span class="ns-icon"></span>
                <c:choose>
                  <c:when test="${empty param.keyword}">
                    <span class="ns-content">抱歉，没有找到相关的商品</span>
                  </c:when>
                  <c:otherwise>
                    <span class="ns-content">抱歉，没有找到与“<em>${param.keyword}</em>”相关的商品</span>
                  </c:otherwise>
                </c:choose>
              </div>
            </c:when>
            <c:otherwise>
              <ul>
                <c:forEach items="${productProxys.result}" var="productProxy">
                  <li class="media">
                    <a class="media-left" href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}">
                      <img src="${productProxy.defaultImage['130X130']}" width="130px" height="130px" alt="">
                    </a>
                    <div class="media-body">
                      <a class="media-tit" href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}&nbsp;${productProxy.salePoint}</a>
                      <p class="media-other">
                        <span><i class="icon-saled"></i>&ensp;${productProxy.salesVolume}</span>&emsp;
                        <a href="javascript:" title="评价"><i class="icon-msg"></i>&ensp;${productProxy.commentQuantity}</a>
                      </p>
                      <p class="price">
                        <span class="cur-price"><small>&yen;</small><fmt:formatNumber value="${productProxy.price.unitPrice}" type="number"  pattern="#0.00#" /></span>&ensp;
                        <del class="old-price">&yen;<fmt:formatNumber value="${productProxy.marketPrice}" type="number"  pattern="#0.00#" /></del>
                      </p>
                    </div>
                    <c:choose>
                      <c:when test="${productProxy.isCanBuy}">
                        <c:choose>
                          <c:when test="${fn:length(productProxy.skus)>1}">
                            <%--多规格，弹出规格选择框--%>
                            <a class="opera" href="javascript:" productId="${productProxy.productId}" onclick="showMultiSpecWin(this)"></a>
                          </c:when>
                          <c:otherwise>
                            <%--单规格--%>
                            <a href="javascript:void(0);" class="opera addCartBtn" skuid="${productProxy.skus[0].skuId}" carttype="store" handler="sku" num="1" orgid="${orgId}"></a>
                          </c:otherwise>
                        </c:choose>
                      </c:when>
                      <c:otherwise>
                        <a class="quehuo_opera" href="${webRoot}/product-${productProxy.productId}.html">缺货</a>
                      </c:otherwise>
                    </c:choose>
                  </li>
                </c:forEach>
              </ul>
            </c:otherwise>
          </c:choose>
        </div>
        <!-- 分页 -->
        <div class="pager">
          <div id="infoPage">
            <c:if test="${productProxys.lastPageNumber>1}">
              <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${productProxys.lastPageNumber}' currentPage='${_page}' totalRecords='${productProxys.totalCount}' ajaxUrl='${webRoot}/citySend/storeDetail.ac' frontPath='${webRoot}' displayNum='6'/>
            </c:if>
          </div>
        </div>
      </div>

      <div class="tabpanel info2" id="commentList">
        <%--评价--%>
      </div>

      <div class="tabpanel info3" style="display: none;">
        <%--店铺介绍--%>
        ${shopProxy.shopDescrStr}
      </div>

    </div>

    <div class="main-side">
      <dl class="notice">
        <dt>门店公告</dt>
        <dd>
          <c:choose>
            <c:when test="${empty shopProxy.shopNoticeStr}">
              暂无公告
            </c:when>
            <c:otherwise>
              ${shopProxy.shopNoticeStr}
            </c:otherwise>
          </c:choose>
        </dd>
        <%--<dd>
          <p>1、满100减15;满200减34;满300减56;满800减168;满1300减338 <span>(手机客户端专享)</span></p>
          <p>2、新用户立减14元,首次使用银行卡支付再减2元<span>(手机客户端专享)</span></p>
          <p>3、折扣商品7.68折起<span>(手机客户端专享)</span></p>
        </dd>--%>
      </dl>


      <%--热销商品--%>
      <c:set value="${fn:length(hotSaleProducts.result)}" var="productAmount"/>
      <c:set value="${(productAmount-1)/3}" var="bannerAmount"/>
      <input type="hidden" value="${productAmount}" id="productAmount">
      <dl class="hotsale">
        <dt>门店热销商品</dt>
        <dd>
          <div class="ul-wrap">
            <c:if test="${productAmount>0}">
              <c:forEach begin="0" end="${bannerAmount}" varStatus="sta">
                <ul <c:if test="${sta.index!=0}">style="display:none"</c:if> id="ul${sta.count}" class="productUl">
                  <c:forEach items="${hotSaleProducts.result}" var="productProxy" varStatus="s" begin="${(sta.count-1)*3}" end="${(sta.count-1)*3+2}">
                    <li class="media">
                      <a href="javascript:" title="${productProxy.name}">
                        <div class="media-left">
                          <a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage['120X120']}" alt="${productProxy.name}"></a>
                        </div>
                        <div class="media-body">
                          <p><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></p>
                          <strong><small>&yen;</small><fmt:formatNumber value="${productProxy.price.unitPrice}" type="number"  pattern="#0.00#" /></strong>
                          <del>&yen;<fmt:formatNumber value="${productProxy.marketPrice}" type="number"  pattern="#0.00#" /></del>
                        </div>
                      </a>
                    </li>
                  </c:forEach>
                </ul>
              </c:forEach>
              <div class="pagination">
                  <%--<span></span>
                  <span class="active"></span>
                  <span></span>--%>
                <c:forEach begin="0" end="${bannerAmount}" varStatus="stu">
                  <c:choose>
                    <c:when test="${stu.index==0}">
                      <span class="active nav${stu.count} nav" uSec="${stu.count}" style="cursor: pointer;"></span>
                    </c:when>
                    <c:otherwise>
                      <span class="nav${stu.count} nav" uSec="${stu.count}" style="cursor: pointer;"></span>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </div>
            </c:if>
          </div>
        </dd>
      </dl>
    </div>
  </div>
</div>

<div id="containerMap" style="display: none;"></div>

<%--多规格选择弹窗--%>
<div id="modelDialog" style="display: none;">

</div>

<%--分享--%>
<div class="share-cont" style="display: none;"id="shareCont">
  <div class="s-ewm">
    <p>扫一扫,门店二维码</p>
    <c:set value="${weixinSdk:getQRCodeLongFormat2(prdHref,'')}" var="vorderaddQr"/>
    <img src="${webRoot}/QRCodeServlet?qrcodelong=${vorderaddQr}" height="180" width="180" alt="">
  </div>
  <div class="smc">
    <label>分享当前页面到：</label>
    <div id="jiathis_style_32x32" class="mc-ul ">
      <ul>
        <li><a class="jiathis_button_weixin"></a></li>
        <li><a class="jiathis_button_cqq"></a></li>
        <li><a class="jiathis_button_tqq"></a></li>
        <li><a class="jiathis_button_tsina"></a></li>
        <li><a class="jiathis_button_tsina"></a></li>
        <li><a class="jiathis_button_xiaoyou"></a></li>
        <li><a class="jiathis_button_qzone"></a></li>
        <li><a class="jiathis_button_renren"></a></li>
        <li><a class="jiathis_button_youdao"></a></li>
        <li><a class="jiathis_button_kaixin001"></a></li>
        <li><a class="jiathis_button_douban"></a></li>
        <li><a class="jiathis_button_twitter"></a></li>
      </ul>
    </div>
    <script type="text/javascript">
      var jiathis_config = {
        url: "${prdHref}",
        title: "我要分享 #${webName}-${shopProxy.shopNm}#",
        summary:"我在${webName}购物，你也来吧"
      }
    </script>
    <script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>
   <p><a class="more" onclick="$CKE.center(this);return false;"><span class="jtico jtico_jiathis">查看更多</span></a></p>
  </div>
</div>



<%--页脚--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
</body>
</html>
