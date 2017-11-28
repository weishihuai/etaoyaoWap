<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:set value="${sdk:findKeywordByCategoryId(param.category,5)}" var="hotKeywords"/>
<c:set value="${sdk:getUserCartListProxy('normal')}" var="cart"/>
<script type="text/javascript">
    var goToUrl = function (url) {
        setTimeout(function () {
            window.location.href = url
        }, 1)
    };
    var Top_Path = {webRoot: "${webRoot}", topParam: "${param.p}", keyword: "${param.keyword}"};
    var top_searchField = "${param.searchField}"
</script>


<link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>

<link rel="icon" href="${webRoot}/favicon.ico" type="image/x-icon"/>
<link rel="shortcut icon" href="${webRoot}/favicon.ico" type="image/x-icon"/>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/top.js"></script>
<%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/addFavorite.js"></script>--%>

<div class="header" id="LinkH">
    <div class="topbg">
        <div class="h_top">
            <div class="welcome" style="line-height: 30px;width: 990px; margin: 0 auto;">
                <c:choose>
                    <c:when test="${not empty userProxy}">
                        您好，<a href="${webRoot}/module/member/index.ac" style="color: #e82c35;">${fn:substring(userProxy.userName,0,15)}</a>，欢迎来到${webName}&nbsp;&nbsp;[<a  href="<c:url value='/member/exit.ac?sysUserId=${userProxy.userId}'/>" title="退出">退出</a>]
                    </c:when>
                    <c:otherwise>
                        您好，欢迎来到${webName}！[<a class="cur" href="${webRoot}/login.ac" title="登录">登录</a>] [<a class="color" href="${webRoot}/register.ac" title="免费注册">免费注册</a>]
                    </c:otherwise>
                </c:choose>
            </div>
            <%--<div class="top_r">
                <div class="r_item" style=" width:68px;">
                    <div class="tab" style="background:none; width:55px;"><a href="${webRoot}/module/member/orderList.ac">我的订单</a></div>
                    <i>|</i>
                </div>
                <div class="r_item myAcunnt">
                    <div class="tab"><a href="javascript:;">我的宝得</a></div>
                    <i>|</i>
                    <div class="item_popup" style="display: none;">
                        <p><a href="${webRoot}/module/member/index.ac" show="N">会员首页</a></p>
                        <p><a href="${webRoot}/module/member/myIntegral.ac">我的积分</a></p>
                        <p><a href="${webRoot}/module/member/productCollection.ac">我的收藏</a></p>
                    </div>
                </div>
                &lt;%&ndash;<div class="r_item myAcunnt">
                    <div class="tab"><a href="javascript:;">客户服务</a></div>
                    <i>|</i>
                    <div class="item_popup" style="display: none;">
                        <p><a href="${webRoot}/help.ac">帮助中心</a></p>
                        <p><a href="#">售后服务</a></p>
                        <p><a href="#">在线客服</a></p>
                    </div>
                </div>&ndash;%&gt;
                <div class="r_item myAcunnt" style=" width:68px;">
                    <div class="tab" style="background:none; width:55px;"><a href="${webRoot}/help.ac">帮助中心</a></div>
                    <i>|</i>
                    &lt;%&ndash;<div class="item_popup" style="display: none;">
                        <p><a href="${webRoot}/help.ac">帮助中心</a></p>
                        <p><a href="#">售后服务</a></p>
                        <p><a href="#">在线客服</a></p>
                    </div>&ndash;%&gt;
                </div>
                <div class="r_item2 cur2 wechatQr frameEdit" frameInfo="top_wechat_qr|168X174">
                    <div class="tab"><i></i><a href="javascript:;">关注我们</a></div>
                    <div class="item_popup2" style="display: none;">
                        <c:forEach items="${sdk:findPageModuleProxy('top_wechat_qr').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                            <img src="${advtProxys.advUrl}" width="168" height="174"/>
                        </c:forEach>
                        <span></span>
                    </div>
                </div>
            </div>--%>
        </div>
    </div>

</div>
