<%--
  Created by IntelliJ IDEA.
  User: xws
  Date: 12-8-8
  Time: 上午10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-完善账户信息-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <style type="text/css">
        #member .rBox{width:980px;}
        #member .rBox .myInformation{width:980px;}
        #member .rBox .myInformation .box{width: 978px;}
        #model-login {background: none repeat scroll 0 0 #FFFDEE;border: 1px solid #EDD28B;line-height: 30px;margin: 20px 40px 20px;padding: 10px 15px;}
        #member .rBox .myInformation .box .btn{float: left;}
    </style>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.md5.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/regbind.js"></script>
    <script type="text/javascript">
        <%--初始化参数，供myInformation.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}",  //当前地址
            email:"${loginUser.email}"  //用户email
        };
        <%--初始化参数，供myInformation.js调用 end--%>
    </script>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--个人资料设置 start--%>
<div id="member">
    <div class="rBox">
        <%--填写信息 start--%>
        <div class="myInformation">
            <h2 class="rightbox_h2_border">完善个人资料</h2>
            <div class="box right_box_border">
                <div id="myInfo">
                    <div class="model-prompt" id="model-login">
                        <dl>
                            <dt>${webName}欢迎您！ 接下来只要简单完善下您的账户信息就OK了！</dt>
                            <dd>完善信息后可用您定义的账户名直接访问${webName}，随时随地享受愉快的购物之旅！</dd>
                        </dl>

                    </div>

                    <form id="infoForm" name="infoForm" onsubmit="return false;" method="post">
                        <div class="fixBox">
                            <label>登录帐号：</label>
                            <div class="tex">${loginUser.loginId}</div>
                            <div class="clear"></div>
                        </div>
                        <div class="fixBox" id="userName_div">
                            <label>真实姓名：</label>
                            <div class="put"><input id="userName" name="userName" type="text" value="${loginUser.userName}" maxlength="48" onclick="return checkUserName();" onblur="return checkUserName();" /></div>
                            <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                            <div class="tips" id="userNameTips" style="display:none; width:125px;">
                                <div class="l-l"></div>
                                <div class="t-b" id="userNameMsg"></div>
                                <div class="r-l"></div>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="fixBox"  id="mobile_div">
                            <label>手机号码：</label>
                            <div class="put"><input id="mobile" name="userMobile" type="text" value="${loginUser.mobile}" maxlength="24"  onclick="return checkMobile()" onblur="return checkMobile()" /></div>
                            <div class="pass" style="display:none;"><img alt="" src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                            <div class="tips" id="mobileTips" style="display:none; width:205px;">
                                <div class="l-l"></div>
                                <div class="t-b" id="mobileMsg"></div>
                                <div class="r-l"></div>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="fixBox" id="email_div">
                            <label>E-mail：</label>
                            <div class="put"><input id="userEmail" name="userEmail" type="text" value="${loginUser.email}" onclick="return checkUserMailValidate()" onblur="return checkUserMailValidate()" /></div>
                            <div class="pass" style="display:none;"><img alt="" src="${webRoot}/template/bdw/statics/images/register_passIco.gif" /></div>
                            <div class="tips" id="emailTips" style="display:none; width:180px;">
                                <div class="l-l"></div>
                                <div class="t-b" id="emailMsg"></div>
                                <div class="r-l"></div>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="btn"><a href="javascript:" onclick="saveUserInfo()" title="保存设置">保存设置</a></div>
                        <a style="float: left;padding:30px 0 0 10px;color: #005EA7;" href="${webRoot}/index.ac">以后再说，立即去购物！</a>
                    </form>
                </div>
            </div>
        </div>
        <%--填写信息 end--%>
    </div>
    <div class="clear"></div>
</div>
<%--个人资料设置 end--%>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
