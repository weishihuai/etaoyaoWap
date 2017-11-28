<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.passwordStrength.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/myPswModify.js"></script>
    <script type="text/javascript" language="javascript">
        <%--初始化参数，供myPswModify.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
        <%--初始化参数，供myPswModify.js调用 end--%>
    </script>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a title="首页" href="${webRoot}/index.html">首页</a> >  <a href="${webRoot}/module/member/index.ac" tetle="会员中心">会员中心</a> >  帐号与密码 </div></div>
<%--面包屑导航 end--%>

<%--个人资料设置 start--%>
<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <%--修改密码 start--%>
        <div class="myInformation">
            <h2 class="rightbox_h2_border">个人资料</h2>
            <div class="box  right_box_border">
                <%--tab栏目 start--%>
                <div class="myTAB">
                    <a title="个人信息" class="" href="${webRoot}/module/member/myInformation.ac">个人信息</a>   |
                    <a title="修改头像" class="" href="${webRoot}/module/member/myUserIcon.ac">修改头像</a>   |
                    <a title="帐号与密码" class="cur" href="${webRoot}/module/member/myPswModify.ac">帐号与密码</a>
                </div>
                <%--tab栏目 end--%>

                <div>
                    <%--当前密码 start--%>
                    <div class="fixBox" id="password_div">
                        <label>当前密码：</label>

                        <div class="put"><input type="password" id="password" onblur="return checkPassword()"/></div>
                        <div class="pass" style="display:none;"><img alt="" src="${webRoot}/template/bdw/statics/images/register_passIco.gif"/>
                        </div>
                        <div class="tips" id="passwordTips" style="display:none; width:216px;">
                            <div class="l-l"></div>
                            <div class="t-b" id="passwordMsg"></div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <%--当前密码 end--%>

                    <div class="tip">提示：密码修改成功后，请使用新密码登录。</div>
                    <%--新密码 start--%>
                    <div class="fixBox" id="new_password_div">
                        <label>新密码：</label>

                        <div class="put"><input type="password" id="new_password" onblur="return checkNewPassword()" maxlength="16"/>
                        </div>
                        <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif"/>
                        </div>
                        <div class="tips" id="new_passwordTips" style="display:none; width:216px;">
                            <div class="l-l"></div>
                            <div class="t-b" id="new_passwordMsg"></div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <%--新密码 end--%>

                    <%--密码强度 start--%>
                    <div class="Newpw_t">
                        <div style="float:left;margin-top:-3px;padding-right: 5px;">密码强度</div>
                        <div style="height:7px;overflow:hidden;">
                            <div id="passwordStrengthDiv" class="is0"></div>
                        </div>
                    </div>
                    <%--密码强度 end--%>

                    <%--确认新密码 start--%>
                    <div class="fixBox" id="confirm_Password_div">
                        <label>确认新密码：</label>

                        <div class="put"><input type="password" id="confirm_Password" onblur="return checkConfirmPassword()"
                                                maxlength="16"/></div>
                        <div class="pass" style="display:none;"><img src="${webRoot}/template/bdw/statics/images/register_passIco.gif"/>
                        </div>
                        <div class="tips" id="confirm_PasswordTips" style="display:none; width:216px;">
                            <div class="l-l"></div>
                            <div class="t-b" id="confirm_PasswordMsg"></div>
                            <div class="r-l"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <%--确认新密码 end--%>
                    <div class="btn"><a href="javascript:" onclick="modPsw()">保存设置</a></div>
                </div>
            </div>
        </div>
        <%--修改密码 end--%>
    </div>
    <div class="clear"></div>
</div>
<%--个人资料设置 end--%>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
