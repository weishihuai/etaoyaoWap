<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<c:set value="${param.category == null ? 1 : param.category}" var="categoryId"/>
<c:set value="${sdk:getBrandByCategoryId(categoryId)}" var="brands"/>
<c:set value="${sdk:getFacet()}" var="facetProxy"/>

<div>
    <ul class="li-dd-inner" id="brandBox">
        <c:choose>
            <c:when test="${categoryId == 1}">
                <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="i">
                    <c:if test="${fn:length(unSelections.couts) > 0}">
                        <c:if test="${not empty unSelections.couts[0].name and unSelections.title eq '品牌'}">
                            <li>
                                <div class="brand-item-box">
                                    <c:forEach items="${unSelections.couts}" var="count" varStatus="i">
                                        <c:if test="${not empty count.name}">
                                            <p id="brandId-${count.value}" class="brandName" field="${count.field}" fieldValue="${count.value}" onclick="selectBrandOrForm(this)">${count.name}</p>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </li>
                        </c:if>
                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:forEach items="${brands}" var="brand" varStatus="i">
                    <li>
                        <div class="brand-item-box">
                            <c:if test="${not empty brand.name}">
                                <p id="brandId-${brand.brandId}" class="brandName" field="brandId" fieldValue="${brand.brandId}" onclick="selectBrandOrForm(this)">${brand.name}</p>
                            </c:if>
                        </div>
                    </li>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>
</div>



