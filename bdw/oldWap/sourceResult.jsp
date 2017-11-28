<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--微信配置信息--%>
<c:set value="${weixinSdk:getWinxinConfig()}" var="config"/>

<%
    System.out.print("----------------");
    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();
    request.setAttribute("tempContextUrl", tempContextUrl);

%>

<%--<script>
    alert('${param.productId}');
</script>--%>

<%--页面转向分发--%>
<c:choose>
    <c:when test="${isWeixin eq 'Y'}">
        <c:set var="vorderUrl" value="${tempContextUrl}/wap/vproductSource.ac?showwxpaytitle=1&productId=${param.productId}"/>
        <c:set var="urlStr" value="https://open.weixin.qq.com/connect/oauth2/authorize?appid=${config.appId}&redirect_uri=${vorderUrl}&response_type=code&scope=snsapi_base&state=${param.productId}#wechat_redirect"/>
    </c:when>
    <c:when test="${isWeixin eq 'N'}">
        <c:set var="urlStr" value="${tempContextUrl}/wechat/scanFailure.ac"/>
    </c:when>
    <c:otherwise>
        <c:set var="urlStr" value="${tempContextUrl}/wechat/scanFailure.ac"/>
    </c:otherwise>
</c:choose>

<script type="text/javascript">
    setTimeout(function(){
        location.replace("${urlStr}");
    });
</script>
