<%--
  Created by IntelliJ IDEA.
  User: lm
  Date: 17-01-06
  Time: 上午 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="_page" value="${empty param.page?1:param.page}"/>  <%--接受页数--%>
<c:set value="${sdk:findOrderDetailed(param.orderId)}" var="orderProxy"/><%--查询订单详细--%>
<!DOCTYPE HTML>
<html>
<head>
    <title>店铺评价</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/m-evaluate.css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/commonOnBootstrap.css" rel="stylesheet" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/main.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
    <script src="${webRoot}/template/bdw/module/member/statics/js/ObjectToJsonUtil.js" ></script>
    <script src="${webRoot}/template/bdw/oldWap/module/member/statics/js/judgement.js"></script>
    <script type="text/javascript">
        var dataValue = {webRoot: "${webRoot}"};
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}",orderId:${param.orderId}};
    </script>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=店铺评价"/>
<%--页头结束--%>
<div class="main">
    <form id="orderCommentForm" method="post" autocomplete="off">
        <div class="grade">
            <div class="stars serviceAttitude">
                <span class="lab">服务态度</span>
                <input type="hidden" name="serviceAttitude" value="${empty orderComment.serviceAttitude ?  '5' :orderComment.serviceAttitude}">
                <span class="star star${empty orderComment.serviceAttitude ?  '5' :orderComment.serviceAttitude}">
                    <a class="star1" href="javascript:;" title=""></a>
                    <a class="star2" href="javascript:;" title=""></a>
                    <a class="star3" href="javascript:;" title=""></a>
                    <a class="star4" href="javascript:;" title=""></a>
                    <a class="star5" href="javascript:;" title=""></a>
                </span>
            </div>
            <div class="stars sendOutSpeed">
                    <span class="lab">发货速度</span>
                <input type="hidden" name="sendOutSpeed" value="${empty orderComment.sendOutSpeed ?  '5' :orderComment.sendOutSpeed}">
                <span class="star star${empty orderComment.sendOutSpeed ?  '5' :orderComment.sendOutSpeed}">
                    <a class="star1" href="javascript:;" title=""></a>
                    <a class="star2" href="javascript:;" title=""></a>
                    <a class="star3" href="javascript:;" title=""></a>
                    <a class="star4" href="javascript:;" title=""></a>
                    <a class="star5" href="javascript:;" title=""></a>
                </span>

            </div>
            <div class="stars majorLevel">
                    <span class="lab">宝贝相符</span>
                <input type="hidden" name="majorLevel" value="${empty orderComment.majorLevel ?  '5' :orderComment.majorLevel}">
                <span class="star star${empty orderComment.majorLevel ?  '5' :orderComment.majorLevel}">
                    <a class="star1" href="javascript:;" title=""></a>
                    <a class="star2" href="javascript:;" title=""></a>
                    <a class="star3" href="javascript:;" title=""></a>
                    <a class="star4" href="javascript:;" title=""></a>
                    <a class="star5" href="javascript:;" title=""></a>
                </span>
            </div>
        </div>

        <div class="btn-btm">
            <c:choose>
                <c:when test="${orderProxy.orderRatingStat == '买家未评'}">
                    <a href="javascript:;" onclick="ajaxShopComment()" style="color: #fff;">发表店铺评价</a>
                </c:when>
                <c:when test="${orderProxy.orderRatingStat=='双方已评，追加评价'}">
                    <a href="javascript:;" onclick="ajaxShopComment()" style="color: #fff;">重新评价</a>
                </c:when>
                <c:when test="${orderProxy.orderRatingStat=='卖家未评，追加评价'}">
                    <a href="javascript:;" onclick="ajaxShopComment()" style="color: #fff;">重新评价</a>
                </c:when>
                <c:when test="${orderProxy.orderRatingStat=='双方已评'}">
                    <a href="javascript:void(0);" style="color: #fff;">双方已评</a>
                </c:when>
                <c:when test="${orderProxy.orderRatingStat=='买家已评'}">
                    <a href="javascript:void(0);" style="color: #fff;">买家已评</a>
                </c:when>
            </c:choose>
        </div>
    </form>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>