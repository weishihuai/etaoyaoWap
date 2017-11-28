<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${webRoot}/template/bdw/statics/css/loginDialog.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.md5.js"></script>
<script language="javascript" type="text/javascript"
        src="${webRoot}/template/bdw/statics/js/loginDialog.js"></script>
<script language="javascript" type="text/javascript"
        src="${webRoot}/template/bdw/statics/js/loginValidateCode.js"></script>
<div class="login-layer" style="display: none;">
    <div class="d-layer login">
        <div class="mt">
            <span>您尚未登录</span>
            <a href="javascript:;" class="close"></a>
        </div>
        <form method="post" id="loginForm" name="loginForm">
            <div class="mc">
                <div class="mc-top">
                    <span>会员登录</span>
                    <a href="${webRoot}/register.ac">注册新用户</a>
                </div>
                <div class="item-fore1"><input type="text" id="loginId" onclick="getFocus(this,'邮箱/手机号码')"
                                               placeholder="用户名/邮箱/手机号码"></div>
                <div class="item-fore2"><input type="password" id="userPsw" name="userPsw" placeholder="密码"></div>
                <%--<div class="item-fore3" id="validateCodeField">
                    <input style="float: left;" type="text" name="validateCode" id="validateCode" maxlength="4"
                           placeholder="验证码">

                    <div class="codeImg" style="float: left;padding-left: 10px;line-height: 37px;"><img
                            id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'> <a
                            href="javascript:void(0)" onclick="changValidateCode();return false;">换一个</a></div>
                </div>--%>
                <div class="forget">
                    <div class="clear"></div>
                    <div id="alert" style="display: none;color:red;text-align: left; width:194px;height: 41px;line-height:41px;float: left">
                        <div class="l-l"></div>
                        <div class="t-b" id="alerttext"></div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>

                    <div class="clear"></div>
                    <div id="alert2" style="display: none;color:red;text-align: left;line-height:41px;width:194px;height: 41px;">
                        <div class="l-l"></div>
                        <div class="t-b" id="alerttext1"></div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                    <a href="${webRoot}/fetchPsw/fetchPsw.ac">忘记密码？</a>
                    <div class="clear"></div>
                    <div id="alert3" style="display: none;color:red;text-align: left;width:194px;line-height:41px;height: 41px;">
                        <div class="l-l"></div>
                        <div class="t-b" id="alerttext2"></div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>


                </div>
                <a href="javascript:;" onclick="$('#loginForm').submit();" class="l-btn">登 录</a>

                <div class="coagent">
                    <h5>使用合作网站账号登录：</h5>
                    <ul>
                        <c:if test="${sdk:checkMultiLoginIsEnable('1')=='Y'}">
                            <li><a href="${webRoot}/OAuth/toQQLogin.ac">QQ<span>|</span></a></li>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('0')=='Y'}">
                            <li><a href="${webRoot}/OAuth/toWeiboLogin.ac">微博<span>|</span></a></li>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('2')=='Y'}">
                            <li><a href="${webRoot}/OAuth/toTaobaoLogin.ac">淘宝<span>|</span></a></li>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('6')=='Y'}">
                            <li><a href="${webRoot}/OAuth/toDoubanLogin.ac">豆瓣<span>|</span></a></li>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('3')=='Y'}">
                            <li><a href="${webRoot}/OAuth/toRenrenLogin.ac">人人网<span>|</span></a></li>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('5')=='Y'}">
                            <li><a href="${webRoot}/OAuth/toKaixinLogin.ac">开心网</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </form>
    </div>
</div>
