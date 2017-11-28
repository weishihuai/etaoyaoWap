<%@ page import="com.iloosen.imall.sdk.user.proxy.UserProxy" %>
<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/22
  Time: 13:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getSysParamValue('key_tengxunMap')}" var="mapKey"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
  <c:redirect url="${webRoot}/login.ac"/>
</c:if>
<c:set value="${bdw:getShopInfProxyByOrgId(param.orgId)}" var="storeProxy"/>
<c:if test="${empty storeProxy || storeProxy.isFreeze == 'Y'}">
  <c:redirect url="/storeError.ac"></c:redirect>
</c:if>
<c:set value="${storeProxy.sysOrgId}" var="orgId"/>
<c:set var="carttype" value="store"/>
<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr" />
<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />
<%--默认商品图片--%>
<c:set var="noProductPic" value="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg"/>
<%-- 如果地址只有一个的情况下，设置这个地址为默认默认地址 --%>
<c:if test="${fn:length(loginUser.addr) == 1}">
  <%
    UserProxy loginUser = (UserProxy) pageContext.getAttribute("loginUser");
    ServiceManager.receiverAddrService.updateReceiverAddrDefaultId(Integer.parseInt(loginUser.getReceiverAddress().get(0).getReceiveAddrId()));
  %>
</c:if>

<c:set value="${bdw:findCitySendAddr(loginUser.userId,param.orgId,true)}" var="citySendAddr"/>
<%--检查购物车配送 优先放在取出购物车之前--%>
${sdk:checkCartDelivery(carttype)}

<c:set var="mdCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>
<c:set var="mdCartNum" value="${mdCartProxy.selectedCartItemNum}" />
${sdk:saveOrderParam(carttype)}
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title>淘药店-${webName}</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="${webRoot}/template/bdw/citySend/statics/css/addOrder.css">

  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript">
    var webParams = {
      webRoot: '${webRoot}',
      orgId: '${param.orgId}',
      isCod: '${isCod}',
      isCodStr:'${isCodStr}',
      lat: '${param.lat}',
      lng: '${param.lng}',
      userId:'${loginUser.userId}',
      carttype:'${carttype}'
    };

    var orderData = {isCod:${isCod},productTotal:${mdCartNum}};
    var invalidCartItems = [];

  </script>
  <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/jquery.ld.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/external/jquery.cookie.js"></script>
  <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-powerFloat/js/jquery-powerFloat.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/citySend/statics/js/addOrder.js"></script>
</head>
<body>

<%--同城送头部--%>
<c:import url="/template/bdw/citySend/common/citySendTop.jsp?p=order"/>

