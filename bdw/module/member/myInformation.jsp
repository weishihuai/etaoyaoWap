<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:set value="${empty param.fromOtoo ? 0 : 1}" var="fromOtoo"/>
<%--<c:set value="${empty param.fromPayment ? 0 : 1}" var="fromPayment"/>--%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-个人资料-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.Jcrop.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.md5.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/myInformation.js"></script>
    <script type="text/javascript">
        <%--初始化参数，供myInformation.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}",  //当前地址
            email:"${loginUser.email}"  //用户email
        };
        <%--初始化参数，供myInformation.js调用 end--%>

        var fromOtoo = ${fromOtoo};//是否因为没有注册而从otoo付款跳转到此页面
        /*var fromPayment = ${fromPayment} */ //支付时如果没有绑定手机号跳转回此页面
    </script>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> >  <a href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >  个人信息</div> </div>
<%--面包屑导航 end--%>

<%--个人资料设置 start--%>
<div id="member">
    <%--左边菜单栏 start--%>
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <%--填写信息 start--%>
        <div class="myInformation">
            <h2 class="rightbox_h2_border">个人资料</h2>
            <div class="box right_box_border">
                <div class="myTAB">
                    <a title="个人信息" class="cur" href="${webRoot}/module/member/myInformation.ac">个人信息</a>   |
                    <a title="修改头像" class="" href="${webRoot}/module/member/myUserIcon.ac">修改头像</a>   |
                    <a title="帐号与密码" class="" href="${webRoot}/module/member/myPswModify.ac">帐号与密码</a>
                </div>
                <div id="myInfo">
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
                        <div class="fixBox">
                            <label>会员等级：</label>
                            <div class="tex2"><p> ${loginUser.level} </p></div>
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
                        <div class="tip">提示：手机号码修改后，请使用新的手机号码进行登录。</div>
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
