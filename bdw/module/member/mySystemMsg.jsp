<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName} - 系统信息 - ${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/mySystemMsg.js"></script><%--系统信息页面js--%>
</head>


<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>
<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > 系统信息</div></div>
<%--面包屑导航 end--%>


<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>

    <div class="rBox">
        <div class="system">
            <h2 class="rightbox_h2_border">系统信息</h2>
            <div class="box right_box_border">
                <div class="t_Menu">
                    <ul>
                        <li><a class="systemMsgTab cur" href="javascript:void(0);">消息提醒</a></li>
                        <li><a class="imallNoticeTab" href="javascript:void(0);">商城公告</a></li>
                    </ul>
                </div>
                <%--消息提醒 start--%>
                <div class="m1" id="systemMsg">
                    <table width="100%" border="0" cellspacing="0">
                        <tr class="tr1">
                            <td class="td2">标题</td>
                            <td class="td3">发送时间</td>
                            <td class="td4">操作</td>
                        </tr>
                        <c:forEach items="${loginUser.userMsgListBySystem}" var="systemMsg" varStatus="s">
                            <tr>
                                <td class="td2" style="padding-left: 40px;">${systemMsg.title}</td>
                                <td class="td3">${systemMsg.messageTimeString}</td>
                                <td class="td4"><a href="javascript:" onclick="showSystemTip('systemMsg_${s.count}')">展开</a></td>
                            </tr>
                            <tr>
                                <td colspan="4" class="tips" id="systemMsg_${s.count}" style="display: none;">
                                    <p>${systemMsg.userMsgCont}</p>
                                    <a href="javascript:" onclick="closeSystemTip('systemMsg_${s.count}')" class="closeTip">关闭</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <%--消息提醒 end--%>

                <%--商城公告 start--%>
                <div class="m1" id="imallNotice" style="display: none;">
                    <table width="100%" border="0" cellspacing="0">
                        <tr class="tr1">
                            <td class="td2">标题</td>
                            <td class="td3">发送时间</td>
                            <td class="td4">操作</td>
                        </tr>
                        <c:forEach items="${loginUser.IMallNoticeList}" var="articleProxy" varStatus="s">
                            <tr>
                                <td class="td2" style="padding-left: 40px;">${articleProxy.title}</td>
                                <td class="td3">
                                    <fmt:formatDate  value="${articleProxy.createTime}" type="both" pattern="yyyy.MM.dd HH:mm:ss" />
                                </td>
                                <td class="td4"><a href="javascript:" onclick="showNoticeTip('notice_${s.count}')">展开</a></td>
                            </tr>
                            <tr>
                                <td colspan="4" class="tips" id="notice_${s.count}" style="display: none;">
                                    <p>${articleProxy.articleCont}</p>
                                    <a href="javascript:" onclick="closeNoticeTip('notice_${s.count}')" class="closeTip">关闭</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <%--商城公告 end--%>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>

</body>
</html>
