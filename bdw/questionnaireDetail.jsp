<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/> <%-- 获取当前登录的用户--%>
<c:set value="${sdk:getQuestionnaireQuestionAndOptionById(param.questionnaireId)}" var="resultProxy"/>  <%--根据问卷的Id，取出问卷及问卷下的所有问题和问题选项--%>
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
            webRoot:"${webRoot}",userId:'${userProxy.userId}',isAllowViewResult:'${resultProxy.allowViewResult}' ,isAnonymousVote:'${resultProxy.anonymousVote}'
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
            <a class="nvhm" href="#"></a><em>›</em><a href="${webRoot}/questionnaireList.ac">问卷调查系统</a><em>›</em>浏览问卷
        </div>
    </div>
    <div class="wp cl" id="ct">
        <div class="mn">
            <div class="bm bml">
                <div class="bm_h cl">
                    <%--<span class="y"><a href="">查看答卷</a><span class="pipe">|</span><a href="">统计</a></span>--%>
                    <h1 class="xs2"><marquee style="width: 588px;color: #CD0001;" scrollamount="2" direction="left">问卷说明：亲爱的商城用户,您的60秒，我们的完美！感谢您为商城填写一封通向阳光的问卷...</marquee></h1>
                </div>
            </div>
            <div class="fl bm">
                <div class="bm bmw  cl">
                    <div class="bm_h cl">
                        <h2>${resultProxy.questionnaireTitle}</h2>
                    </div>
                    <div style="" class="bm_c" id="category_1">
                        <input type="hidden" id="questionnaireId" name="questionnaireId" value="${resultProxy.questionnaireId}">
                        <table cellspacing="0" cellpadding="0" class="fl_tb">
                            <c:forEach items="${resultProxy.questionProxies}" var="questionItem" varStatus="num">
                                <thead>
                                <tr class="fl_row">
                                    <td>
                                        <h2 style="margin-bottom: 10px;">${num.count}、${questionItem.questionTitle}【${questionItem.questionOptionType}】</h2>
                                        <div class="postmessage"></div>
                                        <c:forEach items="${questionItem.optionProxies}" var="optionItem">
                                            <input  class="optionItem" type="${questionItem.questionOptionType=="单选"?"radio":"checkbox"}" value="${optionItem.questionOptionId}" <c:if test="${questionItem.questionOptionType=='单选'}">name="${num.count}"</c:if>" />
                                            ${optionItem.questionOptionTitle}<br>
                                        </c:forEach>
                                    </td>
                                </tr>
                                </thead>
                            </c:forEach>
                        </table>
                        <div class="mtm mbm">
                            <button style="cursor: pointer;padding: 2px 10px;" onclick="questionnaireCommit()" name="quessubmit" value="true" class="pn pnc" id="postsubmit" type="submit"><span>提交</span></button>
                        </div>
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

<%--是否查看结果弹出层--开始--%>
<div id="Layer" style="display: none;">
    <div class="viewResultLayer">
        <div class="showTip">
            <div class="close"><a href="javascript:" onclick="closeShoppingCartTip();">
                <img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif" onclick="closeShoppingCartTip();"/>
                关闭</a></div>
            <div class="succe">
                <div class="succe_l"><img src="${webRoot}/template/bdw/statics/images/detail_layerSuecc.gif"/></div>
                <div class="succe_r">
                    <h3>是否查看投票结果？</h3>
                    <div class="tips"><a href="${webRoot}/questionnaireResult.ac?questionnaireId=${resultProxy.questionnaireId}"><button style="color: red;cursor: pointer">查看</button></a></div>
                    <div class="closeView"><button onclick="closeShoppingCartTip();">关闭</button></div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--是否查看结果弹出层--结束--%>

</body>
</html>
