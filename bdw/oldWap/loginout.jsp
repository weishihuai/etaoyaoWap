<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SysUser user = WebContextFactory.getWebContext().getFrontEndUser();
    if(user != null){
        request.getSession().invalidate();
    }
%>
<html>
<head>
    <title></title>
</head>
<body>
    退出成功
</body>
</html>
