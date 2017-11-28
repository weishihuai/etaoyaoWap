<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${weixinSdk:getLogisticsDetail(param.getTorphyRecodeId)}" var="torphyRecode"/>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>物流信息</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/vLogisticsDetail.js"></script>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <script type="text/javascript">
        var dataValue = {
            webRoot: "${webRoot}"
        }
    </script>
    <style type="text/css">
        .jf_box{border:#c3c3c3 1px solid; background:#fff; width:100%; margin-bottom:10px;}
        .jf_box .b_rows{color:#666; font-size:14px; line-height:30px; padding-left:20px;}
    </style>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=物流信息"/>
<%--页头结束--%>

<div class="container jf_box" style="border-radius:5px; border:none;">
    <div class="row b_rows">
        <div class="col-xs-12" style="font-weight:bold;">收货地址</div>
    </div>
    <div class="row b_rows">
        <div class="col-xs-12">${torphyRecode.receiverName}&nbsp;&nbsp;&nbsp;&nbsp;${torphyRecode.receiverMobile}</div>
    </div>
    <div class="row b_rows">
        <div class="col-xs-12">${torphyRecode.zoneAddr}</div>
    </div>
    <div class="row b_rows">
        <div class="col-xs-12">${torphyRecode.receiverAddress}</div>
    </div>
</div>

<div class="container jf_box" style="border-radius:5px; border:none;">
    <div class="row b_rows">
        <div class="col-xs-12" style="font-weight:bold;">物流信息</div>
    </div>
    <div class="row b_rows">
        <div class="col-xs-12">快递公司&nbsp;&nbsp;&nbsp;&nbsp;${torphyRecode.expressCompany}</div>
    </div>
    <div class="row b_rows">
        <div class="col-xs-12">快递单号&nbsp;&nbsp;&nbsp;&nbsp;${torphyRecode.expressId}</div>
    </div>
</div>

<c:if test="${torphyRecode.state!='3'}">
    <div class="container tjdd">
        <div class="row row7">
            <div class="col-xs-12 df"><a href="javascript:void(0)" onclick="buyerSigned(${param.getTorphyRecodeId})" class="btn btn-primary bd_btn btn-block " style="color:#fff; background:#cc0000; border:#cc0000 1px solid;" role="button">确认领奖</a></div>
        </div>
    </div>
</c:if>

</body>
</html>
