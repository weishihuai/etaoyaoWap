<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>                                        <%--获取当前用户--%>
<c:set value="${bdw:findDiagnosisList('sections')}" var="sectionsList"/>                    <!--主科室List-->
<c:set value="${bdw:findDiagnosisList('symptom')}" var="symptomList"/>                      <!--主部位List-->
<c:set value="${bdw:findSubDepartment(param.mainDepartmentCode)}" var="subDepartmentList"/>  <!--子科室List-->
<c:set value="${bdw:findSubPart(param.mainPartCode)}" var="subPartList"/>                    <!--子部位List-->
<c:set value="${bdw:findSexCode()}" var="sexList"/>                                          <!--性别List-->
<c:set value="${bdw:findSusceptiblesProxy()}" var="susceptiblesList"/>                      <!--年龄阶段List-->

<c:set value="${bdw:findDiseaseLibList(param.subDepartmentId,param.subPartId,param.sexCode,param.susceptiblesCode)}" var="diseaseLibPage"/>                      <!--疾病List-->

<!DOCTYPE html>
<html>
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <title>疾病列表-${webName}</title>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/mc-base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/xywy-list.css">
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/channelXywyDiseaseLib.js"></script>
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

<form id="sendFrom" method="get" action="${webRoot}/channelXywyDiseaseLib.ac" >
    <input id="sexCode" name="sexCode" type="hidden" value="">
    <input id="subDepartmentId" name="subDepartmentId" type="hidden" value="">
    <input id="subPartId" name="subPartId" type="hidden" value="">
    <input id="susceptiblesCode" name="susceptiblesCode" type="hidden" value="">
    <input id="mainDepartmentCode" name="mainDepartmentCode" type="hidden" value="${param.mainDepartmentCode}">
    <input id="mainPartCode" name="mainPartCode" type="hidden" value="${param.mainPartCode}">
</form>

<div class="m-center">
<div class="past">
    <div class="first">
        <a href="${webRoot}/index.html" class="cata">${webName}</a> <i class="crumbs-arrow"></i>
    </div>
    <a href="${webRoot}/channelXywyIndex.ac" class="cata">寻医问药</a>
</div>
<div class="m-cont">
    <div class="m-cont-t">
        <h2>疾病列表</h2>
    </div>
    <div class="m-cont-m">
        <p class="tit clearfix">
            <span>疾病筛选</span>
            <a href="${webRoot}/channelXywyDepartment.ac?askType=sections" title="返回问诊科室">返回问诊科室</a>
        </p>
        <ul class="list">
            <!--最后一个 li元素 添加 bb-no -->
            <li class="clearfix">
                <span class="lab">部位</span>
                <div class="val">
                    <c:forEach var="proxy" items="${symptomList}" varStatus="num">
                        <a class="item mainPartCode ${param.mainPartCode==proxy.mainPartCode && not empty param.subPartId?'hover':''}" href="javascript:"  mainPartCode="${proxy.mainPartCode}" onclick="findPartsOfBodyList(${proxy.mainPartCode},this)">${proxy.mainPartNm}</a>
                    </c:forEach>

                    <div class="popover ${not empty param.subPartId ?'show':''}" id="item4">
                        <c:forEach var="subPart" items="${subPartList}">
                            <a  class="subPartId ${subPart.subPartId == param.subPartId ?'active':''}" subPartId="${subPart.subPartId}" subPartNm="${subPart.subPartNm}" onclick="sendFun('item4',this)" href="javascript:">${subPart.subPartNm}</a>
                        </c:forEach>
                    </div>
                </div>
            </li>
            <li class="clearfix">
                <span class="lab">科室</span>
                <div class="val">
                    <!--鼠标经过给item 加： hover-->
                    <c:forEach var="proxy" items="${sectionsList}" varStatus="num">
                        <a class="item mainDepartment ${ param.mainDepartmentCode==proxy.mainDepartmentCode && not empty param.subDepartmentId?'hover':''}"  href="javascript:" mainDepartmentCode="${proxy.mainDepartmentCode}" mainDepartmentNm="${proxy.mainDepartmentNm}"  onclick="findSubDepartmentNm('${proxy.mainDepartmentCode}',this);" >${proxy.mainDepartmentNm}</a>
                    </c:forEach>
                    <!--弹出层-->
                    <div class="popover ${not empty param.subDepartmentId?'show':''}" id="item2">
                        <c:forEach var="sub" items="${subDepartmentList}" varStatus="c">
                            <a href="javascript:" class="subDepartmentId ${ param.subDepartmentId==sub.subDepartmentId?'active':''}" onclick="sendFun('item2',this)" subDepartmentId="${sub.subDepartmentId}">${sub.subDepartmentNm}</a>
                        </c:forEach>
                    </div>
                </div>
            </li>
            <li class="clearfix">
                <span class="lab">人群</span>
                <div class="val" id="item6">
                    <c:forEach items="${susceptiblesList}" var="susceptiblesProxy">
                        <a class="item susceptiblesCode ${ param.susceptiblesCode==susceptiblesProxy.susceptiblesCode?'active':''}" susceptiblesCode="${susceptiblesProxy.susceptiblesCode}" href="javascript:" onclick="sendFun('item6',this)" title="">${susceptiblesProxy.susceptiblesName}</a>
                    </c:forEach>
                     <a class="item susceptiblesCode ${ empty param.susceptiblesCode?'active':''}" susceptiblesCode="" href="javascript:" onclick="sendFun('item6',this)" title="">全部</a>
                </div>
            </li>
            <li class="clearfix bb-no">
                <span class="lab">性别</span>
                <div class="val" id="item8">
                   <c:forEach items="${sexList}" var="sexProxy">
                       <a class="item sexCode ${ param.sexCode==sexProxy.sexCode?'active':''}" sexCode="${sexProxy.sexCode}" href="javascript:" onclick="sendFun('item8',this)" title="">${sexProxy.sexName}</a>
                   </c:forEach>
                </div>
            </li>
        </ul>
    </div>
    <div class="m-cont-b">
        <c:forEach var="libProxy" items="${diseaseLibPage.result}" varStatus="s">
            <div class="item">
                <h3 class="item-t"><a href="${webRoot}/xywyIllnessDetail.ac?sysDiseaseId=${libProxy.diseaseLibId}" title="查看详情">${libProxy.diseaseNm}</a></h3>
                <p class="item-m">简介：${libProxy.diseaseIntroduceStr}</p>
                <div class="item-b clearfix">
                    <dl>
                        <dt>表现在症状：</dt>
                        <dd>
                            <c:forEach var="sym" items="${libProxy.selectedSymptoms}" varStatus="c">
                                <span>${sym.symptomNm}</span>
                            </c:forEach>
                        </dd>
                    </dl>
                    <a href="${webRoot}/xywyIllnessDetail.ac?sysDiseaseId=${libProxy.diseaseLibId}" title="查看详情">查看详情</a>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="pager">
        <div id="infoPage">
            <c:if test="${diseaseLibPage.lastPageNumber>1}">
                <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${diseaseLibPage.lastPageNumber}' currentPage='${diseaseLibPage.thisPageNumber}'  totalRecords='${diseaseLibPage.totalCount}' ajaxUrl='${webRoot}/channelXywyDiseaseLib.ac' frontPath='${webRoot}' displayNum='6' />
            </c:if>
        </div>
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