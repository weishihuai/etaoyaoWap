<%--
  Created by IntelliJ IDEA.
  User: xws
  Date: 12-6-12
  Time: 上午11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-${sdk:getSysParamValue('index_title')}-提交投诉建议</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidator-4.1.1.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidatorRegex.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/suggest.js"></script>
</head>

<%--客服电话--%>
<c:set value="${sdk:getSysParamValue('webPhone')}" var="webPhone" />
<%--客服邮箱--%>
<c:set value="${sdk:getSysParamValue('webEmail')}" var="webEmail" />
<%--投诉与建议类型--%>
<c:set value="${sdk:getComPlainTypeList()}" var="comPlainTypeList" />
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="getYuorGinst">
    <div class="sali">
        <div class="box">
            <form id="form1" method="post">
            <h1>${webName}的成长需要您的关爱！</h1>
            <h1>如果对网站有好的建议，在浏览网站时有疑问，或是在订购过程中需要投诉，请给我们留言，或直接联系我们。</h1>
            <h1>客服电话：<span>${webPhone} </span>客服邮箱： <span>${webEmail}</span></h1>
            <div class="fixBox">
                <label><span>*</span>&nbsp;留言类型：</label>
                <div class="put">
                <select name="complainType" id="complainType">
                    <c:forEach items="${comPlainTypeList}" var="comPlainType">
                        <option>${comPlainType}</option>
                    </c:forEach>
                </select></div>
                <div class="clear"></div>
            </div>
            <div class="fixBox">
                <label><span>*</span>&nbsp;留言内容：</label>
                <div class="put2"><textarea name="complainCont" id="complainCont"></textarea></div>
                <div id="complainContTip" style="float: left"></div>
                <div class="clear"></div>
            </div>
            <p>(请至少输入10个汉字，且不得超过500个汉字的内容)</p>
            <div class="fixBox">
                <label><span>*</span>&nbsp;手机号码：</label>
                <div class="put"><input type="text" id="memberTel" name="memberTel" /></div>
                <div id="memberTelTip" style="float: left"></div>
                <div class="clear"></div>
            </div>
            <div class="fixBox">
                <label>会员姓名：</label>
                <div class="put"><input type="text" name="memberName" id="memberName" maxlength="16" /></div>
                <div class="clear"></div>
            </div>
            <div class="fixBox">
                <label><span>*</span>&nbsp;验证码：</label>
                <div class="put"><input class="code" type="text" id="validateCode" name="validateCode" style="width: 110px;" maxlength="4" /></div>
                <div class="codeImg" style="padding-top:5px;"><img id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'> <a href="javascript:void(0)" onclick="changValidateCode();return false;" style="color: #3366CC;">换一个</a></div>
                <div id="validateCodeTip" style="float: left"></div>
                <div class="clear"></div>
            </div>
            <div class="btn"><a id="suggestBtn" href="javascript:void(0);" onclick="$('#form1').submit();">提交意见建议</a></div>
            </form>
        </div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
