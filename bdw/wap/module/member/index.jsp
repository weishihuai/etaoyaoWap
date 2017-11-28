<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.commons.global.Global" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>

<c:set value="${sdk:getPromoteMemberByLoginUserId()}" var="memberInfo"/><!--会员信息，通过登录用户的id获得推广员对象-->
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>会员首页-${webName}</title>
      <meta content="yes" name="apple-mobile-web-app-capable">
      <meta content="yes" name="apple-touch-fullscreen">
      <meta content="telephone=no,email=no" name="format-detection">
      <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
      <link href="${webRoot}/template/bdw/wap/module/member/statics/css/vip-index.css" type="text/css" rel="stylesheet" />

      <script type="text/javascript">
          var dataValue={
              webRoot:"${webRoot}"
          };
      </script>
      <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
      <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
      <script src="${webRoot}/template/bdw/wap/module/member/statics/js/index.js"></script>
  </head>
  <body>
  <div class="vip-index-main">
      <div class="vip-index-head">
          <%--<div class="info-link"><em></em></div>--%>
          <div class="info-link" onclick="window.location.href='${webRoot}/wap/module/member/myMessage.ac'"></div>
          <c:set value="${loginUser.icon['100X100']}" var="userImageUrl"/>
          <c:choose>
              <c:when test="${empty userImageUrl or (userImageUrl eq '/template/bdw/statics/images/noPic_100X100.jpg')}">
                  <a href="${webRoot}/wap/module/member/myInformation.ac"><img class="vip-logo" src="${webRoot}/template/bdw/wap/statics/images/wutupain_160x160.png" alt=""></a>
              </c:when>
              <c:otherwise>
                  <a href="${webRoot}/wap/module/member/myInformation.ac"><img class="vip-logo" src="${userImageUrl}" alt=""></a>
              </c:otherwise>
          </c:choose>
          <p class="vip-number">${loginUser.bindLoginId}</p>
          <p class="vip-grade">${loginUser.level}</p>
          <p class="integral" style="display: none">签到赚积分</p>
      </div>

      <div class="collect-box">
          <p onclick="window.location.href='${webRoot}/wap/module/member/productCollect.ac'"><span>${loginUser.productCollectCount}</span>商品收藏</p>
          <p onclick="window.location.href='${webRoot}/wap/module/member/shopCollect.ac'"><span>${loginUser.shopCollectCount}</span>店铺收藏</p>
          <p onclick="window.location.href='${webRoot}/wap/module/member/storeCollect.ac'"><span>${loginUser.storeCollectCount}</span>门店关注</p>
      </div>

      <div class="order-box">
          <div class="dt"><a style="color: #051B28" href="${webRoot}/wap/module/member/myOrders.ac">我的订单<span>查看全部订单</span></a></div>
          <div class="dd clearfix">
              <p onclick="window.location.href='${webRoot}/wap/module/member/myOrders.ac?status=7'">
                  <c:if test="${loginUser.unPayOrderCount > 0}"><span>${loginUser.unPayOrderCount}</span></c:if>待付款
              </p>
              <p onclick="window.location.href='${webRoot}/wap/module/member/myOrders.ac?status=3'">
                  <c:if test="${loginUser.confirmedOrderCount > 0}"><span>${loginUser.confirmedOrderCount}</span></c:if>待发货
              </p>
              <p onclick="window.location.href='${webRoot}/wap/module/member/myOrders.ac?status=4'">
                  <c:if test="${loginUser.sentOrderCount > 0}"><span>${loginUser.sentOrderCount}</span></c:if>待收货
              </p>
              <p onclick="window.location.href='${webRoot}/wap/module/member/myOrders.ac?status=8'">
                  <c:if test="${loginUser.commentOrderCount > 0}"><span>${loginUser.commentOrderCount}</span></c:if>待评价
              </p>
              <p onclick="window.location.href='${webRoot}/wap/module/member/returnList.ac'">退款/售后</p>
          </div>
      </div>
      <div class="assets-box">
          <div class="dt">我的资产</div>
          <div class="dd clearfix">
              <p onclick="window.location.href='${webRoot}/wap/module/member/accountIntegral.ac'"><span><fmt:formatNumber value="${loginUser.integral}" type="number" pattern="0"/></span>账户积分</p>
              <p onclick="window.location.href='${webRoot}/wap/module/member/myCoupon.ac'"><span><fmt:formatNumber value="${fn:length(loginUser.unusedCoupon)}" type="number" pattern="#"/></span>优惠券</p>
              <p onclick="window.location.href='${webRoot}/wap/module/member/myGiftCards.ac'"><span>${loginUser.userCanUseGiftCardsNum}</span>礼品卡</p>
              <p onclick="window.location.href='${webRoot}/wap/module/member/accountBalance.ac'"><span><fmt:formatNumber value="${loginUser.prestore}" type="number" pattern="#,#00.00#"/></span>账户余额</p>
          </div>
      </div>
      <div class="item-link-box" style="display: none">
          <p>我的试用</p>
          <p>我的委托购药</p>
      </div>

      <div class="item-link-box">
          <p onclick="window.location.href='${webRoot}/wap/module/member/addrManage.ac'" class="addr-manage">地址管理</p>
          <p style="display: none">处方笺管理</p>
          <p style="display: none">安全中心</p>
      </div>
      <div class="item-link-box">
          <p onclick="window.location.href='${webRoot}/wap/module/member/feedbackList.ac'" class="advice">投诉/建议</p>

          <!--申请成为推广员-->
          <c:choose>
              <c:when test="${loginUser.isPopularizeMan eq 'Y'}">
                  <p onclick="window.location.href='${webRoot}/wap/module/member/cps/cpsIndex.ac'" class="cps-promotion">推广赚钱</p>
              </c:when>
              <c:otherwise>
                  <c:choose>
                      <c:when test="${not empty memberInfo and memberInfo.approveStat eq 0}">
                          <p onclick="window.location.href='${webRoot}/wap/module/member/cps/myPromoteRegisterFirstStep.ac'" class="cps-promotion">推广赚钱</p>
                      </c:when>
                      <c:otherwise>
                          <p onclick="window.location.href='${webRoot}/wap/module/member/cps/myPromoteRegisterFirstStep.ac'" class="cps-promotion">推广赚钱</p>
                      </c:otherwise>
                  </c:choose>
              </c:otherwise>
          </c:choose>

          <c:set value="${sdk:getSysParamValue('webPhone')}" var="webPhone"/>
          <c:set value="${sdk:getSysParamValue('workTime')}" var="workTime"/>
          <c:choose>
              <c:when test="${not empty webPhone}">
                  <p class="contact"><a href="tel:${webPhone}">联系我们<span>服务时间  ${workTime}</span></a></p>
              </c:when>
              <c:otherwise>
                  <p class="contact"><a href="javascript:void(0);" onclick="noCustomService()">联系我们<span>服务时间  ${workTime}</span></a></p>
              </c:otherwise>
          </c:choose>
      </div>

      <div class="copyright frameEdit" frameInfo="wap_member_index_copyright">
          <c:if test="${not empty sdk:findPageModuleProxy('wap_member_index_copyright').pageModuleObjects[0]}">
              ${sdk:findPageModuleProxy('wap_member_index_copyright').pageModuleObjects[0].userDefinedContStr}
          </c:if>
      </div>
      <%--<div class="bottom-logo"></div>--%>
  </div>

  <div id="tipsDiv" class="rem-get" style="display: none;" ><span id="tipsSpan"></span></div>
  <%--底部导航--%>
  <c:import url="../../footer.jsp"/>
  </body>
  <f:FrameEditTag />
</html>