<!--主体-->
<div class="main-bg">
  <div class="main">
    <div class="breadcrumb">
      <ul>
        <li>
          <a href="${webRoot}/citySend/storeDetail.ac?orgId=${storeProxy.sysOrgId}">${storeProxy.shopNm}</a>
        </li>
        <li>确认购买</li>
      </ul>
    </div>
    <div class="main-side" id="leftProductDetail">
      <span class="bg"></span>
      <dl>
        <dt>
        <h3>购物清单</h3>
        <a href="${webRoot}/citySend/storeDetail.ac?orgId=${storeProxy.sysOrgId}" title="返回门店">返回门店修改</a>
        </dt>
        <dd>
          <ul>
            <c:forEach items="${mdCartProxy.cartItemProxyList}" var="ocartItemProxy">
              <c:set var="ocurHandler" value="${ocartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
              <c:set var="oitemKey" value="${ocartItemProxy.itemKey}"/>
              <c:set var="oisSelected" value="${ocartItemProxy.itemSelected}"/>
              <c:set var="opromotionType" value="${ocartItemProxy.promotionType}"/>
              <c:if test="${ocartItemProxy.itemSelected}">
                <li class="media">
                  <a href="${webRoot}/product-${ocartItemProxy.productId}.html">
                    <div class="media-left">
                      <c:choose>
                        <c:when test="${not empty ocartItemProxy.productProxy.defaultImage['80X80']}">
                          <img src="${ocartItemProxy.productProxy.defaultImage["80X80"]}" alt="${ocartItemProxy.name}" width="80px" height="80px">
                        </c:when>
                        <c:otherwise>
                          <img src="${noProductPic}" alt="${ocartItemProxy.name}" width="80px" height="80px">
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </a>
                  <div class="media-body">
                    <p class="media-heading">
                      <c:if test="${opromotionType == 'COMBINED_PRODUCT'}">
                        <label style="color:red;">[套餐]</label>
                      </c:if>
                      <c:if test="${opromotionType == 'PRESENT'}">
                        <label style="color:red;">[赠品]</label>
                      </c:if>
                      <a href="${webRoot}/product-${ocartItemProxy.productId}.html">
                          ${ocartItemProxy.name}
                      </a>
                    </p>
                    <c:if test="${null != ocartItemProxy.combos}">
                      <p>
                        <c:forEach items="${ocartItemProxy.combos}"  var="combo">
                          <a href="${webRoot}/product-${combo.productId}.html">
                            <h4><img width="30" height="30" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/>${combo.name}<span style="line-height: 22px;">× ${combo.quantity}</span></h4>
                          </a>
                        </c:forEach>
                      </p>
                    </c:if>
                    <c:if test="${null != ocartItemProxy.presents}">
                      <c:forEach items="${ocartItemProxy.presents}"  var="combo">
                        <a href="${webRoot}/product-${combo.productId}.html">
                          <h4><img width="30" height="30" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/><span style="color:red;">[赠品]</span>${combo.name}<span style="line-height: 22px;">× ${combo.quantity}</span></h4>
                        </a>
                      </c:forEach>
                    </c:if>
                    <p>
                      <em>x${ocartItemProxy.quantity}</em>
                    </p>
                    <p>
                      <c:if test="${not empty ocartItemProxy.specName}">
                        <span>规格: ${ocartItemProxy.specName}</span>
                      </c:if>
                      <em>&yen;${ocartItemProxy.productUnitPrice}</em>
                    </p>
                  </div>
                </li>
              </c:if>
            </c:forEach>
          </ul>
          <div class="total">
            <p>共${mdCartNum}件商品</p>
            <p>
              <span class="fl">商品总金额</span>
              <em class="fr">&yen;&nbsp;${mdCartProxy.productTotalAmount}</em>
            </p>
          </div>
        </dd>
      </dl>
    </div>
    <div class="main-content" id="mainContent">
      <!-- 收货地址 -->
      <dl class="address">
        <dt>
        <h3>收货地址</h3>
        <a href="javascript:" title="添加新地址" id="addNewAddresss">[添加新地址]</a>
        </dt>
        <dd id="address-ul">
          <ul>
            <c:forEach items="${citySendAddr}" var="uAddr" varStatus="stus">
              <li class="item addr${stus.count} uaddItem <c:if test="${uAddr.isDefault == 'Y'}">active</c:if>" <c:if test="${stus.count > 2}">style="display: none;" </c:if> receiverAddrId="${uAddr.receiveAddrId}" orgid="${param.orgId}">
                <i class="item-img"></i>
                <div class="item-opera">
                  <a href="javascript:" id="updateAddress" receiverAddrId="${uAddr.receiveAddrId}" orgid="${param.orgId}">修改</a>
                  <a href="javascript:" id="deleteAddress" receiverAddrId="${uAddr.receiveAddrId}" orgid="${param.orgId}">删除</a>
                </div>
                <h4 class="item-tit">
                  <span>${uAddr.name}</span>&emsp;&emsp;
                  <span>${uAddr.mobile}</span>
                  <c:if test="${uAddr.isDefault == 'Y' && !uAddr.citySendSupport}"><span style="color: red;margin-left: 100px;font-family:'楷体'" class="errorTxt">不在配送范围内</span></c:if>
                </h4>
                <p class="item-cont">${uAddr.addressPath}&nbsp;&nbsp;${uAddr.addressStr}</p>
              </li>
            </c:forEach>
          </ul>
          <p class="showAddr">
            <a class="btn-link" href="javascript:" id="showMoreAddress">显示全部地址&nbsp;<i class="icon-angel-down"></i></a>
          </p>
          <p class="hideAddr" style="display: none;">
            <a class="btn-link" href="javascript:" id="hideMoreAddress">收起&nbsp;<i class="icon-angel-up"></i></a>
          </p>
        </dd>
      </dl>

      <!-- 支付方式 -->
      <%--<dl class="payment">
        <dt>
        <h3>支付方式</h3>
        </dt>
        <dd>
          <span class="item active" id="onlinePay" isOnlinePay="Y">在线支付</span>
            &lt;%&ndash; <span class="item">货到付款</span>&ndash;%&gt;&lt;%&ndash;todo lhw,因货到付款较为复杂，暂时隐藏&ndash;%&gt;
        </dd>
      </dl>--%>

      <%--配送方式--%>
      <dl class="deliveryRule">
        <dt>
        <h3>配送方式</h3>
        </dt>
        <dd id="rule">
          <c:set value="${sdk:getDeliveryRuleList(carttype,orgId ,isCod)}" var="deliveryRuleList"/>
          <select class="saveDelivery delivery"  carttype="${carttype}" orgid="${orgId}" <%--class="delivery"--%>>
            <option value="0">请选择配送方式</option>
            <c:forEach items="${deliveryRuleList}" var="rule">
              <option value="${rule.deliveryRule.deliveryRuleId}" data-company-id="${rule.deliveryLogisticsCompanyId}"
                      <c:if test="${mdCartProxy.deliveryRuleId == rule.deliveryRule.deliveryRuleId}">selected="selected"</c:if> >${rule.deliveryRuleNm}</option>
            </c:forEach>
          </select>
        </dd>
      </dl>

      <!-- 现金账户 -->
      <c:set value="${sdk:findUserCouponList(carttype, orgId)}" var="userCouponList"/> <%--可以使用的购物劵--%>
      <c:set value="${sdk:getCurrSelectCoupons(carttype,orgId)}" var="useCoupons"/> <%--已经选择的购物劵--%>
      <c:set value="${useCoupons[0]}" var="usedCoupon"/> <%--已经选择的购物劵--%>
      <dl class="cash-account">
        <c:if test="${not empty userCouponList && not empty useCoupons}">
          <dt>
          <h3>现金账户</h3>
          </dt>
        </c:if>
        <dd>
          <c:if test="${not empty userCouponList}">
            <p class="sCoupon">
              <span class="toggle" id="showCoupon" couponNum="${fn:length(userCouponList)}"><i class="icon-plus"></i>&emsp;购物券 <small> (${fn:length(userCouponList)}张可用)</small></span>
            </p>
          </c:if>
          <c:if test="${not empty usedCoupon}">
            <p class="hCoupon">
              <span class="toggle" id="hideCoupon"><i class="icon-minus"></i>&emsp;赠券抵消部分总额  <small> (${fn:length(useCoupons)}张已用)</small></span>
            </p>
          </c:if>
          <c:if test="${not empty userCouponList}">
            <div class="ticket" id="allUserCoupon" style="display: none;">
              <div class="ticket-tit">
                <span class="th th-name">优惠券</span>
                <span class="th th-price">面额</span>
                <span class="th th-date">有效期</span>
              </div>
              <div class="ticket-cont" id="useCoupon">
                <ul>
                  <c:forEach items="${userCouponList}" var="couponProxy">
                    <li>
                      <div class="td td-name">${couponProxy.couponNum}</div>
                      <div class="td td-price">&yen;${couponProxy.amount}</div>
                      <div class="td td-date"><fmt:formatDate value="${couponProxy.startTime}" pattern="yyyy-MM-dd"/> 至 <fmt:formatDate value="${couponProxy.endTime}" pattern="yyyy-MM-dd"/></div>
                      <div class="td td-op">
                        <c:choose>
                          <c:when test="${usedCoupon.couponId eq couponProxy.couponId}">
                            <a href="javascript:void(0);">已使用</a>
                          </c:when>
                          <c:otherwise>
                            <a href="javascript:" id="useCp${couponProxy.couponId}" onclick="useCoupon('${carttype}','${couponProxy.couponId}','${orgId}');">立即使用</a>
                          </c:otherwise>
                        </c:choose>
                      </div>
                    </li>
                  </c:forEach>
                </ul>
              </div>
            </div>
          </c:if>
          <c:if test="${not empty usedCoupon}">
            <div class="ticket" id="usedCoupon">
              <div class="ticket-ft">
                <p class="fl">已使用赠券抵扣&emsp;<span>&yen;${usedCoupon.amount}</span>&emsp;订单总额</p>
                <a class="fr" href="javascript:" id="cancelSelectedCoupon" onclick="clearCoupon('${carttype}','${couponProxy.couponId}','${orgId}')">取消使用</a>
              </div>
            </div>
          </c:if>

        </dd>
      </dl>

      <!-- 发票 -->
      <div class="invoice">
        <div class="toggle-title">
          <a href="javascript:" id="showInvoice"></a>
          <span class="hoverWord">发票</span>
          <div class="in-tips"><!--鼠标经过加class hover-->
            <p><i></i>温馨提示：发票的开票金额不包括优惠券、积分。</p>
          </div>
          <%--发票内容--%>
          <div style="margin-left: 100px;display: none;" id="sinvoice">
            <p></p>
          </div>
        </div>
        <div class="inv-wrap" id="invoiceDetail" style="display: none;">
          <div class="inv-title">
            <span class="label">发票抬头：</span>
            <a href="javascript:" class="sel" id="personal" invoiceTitleType="0">个人</a>
            <a href="javascript:" id="company" invoiceTitleType="1">公司</a>
            <input type="text" placeholder="请输入公司名称" id="cpyName" style="display: none;">
          </div>
          <div class="inv-cont">
            <span class="label">发票内容：</span>
            <div class="down-menu"><!-- 鼠标点击加class:pull -->
              <a href="javascript:" class="down-switch" id="downSwith">
                <label invoticeValue="" class="selectedInvoice">发票内容</label>
                <i class="arrow"></i>
              </a>
              <div class="down-data" style="display: none;">
                <ul class="data-list" id="dataList">
                  <li cont="明细"><a href="javascript:">明细</a></li>
                  <li cont="办公用品"><a href="javascript:">办公用品</a></li>
                  <li cont="电脑配件"><a href="javascript:">电脑配件</a></li>
                  <li cont="耗材"><a href="javascript:">耗材</a></li>
                  <li cont="不选"><a href="javascript:">不选</a></li>
                </ul>
              </div>
            </div>
          </div>
          <a href="javascript:" class="inv-btn" id="saveInvoice" titleType="0" invoiceContent="">保存发票信息</a>
        </div>
      </div>

      <!-- 订单备注 -->
      <div class="remark">
        <span>订单备注：</span>
        <input class="inp-txt" type="text" placeholder="请输入短备注" id="orderRemark" carttype="${carttype}" orgid="${orgId}" value="${mdCartProxy.remark}">
      </div>

      <div class="total-box">
        <p>
          <span class="lab">商品总金额：</span>
          <span class="val">&yen;${mdCartProxy.productTotalAmount}</span>
        </p>
        <p>
          <span class="lab">优惠金额：</span>
          <span class="val">&yen;<b id="discountAmount">${mdCartProxy.discountAmount}</b></span>
        </p>
        <p>
          <span class="lab">运费：</span>
          <span class="val">&yen;<b id="freightAmount">${mdCartProxy.freightAmount}</b></span>
        </p>
        <p>
          <span class="lab">赠送积分：</span>
          <span class="val"><b id="integral">${mdCartProxy.obtainTotalIntegral}</b></span>
        </p>

        <div class="total">&yen;<b id="orderTotalAmout">${mdCartProxy.orderTotalAmount}</b></div>
      </div>
      <button class="btn-submit submitOrder" type="button" style="cursor: pointer;">提交订单</button>
    </div>
  </div>
