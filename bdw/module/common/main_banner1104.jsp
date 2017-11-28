<%--
  Created by IntelliJ IDEA.
  User: hj
  Date: 2015/10/21
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<div class="focus">
  <div class="main-banner">
    <div class="m-b-con frameEdit" frameInfo="yz_main_banner|1900X440">
      <div class="cont">
        <ul id="roteAdv">
          <c:forEach items="${sdk:findPageModuleProxy('yz_main_banner').advt.advtProxy}" var="bannerAdvt" varStatus="s">
            <li id="${s.count}">
              <a href="${bannerAdvt.link}" target="_blank" title="${bannerAdvt.title}"><img src="${bannerAdvt.advUrl}" height="440" width="1900" alt="${bannerAdvt.title}"></a>
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>
    <div class="slider" id="nav" style="width:${fn:length(sdk:findPageModuleProxy('yz_main_banner').advt.advtProxy) * 20}px" ></div>
  </div>
  <div class="w">

    <!-- 促销活动 -->
    <div class="tabs">
      <div class="tab-tit frameEdit" frameInfo="yz_banner_right_sale">
        <c:forEach items="${sdk:findPageModuleProxy('yz_banner_right_sale').links}" var="sale_title" varStatus="s" end="1">
          <a <c:if test="${s.count == 1}">class="cur"</c:if> href="javascript:void(0)" title="${sale_title.title}" tab="${s.count}" >${sale_title.title}</a>
        </c:forEach>
      </div>
      <div class="tab-cont">
        <div class="tab-panel frameEdit" id="tab-cont1" frameInfo="yz_banner_right_sale_links1">
          <c:forEach items="${sdk:findPageModuleProxy('yz_banner_right_sale_links1').links}" var="sale_link">
            <a class="elli" href="${sale_link.link}" title="${sale_link.title}" target="_blank">${sale_link.title}</a>
          </c:forEach>
        </div>
        <div class="tab-panel frameEdit" style="display: none" id="tab-cont2" frameInfo="yz_banner_right_sale_links2">
          <c:forEach items="${sdk:findPageModuleProxy('yz_banner_right_sale_links2').links}" var="sale_link">
            <a class="elli" href="${sale_link.link}" title="${sale_link.title}" target="_blank">${sale_link.title}</a>
          </c:forEach>
        </div>
      </div>
    </div>
    <div class="side-banner frameEdit" frameInfo="yz_banner_right_advt|240X260">
      <c:forEach items="${sdk:findPageModuleProxy('yz_banner_right_advt').advt.advtProxy}" var="bannerAdvt" varStatus="s" end="0">
        ${bannerAdvt.htmlTemplate}
      </c:forEach>
    </div>
  </div>
</div>