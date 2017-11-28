<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-重置密码</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.passwordStrength.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-0.1.tip.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.md5.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:'${webRoot}',userId:'${param.userId}',validateInfCode:'${param.validateInfCode}'};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/fetchPsw.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="register">
    <div class="resulr">
        <div class="findPassword">
            <div class="fixBox">
                <label>重置密码：</label>
                <div class="put"><input id="resetPsw" type="password"  maxlength="16" /></div>
                <div class="clear"></div>
            </div>
            <div style="display: block;" class="PasswordTipsBox">
                <%--密码强度提示框--%>
                <div class="powerTip">
                    <div style="float:left;margin-top:-3px;padding-right: 5px;">密码强度</div>
                    <div style="height:7px;overflow:hidden;">
                        <div id="passwordStrengthDiv" class="is0"></div>
                    </div>
                </div>
                <%--密码确认框--%>
            </div>
            <div class="fixBox">
                <label>确认密码：</label>
                <div class="put"><input id="confirmPsw" type="password"  maxlength="16" /></div>
                <div class="clear"></div>
            </div>
            <div class="btn"><a href="javascript:void(0);" id="resetSubmit">确定</a></div>
        </div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
