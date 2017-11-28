<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<div class="l_footer">
    <c:set value="${sdk:getSysParamValue('copyright')}" var="copyright"/>
    <c:set value="${sdk:getSysParamValue('webUrl')}" var="webUrl"/>
	${copyright}&nbsp;&nbsp;${webName}自提服务中心&nbsp;&nbsp;${webUrl}
</div>
