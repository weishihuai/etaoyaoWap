<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:if test="${empty loginUser}">
    <c:redirect url="/wap/login.ac"></c:redirect>
</c:if>

<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE HTML>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>系统消息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <META HTTP-EQUIV="pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <META HTTP-EQUIV="expires" CONTENT="0">
    <!-- Bootstrap -->
    <link href="${webRoot}/${templateCatalog}/wap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/${templateCatalog}/wap/module/member/statics/css/member.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/${templateCatalog}/wap/statics/css/footer.css" rel="stylesheet" media="screen">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>

    <script>
        function changeIcon(num){
            var obj = $('#collapse'+num);
            if(obj.hasClass('in')){
               $("#icon"+num).removeClass('glyphicon-chevron-up');
               $("#icon"+num).addClass('glyphicon-chevron-down');
            }
            else{
                $("#icon"+num).removeClass('glyphicon-chevron-down');
                $("#icon"+num).addClass('glyphicon-chevron-up');
            }
        }
    </script>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=系统消息"/>
<%--页头结束--%>
<c:if test="${fn:length(loginUser.userMsgListBySystem) == 0}">
    <div class="container">
        <div class="row " style="margin:20px 0;padding:10px 0;">
            <div class="col-xs-12 text-center">
                暂时没有系统消息
            </div>
        </div>
    </div>
</c:if>

<div class="container" style="padding-top: 10px;margin-bottom: 10px;">
    <div class="row">
        <div class="col-xs-12">
            <div class="panel-group" id="accordion">
                <c:forEach items="${loginUser.userMsgListBySystem}" var="systemMsg" varStatus="s">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h6 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion"
                                   href="#collapse${s.count}" onclick="changeIcon('${s.count}')">
                                    <ul class="nav nav-pills text">
                                        <li class="col-xs-6">
                                            <h5>${systemMsg.title}</h5>
                                        </li>
                                        <li class="col-xs-4">
                                            <h5>${fn:substring(systemMsg.messageTimeString,0,10)}</h5>
                                        </li>
                                        <li class="col-xs-1 pull-right">
                                            <h5><span class="glyphicon glyphicon-chevron-down" id="icon${s.count}"></span></h5>
                                        </li>
                                    </ul>
                                </a>
                            </h6>
                        </div>
                        <div id="collapse${s.count}" class="panel-collapse collapse">
                            <div class="panel-body">
                                ${systemMsg.userMsgCont}
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<c:choose>
    <c:when test="${empty loginUser.bytUserId}">
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>
<div style="display: none">${now}</div>
</body>
</html>

