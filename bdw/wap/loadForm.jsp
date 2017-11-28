<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<c:set value="${param.category == null ? 1 : param.category}" var="categoryId"/>
<c:set value="${sdk:getFacetByCategoryId(categoryId)}" var="facetProxy"/>

<div>
    <div class="li-dd-inner" id="innerDiv">
        <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="s">
            <c:if test="${fn:length(unSelections.couts) > 0}">
                <c:if test="${not empty unSelections.couts[0].name and unSelections.title eq '剂型'}">
                    <c:forEach items="${unSelections.couts}" var="count">
                        <c:if test="${not empty count.name}">
                            <p id="${count.field}-${count.value}" field="${count.field}" fieldValue="${count.value}" onclick="selectBrandOrForm(this)">${count.name}</p>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:if>
        </c:forEach>
    </div>
</div>




