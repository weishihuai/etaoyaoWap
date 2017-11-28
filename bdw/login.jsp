    <%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-5-29
  Time: 上午10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:if test="${not empty loginUser}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>

<%
    String source = request.getHeader("Referer");
    if(source!=null && !source.contains("register.ac")&&!source.contains("checkMobile.ac")){
        request.getSession().setAttribute("redirectUrl",source);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-${sdk:getSysParamValue('index_title')}-会员登录</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.md5.js"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}"
        };
    </script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/loginValidate.js"></script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/loginValidateCode.js"></script><%--登录验证插件--%>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?pageName=login"/>
<%--页头结束--%>

<div class="login-bg frameEdit" frameInfo="jvan_loginAdv">
    <div class="produ">
        <div class="show">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_loginAdv').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}" width="100%" height="100%"/></a>
             </c:forEach>
        </div>
    </div>
    <div class="l-main">
            <div class="mt">
                <a href="#" class="cur">会员登录</a>
                <a href="/register.ac">新用户注册</a>
            </div>
            <form method="post"  id="loginForm" name="loginForm" >
                <div class="mc">
                    <div class="item-fore1">
                        <input id="loginId" autocomplete="off" placeholder="请输入手机号" type="text"  onclick="getFocus(this,'请输入手机号')" tabindex="1">
                    </div>
                    <div class="item-fore2">
                        <input type="password" autocomplete="off" id="userPsw" name="userPsw" tabindex="2" placeholder="请输入密码">
                    </div>
                    <div class="item-fore3 validateDiv" id="validateCodeField" style="display: none" >
                        <input class="code" type="text"  name="validateCode" id="validateCode"  maxlength="4" tabindex="3" placeholder="验证码">
                        <div class="codeImg" style="float: left;padding-left: 10px;line-height: 37px;"><img id="validateCodeImg" src='/ValidateCode'> <a href="javascript:void(0)" onclick="changValidateCode();return false;">换一个</a></div>
                    </div>
                    <div class="forget">
                        <div  id="alert" style="display: none; width:235px;height: 27px;float: left;">
                            <div class="l-l"></div>
                            <div class="t-b" id="alerttext"></div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                        <div id="alert2" style="display: none;width:248px;height: 27px;float: left;">
                            <div class="l-l"></div>
                            <div class="t-b" id="alerttext1"></div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                        <div id="alert3" style="display: none;width:248px;height: 27px;float: left;">
                            <div class="l-l"></div>
                            <div class="t-b" id="alerttext2"></div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>

                        <a href="/fetchPsw/fetchPsw.ac">忘记密码？</a>
                    </div>
                    <a href="javascript:;" class="l-btn" onclick="$('#loginForm').submit();">登 录</a>
                    <div class="coagent">
                        <h5>使用合作网站账号登录：</h5>
                        <ul>
                        </ul>
                    </div>
                </div>
            </form>
        </div>
</div>

