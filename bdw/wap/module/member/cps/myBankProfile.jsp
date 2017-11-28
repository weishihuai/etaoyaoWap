<%@ page import="com.iloosen.imall.module.cps.domain.code.CpsPromoteMemberTypeCodeEnum" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>我的资料</title>
        <meta content="yes" name="apple-mobile-web-app-capable" />
        <meta content="yes" name="apple-touch-fullscreen" />
        <meta content="telephone=no,email=no" name="format-detection" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">
        <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/myProfile.css">

        <c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
        <c:set value="${sdk:getSysParamValue('sendSmsFrequency')}" var="sendSmsFrequency" /><%--获取短信发送倒计时--%>

        <%
            request.setAttribute("bankCard", CpsPromoteMemberTypeCodeEnum.BANK_CARD.toCode());
            request.setAttribute("alipay", CpsPromoteMemberTypeCodeEnum.ALIPAY.toCode());
            request.setAttribute("yes", BoolCodeEnum.YES.toCode());
            request.setAttribute("no", BoolCodeEnum.NO.toCode());
        %>
    </head>

    <body>
        <%--<header class="header">
            <a href="${webRoot}/wap/module/member/cps/myProfile.ac" class="back"></a>
            <div class="header-title">我的资料</div>
        </header>--%>
        <div class="main m-my-brank_card">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="control-label">银行信息</label>
                    <div class="input-group">
                        <a class="toggle" href="javascript:void(0);"></a>
                        <select class="form-control" id="bankOfDeposit">
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
                    <label class="control-label">支行信息</label>
                    <div class="input-group">
                        <a class="clear" href="javascript:void(0);"></a>
                        <c:choose>
                            <c:when test="${empty param.bankInf}">
                                <input class="form-control" type="text" value="" placeholder="请输入支行所在信息" id="bankInf" />
                            </c:when>
                            <c:otherwise>
                                <input class="form-control" type="text" value="${param.bankInf}" placeholder="请输入支行所在信息" id="bankInf" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label">开户人名</label>
                    <div class="input-group">
                        <a class="clear" href="javascript:void(0);"></a>
                        <c:choose>
                            <c:when test="${empty param.bankOpenManName}">
                                <input class="form-control" type="text" value="" placeholder="请输入开户人姓名" id="bankOpenManName" />
                            </c:when>
                            <c:otherwise>
                                <input class="form-control" type="text" value="${param.bankOpenManName}" placeholder="请输入开户人姓名" id="bankOpenManName" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label" >银行卡号</label>
                    <div class="input-group">
                        <a class="clear" href="javascript:void(0);"></a>
                        <c:choose>
                            <c:when test="${empty param.bankAccount}">
                                <input class="form-control" type="number" value="" placeholder="请输入银行卡账号" id="bankAccount" />
                            </c:when>
                            <c:otherwise>
                                <input class="form-control" type="number" value="${param.bankAccount}" placeholder="请输入银行卡账号" id="bankAccount" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group valid-group">
                    <div class="valid-div">
                        <input autocomplete="off" class="valid-in" type="number" value="" placeholder="请输入验证码" maxlength="6" id="validateCode">
                        <a class="op-icon-valid  del validateCodeDel" href="javascript:void(0);"></a>
                        <a class="get-valid" href="javascript:void(0);" onclick="getValidateCode(this)">获取验证码</a>
                        <span style="display: none;" class="count-down get-valid"></span>
                    </div>
                </div>

                <a class="btn-block" href="javascript:upateBankInfo();">提交保存</a>
            </form>
        </div>

        <div class="modal fade in" id="sysMsg" style="display: <c:choose><c:when test="${empty loginUser.mobile}">block</c:when><c:otherwise>none</c:otherwise></c:choose>;">
            <div class="modal-dropback"></div>
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">系统消息</h4>
                    </div>
                    <div class="modal-body">
                        尊敬的用户，您还没有绑定手机，请先绑定手机。
                    </div>
                    <div class="modal-footer">
                        <a class="btn-link" href="${webRoot}/wap/module/member/verify.ac?type=2">我知道了</a>
                    </div>
                </div>
            </div>
        </div>

        <form id="infoForm" type="hidden" action="">
            <input type="hidden" name="promoteMemberId" value="${param.promoteMemberId}" id="idHide">
            <input type="hidden" name="name" value="${param.name}" id="nameHide">
            <input type="hidden" name="mobile" value="${param.mobile}" id="mobileHide">
            <input type="hidden" name="bankOfDeposit" value="${param.bankOfDeposit}" id="bankOfDepositHide">
            <input type="hidden" name="bankInf" value="${param.bankInf}" id="bankInfHide">
            <input type="hidden" name="bankOpenManName" value="${param.bankOpenManName}" id="bankOpenManNameHide">
            <input type="hidden" name="bankAccount" value="${param.bankAccount}" id="bankAccountHide">
            <input type="hidden" name="alipayOpenManName" value="${param.alipayOpenManName}" id="alipayOpenManNameHide">
            <input type="hidden" name="alipayAccount" value="${param.alipayAccount}" id="alipayAccountHide">
            <input type="hidden" name="withdrawalWayCode" value="${bankCard}" id="withdrawalWayCodeHide">
            <input type="hidden" name="validateCode" id="validateCodeHide">
            <input type="hidden" name="isNeedValidateCode" value="${yes}">
        </form>


        <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/base.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/myProfile.js" type="text/javascript"></script>
        <script>
            var webParams = {
                webRoot: '${webRoot}',
                type: '3',
                sendSmsFrequency:'${sendSmsFrequency}'
            }
        </script>
    </body>
</html>
