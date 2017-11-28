<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>密码修改成功</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/jquery.mmenu.css" rel="stylesheet">
   	<link type="${webRoot}/template/bdw/oldWap/statics/text/css" rel="stylesheet" href="css/jquery.mmenu.positioning.css" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
  </head>
  <body>
<%--	<div class="row" id="d_row1">
        <div class="col-xs-2"><span class="glyphicon glyphicon-arrow-left"></span></div>
        <div class="col-xs-8">修改密码</div>
    </div>--%>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=密码修改成功"/>
    <%--页头结束--%>
    <div class="container">
    	<div class="row m_rows2"  style="margin:20px 0;">
        	<div class="col-xs-12"><span class="glyphicon glyphicon-ok glyphicon-ok2" onclick="javascript:history.back();"></span>您的密码已成功修改，请记住新密码！</div>
        </div>
        <div class="row m_rows2"  style="margin-bottom:38px;">
            <div class="col-xs-12"><a href="${webRoot}/wap/index.ac" class="btn btn-danger btn-lg btn-danger2" type="button">返回首页</a></div>
        </div>
    </div>

  </body>
  <%--页脚开始--%>
  <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
  <%--页脚结束--%>
  </div>
</html>