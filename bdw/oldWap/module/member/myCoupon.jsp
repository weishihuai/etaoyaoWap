<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${pageContext.request.contextPath}" var="webRoot" />
<c:set value="${weixinSdk:getUnusedCouponPage(5)}" var="unusedCoupon"/>  <%--未使用的--%>
<c:set value="${weixinSdk:getUsedCouponPage(5)}" var="usedCoupon"/>  <%--已使用的--%>
<c:set value="${weixinSdk:getPastCouponPage(5)}" var="pastCoupon"/>  <%--已过期的--%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>我的购物券</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/couponList.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/module/member/statics/js/myCoupon.js"></script>
    <script>
        var dataValue={
            //myCoupon.js URL前路径引用
            webRoot:"${webRoot}"
        };
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=我的购物券"/>
<%--页头结束--%>
<div>
    <div class="add_row">
        <div class="select-box invoice">
            <span class="lab">添加购物券</span>
            <label class="switch">
                <input class="hide" type="checkbox" id="needInvoice" value="N">
                <span class="invoiceIcon icon"></span>
            </label>
        </div>
    </div>
    <div id="addCoupon" style="display: none;">
        <div class="add_row">
            <span class="lab">优惠券号</span>
            <div class="input-g">
                <input class="add_text" id="cardNum" type="text" placeholder="请输入优惠券号" />
            </div>
        </div>

        <div class="add_row">
            <span class="lab">券密码</span>
            <div class="input-g">
                <input class="add_text" type="password" id="cardPwd" placeholder="请输入优惠券密码" />
            </div>
        </div>
        <div class="add_row">
            <a class="add_btn" href="javascript:" id="bindCoupon">添加购物券</a>
        </div>
    </div>

</div>

