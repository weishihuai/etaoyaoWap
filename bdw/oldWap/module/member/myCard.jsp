<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${empty param.isBind ? 'N' : param.isBind}" var="isBind"/>
<c:set value="${bdw:getCardPage(page,5,isBind)}" var="cardProxyPage"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>礼品卡充值</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/myCard.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/commonOnBootstrap.css" rel="stylesheet" media="screen">

    <script>
        var dataValue={
            webRoot:"${webRoot}"
        };
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/mainOnBootstrap.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/module/member/statics/js/myCard.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=礼品卡充值"/>
<%--页头结束--%>
<div>
    <div class="add_row">
        <div class="select-box invoice">
            <span class="lab">礼品卡充值</span>
            <label class="switch">
                <input class="hide" type="checkbox" id="cardChange" value="Y">
                <span class="invoiceIcon icon"></span>
            </label>
        </div>
    </div>
    <div id="addCard" style="display: none;">
        <div class="add_row">
            <div class="input-g">
                <input class="add_text" id="cardNum" type="text" placeholder="请输入礼品卡卡号" />
            </div>
        </div>

        <div class="add_row">
            <div class="input-g">
                <input class="add_text" type="password" id="cardPwd" placeholder="请输入礼品卡密码" />
            </div>
        </div>
        <div class="add_row">
            <a class="add_btn" href="javascript:" id="bindCard">充值</a>
        </div>
    </div>

</div>

<div class="row">
    <div class="col-xs-12">
        <div class="navtabs">
            <ul class="nav nav-tabs">
                <li style="width: 50%;" <c:choose><c:when test="${empty param.isBind || param.isBind=='N'}">class="active"</c:when></c:choose>><a role="button" class="btn btn-default" href="${webRoot}/wap/module/member/myCard.ac?page=1&isBind=N">未充值</a></li>
                <li style="width: 50%;" <c:choose><c:when test="${param.isBind == 'Y'}">class="active"</c:when></c:choose>><a role="button" class="btn btn-default" href="${webRoot}/wap/module/member/myCard.ac?page=1&isBind=Y">已充值</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="tab-content main">
    <div class="tab-pane <c:choose><c:when test="${empty param.isBind || param.isBind=='N'}">active</c:when></c:choose>" id="defaut" >
    <c:choose>
        <c:when test="${empty cardProxyPage.result}">
            <div class="row" >
                <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card-list">
                <c:forEach items="${cardProxyPage.result}" var="cardProxy">
                    <span class="card-one">
                        <div class="cou-text">
                            <div class="cou-l">
                                <div class="cou-num">${cardProxy.cardAmount}<span></span></div>
                            </div>
                            <div class="cou-m"></div>
                            <div class="cou-r">
                                <div class="text1">卡号：${cardProxy.cardNum}</div>
                                <div class="text2">密码：${cardProxy.cardPsw}</div>
                                <div class="text3"><a href="javascript:void(0);"  onclick="cardChange('${cardProxy.cardId}')">立即充值</a></div>
                            </div>
                        </div>
                    </span>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
        <%--未使用列表分页 start--%>
        <div class="pn-page row text-center"style="padding-bottom: 10px;">
            <form action='${webRoot}/wap/module/member/myCard.ac' id="pageForm" method="post" style="display: inline;" totalPages='${cardProxyPage.lastPageNumber}' currentPage='${page}' frontPath='${webRoot}' displayNum='6' totalRecords='${unusedCoupon.totalCount}'>
                <c:if test="${cardProxyPage.lastPageNumber >1}">
                    <c:choose>
                        <c:when test="${cardProxyPage.firstPage}">
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1&isBind=N">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${page-1}&isBind=N">上一页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" href="?page=1&isBind=N">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page-1}&isBind=N">上一页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="col-xs-2 dropup">
                        <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button" data-toggle="dropdown">
                                ${page}/${cardProxyPage.lastPageNumber} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" style="min-width:50px;width:50px;height: auto;overflow-y: scroll;">
                            <c:forEach begin="1" end="${cardProxyPage.lastPageNumber}" varStatus="status">
                                <li><a href="?page=${status.index}&isBind=N">${status.index}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <c:choose>
                        <c:when test="${cardProxyPage.lastPage}">
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${cardProxyPage.lastPageNumber}&isBind=N">末页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page+1}&isBind=N">下一页</a>

                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default"
                                   href="?page=${cardProxyPage.lastPageNumber}&isBind=N">末页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </form>
        </div>
        <%--未使用列表分页 end--%>
    </div>

    <div class="tab-pane <c:choose><c:when test="${param.isBind == 'Y'}">active</c:when></c:choose>" id="sell">
        <c:choose>
            <c:when test="${empty cardProxyPage.result}">
                <div class="row" >
                    <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card-list">
                    <c:forEach items="${cardProxyPage.result}" var="usedProxy">
                        <span class="card-one">
                            <div class="cou-text">
                                <div class="cou-l">
                                    <div class="cou-num">${usedProxy.cardAmount}<span>元</span></div>
                                </div>
                                <div class="cou-m"></div>
                                <div class="cou-r">
                                    <div class="text1">卡号：${usedProxy.cardNum}</div>
                                    <div class="text2">密码：${usedProxy.cardPsw}</div>
                                    <div class="text3">已充值</div>
                                </div>
                            </div>
                        </span>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <%--已使用列表分页 start--%>
        <div class="pn-page row text-center"style="padding-bottom: 10px;">
                <c:if test="${cardProxyPage.lastPageNumber >1}">
                    <c:choose>
                        <c:when test="${cardProxyPage.firstPage}">
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=1&isBind=Y">首页</a>
                            </div>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'
                                   href="?page=${page-1}&isBind=Y">上一页</a>
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
                    <div class="col-xs-2 dropup">
                        <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button" data-toggle="dropdown">
                                ${page}/${cardProxyPage.lastPageNumber} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" style="min-width:60px;width:60px;overflow-y: scroll;height: auto;max-height: 140px;">
                            <c:forEach begin="1" end="${cardProxyPage.lastPageNumber}" varStatus="status">
                                <li><a href="?page=${status.index}&isBind=Y">${status.index}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <c:choose>
                        <c:when test="${cardProxyPage.lastPage}">
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled'>下一页</a>
                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" disabled='disabled' href="?page=${cardProxyPage.lastPageNumber}&isBind=Y">末页</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-3">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${page+1}&sell=2">下一页</a>
                            </div>
                            <div class="col-xs-2">
                                <a type="button" class="btn btn-sm btn-default" href="?page=${cardProxyPage.lastPageNumber}&isBind=Y">末页</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
        </div>
        <%--已使用列表分页 end--%>

    </div>

</div>

<script src="${webRoot}/template/bdw/oldWap/citySend/statics/js/base.js"></script>
<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
