<%@ page import="cn.emay.sdk.client.api.Client" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%
    Client client = null;
    if (client == null) {
        try {
            client = new Client("0SDK-EAA-6688-JERTL", "713137");
            //每台机子,首次使用都要注册一下.这是跟机子是有关系
            int i = client.registEx("713137");
            System.out.println("--------------------------------短信注册结果(0表示注册成功):" + i);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>欢迎</title>
    <%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>--%>
    <script type="text/javascript">
    </script>
</head>

<body>

</body>
</html>
