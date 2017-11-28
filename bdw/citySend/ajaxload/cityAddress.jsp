<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/24
  Time: 16:33
  To change this template use File | Settings | File Templates.
  暂时无用到
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="carttype" value="${param.carttype}"/>
<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr" />
<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />
<c:set value="${bdw:findCitySendAddr(loginUser.userId,param.orgId,true)}" var="citySendAddr"/>
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
        <c:if test="${!uAddr.citySendSupport}"><span style="color: red;margin-left: 100px" class="errorTxt">不在配送范围内</span></c:if>
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
