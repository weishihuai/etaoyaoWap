
<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-25
  Time: 下午5:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>


<c:if test="${isWeixin!='Y'}">
<div class="col-xs-12 frameEdit" frameInfo="bottom_link1_mobile" style="height: 30px; line-height: 30px; text-align: center;">

    <c:forEach items="${sdk:findPageModuleProxy('bottom_link1_mobile').links}" var="pageLinks" end="0" varStatus="s">
        <a href="${pageLinks.link}" class="cur">${pageLinks.title}</a>
    </c:forEach>
    <c:forEach items="${sdk:findPageModuleProxy('bottom_link1_mobile').links}" var="pageLinks" begin="1" end="1" varStatus="s">
        <a href="${pageLinks.link}">${pageLinks.title}</a>
    </c:forEach>
    <%--<a href="#" class="cur">触摸版</a>--%>
    <%--<a href="#">电脑版</a>--%>

</div>
<div class="col-xs-12 frameEdit" frameInfo="bottom_link2_mobile" style="height: 30px; line-height: 30px; text-align: center;">
    <c:forEach items="${sdk:findPageModuleProxy('bottom_link2_mobile').links}" var="pageLinks" end="0" varStatus="s">
        ${pageLinks.title}
    </c:forEach>
</div>
<div class="col-xs-12 frameEdit" frameInfo="bottom_link3_mobile" style="height: 30px; line-height: 30px; text-align: center;height: 30px;">
    <c:forEach items="${sdk:findPageModuleProxy('bottom_link3_mobile').links}" var="pageLinks" end="0" varStatus="s">
        ${pageLinks.title}
    </c:forEach>
</div>
</c:if>

<script src="${webRoot}/template/bdw/wap/statics/js/common.js"></script>
