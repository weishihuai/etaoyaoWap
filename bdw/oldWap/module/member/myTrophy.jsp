<%--
  Created by IntelliJ IDEA.
  User: ljt
  Date: 14-3-17
  Time: 下午6:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${pageContext.request.contextPath}" var="webRoot" />
<%--取出我的奖品记录--%>
<c:set value="${weixinSdk:getVwinnerRecodeListByLoginUser(5)}" var="vwinnerRecodeProxy" />
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>我的奖品</title>

    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/list.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/integral.js"></script>
    <%--<script src="${webRoot}/template/bdw/oldWap/statics/js/list.js" type="text/javascript" ></script>--%>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=我的奖品"/>
<%--页头结束--%>
<c:if test="${empty vwinnerRecodeProxy.result}">
    <div class="row" >
        <div class="col-xs-12 "style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
    </div>
</c:if>
<c:forEach items="${vwinnerRecodeProxy.result}" var="awardProxy">
    <div class="container wdjp_box">

        <div class="row b_rows" style="border-bottom:1px dashed #ccc;">
            <div><input type="hidden" value="${awardProxy.getTorphyRecodeId}"></div>
            <div><input type="hidden" value="${awardProxy.winnerRecodeId}"></div>
            <div class="col-xs-6">中奖方式： ${awardProxy.activityType} </div>
            <div class="col-xs-6 time text-right"> <fmt:formatDate value="${awardProxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
        </div>
        <div class="row b_rows" style="border-bottom:1px dashed #ccc;">
            <div class="col-xs-12">奖品：  ${awardProxy.torphyName} </div>
        </div>
        <div class="row b_rows" style="border-bottom:0;">
            <div class="col-xs-6">状态：
                <c:if test="${awardProxy.trophyType== 1 || awardProxy.trophyType== 2 }">
                    <i>  已发放   </i>
                </c:if>
                <c:if test="${awardProxy.trophyType == 0 }">
                    <c:if test="${awardProxy.state == 0 }">
                        <i>  未领取     </i>
                    </c:if>
                    <c:if test="${awardProxy.state == 1 }">
                        <i>  已提交     </i>
                    </c:if>
                    <c:if test="${awardProxy.state == 2 }">
                        <i>  已发货     </i>
                    </c:if>
                    <c:if test="${awardProxy.state == 3 }">
                        <i>  已领取     </i>
                    </c:if>
                </c:if>
            </div>
            <c:if test="${awardProxy.trophyType == 0 }">
                <c:if test="${awardProxy.state !=null }" >
                    <c:if test="${awardProxy.state == 0 }">
                        <a href="${webRoot}/wap/module/member/addAddress.ac?getTorphyRecodeId=${awardProxy.getTorphyRecodeId}" ><div class="col-xs-6 text-right">填写收货地址<span class="glyphicon glyphicon-chevron-right" ></span></div></a>
                    </c:if>
                    <c:if test="${awardProxy.state == 1 }">
                        <a href="${webRoot}/wap/module/member/addAddress.ac?getTorphyRecodeId=${awardProxy.getTorphyRecodeId}" ><div class="col-xs-6 text-right">查看收货地址<span class="glyphicon glyphicon-chevron-right" ></span></div></a>
                    </c:if>
                    <c:if test="${awardProxy.state == 2 ||awardProxy.state == 3 }">
                        <a href="${webRoot}/wap/module/member/vLogisticsDetail.ac?getTorphyRecodeId=${awardProxy.getTorphyRecodeId}" ><div class="col-xs-6 text-right">查看物流信息<span class="glyphicon glyphicon-chevron-right" ></span></div></a>
                    </c:if>
                </c:if>
            </c:if>

            <c:if test="${awardProxy.trophyType == 1 }">
                <a href="${webRoot}/wap/module/member/myIntegral.ac?userid=${awardProxy.userId}"><div class="col-xs-6 text-right">查看我的积分<span class="glyphicon glyphicon-chevron-right" ></span></div></a>
            </c:if>
            <c:if test="${awardProxy.trophyType == 2 }">
                <a href="${webRoot}/wap/module/member/myCoupon.ac?userid=${awardProxy.userId}"><div class="col-xs-6 text-right">查看我的购物券<span class="glyphicon glyphicon-chevron-right" ></span></div></a>
            </c:if>
        </div>

    </div>
</c:forEach>
<%--奖品列表分页 start--%>
<div class="pn-page row">
        <c:if test="${vwinnerRecodeProxy.lastPageNumber >1}">
            <c:choose>
                <c:when test="${vwinnerRecodeProxy.firstPage}">
                    <div class="col-xs-2">
                        <a type="button" class="btn btn-sm btn-default" disabled='disabled' style="color: #333;" href="?page=1">首页</a>
                    </div>
                    <div class="col-xs-3">
                        <a type="button" class="btn btn-sm btn-default" disabled='disabled' style="color: #333;" href="?page=${page-1}">上一页</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="col-xs-2">
                        <a type="button" class="btn btn-sm btn-default" style="color: #333;" href="?page=1">首页</a>
                    </div>
                    <div class="col-xs-3">
                        <a type="button" class="btn btn-sm btn-default" style="color: #333;" href="?page=${page-1}">上一页</a>
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="col-xs-2">
                <button class="btn btn-default btn-sm dropdown-toggle btn-block" type="button"
                        data-toggle="dropdown">
                        ${page}/${vwinnerRecodeProxy.lastPageNumber} <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" style="width:50px;height:160px;overflow-y: scroll;">

                    <c:forEach begin="1" end="${vwinnerRecodeProxy.lastPageNumber}" varStatus="status">

                        <li><a href="?page=${status.index}" style="color: #333;">第${status.index}页</a></li>

                    </c:forEach>
                </ul>
            </div>
            <c:choose>
                <c:when test="${vwinnerRecodeProxy.lastPage}">
                    <div class="col-xs-3">

                        <a type="button" class="btn btn-sm btn-default" style="color: #333;" disabled='disabled'>下一页</a>
                    </div>
                    <div class="col-xs-2">
                        <a type="button" class="btn btn-sm btn-default" disabled='disabled' style="color: #333;"
                           href="?page=${vwinnerRecodeProxy.lastPageNumber}">末页</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="col-xs-3">
                        <a type="button" class="btn btn-sm btn-default" href="?page=${page+1}" style="color: #333;">下一页</a>
                    </div>
                    <div class="col-xs-2">
                        <a type="button" class="btn btn-sm btn-default"  style="color: #333;"
                           href="?page=${vwinnerRecodeProxy.lastPageNumber}">末页</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
</div>
<%--奖品列表分页 end--%>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>