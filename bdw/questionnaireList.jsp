<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getQuestionnaireList(100)}" var="questions"/>  <%--取出前100份问卷--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-问卷列表-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/questionnaire.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<%--问卷列表 start--%>
<div class="wp" id="wp">
    <div class="wp" id="pt">
        <div class="z">
            <a class="nvhm" href="#"></a><em>›</em>问卷调查系统
        </div>
    </div>
    <div class="wp cl" id="ct">
        <div class="mn">
            <div class="bm bml">
                <div class="bm_h cl"><span class="y"></span><h1 class="xs2">问卷列表<span class="xs1 xw0 i">问卷总数: <strong class="xi1">${questions.totalCount}</strong></span></h1></div>
            </div>
            <div class="tl bm bmw" id="threadlist">
                <div class="th">
                    <div class="tf">
                    </div><table cellspacing="0" cellpadding="0" width="100%" class="th">
                    <tbody><tr>
                        <td width="45%">问卷标题</td>
                        <td width="25%">奖励</td>
                        <td width="10%">总投票数</td>
                        <td width="20%">有效期</td>
                    </tr>
                    </tbody></table>
                </div>
                <table cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <c:forEach items="${questions.result}" var="item">
                        <tr>
                            <td width="45%"><a href="${webRoot}/questionnaireDetail.ac?questionnaireId=${item.questionnaireId}">${item.questionnaireTitle}</a></td>
                            <td width="25%">${item.reward}</td>
                            <td width="10%">${item.totalVoteTimes}</td>
                            <td width="20%">${item.validityTime}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="bm bw0 pgs cl" id="pgt">
            </div>
        </div>
    </div>	</div>
<%--问卷列表 end--%>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
