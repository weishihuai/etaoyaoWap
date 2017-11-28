<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--根据店铺ID查询店铺详情--%>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<%--如果找不到店铺或店铺已冻结，则重定向到登录页面--%>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="${webRoot}/wap/index.ac"/>
</c:if>

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
      <title>${shop.shopNm}-${webName}</title>
      <meta content="yes" name="apple-mobile-web-app-capable">
      <meta content="yes" name="apple-touch-fullscreen">
      <meta content="telephone=no,email=no" name="format-detection">
      <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/store-detail.css" type="text/css" rel="stylesheet" />

      <script type="text/javascript">
          var dataValue = {
              webRoot:"${webRoot}",
              shopId:"${shop.shopInfId}",
              loginUserIsAttention:"${shop.loginUserIsAttention}"
          };
      </script>
      <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
      <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
      <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/storeDetail.js"></script>
  </head>
  <body>
      <div class="m-top">
          <a class="back" href="javascript:history.go(-1)"></a>
          <div class="toggle-box">店铺详情</div>
      </div>
      <div class="store-detail">
          <div class="store-dt">
              <div class="pic">
                  <a href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shop.shopInfId}">
                    <img id="shopPic" src="${shop.defaultImage["100X100"]}" alt="${shop.shopNm}">
                  </a>
              </div>
              <a href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shop.shopInfId}" class="title">${shop.shopNm}</a>
              <div class="class">
                  等级:<img src="${shop.shopLevel.levelIcon['']}" alt="">
              </div>
              <div class="sd-rt">
                  <a id="collectStore" class="<c:if test="${shop.loginUserIsAttention == 'false'}">selected</c:if>" href="javascript:void(0);" isCollect="${shop.loginUserIsAttention}">收藏</a>
                  <span id="collectByUserNumSpan" num="${shop.collectdByUserNum}">${shop.collectdByUserNum}人</span>
              </div>
          </div>
          <div class="score">
              <div class="item">
                  <span>描述相符</span>
                  <p><fmt:formatNumber value="${shop.shopRatingAvgVo.productDescrSame}" pattern="#0.0"/>分</p>
              </div>
              <div class="item">
                  <span>服务态度</span>
                  <p><fmt:formatNumber value="${shop.shopRatingAvgVo.sellerServiceAttitude}" pattern="#0.0"/>分</p>
              </div>
              <div class="item">
                  <span>物流速度</span>
                  <p><fmt:formatNumber value="${shop.shopRatingAvgVo.sellerSendOutSpeed}" pattern="#0.0"/>分</p>
              </div>
          </div>
          <div class="op-time">
              <div class="item">
                  <span>工作时间</span>
                  <p>${shop.csadOnlineDescr}</p>
              </div>
              <div class="item">
                  <span>开店日期</span>
                  <p>${shop.startDateString}</p>
              </div>
          </div>
          <div class="attestation">
              <span>认证信息</span>
              <div class="att-box">
                  <c:set value="${sdk:getShopAttestations(shop.shopInfId)}" var="shopAttestations"/>
                  <c:if test="${not empty shopAttestations}">
                      <c:forEach items="${shopAttestations}" var="attestations">
                          <img src="${attestations.logo['']}" alt=""/>
                      </c:forEach>
                  </c:if>
              </div>
          </div>
          <div class="sto-bot">
              <c:set value="${sdk:getSysParamValue('webPhone')}" var="webPhone"/>
              <c:choose>
                  <c:when test="${not empty webPhone}">
                      <a href="tel:${webPhone}" class="call-service">联系客服</a>
                  </c:when>
                  <c:otherwise>
                      <a href="javascript:void(0);" class="call-service" onclick="noCustomService()">联系客服</a>
                  </c:otherwise>
              </c:choose>
              <c:choose>
                  <c:when test="${not empty shop.tel}">
                      <a href="tel:${shop.tel}" class="call-seller">联系卖家</a>
                  </c:when>
                  <c:otherwise>
                      <c:choose>
                          <c:when test="${not empty shop.mobile}">
                              <a href="tel:${shop.mobile}" class="call-seller">联系卖家</a>
                          </c:when>
                          <c:otherwise>
                              <c:choose>
                                  <c:when test="${not empty shop.ceoMobile}">
                                      <a href="tel:${shop.ceoMobile}" class="call-seller">联系卖家</a>
                                  </c:when>
                                  <c:otherwise>
                                      <a href="javascript:void(0);" class="call-seller" onclick="noCustomService()">联系卖家</a>
                                  </c:otherwise>
                              </c:choose>
                          </c:otherwise>
                      </c:choose>
                  </c:otherwise>
              </c:choose>
          </div>
      </div>
      <div id="tipsDiv" class="rem-get" style="display: none;" ><span id="tipsSpan"></span></div>
  </body>
</html>

