<%@ page import="com.iloosen.imall.module.order.domain.Order" %>
<%@ page import="com.iloosen.imall.commons.util.BigDecimalUtil" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysUser" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
    <c:redirect url="/wap/login.ac" />
</c:if>
<c:set value="${sdk:getMobilePayWayVo()}" var="payWayList" />

<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
<c:if test="${isWeixin=='Y'}">
    <script src="${webRoot}/template/bdw/wap/statics/js/jweixin-1.2.0.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/weixinJsConfigInit.js"></script>
</c:if>

<script type="text/javascript">

    var webPath={
        webRoot:"${webRoot}",
        weixinJsConfig: {
            jsApiList: [
                'chooseWXPay'//微信支付
            ]
        }
    };

    $(function () {

        $(".checkbox").click(function(){
            $("p em").removeClass("checkbox-active");
            $(this).addClass("checkbox-active");
            var payWayId = $(this).attr("payWayId");
            $("#payWayId").val(payWayId);
        });

        $('#payNow').click(function(){

            var payWayId = $("#payWayId").val();

            if(payWayId==""){
                alert("请选择支付方式！");
                return;
            }

            if (payWayId!='4'){
                $("#goBank").submit();
                return;
            }

            var isUseAccount = $("#isUseAccount").val();
            var extraData = $("#extraData").val();
            var orderType = $("#orderType").val();
            $.ajax({
                type:"POST",
                url:"${webRoot}/cashier/goBank.json",
                data:{"isUseAccount":isUseAccount,"payWayId":payWayId,"extraData":extraData,"orderType":orderType},
                dataType: "json",
                success:function(data) {
                    vpayWay(data.documentNum);
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        });


        function vpayWay(documentNum) {
            $.ajax({
                url: "${webRoot}/wxsdk/wxpay/jspay.json",
                data: {documentNum: documentNum},
                type: "post",
                success: function (data) {
                    //alert("成功生成支付");
                    //alert(data.result);
                    if (data.success == "true") {
                        var result = eval("(" + data.result + ")");
                        if(result==null){
                            alert("请求失败，请稍后再进行支付...");
                            result;
                        }
                        var package = result.package;
                        var timestamp = result.timestamp;
                        var noncestr = result.noncestr;
                        var paySign = result.paySign;
                        var signType = result.signType;

                        wx.chooseWXPay({
                            timestamp: timestamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                            nonceStr: noncestr, // 支付签名随机串，不长于 32 位
                            package: package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
                            signType: signType, // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                            paySign: paySign, // 支付签名
                            success: function (res) {
                                window.location.href = "${webRoot}/wap/shoppingcart/returnPay.ac";
                            }
                        });
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }

    });



</script>


<%
    String orderIds = request.getParameter("orderIds");
    Double totalAmount = 0D;
    SysUser sysUser = WebContextFactory.getWebContext().getFrontEndUser();
    for (String orderIdStr : orderIds.split(",")){
        try {
            Integer orderId = Integer.parseInt(orderIdStr);
            Order order = ServiceManager.orderService.getById(orderId);
            if (order != null && order.getSysUserId().equals(sysUser.getSysUserId()) && BoolCodeEnum.NO == BoolCodeEnum.fromCode(order.getIsPayed())){
                totalAmount = BigDecimalUtil.add(totalAmount, order.getOrderTotalAmount());
            }
        }catch (Exception e){
        }
    }
    request.setAttribute("totalAmount", totalAmount);
%>
<div class="payment-layer">
    <div class="payment-layer-inner">
        <div class="dt"><a class="close" href="${webRoot}/wap/shoppingcart/paySuccess.ac?carttype=${param.cartType}"></a>选择付款方式</div>
        <div class="dd">
            <c:forEach items="${payWayList}" var="payWay">
                <c:if test="${payWay.paymentTypeCode eq '21'}">
                    <p class="wechat" >微信支付<em payWayId="${payWay.payWayId}" data-payWay-id="${payWay.payWayId}" class="checkbox"></em></p>
                </c:if>
                <c:if test="${payWay.paymentTypeCode eq '20'}">
                    <p class="alipay">支付宝<em payWayId="${payWay.payWayId}" data-payWay-id="${payWay.payWayId}" class="checkbox"></em></p>
                </c:if>
            </c:forEach>
            <div class="payment-btn-box">
                <p>应付金额<span>￥<fmt:formatNumber value="${totalAmount}" type="number" pattern="#0.00#" /></span></p>
                <a class="payment-btn" id="payNow" href="javascript:;">去付款</a>
            </div>
        </div>
    </div>

    <form action="${webRoot}/cashier/goBank.ac" method="post" id="goBank">
        <input type="hidden" value="false" name="isUseAccount" id="isUseAccount"/>
        <input type="hidden" value="${param.orderIds}" id="extraData" name="extraData"/>
        <input type="hidden" name="payWayId" id="payWayId"/>
        <input type="hidden" value="wap"  id="orderType" name="orderType" />
    </form>

</div>

