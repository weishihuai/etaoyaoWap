<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getUserCartListProxy('normal')}" var="cart"/>
<c:set value="${bdw:findAllCategory()}" var="allCategory"></c:set>

<link rel="icon" href="${webRoot}/favicon.ico" type="image/x-icon"/>
<link rel="shortcut icon" href="${webRoot}/favicon.ico" type="image/x-icon"/>

<script type="text/javascript">
	var goToUrl = function (url) {
		setTimeout(function () {
			window.location.href = url
		}, 1)
	};
	var Top_Path = {webUrl: "${webUrl}", webRoot: "${webRoot}", topParam: "${param.p}", keyword: "${param.keyword}", webName: "${webName}", categoryId: "${param.categoryId}"};
	var top_searchField = "${param.searchField}"
</script>
<%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.bgiframe.min.js"></script>--%>
<script type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/top.js"></script>

<div class="header">
	<div class="topbg">
		<div class="h_top">
			<%--因为nginx代理问题,所以这里如果不加个时间戳会出现会显示其他用户的登录名--%>
			<%--<c:import url="/template/bdw/module/common/topUserName.jsp?randomTime=${dataTime.time}"/>--%>
			<div class="welcome">
				<div id="showUserId">
					您好，欢迎来到${webName}！[<a class="cur" href="${webRoot}/login.ac" title="登录">登录</a>] [<a class="color" href="${webRoot}/register.ac" title="免费注册">免费注册</a>]
				</div>
			</div>

			<div class="top_r">
				<div class="r_item" style=" width:68px;">
					<div class="tab" style="background:none; width:55px;"><a href="${webRoot}/module/member/orderList.ac?pitchOnRow=11">我的订单</a></div>
					<i>|</i>
				</div>
				<div class="r_item myAcunnt">
					<div class="tab"><a href="javascript:;">我的${webName}</a></div>
					<i>|</i>

					<div class="item_popup" style="display: none;">
						<p><a href="${webRoot}/module/member/index.ac" show="N">会员首页</a></p>

						<p><a href="${webRoot}/module/member/myIntegral.ac">我的积分</a></p>

						<p><a href="${webRoot}/module/member/productCollection.ac?pitchOnRow=3">我的收藏</a></p>
					</div>
				</div>
				<div class="r_item myAcunnt" style=" width:68px;">
					<div class="tab" style="background:none; width:55px;"><a href="${webRoot}/help.ac">帮助中心</a></div>
					<i>|</i>
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
			</div>
		</div>
	</div>

	<div class="logobar">
		<div class="logo frameEdit" frameInfo="top_logo|365X70">
			<c:forEach items="${sdk:findPageModuleProxy('top_logo').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
				${advtProxys.htmlTemplate}
			</c:forEach>
		</div>
		<div class="searchDiv">
			<input class="inp" type="text" name="keyword" id="keyword" value="${param.keyword}" placeholder="请输入关键字">
			<input class="btn" type="button" name="keyword" id="search" value="搜索">
		</div>
	</div>


	<div class="navbar">
		<div class="w">
			<div class="category" rel="${param.p}">
				<div class="dt">全部商品分类<i></i></div>
				<div class="dd" style="z-index: 999;">
					<c:forEach items="${allCategory}" var="category" varStatus="s" end="7">
						<set value="O2O_topLeft_decoration_${s.count}" var="O2O_topLeft_decoration"></set>
						<div class="control">
							<div class="tit">
								<span class="index" style="display: none;">${s.count}</span>
								<strong><a href="${webRoot}/otoo/productList.ac?categoryId=${category.categoryId}">${category.categoryName}</a></strong>
								<c:set value="O2O_topLeft_decoration_${s.count}" var="O2O_topLeft_decoration"/>
                            <span class="frameEdit" frameInfo="${O2O_topLeft_decoration}">
                              <c:set value="${sdk:findPageModuleProxy(O2O_topLeft_decoration).links}" var="decorationLink"/>
                              <c:forEach items="${decorationLink}" var="link" end="1">
	                              ${link.title}&nbsp;&nbsp;&gt;
                              </c:forEach>
                            </span>
							</div>

							<div class="con" id="con${s.count}" style="display: none">
								<div class="inner">
									<c:forEach items="${category.children}" var="child">
										<a href="${webRoot}/otoo/productList.ac?categoryId=${child.categoryId}" title="${child.categoryName}">${child.categoryName}</a>|
									</c:forEach>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<!--category end-->
			<div class="nav" style="width: 170px;">
				<a class="cur" href="${webRoot}/otoo/index.ac" title="">O2O首页</a>
			</div>
			<!--nav end-->
			<div class="clearfix"></div>
		</div>
	</div>
	<!--navbar end-->
</div>
