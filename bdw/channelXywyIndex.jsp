<%@ page import="com.iloosen.imall.module.shiyao.domain.code.SexCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<%
    request.setAttribute("male",SexCodeEnum.MAN.toCode());                      //性别：男
    request.setAttribute("female", SexCodeEnum.WOMAN.toCode());                  //性别：女
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <%--SEO keywords优化--%>
    <title>问疾问药-${webName}</title>
    <%--<meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}"/>--%>
    <%--<meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}"/>--%>

    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/mc-base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/xywy-index.css">
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>

</head>
<%--页头开始--%>
<body>
<c:import url="/template/bdw/module/common/top.jsp"/>

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
            <h2>请选择问诊方式</h2>
        </div>
        <div class="m-cont-m">
            <div class="xywy_item item-l">
                <a href="${webRoot}/channelXywyDepartment.ac?askType=sections" title="按科室自选"> <h3>按科室自选</h3><p>此处有17大科室供您选择</p>  </a>
            </div>
            <div class="xywy_item item-r">
                <a href="${webRoot}/channelXywy.ac?askType=symptom" title="按部位自选"> <h3>按部位自选</h3><p>此处可选择您患病的部位</p>  </a>
            </div>
        </div>
        <div class="m-cont-b"></div>
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