<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/> <%-- 获取当前登录的用户--%>
<c:set value="${sdk:getQuestionnaireQuestionAndOptionById(param.questionnaireId)}" var="questionnaireProxy"/>  <%--根据问卷的Id，取出问卷及问卷下的所有问题和问题选项--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-问卷调查-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/questionnaire.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/commons/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.DOMWindow.js"></script>
    <script type="text/javascript">
        var pageData={
            webRoot:"${webRoot}",userId:'${userProxy.userId}',isAllowViewResult:'${questionnaireProxy.allowViewResult}' ,isAnonymousVote:'${questionnaireProxy.anonymousVote}'
        };
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/ObjectToJsonUtil.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/questionnaire.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<%--问卷问题列表 start--%>
<div class="wp" id="wp">
    <div class="wp" id="pt">
        <div class="z">
            <a class="nvhm" href="#"></a><em>›</em><a href="${webRoot}/questionnaireList.ac">问卷调查系统</a><em>›</em>问卷投票结果
        </div>
    </div>
    <div class="wp cl" id="ct">
        <div class="mn">
            <div class="bm bml">
                <div class="bm_h cl">
                    <%--<span class="y"><a href="">查看答卷</a><span class="pipe">|</span><a href="">统计</a></span>--%>
                    <h1 class="xs2">问卷投票结果<span class="xs1 xw0 i"> <strong class="xi1"></strong></span></h1>
                </div>
            </div>
            <div class="fl bm">
                <div class="bm bmw  cl">
                    <div class="bm_h cl">
                        <h2>${questionnaireProxy.questionnaireTitle}</h2>
                    </div>
                    <div style="" class="bm_c" id="category_1">
                        <input type="hidden" id="questionnaireId" name="questionnaireId" value="${questionnaireProxy.questionnaireId}">
                        <table cellspacing="0" cellpadding="0" class="fl_tb">
                            <thead>
                            <tr>
                                <td><b>问卷说明</b>:
                                    <div class="pbm xg2">
                                        亲爱的商城用户：<br>
                                        您的60秒，我们的完美！<br>
                                        感谢您为商城填写一封通向阳光的问卷••••<br>
                                    </div>
                                </td>
                            </tr>
                            </thead>
                            <c:forEach items="${questionnaireProxy.questionProxies}" var="questionItem" varStatus="num">
                                <thead>
                                <tr class="fl_row" >
                                    <td>
                                        <h2>${num.count}、${questionItem.questionTitle}【${questionItem.questionOptionType}】</h2>
                                        <c:forEach items="${questionItem.optionProxies}" var="optionItem">
                                            <div class="question_b">
                                                <div class="question_b_l"><span style="color: #CD0001;">★</span>${optionItem.questionOptionTitle}</div>
                                                <div class="question_b_r">
                                                    <div class="r_sub" style='
                                                            <c:if test="${optionItem.voteTimes==0||questionnaireProxy.totalVoteTimes==0}">
                                                                      width:0;
                                                            </c:if>
                                                            <c:if test="${optionItem.voteTimes!=0&&questionnaireProxy.totalVoteTimes!=0}">
                                                                      width:${optionItem.voteTimes/questionnaireProxy.totalVoteTimes*100}%;
                                                            </c:if>'>
                                                           <c:if test="${optionItem.voteTimes!=0&&questionnaireProxy.totalVoteTimes!=0}">
                                                                    <b style="color: #e9e7f2;"> ${fn:substring(optionItem.voteTimes/questionnaireProxy.totalVoteTimes*100, 0, 4)}0%</b>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </td>
                                </tr>
                                </thead>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--问卷问题列表 end--%>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
