<%--
  Created by IntelliJ IDEA.
  User: Hgf
  Date: 2015/12/14
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %><%--分页引用--%>
<%
    request.setAttribute("sex", request.getParameter("sex"));
%>
<c:set value="${bdw:getDiagnosis(param.subPartIdSymptomIds ,param.diseaseCommonCategoryId,param.subDepartmentId,1000)}" var="Diagnosis"/>
<html>
<head>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title>自测结果-${webName}</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/mc-base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/xywy-result.css">
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/xywyZdjg.js"></script>
  <script type="text/javascript">
    var webPath = {
      webRoot: "${webRoot}"
    }
  </script>
</head>
<body>
<%--页头--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<form id="sendFrom" method="get" action="${webRoot}/xywyZdjg.ac">
  <input id="askType" name="askType" type="hidden" value="${empty param.askType?'sections':param.askType}">
  <input id="subPartIdSymptomIds" name="subPartIdSymptomIds" type="hidden" value="${param.subPartIdSymptomIds}">
  <input id="diseaseCommonCategoryId" name="diseaseCommonCategoryId" type="hidden" value="${param.diseaseCommonCategoryId}">
  <input id="subDepartmentId" name="subDepartmentId" type="hidden" value="${param.subDepartmentId}">
  <input id="sex" name="sex" type="hidden" value="${param.sex}">
</form>
<!--主体:疾病列表 channelXywyIndex-->
<div class="m-center">
  <div class="past">
    <div class="first">
      <a href="${webRoot}/index.html" class="cata">${webName}</a>
      <i class="crumbs-arrow"></i>
    </div>
    <a class="cata" href="${webRoot}/channelXywyIndex.ac">寻医问药</a>
    <i class="crumbs-arrow"></i>
    <div class="last">
      <a  class="cata" href="javascript:void(0);">自测结果</a>
    </div>
  </div>
  <div class="m-cont">
    <div class="m-cont-t">
      <h2>自测结果</h2>
      <a href="${webRoot}/channelXywyIndex.ac" title="返回问诊方式">返回问诊方式</a>
    </div>
    <div class="m-cont-b">
      <c:if test="${empty Diagnosis.result}">
        <div class="item mc-bg"  style="height: 150px;line-height: 150px; font-size: 16px;text-align: center;">
          未自测出疾病，若有疑问，建议去医院做进一步检查。
        </div>
      </c:if>
      <c:if test="${!empty Diagnosis.result}">
        <c:forEach items="${Diagnosis.result}" var="diagnosis">
          <div class="item">
            <div class="item-t clearfix">
              <h3>${diagnosis.diseaseNm} <em>{ <fmt:formatNumber pattern="#" value="${diagnosis.probability}"/>%可能性 }</em></h3>
              <a href="${webRoot}/xywyIllnessDetail.ac?sysDiseaseId=${diagnosis.diseaseLibId}" title="查看详情">查看详情</a>
            </div>
            <div class="item-m">
              <p>${diagnosis.diseaseIntroduceStr}</p>
            </div>
            <div class="item-b">
              <dl class="item-b-t clearfix">
                <dt>已选症状：</dt>
                <dd>
                  <div class="dd-cont">
                    <c:forEach items="${diagnosis.selectedSymptoms}" var="selectedSymptom">
                      <c:set value="${bdw:getSubPartId(diagnosis.diseaseLibId,selectedSymptom.symptomId)}" var="partId"/>
                      <a href="javascript:void(0);" title="" subPartIdSymptomId =",${partId}_${selectedSymptom.symptomId}">${selectedSymptom.symptomNm}</a>
                    </c:forEach>
                  </div>
                </dd>
              </dl>
              <c:if test="${!empty diagnosis.unselectedSymptoms}">
                <dl class="item-b-b clearfix">
                  <dt>未选症状：</dt>
                  <dd>
                    <div class="dd-cont">
                      <c:forEach items="${diagnosis.unselectedSymptoms}" var="unselectedSymptom">
                        <c:set value="${bdw:getSubPartId(diagnosis.diseaseLibId,unselectedSymptom.symptomId)}" var="partId"/>
                        <a class="" href="javascript:void(0);" title="" subPartIdSymptomId =",${partId}_${unselectedSymptom.symptomId}">${unselectedSymptom.symptomNm}</a>
                      </c:forEach>
                    </div>
                    <a class="btn" href="javascript:void(0);" title="" style="display: none;">确认</a>
                  </dd>
                </dl>
              </c:if>
            </div>
          </div>
        </c:forEach>

      </c:if>

    </div>
    <c:if test="${!empty Diagnosis.result}">
      <div class="pager">
        <div id="infoPage">
          <c:if test="${Diagnosis.lastPageNumber > 1}">
            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" ajaxUrl="${webRoot}/xywyZdjg.ac" totalPages='${Diagnosis.lastPageNumber}' currentPage='${Diagnosis.thisPageNumber}' totalRecords='${Diagnosis.totalCount}' frontPath='${webRoot}'  displayNum='6'/>
          </c:if>
        </div>
      </div>
    </c:if>
  </div>


</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
