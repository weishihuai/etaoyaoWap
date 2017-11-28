<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>申请推广员</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/myPromoteRegister.css">

    <c:set value="${sdk:getSysParamValue('promotion_alliance_agreement')}" var="promoteProtocol" /><%--CPS推广协议--%>
</head>
<body style="background-color: #f8f8f8;">

<div class="main m-expand">
    <%--<header class="header">
        <a href="javascript:history.go(-1);" class="back"></a>
        <div class="header-title">申请推广员</div>
    </header>--%>
    <ul class="tab-nav">
       <%-- <li class="active" id="bankCard">
            <a href="javascript:void(0);">银行卡</a>
        </li>--%>
        <li class="active" id="alipay">
            <a href="javascript:void(0);">支付宝信息</a>
        </li>
    </ul>

    <div class="tab-content">
        <!-- 银行卡 -->
       <%-- <div class="tabpanel div-bank-card">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="control-label" >银行信息</label>
                    <div class="input-group">
                        <a class="toggle" href="javascript:void(0);"></a>
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
                    <label class="control-label" >支行信息</label>
                    <div class="input-group">
                        <a class="clear" href="javascript:void(0);"></a>
                        <c:choose>
                            <c:when test="${empty param.bankInf}">
                                <input class="form-control" type="text" value="" placeholder="请输入支行所在信息" id="bankInfo" />
                            </c:when>
                            <c:otherwise>
                                <input class="form-control" type="text" value="${param.bankInf}" placeholder="请输入支行所在信息" id="bankInfo" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label" >开户人名</label>
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
                <div class="form-group last">
                    <label class="control-label" >银行卡号</label>
                    <div class="input-group">
                        <a class="clear" href="javascript:void(0);"></a>
                        <c:choose>
                            <c:when test="${empty param.bankAccount}">
                                <input class="form-control" type="text" value="" placeholder="请输入银行卡账号" id="bankAccount" />
                            </c:when>
                            <c:otherwise>
                                <input class="form-control" type="text" value="${param.bankAccount}" placeholder="请输入银行卡账号" id="bankAccount" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="agreement">
                    <div class="checkbox">
                        <input type="checkbox" name="" id="chk1" checked onchange="agreement(this, 'btn-block1')" />
                        <label for="chk1">
                            <i class="icon-chk"></i>同意
                        </label>
                    </div>
                    <a class="deal-toggle" href="javascript:void(0);">&#12298;推广联盟协议&#12299;</a>
                </div>

                <c:choose>
                    <c:when test="${empty param.id}">
                        <a class="btn-block btn-block1" href="javascript:submitRegisterInfo();">下一步</a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn-block btn-block1" href="javascript:submitRegisterInfo();">下一步</a>
                    </c:otherwise>
                </c:choose>
            </form>
        </div>--%>

        <!-- 支付宝 -->
        <div class="tabpanel div-alipay">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="control-label" >真实姓名</label>
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

                <div class="form-group last">
                    <label class="control-label" >支付账号</label>
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

                <div class="agreement">
                    <div class="checkbox">
                        <input type="checkbox" name="" id="chk2" checked onchange="agreement(this, 'btn-block2')" />
                        <label for="chk2">
                            <i class="icon-chk"></i>同意
                        </label>
                    </div>
                    <a class="deal-toggle" href="javascript:void(0);">&#12298;推广联盟协议&#12299;</a>
                </div>

                <c:choose>
                    <c:when test="${empty param.id}">
                        <a class="btn-block btn-block2" href="javascript:submitRegisterInfo();">下一步</a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn-block btn-block2" href="javascript:submitRegisterInfo();">下一步</a>
                    </c:otherwise>
                </c:choose>
            </form>
        </div>
    </div>
</div>

<!--推广联盟协议弹窗-->
<div class="layer-bg" id="promoteRuleDiv" style="display:none;">
    <div class="layer">
        <div class="layer-t">
            <h3>推广联盟协议</h3><%--<%--规则或协议标题--%>
        </div>
        <div class="layer-b">
            <p>${promoteProtocol}</p><%--规则或协议内容--%>
        </div>
        <a class="close-btn" href="javascript:void(0);"></a>
    </div>
</div>


<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/myPromoteRegisterSecondStep.js"></script>

<script type="text/javascript">
    var webPath = {webRoot:"${webRoot}"};
    var userName = '${param.userName}';
    var userPhone = '${param.userPhone}';
    var memberId="${param.id}";
    var approveStat="${param.approveStat}";
    var withdrawalWayCode="${param.withdrawalWayCode}"
</script>
</body>

</html>
