<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getSysParamValue('webUrl')}" var="webUrl"/>   <%--系统参数：网络地址--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>  <%--系统参数：登录用户--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-邀请好友 ${webUrl}/checkMobile.ac?fid=${loginUser.userId} ${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />\
    <link href="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/myInvite.js"></script>
</head>
<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--弹出层 start--%>
<div style="display:none;" id="tip" class="box" title="系统提示" >
    <div align="center" id="tiptext" style="font-size: 14px;font-weight: bold;padding: 15px"></div>
</div>
<%--弹出层 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html" title="首页">首页</a> >  <a href="${webRoot}/module/member/index.ac" title="会员中心">会员中心</a> >  邀请好友</div> </div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
    <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <%--邀请好友 start--%>
        <div class="Invite">
            <h2 class="rightbox_h2_border">邀请好友</h2>
            <div class="box right_box_border">
                <div class="m1">
                    <c:set var="advtProxyList" value="${sdk:findPageModuleProxy('memberBanner').advt.advtProxy}"></c:set>
                    <div style=" ${empty advtProxyList ? 'display:none' : 'display:block'}">
                        ${empty advtProxyList ? "<div class='framepoint_cust_beginelse'><i></i><b class='emptyCustom'>建设中</b></div>":""}
                        <div class="t frameEdit"  frameInfo="memberBanner|778X150" >
                            ${empty advtProxyList?"<i>建设中</i>":""+
                            "<c:forEach items='${advtProxyList}' var='adv' end='0' varStatus='s'>"+

                                "<a href='${adv.link}'  title='${adv.title}'><img  src='${adv.advUrl}' alt='${adv.hint}' title='${adv.title}'  width='778px' height='150px' /></a>"
                            +"</c:forEach>"}
                        </div>
                    </div>

                    <div style="${empty sdk:findPageModuleProxy('myInvite').pageModuleObjects[0].userDefinedContStr ? 'display:none' : 'display:block'}">
                        ${empty sdk:findPageModuleProxy('myInvite').pageModuleObjects[0].userDefinedContStr? "<div class='framepoint_cust_beginelse'><i></i><b class='emptyCustom'>建设中</b></div>":""}
                        <div class="b frameEdit" frameInfo="myInvite">
                            ${empty sdk:findPageModuleProxy('myInvite').pageModuleObjects[0].userDefinedContStr? "<i>建设中</i>":sdk:findPageModuleProxy('myInvite').pageModuleObjects[0].userDefinedContStr}
                        </div>
                    </div>
                </div>
                <div class="m2">
                    <h4>复制链接发给QQ/MSN上的好友</h4>
                    <div class="put"><input type="text" id="yaoqingVal" value="${webUrl}/checkMobile.ac?fid=${loginUser.userId}" /></div>
                    <div class="btn"><a title="复制地址" href="javascript:copy()">复制地址</a></div>
                </div>
                <div class="m3">
                    <h4>分享给好友：</h4>
                    <div class="area">
                        <div id="jiathis_style_32x32">
                            <a class="jiathis_button_qzone"></a>
                            <a class="jiathis_button_tsina"></a>
                            <a class="jiathis_button_tqq"></a>
                            <a class="jiathis_button_renren"></a>
                            <a class="jiathis_button_kaixin001"></a>
                            <a class="jiathis_button_taobao"></a>
                            <a class="jiathis_button_douban"></a>
                            <a class="jiathis_button_t163"></a>
                            <a class="jiathis_button_feixin"></a>
                            <a class="jiathis_button_google"></a>
                            <a class="jiathis_button_sohu"></a>
                            <a class="jiathis_button_sina"></a>
                            <a class="jiathis_button_buzz"></a>
                            <a class="jiathis_button_twitter"></a>
                            <a class="jiathis_button_youdao"></a>
                            <a class="jiathis_button_115"></a>
                            <a class="jiathis_button_gmail"></a>
                            <a class="jiathis_button_zhuaxia"></a>

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
                            <a class="jiathis_counter_style"></a>
                        </div>
                        <script type="text/javascript">
                        var jiathis_config = {
                        	url: "${webUrl}/checkMobile.ac?fid=${loginUser.userId}",
                        	title: "邀请好友 #${webName}#",
                        	summary:"我在${webName}购物，你也来吧"
                        }
                        </script>
                        <script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>
                    </div>
                </div>
                <div class="m4">
                    <h4>邮件推荐：</h4>
                    <form action="${webRoot}/member/InviteForEmail.json" id="sendEmail" method="post">
                        <div class="area">
                            <p>输入好友邮箱，我们将向您的好友发送推荐邮件：</p>
                            <div class="fixBox">
                                <label>好友E-mail：</label>
                                <div class="put"><input type="text" name="email" id="email" />  (多个请用“,”号隔开)</div>
                                <div class="clear"></div>
                            </div>
                            <div class="fixBox">
                                <label>标题：</label>
                                <div class="put"><input id="title" name="title" class="w" value="<%--${webName}--%>易淘药集团旗下健康网，药食同源，食药健康！" type="text" /></div>
                                <div class="clear"></div>
                            </div>
                            <div class="fixBox">
                                <label>内容：</label>
                                <div class="put"><textarea name="content" id="content" cols="" rows="">易淘药健康网，易淘药集团旗下电商品牌</textarea></div>
                                <div class="clear"></div>
                            </div>
                            <div class="btn"><a href="javascript:" onclick="$('#sendEmail').submit();" title="发送邮件">发送邮件</a></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%--邀请好友 end--%>
    </div>
    <div class="clear"></div>
</div>
<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>

