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
        <div class="main m-my-aliapy">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="control-label">真实姓名</label>
                    <div class="input-group">
                        <a class="clear" href="javascript:void(0);"></a>
                        <c:choose>
                            <c:when test="${empty param.alipayOpenManName}">
                                <input class="form-control" type="text" placeholder="请输入真实姓名" id="alipayOpenManName" />
                            </c:when>
                            <c:otherwise>
                                <input class="form-control" type="text" placeholder="请输入真实姓名" id="alipayOpenManName" value="${param.alipayOpenManName}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label">支付账号</label>
                    <div class="input-group">
                        <a class="clear" href="javascript:void(0);"></a>
                        <c:choose>
                            <c:when test="${empty param.alipayAccount}">
                                <input class="form-control" type="text"  placeholder="请输入支付账号" id="alipayAccount" />
                            </c:when>
                            <c:otherwise>
                                <input class="form-control" type="text"  placeholder="请输入支付账号" id="alipayAccount" value="${param.alipayAccount}" />
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

                <a class="btn-block" href="javascript:upateAlipayInfo();">提交保存</a>
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
            <input type="hidden" name="withdrawalWayCode" value="${alipay}" id="withdrawalWayCodeHide">
            <input type="hidden" name="validateCode" id="validateCodeHide">
            <input type="hidden" name="isNeedValidateCode" value="${yes}">
        </form>

        <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/base.js" type="text/javascript"></script>
        <script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/myProfile.js" type="text/javascript"></script>
        <script type="text/javascript">
            var webParams = {
                webRoot: '${webRoot}',
                type: '3',
                sendSmsFrequency:'${sendSmsFrequency}'
            }
        </script>
    </body>
</html>

