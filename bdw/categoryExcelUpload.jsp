<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/01/26
  Time: 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%
  PrintWriter writer = response.getWriter();
  try {
   ServiceManager.categoryService.categoryUpload("/opt/setups/shiyaoCategory.xlsx");
    writer.println("数据导入成功！！");
  }
  catch (Exception e){
    System.out.println("错误异常：" + e.getMessage());
    writer.println("错误异常：" + e.getMessage());
  }
  finally {
    System.out.println("执行完毕");
  }


%>
<html>
<head>
    <title>分类数据处理</title>
</head>
<body>
</body>
</html>
