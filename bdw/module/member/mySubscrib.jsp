<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName} - 信息订阅 - ${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/mySubscrib.js"></script>
    <script type="text/javascript">
        <%--初始化参数，mySubscrib.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
        <%--初始化参数，mySubscrib.js调用 end--%>
    </script>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > 信息订阅</div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <div class="RSS_list">
             <h2 class="rightbox_h2_border">信息订阅</h2>
            <div class="box  right_box_border">
                <h1>订阅下列情况时有新情况，会发送邮件通知我</h1>
                <ul>
                    <%--信息订阅列表 start--%>
                    <c:forEach items="${loginUser.subscribListByUser}" var="node">
                    <li>
                        <div class="ico">
                            <c:choose>
                            <c:when test="${not empty node.icon}">
                                <img src="${node.nodeIcon["130X130"]}" style="height: 95px;width: 130px;" title="${node.name}" />
                            </c:when>
                            <c:otherwise>
                                <img src="${webRoot}/template/bdw/module/member/statics/images/member_lisIco01.gif"  title="${node.name}" style="margin-top: 20px;" /><%--无图标--%>
                            </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="tit">${node.name}</div>
                        <div class="btn">
                            <c:choose>
                                <c:when test="${node.isSubscrib == true}">
                                    <a href="javascript:" class="cur" title="取消订阅${node.name}" onclick="unsubscribe('${node.id}')">取消订阅</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="javascript:" title="订阅${node.name}" onclick="subscription('${node.id}')">订阅</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    </c:forEach>
                    <%--信息订阅列表 end--%>
                </ul>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>

</body>
</html>
