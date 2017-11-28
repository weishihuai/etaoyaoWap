<%--
  Created by IntelliJ IDEA.
  User: lxq
  Date: 12-3-31
  Time: 上午11:52
  菜单
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="loginUser" value="${sdk:getLoginUser()}"/> <%--获取当前用户--%>
<div class="lBox">
    <h2>会员中心</h2>
    <%--左边菜单个人信息展示 start--%>
    <div class="userPro leftmenu_left_border leftmenu_right_border">
        <p class="name">${loginUser.userName}</p>
        <p>您好！欢迎光临${webName}</p>
        <p>会员等级：${loginUser.level}</p>
        <p>您的积分：<span><fmt:formatNumber value="${loginUser.integral}" type="number" pattern="##" /></span></p>
    </div>
    <%--左边菜单个人信息展示 end--%>

    <%--左边菜单展示 start--%>
    <h3 class="leftmenu_h3_border">订单管理</h3>
    <ul class="leftmenu_left_border leftmenu_right_border">
        <li>
            <a class="row row_11" href="${webRoot}/module/member/orderList.ac?pitchOnRow=11" title="普通订单">普通订单</a>
        </li>
        <li>
            <a class="row row_14" href="${webRoot}/module/member/cardOrderList.ac?pitchOnRow=14" title="礼品卡订单">礼品卡订单</a>
        </li>
        <li>
            <a class="row row_12" href="${webRoot}/module/member/groupBuyOrder.ac?pitchOnRow=12" title="团购订单">团购订单</a>
        </li>
        <li>
            <a class="row row_13" href="${webRoot}/module/member/returnedPurchase.ac?pitchOnRow=13" title="退换货">退换货</a>
        </li>
        <%--<li>--%>
        <%--2015-04-10,zch,由于宝得做了一个退款记录申请功能,所以这个功能废弃了--%>
        <%--<a class="row row_14" href="${webRoot}/module/member/toCash.ac?pitchOnRow=14" title="申请提现">申请提现</a>--%>
        <%--</li>--%>
        <li>
        <%--2015-04-14,zch,宝得网要求注释掉--%>
            <a class="row row_18" href="${webRoot}/module/member/integralOrderList.ac?pitchOnRow=18" title="积分订单">积分订单</a>
        </li>

        <li>
            <a class="row row_40" href="${webRoot}/module/member/myTry.ac?pitchOnRow=40" title="免费试用">免费试用</a>
        </li>
    </ul>
    <%--2015-09-08,zch,客户发过来的文件注释了该部分内容--%>
   <%-- <h3 class="leftmenu_h3_border">O2O管理</h3>
    <ul class="leftmenu_left_border leftmenu_right_border">
    <li>
    <a class="row row_47" href="${webRoot}/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=N&orderStatus=0" title="O2O订单列表">O2O订单列表</a>
    </li>
    <li>
    <a class="row row_48" href="${webRoot}/module/member/otoo/otooMyCoupon.ac?pitchOnRow=48&isApplyRefund=Y&isRefund=N" title="O2O退款列表">O2O退款列表</a>
    </li>
    <li>
    <a class="row row_49" href="${webRoot}/module/member/otoo/otooCollection.ac?pitchOnRow=49" title="O2O商品收藏">O2O商品收藏</a>
    </li>
    <li>
    <a class="row row_50" href="${webRoot}/module/member/otoo/otooComment.ac?pitchOnRow=50" title="O2O商品评价">O2O商品评价</a>
    </li>
    </ul>--%>
    <h3 class="leftmenu_h3_border">帐户管理</h3>
    <ul class="leftmenu_left_border leftmenu_right_border">
        <li>
            <a class="row row_15" href="${webRoot}/module/member/myPrestore.ac?pitchOnRow=15" title="帐户余额">帐户余额</a>
        </li>

        <li>
        <a class="row row_16" href="${webRoot}/module/member/myIntegral.ac?pitchOnRow=16" title="我的积分">我的积分</a>
        </li>
        <li>
            <a class="row row_17" href="${webRoot}/module/member/myCoupon.ac?pitchOnRow=17&is=N" title="购物券">购物券</a>
        </li>

        <li>
            <a class="row row_21" href="${webRoot}/module/member/myCard.ac?pitchOnRow=21&isBind=N" title="礼品卡">礼品卡</a>
        </li>

        <%--<li>
            <a class="row row_19" href="${webRoot}/module/member/boundBankCard.ac?pitchOnRow=19" title=">绑定银行卡">绑定银行卡</a>
        </li>--%>
    </ul>
    <h3 class="leftmenu_h3_border">个人信息</h3>
    <ul class="leftmenu_left_border leftmenu_right_border">
        <li>
            <a class="row row_1" href="${webRoot}/module/member/myInformation.ac?pitchOnRow=1" title="个人资料">个人资料</a>
        </li>
        <li>
            <a class="row row_2" href="${webRoot}/module/member/myAddressBook.ac?pitchOnRow=2" title="收货地址">收货地址</a>
        </li>
        <li>
            <a class="row row_3" href="${webRoot}/module/member/productCollection.ac?pitchOnRow=3" title="收藏商品">收藏商品</a>
        </li>
        <li>
            <a class="row row_23" href="${webRoot}/module/member/shopCollection.ac?pitchOnRow=23" title="收藏店铺">收藏店铺</a>
        </li>
        <li>
            <a class="row row_4" href="${webRoot}/module/member/myInvite.ac?pitchOnRow=4" title="邀请好友">邀请好友</a>
        </li>
    </ul>
    <h3 class="leftmenu_h3_border">客服中心</h3>
    <ul class="leftmenu_left_border leftmenu_right_border">
        <li>
            <a class="row row_5" href="${webRoot}/module/member/myComment.ac?pitchOnRow=5" title="评论相关">评论相关</a>
        </li>
        <li>
            <a class="row row_8" href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=1" title="我的留言">我的留言</a>
        </li>
        <%--<li>--%>
        <%--<a class="row row_6" href="${webRoot}/module/member/mySubscrib.ac?pitchOnRow=6" title="信息订阅">信息订阅</a>--%>
        <%--</li>--%>
        <li>
            <a class="row row_7" href="${webRoot}/module/member/mySystemMsg.ac?pitchOnRow=7" title="系统信息">系统信息</a>
        </li>
    </ul>
    <%--左边菜单展示 end--%>
    <script type="text/javascript">
        //焦点row加样式
        $(".row").removeClass("cur");
        var pitchOnRow = "${param.pitchOnRow}";
        $(".row_" + pitchOnRow).addClass("cur");
    </script>
</div>
