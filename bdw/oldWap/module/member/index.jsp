<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/oldWap/login.ac"></c:redirect>
</c:if>
<c:set value="${sdk:findOrdinaryOrder(loginUser.userId,1,1)}" var="normalOrderPage"/>
<c:set value="${sdk:findAllIntegralOrder(loginUser.userId,1,1)}" var="integralOrderPage"/>
<c:set value="${sdk:findGroupBuyOrder(loginUser.userId,1,1)}" var="grupbuyOrderPage"/>
<c:set value="${sdk:getProductCollect(1)}" var="userProductPage"/>   <%--获取收藏商品列表--%>
<c:set value="${weixinSdk:getUnusedCouponPage(5)}" var="unusedCoupon"/>  <%--未使用的--%>
<c:set value="${bdw:getShopCollect(5)}" var="userShopCollectPage"/>   <%--获取收藏商品列表--%>
<c:set value="${bdw:getCardPage(page,1,'N')}" var="cardProxyPage"/><%--未充值的礼品卡列表--%>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>会员首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
      <META HTTP-EQUIV="pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
      <META HTTP-EQUIV="expires" CONTENT="0">
      <!-- Bootstrap -->
    <link href="${webRoot}/${templateCatalog}/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/${templateCatalog}/oldWap/module/member/statics/css/member.css" rel="stylesheet" media="screen">
	<link href="${webRoot}/${templateCatalog}/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
      <link href="" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
     <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
     <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
      <script type="text/javascript">
          var isBinding = eval(${loginUser.isBinding});
          $(document).ready(function(){
              var ua = navigator.userAgent.toLowerCase();
              //判断是否微信浏览器
              if (ua.match(/MicroMessenger/i) == "micromessenger" && !isBinding) {
                  $("#pwd_a").show();
              }
          });
      </script>
     <%--<script src="${webRoot}/template/bdw/oldWap/module/member/statics/js/index.js"></script>--%>
  </head>
  <body>

    <%--页头开始--%>
      <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=会员中心"/>
      <%--页头结束--%>

      <div class="container">
          <div class="row">
              <div class="col-xs-12">
                  <div class="neme">${loginUser.bindLoginId}<i>欢迎光临${webName}</i></div>
              </div>
          </div>
          <div class="row">
              <div class="col-xs-6">
                <div class="zhye">账户余额：<i><fmt:formatNumber value="${loginUser.prestore}" pattern="#,#00.00#"/>元</i></div>
              </div>
              <div class="col-xs-6">
                <div class="zhye">账户积分：<em><fmt:formatNumber value="${loginUser.integral}" pattern="0"/>积分</em></div>
              </div>
          </div>
      </div>

      <div class="row m_rows1" style="padding-top: 10px;">
      	  <div class="col-xs-3 text-center" >
            	<span class="badge" ><a href="javascript:void(0)"style="color: #fff;">${loginUser.unPayOrderCount}</a></span>
                <span class="m_text"><a href="${webRoot}/oldWap/module/member/myOrders.ac?status=7">待付款</a></span>
          </div>
          <div class="col-xs-3 text-center" >
                <span class="badge" ><a href="javascript:void(0)"style="color: #fff;">${loginUser.confirmedOrderCount}</a></span>
                <span class="m_text"><a href="${webRoot}/oldWap/module/member/myOrders.ac?status=3">待发货</a></span>
          </div>
          <div class="col-xs-3 text-center">
                <span class="badge" ><a href="javascript:void(0)"style="color: #fff;">${loginUser.sentOrderCount}</a></span>
                <span class="m_text"><a href="${webRoot}/oldWap/module/member/myOrders.ac?status=4">待收货</a></span>
          </div>
          <div class="col-xs-3 text-center">
                <span class="badge" ><a href="javascript:void(0)"style="color: #fff;">${loginUser.finishOrderCount}</a></span>
                <span class="m_text"><a href="${webRoot}/oldWap/module/member/myOrders.ac?status=1">已完成</a></span>
          </div>
      </div>
      <div class="container">
          <div class="row">
              <div class="col-xs-12">
                  <c:if test="${isWeixin != 'Y'}">
                      <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/myInformation.ac">
                          <i>个人资料</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                      </a>
                  </c:if>
                  <button type="button" class="btn btn-default wddd_btn"  onclick="location.href='${webRoot}/oldWap/module/member/myOrders.ac?time='+ new Date().getTime();">
                      <i>普通订单<span class="badge" style="margin-left:10px">${normalOrderPage.totalCount}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </button>
                  <button type="button" class="btn btn-default wddd_btn"  onclick="location.href='${webRoot}/oldWap/module/member/myIntegralOrders.ac?time='+ new Date().getTime();">
                      <i>积分订单<span class="badge" style="margin-left:10px">${integralOrderPage.totalCount}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </button>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/groupBuyOrders.ac">
                     <i>团购订单<span class="badge" style="margin-left:10px">${grupbuyOrderPage.totalCount}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/myAddressBook.ac">
                     <i>收货地址<span class="badge" style="margin-left:10px">${fn:length(loginUser.receiverAddress)}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/myFavorite.ac">
                     <i>商品收藏<span class="badge" style="margin-left:10px">${userProductPage.totalCount}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/shopFavorite.ac">
                      <i>店铺收藏<span class="badge" style="margin-left:10px">${userShopCollectPage.totalCount}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/myPreStore.ac">
                      <i>我的余额</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/myIntegral.ac">
                      <i>我的积分</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/myCoupon.ac">
                      <i>购物券<span class="badge" style="margin-left:10px">${unusedCoupon.totalCount}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/myTrophy.ac">
                      <i>我的奖品</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/myCard.ac">
                      <i>礼品卡充值<span class="badge" style="margin-left:10px">${cardProxyPage.totalCount}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <c:if test="${isWeixin != 'Y'}">
                      <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/xgmm.ac">
                          <i>密码修改</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                      </a>
                  </c:if>

                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/afterSaleService/saleServiceApply.ac">
                      <i>售后服务</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>
                  <%--<c:if test="${not empty loginUser.bytUserId}">
                      <a type="button" class="btn btn-default wddd_btn" href="http://app.xiaoyangbao.net/zbtong/#/shopping/home">
                          <i>怡保通商城</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                      </a>
                  </c:if>--%>

                  <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/mySystemMsg.ac">
                      <i>系统消息<span class="badge" style="margin-left:10px">${fn:length(loginUser.userMsgListBySystem)}</span></i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>

                 <%-- <a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/integralList.ac">
                     <i>积分兑换</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>--%>

                 <%-- <a id="pwd_a" type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/boundAccount.ac">
                      <i>绑定会员</i><span class="glyphicon glyphicon-chevron-right jt"></span>
                  </a>--%>


                  <%--<a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/vgetcoupon.ac">--%>
                      <%--<i>购物券领取</i><span class="glyphicon glyphicon-chevron-right jt"></span>--%>
                  <%--</a>--%>


                  <%--<a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/vLuckyDraw.ac">--%>
                      <%--<i>大转盘</i><span class="glyphicon glyphicon-chevron-right jt"></span>--%>
                  <%--</a>--%>

                  <%--<a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/vScratchCard.ac">--%>
                      <%--<i>刮刮卡</i><span class="glyphicon glyphicon-chevron-right jt"></span>--%>
                  <%--</a>--%>

                  <%--<a type="button" class="btn btn-default wddd_btn" href="${webRoot}/oldWap/module/member/vGoldenEggs.ac">--%>
                      <%--<i>砸金蛋</i><span class="glyphicon glyphicon-chevron-right jt"></span>--%>
                  <%--</a>--%>
              </div>
          </div>
      </div>
      <c:if test="${not empty loginUser.bytUserId}">
      <%--页脚开始--%>
          <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
      <%--页脚结束--%>
      </c:if>
      <div style="display: none">${now}</div>
  </body>
</html>

