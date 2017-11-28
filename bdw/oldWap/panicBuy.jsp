<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${empty param.tabSelect ? 'Y' : param.tabSelect}" var="tabSelect"/>
<c:set value="${sdk:findActivitySkuDiscountRuleByState(page,6,tabSelect)}"
       var="panicListResult"/>    <%--查询抢购活动返回抢购列表--%>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE HTML>
<html>
<head>
    <title>抢购活动</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/panicBuy.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript">
        var pageData = {
            tabSelect: "${tabSelect}",
            page: "${page}",
            webRoot: "${webRoot}",
            nowTime: "<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"
        };
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/panicBuy.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/wap-countdown.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=抢购活动"/>
<%--页头结束--%>
<div class="row">
    <div class="col-xs-12">
        <div class="navtabs">
            <ul class="nav nav-tabs" id="myTab">
                <li class="active" style="width:50%;">
                    <a role="button" class="btn btn-default btn-block"
                       href="#defaut" value="pan1"
                       data-toggle="tab" onclick="gotoUrl('Y')">抢购中的商品</a></li>
                <li style="width:50%;">
                    <a role="button" class="btn btn-default btn-block" href="#defaut"
                       data-toggle="tab" value="pan2" onclick="gotoUrl('N')">即将开抢的商品</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="tab-content">
    <div class="tab-pane active" id="defaut">
        <div class="wrap-grid">
            <!--row start-->
            <div class="row show-grid album">
                <c:if test="${not empty panicListResult.result}">
                    <c:forEach items="${panicListResult.result}" var="panic" varStatus="status">
                        <div class="col-xs-6">
                            <div class="wrap">
                                <div class="pro-inner">
                                    <fmt:formatDate value="${panic.price.endTime}" type="both"
                                                    pattern="yyyy/MM/dd HH:mm:ss" var="endTimeStr"/> <%--格式化时间--%>
                                    <div class="proTitle">
                                        <input type="hidden" value="${endTimeStr}" name="time"/>

                                        <div class="proSales" name="endTime">
                                        </div>
                                    </div>
                                    <div class="row" style=" padding-left:10px; padding-right:10px;">
                                        <div class="col-xs-12">
                                            <div class="b_pic"><a title="${panic.name}"
                                                                  href="${webRoot}/wap/product.ac?id=${panic.productId}">
                                                <img alt="${panic.name}" src="${panic.defaultImage['']}" width="150"
                                                     height="150"/></a>
                                            </div>
                                            <div class="b_title"><a title="${panic.name}"
                                                                    href="${webRoot}/wap/product.ac?id=${panic.productId}">${panic.name}</a>
                                            </div>
                                            <div class="b_price">价格：<em>￥<fmt:formatNumber
                                                    value="${panic.price.originalUnitPrice}" type="number"
                                                    pattern="#0.00#"/></em></div>
                                            <div class="b_price">抢购价：<i>￥<fmt:formatNumber
                                                    value="${panic.price.unitPrice}"
                                                    type="number"
                                                    pattern="#0.00#"/></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty panicListResult.result}">
                    <div class="container">
                        <div class="row m_rows1" style="margin:20px 0;padding:10px 0;">
                            <div class="col-xs-12">
                                <%--<span class="glyphicon glyphicon-ok glyphicon-ok2"></span>--%>
                                商城还没有此类型的商品，请您先
                                <a href="${webRoot}/wap/list.ac">选购其他商品»</a>
                            </div>
                        </div>
                        <div class="row m_rows1" style="margin-bottom:38px;padding:10px 0;">
                            <div class="col-xs-12">
                                <button onclick="window.location.href='${webRoot}/wap/index.ac'"
                                        class="btn btn-danger btn-danger2" type="button">返回首页
                                </button>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="pn-page row">
                <c:if test="${panicListResult.lastPageNumber >1}">

                <c:choose>
                    <c:when test="${panicListResult.firstPage}">
                        <div class="col-xs-2">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               disabled="disabled">首页</a>
                        </div>
                        <div class="col-xs-3">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               disabled="disabled">上一页</a>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="col-xs-2">
                            <a href="${webRoot}/wap/panicBuy.ac?page=1&tabSelect=${tabSelect}"
                               class="btn btn-default btn-sm" role="button">首页</a></div>
                        <div class="col-xs-3">
                            <a href="${webRoot}/wap/panicBuy.ac?page=${panicListResult.thisPageNumber-1}&tabSelect=${tabSelect}"
                               class="btn btn-default btn-sm" role="button">上一页</a>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="col-xs-2">
                    <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                            data-toggle="dropdown">
                        ${panicListResult.thisPageNumber}/${panicListResult.lastPageNumber} <span class="caret"></span>
                    </button>

                    <ul class="dropdown-menu" style="width:50px">
                        <c:forEach begin="1" varStatus="n" end="${panicListResult.lastPageNumber}">
                            <li><a href="${webRoot}/wap/panicBuy.ac?page=${n.index}&tabSelect=${tabSelect}"
                                   onclick="test();">第${n.index}页</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <c:choose>
                    <c:when test="${panicListResult.lastPage}">
                        <div class="col-xs-3">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               disabled="disabled">下一页</a>
                        </div>
                        <div class="col-xs-2">
                            <a href="javascript:void(0);" class="btn btn-default btn-sm" role="button"
                               disabled="disabled">末页</a>
                        </div>


                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-3">
                            <a href="${webRoot}/wap/panicBuy.ac?page=${panicListResult.thisPageNumber+1}&tabSelect=${tabSelect}"
                               class="btn btn-default btn-sm" role="button">下一页</a>

                        </div>
                        <div class="col-xs-2">
                            <a href="${webRoot}/wap/panicBuy.ac?page=${panicListResult.lastPageNumber}&tabSelect=${tabSelect}"
                               class="btn btn-default btn-sm" role="button">末页</a>
                        </div>

                    </c:otherwise>
                </c:choose>
                </c:if>
            </div>

        </div>
    </div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>