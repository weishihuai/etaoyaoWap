<%@ page import="com.iloosen.imall.commons.helper.ServiceManager" %>
<%@ page import="com.iloosen.imall.module.page.domain.WebsiteTemplate" %>
<%@ page import="java.util.Date" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>
<%@taglib uri="http://www.iloosen.com/bdw" prefix="bdw"%>
<%@taglib uri="http://www.etaoyao.com/sdk" prefix="sdk"%>
<%@ page errorPage="/commons/error.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    response.setHeader("cache-control","max-age=5,public,must-revalidate"); //one day
    response.setDateHeader("expires", -1);
%>
<c:set value="${pageContext.request.contextPath}" var="webRoot" />
<c:set value="${sdk:getSysParamValue('webName')}" var="webName" />
<c:set value="${sdk:getSysParamValue('webUrl')}" var="webUrl" />
<c:set value="${sdk:getSysParamValue('wapUrl')}" var="wapUrl" />

<%
    String userAgent = request.getHeader("User-Agent");
    String microMessenger = "MicroMessenger/";
    request.setAttribute("isWeixin",userAgent.indexOf(microMessenger) > 0?"Y":"N");

    WebsiteTemplate useTemplate = ServiceManager.websiteTemplateService.getEnableTemplate();
    request.setAttribute("templateCatalog",useTemplate.getTemplateCatalog());
    request.setAttribute("cdnDate",new Date().getTime());
%>



