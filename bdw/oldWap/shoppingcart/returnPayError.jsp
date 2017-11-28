<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!doctype html>
<html>
<head>
    <title>支付失败-${webName}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/member.css" rel="stylesheet">

    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js" type="text/javascript" ></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};

        $(function(){
            setInterval("redirect();",5000);
        });

        function redirect()
        {
            var type=${param.type}
                    if(type == 'integralOrder'){
                        window.location.href="${webRoot}/wap/module/member/myIntegralOrders.ac";
                    }else{
                        window.location.href="${webRoot}/wap/module/member/myOrders.ac";
                    }

        };
    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=订单支付"/>
<%--页头结束--%>
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="navbar-brand">
                <img src="${webRoot}/template/bdw/statics/images/buyCar_erroIco.gif" />
                <span class="h3">订单支付失败!${errorMsg}</span>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="col-xs-12">
            <h4>您现在可以：<a href="${webRoot}/wap/index.ac"><strong>返回首页</strong></a>&nbsp;&nbsp;5秒后将自动跳转至&nbsp;&nbsp;<a href="${webRoot}/wap/module/member/myOrders.ac" class=""><strong>订单中心</strong></a>&nbsp;&nbsp;页</h4>
        </div>
    </div>
</div>

<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>

</body>
</html>