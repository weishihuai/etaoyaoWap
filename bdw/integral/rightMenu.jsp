<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<%--积分兑换说明--%>
<c:set value="${sdk:getArticleById(60911)}" var="redeemHelp"/>

<div class="rBox">

    <c:choose>
        <c:when test="${empty loginUser}">
            <div class="useTologin">
                <p>您好！您还未登录，请登录!</p>
                <div class="btn"><a href="${webRoot}/login.ac" title="会员登录">会员登录</a></div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="haveLongin">
                <h1>账户信息</h1>
                <div class="box">
                    <div class="t_area">
                        <div class="pic">
                            <img src="${loginUser.icon["40X40"]}" style="width: 40px;height: 40px;" />
                        </div>
                        <div class="rinfo">
                            <p>您好！${loginUser.userName}！</p>
                            <p>等级：${empty  loginUser.level?'普通会员':loginUser.level}</p>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="b_area">
                        <p>帐&nbsp;户&nbsp;积&nbsp;分：<b><fmt:formatNumber value="${loginUser.integral}" type="number" pattern="##" /></b></p>
                        <p>积分购物车：<a href="${webRoot}/shoppingcart/cart.ac?carttype=integral&handler=integral" title="进入积分购物车">进入积分购物车</a></p>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>


    <div class="showList">
        <h1>兑换分类</h1>
        <div class="box">
            <ul>
                <%--列出积分商品分类 开始 --%>
                <c:forEach items="${sdk:queryIntegralCategory()}" var="integralCategory" >
<%--
                    <li><a <c:if test="${param.categoryId==integralCategory.categoryId}">class="cur" </c:if> href="${webRoot}/integral/integralList.ac?categoryId=${integralCategory.categoryId}">·&nbsp;${integralCategory.name}</a></li>
--%>
                    <li><a <c:if test="${param.categoryId==integralCategory.categoryId}">class="cur" </c:if> href="${webRoot}/jfhg.ac?categoryId=${integralCategory.categoryId}">·&nbsp;${integralCategory.name}</a></li>
                </c:forEach>
                <%--列出积分商品分类 结束--%>
            </ul>
        </div>
    </div>
    <%--积分兑换说明 开始--%>
    <div class="m1">
        <a href="${webRoot}/mallNotice-${redeemHelp.infArticleId}-${redeemHelp.categoryId}.html"><h2><span>${redeemHelp.title}</span> </h2></a>
        <div class="box">
            <div class="each">${redeemHelp.articleCont}</div>
        </div>
    </div>
    <%--积分兑换说明 结束--%>
</div>
<div class="clear"></div>
