<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--判断是否登录--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="loginUrl" value="${webRoot}/wap/noLogin.ac"/>
<c:if test="${empty loginUser}">
    <c:redirect url="${loginUrl}"/>
</c:if>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>申请提现</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css" />

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsApplyWaysInf.js"></script>
    <script type="text/javascript">
     var webParams = {
    	webRoot: '${webRoot}'
   
    };
    </script>
    

</head>

<body>
    <%--<header class="header">
        <a href="javascript:history.go(-1);" class="back"></a>
        <div class="header-title">绑定银行卡</div>
    </header>--%>
    <div class="main">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="control-label" for="">银行信息</label>
                <div class="input-group">
                    <a class="toggle" href="javascript:;"></a>
                    <select class="form-control" id="bankName">
                            <option value="">请选择银行</option>
                            <c:choose>
                                <c:when test="${empty param.bankOfDeposit}">
                                    <c:forEach var="bankName" items="${fn:split(sdk:getSysParamValue('cashBank'),',')}">
                                        <option value="${bankName}" onclick="selectBank(this)">${bankName}</option>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="bankName" items="${fn:split(sdk:getSysParamValue('cashBank'),',')}">
                                        <c:choose>
                                            <c:when test="${param.bankOfDeposit eq bankName}">
                                                <option value="${bankName}" onclick="selectBank(this)" selected>${bankName}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${bankName}" onclick="selectBank(this)">${bankName}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label" for="">支行信息</label>
                <div class="input-group">
                    <a class="clear" href="javascript:;"></a>
                    <input class="form-control" type="text" value="" placeholder="请输入支行所在信息" id="bankInfo" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label" for="">开户人名</label>
                <div class="input-group">
                    <a class="clear" href="javascript:;"></a>
                    <input class="form-control" type="text" value="" placeholder="请输入开户人姓名" id="bankOpenManName" id="bankOpenManName" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label" for="">银行卡号</label>
                <div class="input-group">
                    <a class="clear" href="javascript:;"></a>
                    <input class="form-control" type="text" value="" placeholder="请输入银行卡账号" id="bankAccount"/>
                </div>
            </div>

            <a class="btn-block" href="javascript:submitBink();">提交保存</a>
        </form>
    </div>

    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
</body>

</html>
