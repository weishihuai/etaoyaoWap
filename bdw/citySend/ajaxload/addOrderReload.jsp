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
<c:set value="${param.orgId}" var="orgId"/>
<c:set var="carttype" value="${param.carttype}"/>
<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr" />
<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />
<%-- 如果地址只有一个的情况下，设置这个地址为默认默认地址 --%>
<c:if test="${fn:length(loginUser.addr) == 1}">
  <%
    UserProxy loginUser = (UserProxy) pageContext.getAttribute("loginUser");
    ServiceManager.receiverAddrService.updateReceiverAddrDefaultId(Integer.parseInt(loginUser.getReceiverAddress().get(0).getReceiveAddrId()));
  %>
</c:if>

<c:set value="${bdw:findCitySendAddr(loginUser.userId,orgId,true)}" var="citySendAddr"/>
<%--检查购物车配送 优先放在取出购物车之前--%>
${sdk:checkCartDelivery(carttype)}

${sdk:saveOrderParam(carttype)}
<c:set var="mdCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>
<c:set var="mdCartNum" value="${mdCartProxy.selectedCartItemNum}" />

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
    <select class="saveDelivery delivery"  carttype="${carttype}" orgid="${orgId}">
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
          <a class="fr" href="javascript:" id="cancelSelectedCoupon" onclick="clearCoupon('${carttype}','${usedCoupon.couponId}','${orgId}')">取消使用</a>
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