<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-售前咨询</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/userTalk.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/comment.js"></script>
</head>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--商品咨询--%>
<c:set var="buyConsultProxys" value="${sdk:findBuyConsultByProductId(param.id,10)}"/>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=product"/>
<%--页头结束--%>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>

<div id="position"><a href="${webRoot}/index.html">首页</a>
    <c:forEach items="${productProxy.category.categoryTree}" var="node" begin="1">
        > <a href="${webRoot}/productlist-${node.categoryId}.html">${node.name}</a>
    </c:forEach>
    > <a href="${webRoot}/product-${param.id}.html" title="${productProxy.name}">${productProxy.name}</a>
</div>

<div id="userTalk">
    <%--商品详细--%>
        <div class="lBox">
            <c:import url="/template/bdw/comment/includeProduct.jsp?id=${param.id}"/>
        </div>
    <%--商品详细--%>
    <div class="rBox">
        <div class="set-B">
            <div class="t_Area">
                <div class="tit">发表售前咨询</div>
                <div class="clear"></div>
            </div>
            <div class="box">
                <div class="m1">声明：您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，我们有专人进行回复！因厂家随时会更改一些产品的包装、颜色、产地等参数，所以该回复仅在当时对提问者有效！咨询回复的工作时间为：周一至周五，9:00至18:00，请耐心等待工作人员回复。</div>
                <div class="askList">
                    <c:forEach items="${buyConsultProxys.result}" var="buyConsultProxy">
                        <div class="each">
                            <div class="fixBox">
                                <div class="question">${buyConsultProxy.userName}：${buyConsultProxy.consultCont}</div>
                                <div class="time">${buyConsultProxy.consultTimeString}</div>
                                <div class="clear"></div>
                            </div>
                            <div class="fixBox">
                                <div class="answer">客服回复：${buyConsultProxy.consultReplyCont}</div>
                                <div class="time">${buyConsultProxy.lastReplyTimeString}</div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${not empty buyConsultProxys && buyConsultProxys.lastPageNumber > 1}">
                        <div class="page">
                            <div style="float:right">
                                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/comment/buyConsult.ac"   totalPages='${buyConsultProxys.lastPageNumber}' currentPage='${buyConsultProxys.thisPageNumber}' totalRecords='${buyConsultProxys.totalCount}' frontPath='${webRoot}'  displayNum='6'/>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div class="m2">
                    <label>咨询内容<span>*</span>：</label>
                    <div class="put2"><textarea id="consultCont" name="consultCont" cols="" rows="">欢迎您发表咨询内容。</textarea></div>
                    <div class="clear"></div>
                </div>
                <div class="m2">
                    <div class="fixBox">
                        <c:choose>
                            <c:when test="${empty loginUser}">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                <div class="text">请登录后提交咨询！ <a href="${webRoot}/login.ac" title="登录"><img src="${webRoot}/template/bdw/statics/images/detail_btn04.gif" /></a> <a href="${webRoot}/register.ac" title="注册新账户"><img src="${webRoot}/template/bdw/statics/images/detail_btn05.gif" /></a></div>
                            </c:when>
                            <c:otherwise>
                                <label>用户账号：</label>
                                <div class="text">${loginUser.loginId}</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="clear"></div>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${not empty loginUser}">
                        <div class="btn"><a href="javascript:void(0);" id="addConsultCont">发表售前咨询</a></div>
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
