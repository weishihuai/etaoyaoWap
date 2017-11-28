<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.title?'':param.title}" var="title"/>

<c:if test="${isWeixin!='Y'}">
    <div class="row" id="d_row1">
        <div class="col-xs-2"><a onclick="history.go(-1);" href="javascript:void(0);" style="color:#FFF"><span class="glyphicon glyphicon-arrow-left"></span></a></div>
        <c:choose>
            <c:when test="${title=='product'}">
                <div class="col-xs-8">商品详情</div>
            </c:when>
            <c:otherwise>
                <div class="col-xs-8">${title}</div>
            </c:otherwise>
        </c:choose>
    </div>
</c:if>

<c:if test="${isWeixin=='Y'&&title=='商品列表'}">
    <div class="row" id="d_row1" style="height:1px;"></div>
</c:if>



