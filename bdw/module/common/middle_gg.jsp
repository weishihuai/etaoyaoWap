<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<div class="main-rec frameEdit" frameInfo="sy_middle_top_gg">
  <c:forEach items="${sdk:findPageModuleProxy('sy_middle_top_gg').advt.advtProxy}" var="advt" varStatus="s" end="1">
    <div <c:if test="${s.index==0}">class="rec-lt"</c:if> <c:if test="${s.index==1}">class="rec-rt"</c:if>>
      <%--<a href="${advt.link}" target="_blank">--%>
        <%--<img src="${advt.advUrl}">--%>
        <%--&lt;%&ndash;&lt;%&ndash;<img class="lazy" data-original="${advt.advUrl}">&ndash;%&gt;&ndash;%&gt;--%>
      <%--</a>--%>
      ${advt.htmlTemplate}
    </div>
  </c:forEach>
</div>
<div class="main-common">
  <c:forEach begin="1" end="3" varStatus="s">
    <c:set var="sy_middle_down_gg" value="sy_middle_down_gg${s.index}" />
    <c:set var="sy_middle_down_link" value="sy_middle_down_link${s.index}" />
      <div class="item">
        <div class="pic frameEdit" frameInfo="${sy_middle_down_gg}">
          <c:forEach items="${sdk:findPageModuleProxy(sy_middle_down_gg).advt.advtProxy}" var="advt" varStatus="s" end="0">
            <h5>${advt.title}</h5>
            <p>${advt.advtHint}</p>
            <%--<img class="lazy" data-original="${advt.advUrl}" width="160px" height="185px">--%>
            <%--<img src="${advt.advUrl}" width="160px" height="185px">--%>
          ${advt.htmlTemplate}
          </c:forEach>

        </div>
        <ul class="cont frameEdit" frameInfo="${sy_middle_down_link}">
          <c:forEach items="${sdk:findPageModuleProxy(sy_middle_down_link).links}" var="link" end="11">
            <li><a href="${link.link}" <c:if test="${link.newWin}">target="_blank" </c:if> >${link.title}</a></li>
          </c:forEach>
        </ul>
      </div>
  </c:forEach>
</div>
