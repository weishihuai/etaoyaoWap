<%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-5-29
  Time: 上午11:41
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
    <title>${webName}-会员注册-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/checkMobile.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/jquery.validate.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/additional-methods.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.passwordStrength.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.md5.js" type="text/javascript" ></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/register.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<%--<div id="register" >
    <div class="newRegist" style="width:1080px;" >--%>
        <%--<form >
            <div class="l">
                <h2>请填写信息</h2>
                <div class="fixBox" style="margin-top: 15px">
                    <label>手机号码：</label>
                    <div class="put"><input id="mobile" name="mobile" value="${param.mobile}" maxlength="20" type="text"/></div>
                    <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                    <div class="tips" id="loginIdTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>

                <div class="fixBox">
                    <label>验证码：</label>
                    <div class="put" style="width:90px;"><input style="width:80px;" class="code" type="text"  name=code" id="code"  maxlength="6" tabindex="3"/></div>
                    <div class="codeImg" style="float:left;margin-top: 3px;">
                         <a href="javascript:void(0)" onclick="sendCode();" style="display: block;float: left;margin-left: 5px;" id="second">
                             发送验证码
                         </a>
                    </div>
                    <div class="tips" id="checkValidateCodeTip" style="display: none; width:auto;">
                        <div class="l-l"></div>
                        <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>


                <div class="btn">
                    <a href="javascript:" onclick="checkMobile();">确定</a>
                </div>
            </div>
        </form>--%>
        <%--<div style="float: left;">
            <div class="show frameEdit" frameInfo="register_page|600X315" style="width:600px;height:315px;">
                <c:forEach items="${sdk:findPageModuleProxy('register_page').advt.advtProxy}" var="adv" end="0" varStatus="s">
                    <a href="${adv.link}"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="600px" height="315px" /></a>
                </c:forEach>
            </div>
        </div>--%>
        <div class="reg-bg">
            <div class="w">
                <form method="post" id="registerForm" name="registerForm" >
                    <input id="userMobile" name="userMobile" type="hidden" value="">
                    <input id="userEmail" name="userEmail" type="hidden" value="">
                    <input id="registerType" name="registerType" type="hidden" value="">
                    <input value="${param.fid}" name="fid" type="hidden"/>
                    <div class="lt">
                        <h4>Hi，欢迎注册成为${webName}用户！ </h4>
                        <div class="item fore1">
                            <span class="label">手机号</span>
                            <input type="text" class="highlight1" autocomplete="off" id="loginId" name="loginId" placeholder="请输入您的手机号码">
                            <div class="pass" style="display:none;"><img src="/template/bdw/statics/images/register_passIco.gif" /></div>
                            <div class="tips" id="loginIdTip" style="display: none; width:300px;">
                                <div class="l-l"></div>
                                <div class="t-b"><img src="/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                                <div class="r-l"></div>
                                <div class="clear"></div>
                            </div>
                        </div>

                        <div class="item fore2">
                            <span class="label">设置密码</span>
                            <input placeholder="请输入您的密码" autocomplete="off" name="userPsw" onclick="return checkPsw()" onblur="return checkPsw()"  id="userPsw" type="password">
                            <div class="pass" style="display:none;"><img src="/template/bdw/statics/images/register_passIco.gif" /></div>
                            <div class="tips" id="userPswTip" style="display: none; width:300px;;">
                                <div class="l-l"></div>
                                <div class="t-b"><img src="/template/bdw/statics/images/register_ico01.gif" />&nbsp;<span></span>&nbsp;</div>
                                <div class="r-l"></div>
                                <div class="clear"></div>
                            </div>

                        </div>
                        <div class="item fore2">
                            <span class="label">确认密码</span>
                            <input  placeholder="请确认您的密码" autocomplete="off" name="checkPassword"  onclick="return cheCkcheckPsw()" onblur="return cheCkcheckPsw()" id="checkPassword" type="password" >
                            <div class="pass" style="display:none;"><img src="/template/bdw/statics/images/register_passIco.gif" /></div>
                            <div class="tips" id="checkPasswordTip" style="display: none; width:300px;">
                                <div class="l-l"></div>
                                <div class="t-b"><img src="/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                                <div class="r-l"></div>
                                <div class="clear"></div>
                            </div>
                        </div>
                        <div class="PasswordTipsBox" style="display:block;margin-top:10px;">
                            <%--&lt;%&ndash;密码强度提示框&ndash;%&gt;--%>
                            <div class="powerTip">
                                <div style="float:left;margin-top:-3px;padding-right: 5px;margin-left: 15px;">密码强度</div>
                                <div style="height:7px;overflow:hidden;">
                                    <div id="passwordStrengthDiv" class="is0"></div>
                                </div>
                            </div>
                            <%--&lt;%&ndash;密码确认框&ndash;%&gt;--%>
                        </div>
                        <div class="codeContainer">
                            <input  type="text" autocomplete="off" placeholder="请输入验证码" class="code" name="code" id="code"/>
                            <div class="codeSpan">
                                <span><a href="javascript:void(0)" onclick="sendCode();" id="second">获取短信验证码</a></span>
                            </div>
                            <div class="tips" id="checkValidateCodeTip" style="display: none; width:300px;">
                                <div class="l-l"></div>
                                <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                                <div class="r-l"></div>
                                <div class="clear"></div>
                            </div>
                        </div>
                        <div class="protocol">
                            <input  type="checkbox" name="tongYi" id="tongYi" />
              <%--              <c:set value="${sdk:getArticleCategoryById(7).userAgreement.top}" var="article"/>--%>
                            <a href="javascript:" id="content" style="display: none;">${sdk:getSysParamValue('register_provisions')}</a>
                       <span>我已阅读并接受<a  href="javascript:" id="userAgreement">《${webName}用户服务协议》</a>
                        </span>
                        </div>
                        <a href="javascript:void(0)" onclick="checkRegisterForm();" class="agree-btn">同意协议并注册</a>
                        <div class="coagent">
                            <h5>使用合作网站账号登录：</h5>
                            <ul>
                            </ul>
                        </div>
                    </div>
                </form>
                <div class="rt">
                    <span>已有会员账号？</span>
                    <a href="/login.ac">快速登录</a>
                </div>
            </div>
        </div>



