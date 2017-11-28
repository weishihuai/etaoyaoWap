<%@ page import="com.iloosen.imall.module.shiyao.domain.code.SexCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<%
    request.setAttribute("male", SexCodeEnum.MAN.toCode());                      //性别：男
    request.setAttribute("female",SexCodeEnum.WOMAN.toCode());                  //性别：女
%>
<c:set value="${bdw:findDiagnosisList(param.askType)}" var="diagnosisList"/>
<!DOCTYPE html>
<html>
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <title>按科室查疾病-${webName}</title>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/mc-base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/xywy-office.css">
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/channelXywyDepartment.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/main.js"></script>

    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            askType:"${param.askType}"
        };
    </script>
</head>
<%--页头开始--%>

<body>
<c:import url="/template/bdw/module/common/top.jsp"/>

<form id="sendFrom" action="${webRoot}/channelXywyDiseaseLib.ac" method="get">
    <input id="subDepartmentId" name="subDepartmentId" type="hidden" value="" >
    <input id="mainDepartmentCode" name="mainDepartmentCode" type="hidden" value="" >
    <input id="askType" name="askType" type="hidden" value="${param.askType}" >
</form>
<!--主体:按科室查疾病-->
<div class="m-center">
    <div class="past">
        <div class="first">
            <a href="${webRoot}/index.html" class="cata">${webName}</a>
            <i class="crumbs-arrow"></i>
        </div>
        <a href="${webRoot}/channelXywyIndex.ac" class="cata">寻医问药</a>
    </div>
    <div class="m-cont">
        <div class="m-cont-t">
            <h2>按科室查疾病</h2>
        </div>
        <div class="m-cont-b">
            <dl class="main-list">
                <dt>
                    <span>请选择患病部位：</span>
                    <a href="${webRoot}/channelXywyIndex.ac" title="返回问诊方式">返回问诊方式</a>
                </dt>
                <dd class="clearfix" id="item1">
                    <c:forEach var="proxy" items="${diagnosisList}" varStatus="num">
                        <a href="#item2" mainDepartmentCode="${proxy.mainDepartmentCode}" mainDepartmentNm="${proxy.mainDepartmentNm}"  onclick="findSubDepartmentNm('${proxy.mainDepartmentCode}',this);" >${proxy.mainDepartmentNm}</a>
                    </c:forEach>
                </dd>
            </dl>
            <dl class="sub-list" id="item2" style="display: none">
                <dt>
                    <span >请选择子科室<strong id="item2_1">（内科）</strong></span>
                </dt>
                <dd class="clearfix" id="item2_2">
                </dd>
            </dl>
        </div>
    </div>
</div>
<c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
</html>
<script type="text/javascript">
    var dataValue = {loginUser:"${loginUser}",webRoot:"${webRoot}"};
    if(dataValue.loginUser==""){
        showAlert("用户未登陆，请登陆后再进行操作！",function(){
            window.location.href=dataValue.webRoot+"/login.ac";
        });
    }
</script>