<%--<div id="login">
    <div class="produ">
        <div class="show frameEdit" frameInfo="jvan_loginAdv|600X380">
            <c:forEach items="${sdk:findPageModuleProxy('jvan_loginAdv').advt.advtProxy}" var="adv" end="0" varStatus="s">
                <a href="${adv.link}"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="600px" height="380px" /></a>
            </c:forEach>
        </div>
    </div>
    <form method="post"  id="loginForm" name="loginForm" >
        <input type="hidden" name="contextPath" id="contextPath" value="${webRoot}"/>
        <input type="hidden" name="redirectUrl" id="redirectUrl" value="<%=request.getRequestURI()%>"/>
        <div class="login_box">
            <div class="box">
                <h2>${webName}用户登录</h2>
                <div class="fixBox">
                    <label>用户名：</label>
                    <div class="put"><input id="loginId" placeholder="请输入员工号或手机号" type="text"  onclick="getFocus(this,'请输入员工号或手机号')" tabindex="1" /></div>
                    <div class="clear"></div>
                    &lt;%&ndash;帐号错误提示区块&ndash;%&gt;
                    <div  id="alert" style="display: none; width:194px; margin-left: 103px;height: 27px;">
                        <div class="l-l"></div>
                        <div class="t-b" id="alerttext"></div>
                        <div class="r-l"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="fixBox">
                    <label>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                    <div class="put"><input type="password"  id="userPsw" name="userPsw" tabindex="2" /></div>
                    <div class="clear"></div>
                    <div id="alert2" style="display: none;width:194px; margin-left: 103px;height: 27px;">
                        <div class="l-l"></div> <div class="r-l"></div>
                        <div class="t-b" id="alerttext1"></div>
                        <div class="clear"></div>
                    </div>
                </div>
                    <div class="fixBox" style="display:none;" id="validateCodeField">
                        <label>验证码：</label>
                        <div class="put"><input class="code" type="text"  name="validateCode" id="validateCode"  maxlength="4" tabindex="3"/></div>
                        <div class="codeImg"><img id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'> <a href="javascript:void(0)" onclick="changValidateCode();return false;">换一个</a></div>
                        <div class="clear"></div>
                        <div id="alert3" style="display: none;width:194px; margin-left: 103px;height: 27px;">
                                      <div class="l-l"></div>
                                      <div class="t-b" id="alerttext2"></div>
                                      <div class="r-l"></div>
                                      <div class="clear"></div>
                                  </div>
                    </div>
                <div class="btnArea">
                    <div class="btn"><a href="javascript:" onclick="$('#loginForm').submit();">登录</a></div>
                    <div class="forget"><a href="${webRoot}/fetchPsw/fetchPsw.ac">忘记密码？</a></div>
                    <div class="clear"></div>
                </div>
               &lt;%&ndash; <div class="loginForOther">
                    <p>使用合作网站帐号登录：</p>
                     <ul>
                        <c:if test="${sdk:checkMultiLoginIsEnable('1')=='Y'}">
                            <a href="${webRoot}/OAuth/toQQLogin.ac"><div class="li1"></div></a>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('0')=='Y'}">
                            <a href="${webRoot}/OAuth/toWeiboLogin.ac"><div class="li2"></div></a>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('2')=='Y'}">
                            <div class="li3"><a href="${webRoot}/OAuth/toTaobaoLogin.ac"><span>淘宝</span></a></div>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('6')=='Y'}">
                            <div class="li4"><a href="${webRoot}/OAuth/toDoubanLogin.ac"><span>豆瓣</span></a></div>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('3')=='Y'}">
                            <div class="li5"><a href="${webRoot}/OAuth/toRenrenLogin.ac"><span>人人网</span></a></div>
                        </c:if>
                        <c:if test="${sdk:checkMultiLoginIsEnable('5')=='Y'}">
                            <div class="li6"><a href="${webRoot}/OAuth/toKaixinLogin.ac"><span>开心网</span></a></div>
                        </c:if>
                    </ul>
                </div>&ndash;%&gt;
                <div class="doles">
                    <h1>还不是${webName}的用户？</h1>
                    <p>轻松注册，就可以方便购物！ <a href="${webRoot}/checkMobile.ac">注册成为新用户</a></p>
                    &lt;%&ndash;todo 2016年11月16日 暂时屏蔽掉&ndash;%&gt;
                   &lt;%&ndash; <p>
                        <a href="${webRoot}/scanCodeLogin.ac"><img width="16px" height="16px" src="${webRoot}/template/bdw/statics/images/logo/weixin_login.png"><span style="color: #666;margin-left: 5px;">微信扫码</span></a>
                    </p>&ndash;%&gt;
                </div>
            </div>
            <div class="b_line"></div>
        </div>
        <div class="clear"></div>
    </form>
</div>--%>

<c:import url="/template/bdw/module/common/bottom.jsp"/>
</body>
</html>