<%--
<div class="submitFormContainer">
    <form class="submitForm" id="registerForm" name="registerForm">
        <input value="${param.fid}" name="fid" type="hidden"/>
        <div class="submitFormSub">
            <div class="loginSpan">
                <span>已有账号？<a href="${webRoot}/login.ac">登录</a></span>
            </div>
            <div class="clear"></div>
            <div class="info-item">
                <div class="mobileContainer fixBox">
                    <span>手&ensp;机&ensp;号：&ensp;</span>
                    <input  type="text" autocomplete="off" class="mobile" id="loginId" name="loginId" placeholder="请输入您的手机号"/>
                </div>
                <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                <div class="tips" id="loginIdTip" style="display: none; width:auto;">
                    <div class="l-l"></div>
                    <div class="t-b"><img src="" />&nbsp;<span></span>&nbsp;</div>
                    <div class="r-l"></div>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="info-item">
                <div class="passwordContainer fixBox">
                    <span>设置密码：&ensp;</span><input type="password" autocomplete="off" class="password" placeholder="请输入您的密码" name="userPsw" onclick="return checkPsw()" onblur="return checkPsw()"  id="userPsw" />
                </div>
                <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                <div class="tips" id="userPswTip" style="display: none;">
                    &lt;%&ndash;<div class="l-l"></div>&ndash;%&gt;
                    <div class="t-b"><img src="${webRoot}/template/bdw/statics//images/register_ico01.gif" />&nbsp;<span></span>&nbsp;</div>
                    &lt;%&ndash;<div class="r-l"></div>&ndash;%&gt;
                    <div class="clear"></div>
                </div>
            </div>

            <div class="info-item">
                <div class="passwordConfirmContainer">
                    <span>确认密码：&ensp;</span><input type="password" autocomplete="off" class="passwordConfirm" name="checkPassword"  onclick="return cheCkcheckPsw()" onblur="return cheCkcheckPsw()" id="checkPassword" placeholder="请确认您的密码" />
                </div>
                <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics//images/register_passIco.gif" /></div>
                <div class="tips" id="checkPasswordTip" style="display: none; width:auto;">
                    <div class="l-l"></div>
                    <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                    <div class="r-l"></div>
                    <div class="clear"></div>
                </div>
            </div>

            <div class="PasswordTipsBox" style="display:block;margin-top:10px;">
                &lt;%&ndash;密码强度提示框&ndash;%&gt;
                <div class="powerTip">
                    <div style="float:left;margin-top:-3px;padding-right: 5px;margin-left: 15px;">密码强度</div>
                    <div style="height:7px;overflow:hidden;">
                        <div id="passwordStrengthDiv" class="is0"></div>
                    </div>
                </div>
                &lt;%&ndash;密码确认框&ndash;%&gt;
            </div>
            <div class="codeContainer">
                <input  type="text" autocomplete="off" placeholder="请输入验证码" class="code" name="code" id="code"/>
                <div class="codeSpan">
                    <span><a href="javascript:void(0)" onclick="sendCode();" id="second">获取短信验证码</a></span>
                </div>
                <div class="tips" id="checkValidateCodeTip" style="display: none; width:auto;">
                    <div class="l-l"></div>
                    <div class="t-b"><img src="${webRoot}/template/bdw/statics/images/register_ico02.gif" />&nbsp;<span></span>&nbsp;</div>
                    <div class="r-l"></div>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="clear"></div>
            <div class="protocol">
                <input  type="checkbox" name="tongYi" id="tongYi" />
                <c:set value="${sdk:getArticleCategoryById(7).userAgreement.top}" var="article"/>
                <a href="javascript:" id="content" style="display: none;">${article.articleCont}</a>
                       <span>我已阅读并接受
                           <c:choose>
                               <c:when test="${not empty article}">
                                   <a  href="javascript:" id="userAgreement">《${webName}用户服务协议》</a>
                               </c:when>
                               <c:otherwise>
                                   <a href="javascript:" id="unRelease">《${webName}用户服务协议》</a>
                               </c:otherwise>
                           </c:choose>
                        </span>
            </div>
            <div class="submit">
                <a href="javascript:" onclick="checkRegisterForm()">立即注册</a>
            </div>
            &lt;%&ndash;<a class="submit" href="javascript:" onclick="checkRegisterForm()">立即注册</a>&ndash;%&gt;
            &lt;%&ndash;<input type="submit" value="立即注册" class="submit" onclick="checkRegisterForm()" />&ndash;%&gt;
        </div>
    </form>
</div>--%>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