<div class="row">
    <div class="col-xs-12">
        <div class="navtabs">
            <ul class="nav nav-tabs">
                <li <c:choose><c:when test="${empty param.sell}">class="active"</c:when></c:choose>><a role="button" class="btn btn-default" href="${webRoot}/wap/module/member/myCoupon.ac?page=1">未使用</a></li>
                <li <c:choose><c:when test="${param.sell == '2'}">class="active"</c:when></c:choose>><a role="button" class="btn btn-default" href="${webRoot}/wap/module/member/myCoupon.ac?page=1&sell=2">已使用</a></li>
                <li <c:choose><c:when test="${param.sell == '3'}">class="active"</c:when></c:choose>><a role="button" class="btn btn-default" href="${webRoot}/wap/module/member/myCoupon.ac?page=1&sell=3">已过期</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="tab-content main">
    <div class="tab-pane <c:choose><c:when test="${empty param.sell}">active</c:when></c:choose>" id="defaut" >
    <c:choose>
        <c:when test="${empty unusedCoupon.result}">
            <div class="row" >
                <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="coupon-list">
                <c:forEach items="${unusedCoupon.result}" var="cardProxy">
                    <span class="coupon-one">
                        <div class="cou-text">
                            <div class="cou-l">
                                <div class="cou-num">${cardProxy.amount}<span>元</span></div>
                            </div>
                            <div class="cou-m"></div>
                            <div class="cou-r">
                                <div class="text1"><a href="javascript:void(0);" class="useRuleState" couponId ="${cardProxy.couponId}">使用说明</a></div>
                                <div class="text2">有效期 ${cardProxy.startTimeString} 至 ${cardProxy.endTimeString}</div>
                            </div>
                        </div>
                    </span>
                    <%--使用说明--%>
                    <div class="status-area" style="display: none;" id="couponId${cardProxy.couponId}">
                        <div class="area-box">
                            <div class="title">
                                <span style="text-align: left;font-size: 14px;">使用说明</span>
                                <a href="javascript:void(0);" class="closeLay" couponId ="${cardProxy.couponId}"><img src="${webRoot}/template/bdw/oldWap/module/member/statics/images/del-icon01.png" width="16" height="16"/></a>
                            </div>
                            <div class="area-list" style="background:#f8f8f8;width:100%;overflow-y: scroll; padding-top:10px;line-height: 20px;font-size:12px;">
                                <div style="text-align: center;">
                                    ${cardProxy.ruleUseMessage}
                                </div>
                            </div>
                            <div class="bottom-text" style="text-align: right;font-size: 10px;padding-right: 10px;"><span>${webName}&nbsp;温馨提示!</span></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
        <%--未使用列表分页 start--%>
        <div class="pn-page row text-center"style="padding-bottom: 10px;">
            <form action='${webRoot}/wap/module/member/myIntegral.ac' id="pageForm" method="post" style="display: inline;" totalPages='${unusedCoupon.lastPageNumber}' currentPage='${page}' frontPath='${webRoot}' displayNum='6' totalRecords='${unusedCoupon.totalCount}'>
                <c:if test="${unusedCoupon.lastPageNumber >1}">
                    <c:choose>
                        <c:when test="${unusedCoupon.firstPage}">
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${page-1}">上一页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" href="?page=1">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page-1}">上一页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="col-xs-2 dropup">
                        <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                                data-toggle="dropdown">
                                ${page}/${unusedCoupon.lastPageNumber} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" style="min-width:50px;width:50px;height: auto;overflow-y: scroll;">

                            <c:forEach begin="1" end="${unusedCoupon.lastPageNumber}" varStatus="status">

                                <li><a href="?page=${status.index}">${status.index}</a></li>

                            </c:forEach>
                        </ul>
                    </div>
                    <c:choose>
                        <c:when test="${unusedCoupon.lastPage}">
                            <div class="col-xs-3">

                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${unusedCoupon.lastPageNumber}">末页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page+1}">下一页</a>

                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default"
                                   href="?page=${unusedCoupon.lastPageNumber}">末页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </form>
        </div>
        <%--未使用列表分页 end--%>
    </div>

    <div class="tab-pane <c:choose><c:when test="${param.sell == '2'}">active</c:when></c:choose>" id="sell">
        <c:choose>
            <c:when test="${empty usedCoupon.result}">
                <div class="row" >
                    <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="coupon-list">
                    <c:forEach items="${usedCoupon.result}" var="usedProxy">
                        <span class="coupon-one">
                            <div class="cou-text">
                                <div class="cou-l">
                                    <div class="cou-num">${usedProxy.amount}<span>元</span></div>
                                </div>
                                <div class="cou-m"></div>
                                <div class="cou-r">
                                    <div class="text1"><a href="javascript:void(0);" class="useRuleState" couponId ="${usedProxy.couponId}">使用说明</a></div>
                                    <div class="text2">有效期 ${usedProxy.startTimeString} 至 ${usedProxy.endTimeString}</div>
                                </div>
                            </div>
                        </span>
                        <%--使用说明--%>
                        <div class="status-area" style="display: none;" id="couponId${usedProxy.couponId}">
                            <div class="area-box">
                                <div class="title">
                                    <span style="text-align: left;font-size: 14px;">使用说明</span>
                                    <a href="javascript:void(0);" class="closeLay" couponId ="${usedProxy.couponId}"><img src="${webRoot}/template/bdw/oldWap/module/member/statics/images/del-icon01.png" width="16" height="16"/></a>
                                </div>
                                <div class="area-list" style="background:#f8f8f8;width:100%;overflow-y: scroll; padding-top:10px;line-height: 20px;font-size:12px;">
                                    <div style="text-align: center;">
                                            ${usedProxy.ruleUseMessage}
                                    </div>
                                </div>
                                <div class="bottom-text" style="text-align: right;font-size: 10px;padding-right: 10px;"><span>${webName}&nbsp;温馨提示!</span></div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </c:otherwise>
        </c:choose>

        <%--已使用列表分页 start--%>
        <div class="pn-page row text-center"style="padding-bottom: 10px;">
                <c:if test="${usedCoupon.lastPageNumber >1}">
                    <c:choose>
                        <c:when test="${usedCoupon.firstPage}">
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1&sell=2">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${page-1}&sell=2">上一页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" href="?page=1&sell=2">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page-1}&sell=2">上一页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="col-xs-2">
                        <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                                data-toggle="dropdown">
                                ${page}/${usedCoupon.lastPageNumber} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" style="width:50px">

                            <c:forEach begin="1" end="${usedCoupon.lastPageNumber}" varStatus="status">

                                <li><a href="?page=${status.index}&sell=2">第${status.index}页</a></li>

                            </c:forEach>
                        </ul>
                    </div>
                    <c:choose>
                        <c:when test="${usedCoupon.lastPage}">
                            <div class="col-xs-3">

                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${usedCoupon.lastPageNumber}&sell=2">末页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page+1}&sell=2">下一页</a>
                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default"
                                   href="?page=${usedCoupon.lastPageNumber}&sell=2">末页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
        </div>
        <%--已使用列表分页 end--%>

    </div>

    <div class="tab-pane <c:choose><c:when test="${param.sell == '3'}">active</c:when></c:choose>" id="sell2">
        <c:choose>
            <c:when test="${empty pastCoupon.result}">
                <div class="row" >
                    <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="coupon-list">
                    <c:forEach items="${pastCoupon.result}" var="pastProxy">
                        <span class="coupon-one">
                            <div class="cou-text">
                                <div class="cou-l">
                                    <div class="cou-num-past">${pastProxy.amount}<span>元</span></div>
                                </div>
                                <div class="cou-m"></div>
                                <div class="cou-r">
                                    <div class="text2-past">有效期 ${pastProxy.startTimeString} 至 ${pastProxy.endTimeString}</div>
                                </div>
                            </div>
                        </span>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        <%--已过期列表分页 start--%>
        <div class="pn-page row text-center"style="padding-bottom: 10px;">

                <c:if test="${pastCoupon.lastPageNumber >1}">
                    <c:choose>
                        <c:when test="${pastCoupon.firstPage}">
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1&sell=3">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${page-1}&sell=3">上一页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" href="?page=1&sell=3">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page-1}&sell=3">上一页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="col-xs-2">
                        <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button" data-toggle="dropdown">
                                ${page}/${pastCoupon.lastPageNumber} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" style="width:50px">

                            <c:forEach begin="1" end="${pastCoupon.lastPageNumber}" varStatus="status">

                                <li><a href="?page=${status.index}&sell=3">第${status.index}页</a></li>

                            </c:forEach>
                        </ul>
                    </div>
                    <c:choose>
                        <c:when test="${pastCoupon.lastPage}">
                            <div class="col-xs-3">

                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=${pastCoupon.lastPageNumber}&sell=3">末页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page+1}&sell=3">下一页</a>

                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${pastCoupon.lastPageNumber}&sell=3">末页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>

        </div>
        <%--已过期列表分页 end--%>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
