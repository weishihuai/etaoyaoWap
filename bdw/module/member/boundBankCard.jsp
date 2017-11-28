<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${bdw:getBoundUserBankCards()}" var="boundUserBankCards"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}"/>
    <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}"/>
    <%--SEO description优化--%>
    <%--<title>${webName}-绑定银行卡管理-${sdk:getSysParamValue('index_title')}</title> --%>
    <title>绑定银行卡管理-${webName}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" language="javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/boundBankCard.js"></script>
    <script type="text/javascript">
        var dataValue = {
            webRoot: "${webRoot}" //当前路径
        };
    </script>
</head>
<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg">
    <div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> > <a
            href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >绑定银行卡
    </div>
</div>
<%--面包屑导航 end--%>
<%--绑定银行卡 start--%>
<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <h2 class="rightbox_h2_border">绑定银行卡</h2>
        <div class="adress right_box_border">
            <%--绑定银行卡信息输入 start--%>
            <div class="t1">
                <h4><b>新增绑定银行卡</b></h4>
                <input id="userBankCardId" name="userBankCardId" type="hidden"/>

                <div class="newAddress">
                    <div class="fixBox">
                        <label style="width:120px"><span>*</span>持卡人姓名：</label>

                        <div class="put"><input id="userName" class="w1" type="text" style="width:158px;"/><span id="alert" style="padding-left:5px;"></span></div>
                    </div>
                    <div class="fixBox">
                        <label style="width:120px"><span>*</span>银行卡号：</label>

                        <div class="put"><input id="bankCardNum" name="bankCardNum" type="text" maxlength="19"/>
                            <span id="alert1" style="padding-left:5px;"></span>
                        </div>
                    </div>
                    <div class="fixBox">
                        <label style="width:120px"><span>*</span>手机号码：</label>
                        <div class="put"><input id="userTelephone" name="userTelephone" type="text" maxlength="20"/><span id="alert2" style="padding-left:5px;"></span></div>
                    </div>
                    <div class="fixBox">
                        <label style="width:120px"><span>*</span>身份证号码：</label>
                        <div class="put"><input id="userIdentityCardNum" name="userIdentityCardNum" type="text" maxlength="18"/><span id="alert3" style="padding-left:5px;"></span></div>
                    </div>
                    <div class="btn"><a id="btnAdd" href="javascript:" title="保存收货人信息" style="margin-left:50px;">保存银行卡信息</a></div>
                </div>
            </div>
            <%--绑定银行卡输入 end--%>
            <%--绑定银行卡列表 start--%>
            <div class="t2">
                <h3>已绑定的有效银行卡</h3>
                <table width="100%" border="0" cellspacing="0">
                    <tr class="tr1">
                        <td class="td1" style="width:300px;">持卡人姓名</td>
                        <td class="td2">银行卡号</td>
                        <td class="td4">手机号码</td>
                        <td class="td3" style="text-align:center">身份号码</td>
                        <td class="td3" style="text-align:center">操作</td>
                    </tr>
                    <c:forEach end="10" items="${boundUserBankCards}" var="userBankCard">
                        <tr>
                            <td class="td1">${userBankCard.userName}</td>
                            <td class="td2">${userBankCard.bankCardNum}</td>
                            <td class="td3" style="text-align:center;">${userBankCard.userTelephone}</td>
                            <td class="td5">${userBankCard.userIdentityCardNum}</td>
                            <td class="td7">
                                <a class="update" name="btnAlt" href="javascript:" userBankCardIdUpdate="${userBankCard.userBankCardId}" title="修改">修改</a> |
                                <a class="delete" name="btnAlt1" href="javascript:" userBankCardIdUpdate="${userBankCard.userBankCardId}" title="删除">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <%--绑定银行卡列表 end--%>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--绑定银行卡end--%>
<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
