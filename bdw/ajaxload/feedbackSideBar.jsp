<%--
  Created by IntelliJ IDEA.
  User: Arthur Tsang
  Date: 2015/3/11 0011
  Time: 下午 8:26
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/myComplaint_sidebar.js"></script>
<c:set value="${empty param.type ? 'normal' : param.type}" var="type"/>
<c:set value="${empty param.handler ? 'sku' : param.handler}" var="handler"/>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<c:if test="${not empty user}">

</c:if>


<div class="dd" style="display: block">
  <div class="title">用户反馈<em></em></div>
  <div class="ly-jy-ts">
    <p class="active">留言</p>
    <p>建议</p>
    <p>投诉</p>
    <em class="icon-b"></em>
  </div>
  <div class="ly-mbar dd-mbar">
    <p>问题描述：</p>
    <textarea id="commentContSidebar"></textarea>
    <a class="submit-btn" href="#" id="publishSidebar" onclick="sendComment(this)">提交反馈</a>
  </div>
  <div style="display: none;" class="jy-mbar dd-mbar">
    <p>问题描述：</p>
    <textarea  id="suggestSidebar"></textarea>
    <a class="submit-btn" href="#" onclick="sendSuggestComment()">提交反馈</a>
  </div>
  <div style="display: none;" class="ts-mbar dd-mbar">
    <p>问题描述：</p>
    <textarea id="complainSidebar"></textarea>
    <a class="submit-btn" href="#" onclick="sendComplainComment()" >提交反馈</a>
  </div>
</div>
<div class="icon-lx icon-lx2" style="display: block"></div>