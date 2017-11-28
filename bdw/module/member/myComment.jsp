<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %><%--分页引用--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:set value="${sdk:findProductCommentsByUserId(loginUser.userId,10)}" var="productComments"/><%--当前用户商品评论--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-商品评论 - ${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.ac">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > 商品评论</div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <div class="myComment2">
            <h2 class="rightbox_h2_border">商品评价</h2>
            <%--商品评论列表 start--%>
            <div class="box right_box_border">
                <div class="m1">
                    <table width="100%" border="0" cellspacing="0">
                        <tr class="tr1">
                            <td class="td1">商品名称</td>
                            <td class="td2">评论内容</td>
                            <td class="td3">评论时间</td>
                            <td class="td4">商品评分</td>
                        </tr>
                        <c:forEach items="${productComments.result}" var="commentProxy">
                        <tr>
                            <td class="td1"><a class="redTitle" href="${webRoot}/product-${commentProxy.objectId}.html" target="_blank" title="${commentProxy.objectTitle}">${commentProxy.objectTitle}</a></td>
                            <td class="td2">${commentProxy.content}</td>
                            <td class="td3">${commentProxy.createTimeString}</td>
                            <td class="td4">${commentProxy.score}</td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
                <%--商品评论列表分页 start--%>
                <div class="page">
                    <div style="float:right">
                        <c:if test="${productComments.totalCount > 0}">
                        <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/module/member/myComment.ac"   totalPages='${productComments.lastPageNumber}' currentPage='${productComments.thisPageNumber}' totalRecords='${productComments.totalCount}' frontPath='${webRoot}'  displayNum='6'/>
                        </c:if>
                    </div>
                </div>
                <%--商品评论列表分页 end--%>
            </div>
            <%--商品评论列表分页 end--%>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>

</body>
</html>
