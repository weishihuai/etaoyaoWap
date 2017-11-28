<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${webName}-密码找回</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
        <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/emailTojump.js"></script>
        <script type="text/javascript">
            $(function(){
                var emailLink = $.emailToUrl('${param.email}');
                if(emailLink != undefined){
                    $("#goToEmail").attr("href",emailLink);
                }else{
                    $("#goToEmail").parent(".btn").hide();
                }
            });
        </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="register">
	<div class="resulr">
		<div class="tipsB">
			<p>我们已将“[${webName}会员]找回密码”邮件发送到您的邮箱 ${param.email} 中，请在48小时内收信重置密码</p>
			<div class="btn"><a id="goToEmail" target="_blank" href="#">前往邮箱取回</a>
		</div>
	</div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
