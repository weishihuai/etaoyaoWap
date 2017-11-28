<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>${webName}-注册成功页</title>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
        <script>
            window.onload=function()
            {
                setInterval("redirect();",5000);
            };
            function redirect()
            {
                window.location.href="${webRoot}/index.ac?firstLogin=1";
            }
        </script>
  </head>
  <body>
    <%--页头开始--%>
    <c:import url="/template/bdw/oldWap/module/common/head.jsp?title=注册成功"/>
    <%--页头结束--%>
    <div class="container">
    	<div class="row"  style="margin:20px 0;text-align: center;padding: 7px;">
        	<div class="col-xs-12"><span class="glyphicon glyphicon-ok glyphicon-ok2"></span>恭喜您注册成功！5秒后将跳转到首页</div>
        </div>
        <div class="row"  style="margin-bottom:38px;">
        	<div class="col-xs-12" style="margin-bottom: 20px;">
                <button class="btn btn-danger btn-danger2 btn-block" type="button" onclick="location.href='${webRoot}/wap/index.ac'">返回首页</button>
            </div>
            <div class="col-xs-12">
                <button class="btn btn-danger btn-danger2 btn-block" type="button" onclick="location.href='${webRoot}/wap/module/member/index.ac'">会员中心</button>
            </div>
        </div>
    </div>
    <%--&lt;%&ndash;menu开始&ndash;%&gt;--%>
    <%--<c:import url="/template/jvan/wap/module/common/menu.jsp"/>--%>
    <%--&lt;%&ndash;menu结束&ndash;%&gt;--%>
  </body>
</html>