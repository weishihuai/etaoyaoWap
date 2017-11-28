<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>


<div class="header">
    <div class="topbar">
        <div class="w">
            <div class="fl">
                <a class="link01" href="javascript:;" style="margin-right: 15px;"><i></i>收藏我们</a>
                <div class="welcome" style="float: right;">
                    <div id="showUserId">
                        <%--您好，欢迎来到${webName}！[<a class="cur" href="${webRoot}/login.ac" title="登录">登录</a>] [<a class="color" href="${webRoot}/register.ac" title="免费注册">免费注册</a>]--%>
                    </div>
                </div>
                <%--<a class="link02" href="#" title="">请登录</a>--%>
                <%--<a class="link03" href="#" title="">免费注册</a>--%>
            </div>
            <div class="fr">
                <ul>
                    <li class="fore01 wechatQr cur2 frameEdit" frameInfo="top_wechat_qr|168X174">
                        <em></em><a href="javascript:;">关注我们</a><i></i>
                        <%--<div class="tab"><i></i><a href="javascript:;">关注我们</a></div>--%>
                        <div class="item_popup2" style="display: none;">
                            <c:forEach items="${sdk:findPageModuleProxy('top_wechat_qr').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                                <img src="${advtProxys.advUrl}" width="168" height="174"/>
                            </c:forEach>
                            <span></span>
                        </div>
                    </li>
                    <li class="spacer"></li>
                    <li class="fore02"><a href="${webRoot}/help.ac" title="">帮助中心</a></li>
                    <li class="spacer"></li>
                    <li class="fore03 myAcunnt">
                        <a href="javascript:;" title="">我的${webName}</a><i></i>
                        <div class="item_popup" style="display: none;">
                            <p><a href="${webRoot}/module/member/index.ac" show="N">会员首页</a></p>
                            <p><a href="${webRoot}/module/member/myIntegral.ac">我的积分</a></p>
                            <p><a href="${webRoot}/module/member/productCollection.ac">我的收藏</a></p>
                        </div>
                    </li>
                    <li class="spacer"></li>
                    <li class="fore04"><a href="${webRoot}/module/member/orderList.ac" title="我的订单">我的订单</a></li>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <!--topbar end-->
    <div class="logobar">
        <div class="logo frameEdit" frameInfo="top_logo|380X80">
            <c:forEach items="${sdk:findPageModuleProxy('top_logo').advt.advtProxy}" var="adv" varStatus="s" end="0">
                <a href="${adv.link}" title="${adv.title}" target="_blank"><img src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="365" height="70"/></a>
            </c:forEach>
        </div>

        <div class="schedule">
            <img src="${webRoot}/template/bdw/otoo/statics/images/schedule.png" height="30" width="475" alt="进度">
        </div>
    </div>
</div>
<!--header end-->