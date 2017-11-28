<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-返利记录-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>


<body>

<c:import url="/template/bdw/module/common/top.jsp?p=member"/>

<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="#">首页</a> >  <a href="#">美妆</a> >  面部保养 </div></div>


<div id="member">
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <div class="rBox">
        <div class="history">
            <h2>返利记录</h2>
            <div class="box">
                <h1>返利说明：${webName}返利活动，开始了！邀请好友注册成功返利10元，邀请越多返利越多！返利佣金将全部自动充值到帐户余额！</h1>
                <table width="100%" border="0" cellspacing="0">
                    <tr class="tr1">
                        <td class="td1">用户名</td>
                        <td class="td2">返利项目</td>
                        <td class="td3">成交时间</td>
                        <td class="td4">返利佣金</td>
                    </tr>
                    <tr>
                        <td class="td1">beatsdy@qq.com</td>
                        <td class="td2">邀请好友下单成功</td>
                        <td class="td3">2011-07-13 00:00:00</td>
                        <td class="td4">10元</td>
                    </tr>
                    <tr>
                        <td class="td1">beatsdy@qq.com</td>
                        <td class="td2">邀请好友下单成功</td>
                        <td class="td3">2011-07-13 00:00:00</td>
                        <td class="td4">10元</td>
                    </tr>
                    <tr>
                        <td class="td1">beatsdy@qq.com</td>
                        <td class="td2">邀请好友下单成功</td>
                        <td class="td3">2011-07-13 00:00:00</td>
                        <td class="td4">10元</td>
                    </tr>
                    <tr>
                        <td colspan="4" class="lest">没有消费记录</td>
                    </tr>
                </table>
                <div class="page"><img src="images/page.gif" /></div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
</html>
