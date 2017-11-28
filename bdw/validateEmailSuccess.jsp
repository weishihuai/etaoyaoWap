<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-提交成功-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="getYuorGinst">
    <div class="sali">
        <div class="succe">
            <c:choose>
                <c:when test="${success == true}">
                    <h1><img src="${webRoot}/template/bdw/statics/images/getYuorGinst_ico.gif" alt="" /> 邮箱验证成功！</h1>
                </c:when>
                <c:otherwise>
                    <h1 style="height: 62px;"><img src="${webRoot}/template/bdw/statics/images/buyCar_erroIco.gif" alt="" />
                        <c:choose>
                            <c:when test="${errorCode == 'hasActivated'}">
                                您的邮箱已激活
                            </c:when>
                            <c:otherwise>
                                邮箱验证失败！
                            </c:otherwise>
                        </c:choose>
                    </h1>
                </c:otherwise>
            </c:choose>
            <p><a href="${webRoot}/" style="color: red;">回到首页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="${webRoot}/module/member/index.ac" style="color: red;">会员中心</a></p>
        </div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