</div>

<%-- 点击提交订单时提交的表单 --%>
<form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
  <input name="orderSourceCode" value="0" type="hidden"/>
  <input name="processStatCode" value="0" type="hidden"/>
  <input name="type" id="type" value="${carttype}" type="hidden"/>
  <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="N" type="hidden"/>
  <input id="invoiceEntNm" name="invoice.invoiceEntNm" type="hidden"/>
  <input id="invoiceTitle" name="invoice.invoiceTitle" type="hidden" />
  <input id="invoiceCont" name="invoice.invoiceCont" type="hidden" />
  <input id="remark" name="remark" type="hidden" value="${mdCartProxy.remark}"/>
  <input name="isCod" value="${empty param.isCod ?  "N" : param.isCod}" type="hidden"/>
  <input name="sysOrgId" value="${orgId}" type="hidden"/>
</form>


<div class="overlay" style="display: none;" id="addrAddayer">
  <div class="add-box">
    <div class="mt">
      <span id="layerTitle">添加收货地址</span>
      <a href="javascript:void(0);" class="close" id="closeAddAddrLayer">&times;</a>
    </div>
    <div class="mc">
      <div class="mc-md cur">
        <div class="md-td" id="receiverAddrMap">
        </div>
        <div class="md-td">
          <input id="receiveAddrId" name="receiveAddrId" type="hidden"/>
          <input type="hidden" id="receiverAddrLat" value="">
          <input type="hidden" id="receiverAddrLng" value="">
          <div class="td-sel elli">
            <span><i style="margin-right: 5px; color: #e5151f;">*</i>所在地区</span>
            <select class="addressOrderSelect" id="receiverProvince" name="" onchange="proviceSelected(this);">
              <option>请选择</option>
            </select>
            <select class="addressOrderSelect" id="receiverCity" name="" onchange="citySelected(this);">
              <option>请选择</option>
            </select>
            <select class="addressOrderSelect" id="receiverZone" name="zoneId" onchange="areaSelected(this)">
              <option>请选择</option>
            </select>
            <b style="margin-left: 5px;color: #e5151f;display: none;" class="newAlert3"></b>
          </div>
          <div class="td-add">
            <span><i style="margin-right: 5px; color: #e5151f;">*</i>配送地址</span>
            <textarea placeholder="无需重复填写省市区，小于125个字" id="receiverAddress" onblur="analyzeAddress()"></textarea>
            <b style="margin-left: 5px;color: #e5151f;display: none;" class="newAlert4"></b>
          </div>
          <div class="td-item">
            <span><i style="margin-right: 5px; color: #e5151f;">*</i>收货人</span>
            <input type="text" name="name" id="receiverName" onblur="userNameTri();"/>
            <b style="margin-left: 5px;color: #e5151f;display: none;" class="newAlert1"></b>
          </div>
          <div class="td-item" style="height: 50px">
            <span><i style="margin-right: 5px; color: #e5151f;">*</i>手机号码</span>
            <input type="text" name="mobile" id="receiverMobile" onblur="userMobileTri();"/>
            <b style="margin-left: 5px;color: #e5151f;display: none;" class="newAlert2"></b>
          </div>
          <div class="td-btn">
            <a href="javascript:void(0);" class="confirm" id="saveReceiverAddrBtn">保存</a>
            <a href="javascript:void(0);" class="cancel" id="cancelAddrBtn">取消</a>
          </div>
        </div>
      </div>
      <%--  <div class="mc-bot"><a href="##" class="disabled">确定</a></div>--%>
    </div>
  </div>
</div>
</body>
</html>