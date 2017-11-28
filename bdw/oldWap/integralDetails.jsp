<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--根据积分商品Id取出积分商品--%>
<c:set value="${sdk:getIntegralProduct(param.integralProductId)}" var="integralProduct"/>
<%--根据积分商品分类Id 取出同类积分商品--%>
<c:set value="${sdk:findIntegralProductsByCategoryId(integralProduct.integralProductCategoryId,4)}" var="similarGoods"/>
<%--积分兑换 详细信息--%>
<c:set value="${sdk:getArticleById(60912)}" var="information"/>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>积分兑换详细</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/integralDetails.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/integralDetails.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=积分兑换详细"/>
<%--页头结束--%>

    <div class="row g_pic">
        <div class="col-xs-12"><img class="col-xs-12 img-responsive"  src="${integralProduct.icon['320X320']}" style="height: 320px;width: 100%;"></div>
        <div class="col-xs-12 layer_title">${integralProduct.integralProductNm}</div>
    </div>

<div class="container">
<c:choose>
    <c:when test="${integralProduct.paymentConvertTypeCode eq '2'}">
    <div class="row jf_layer" id="integralProductShow">
        <div class="col-xs-4 jf">固定积分：</div>
        <div class="col-xs-8 jf_num"><fmt:formatNumber value="${integralProduct.integral}" type="number" pattern="######.##" />分</div>
    </div>
    <div class="row jf_layer" style="display: none" id="exchange">
        <div class="col-xs-4 jf">积分+金额：</div>
        <div class="col-xs-8 jf_num"><fmt:formatNumber value="${integralProduct.exchangeIntegral}" type="number" pattern="######.##" />分+<fmt:formatNumber value="${integralProduct.exchangeAmount}" type="number" pattern="######.##" />元</div>
    </div>
    </c:when>
    <c:when test="${integralProduct.paymentConvertTypeCode eq '0'}">
        <div class="row jf_layer">
            <div class="col-xs-4 jf">固定积分：</div>
            <div class="col-xs-8 jf_num"><fmt:formatNumber value="${integralProduct.integral}" type="number" pattern="######.##" />分</div>
        </div>
    </c:when>
    <c:when test="${integralProduct.paymentConvertTypeCode eq '1'}">
        <div class="row jf_layer">
            <div class="col-xs-4 jf">积分+金额：</div>
            <div class="col-xs-8 jf_num"><b><fmt:formatNumber value="${integralProduct.exchangeIntegral}" type="number" pattern="######.##" /></b>
                分+<b><fmt:formatNumber value="${integralProduct.exchangeAmount}" type="number" pattern="######.##" /></b>元</div>
        </div>
            </c:when>

</c:choose>


    <div class="row jf_layer">
        <div class="col-xs-4 jf">兑换方式：</div>
        <div class="col-xs-8 jf_num">
            <div class="r_Data">
            <c:choose>
                <c:when test="${integralProduct.paymentConvertTypeCode eq '2'}">
                    <div class="choose-pro">
                        <span class="label"></span>
                        <ul class="cho-cont">
                            <li class="cur integralModeBtn" integralExchangeType="0" style=""><a href="javascript:void(0);" style="">固定积分</a><i></i></li><!--这里可以加cur-->
                            <li class="integralCashModeBtn" integralExchangeType="1" ><a href="javascript:void(0);" style="">积分+现金</a><i></i></li>
                        </ul>
                    </div>
                </c:when>
                <c:when test="${integralProduct.paymentConvertTypeCode eq '0'}">
                    <div class="choose-pro">
                        <span class="label"></span>
                        <ul class="cho-cont">
                            <li class="cur integralModeBtn" integralExchangeType="0"><a href="javascript:void(0);" style="">固定积分</a><i></i></li><!--这里可以加cur-->
                        </ul>
                    </div>
                </c:when>
                <c:when test="${integralProduct.paymentConvertTypeCode eq '1'}">
                    <div class="choose-pro">
                        <span class="label"></span>
                        <ul class="cho-cont ">
                            <li class="integralCashModeBtn cur" integralExchangeType="1"><a href="javascript:void(0);" style="">积分+现金</a><i></i></li>
                        </ul>
                    </div>
                </c:when>
            </c:choose>
                </div>

        </div>
    </div>


    <div class="row jf_layer">
    <div class="col-xs-4 jf" style=" margin-top: 12px;">兑换数量：</div>
    <div class="col-xs-8">
        <div class="add_box">
            <div class="sub"><a href="javascript:"></a></div>
            <input type="text" class="number" name="te" value="1" onblur="validateNumber();">
            <div class="add"><a href="javascript:"></a></div><br/>

        </div>
    </div>
</div>
    <div class="row jf_layer" style="margin-top:0px;">
        <div class="col-xs-4 jf"></div>
        <div class="col-xs-8">
       <font style="font-size: 10px;" color="red">(当前库存为${integralProduct.num}件)</font>
        </div>
    </div>

    </div>

    <div class="row jf_layer">
        <div class="col-xs-12 ljdh_btn"><a num="1" objectid="${integralProduct.integralProductId}" integralProductNum="${integralProduct.num}" class="addcart" userIntegral="${loginUser.integral}" carttype="integral" isLogin="${empty loginUser ? true :false}" price="${integralProduct.integral}"  exchangeIntegral="${integralProduct.exchangeIntegral}"  handler="integral" type="${integralProduct.type}" href="javascript:">立即兑换</a></div>
    </div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
