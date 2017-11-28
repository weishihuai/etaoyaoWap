<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/21
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<div class="recommend">
  <h3 class="frameEdit" frameInfo="yz_recommend_title">
    <c:forEach items="${sdk:findPageModuleProxy('yz_recommend_title').links}" var="recommend_title" end="0">
      ${recommend_title.title}
    </c:forEach>
  </h3>
  <div class="r-cont">

    <!-- 大图 -->
    <div class="main-r frameEdit" frameInfo="yz_recommend_big|400X240">
      <c:forEach items="${sdk:findPageModuleProxy('yz_recommend_big').advt.advtProxy}" var="bannerAdvt" varStatus="s" end="0">
        ${bannerAdvt.htmlTemplate}
      </c:forEach>
    </div>

    <!-- 中图 -->
    <ul class="extra-r frameEdit" frameInfo="yz_recommend_center|200X240">
      <c:forEach items="${sdk:findPageModuleProxy('yz_recommend_center').advt.advtProxy}" var="bannerAdvt" varStatus="s" end="3">
        ${bannerAdvt.htmlTemplate}
      </c:forEach>
    </ul>

    <!-- 小图 -->
    <ul class="brands-r frameEdit" frameInfo="yz_recommend_small|240X100">
      <c:forEach items="${sdk:findPageModuleProxy('yz_recommend_small').advt.advtProxy}" var="bannerAdvt" varStatus="s" end="4">
        <a target="_blank" title="${bannerAdvt.title}" href="${bannerAdvt.link}" style="float: left;">
          <img alt="${bannerAdvt.title}" class="lazy" data-original="${bannerAdvt.advUrl}"/>
        </a>
      </c:forEach>
    </ul>
  </div>
</div>
