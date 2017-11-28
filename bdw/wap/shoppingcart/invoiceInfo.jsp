<html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<head lang="en">
    <meta charset="utf-8">
    <title>发票信息</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/invoiceInfo.css" type="text/css" rel="stylesheet" />
</head>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
    <c:redirect url="/wap/login.ac" />
</c:if>
<c:set var="cartType" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="isCod" value="${empty param.isCod ? 'N' : param.isCod}"/>
<c:set var="cartList" value="${sdk:getUserCartListProxy(cartType)}" />
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1);"></a>
    <div class="toggle-box">发票信息</div>
</div>

<div class="invoice-info-main">
    <div class="invoice-title">开具发票</div>
    <div class="invoice-toggle"><a data-need-invoice="N" <c:if test="${cartList.isNeedInvoice eq 'N'}">class="cur"</c:if> href="javascript:;">不开发票</a><a data-need-invoice="Y" <c:if test="${cartList.isNeedInvoice eq 'Y'}">class="cur"</c:if> href="javascript:;">开发票</a></div>
    <div <c:if test="${cartList.isNeedInvoice eq 'N'}">style="display: none;" </c:if> class="invoice-info-inner">
        <div class="invoice-title">发票抬头</div>
        <div class="dt">
            <p><em data-invoice-type="个人" <c:if test="${cartList.invoiceType eq '个人'}">class="checkbox checkbox-active"</c:if> class="checkbox"></em>个人</p>
            <p><em data-invoice-type="公司" <c:if test="${cartList.invoiceType eq '公司'}">class="checkbox checkbox-active"</c:if> class="checkbox"></em>公司</p>
        </div>
        <div class="dd">
            <div class="dd-item">
                <input value="${cartList.invoiceTitle}" id="invoiceTitle" type="text" placeholder="请输入发票抬头" maxlength="50"/>
                <input value="${cartList.invoiceTaxPayerNum}" id="invoiceTaxPayerNum" type="text" placeholder="请输入发票税号" maxlength="15"/>
            </div>
        </div>
    </div>
    <div class="invoice-btn-box"><a class="invoice-btn" href="javascript:;">确定</a></div>
</div>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript">
    $(function(){
        /*发票toggle*/
        (function(){
            $(".invoice-toggle a").click(function(){
                $(".invoice-toggle a").removeClass("cur");
                $(this).addClass("cur");
                if($(this).index() == 0){
                    $(".invoice-info-inner").hide();
                }else {
                    $(".invoice-info-inner").show();
                }
            });
            $(".invoice-info-inner .dt p").click(function(){
                $(this).find(".checkbox").addClass("checkbox-active").parent().siblings().find(".checkbox").removeClass("checkbox-active");
            });
            
            $(".invoice-btn").click(function () {
                var isNeedInvoice = $(".invoice-toggle a.cur").attr("data-need-invoice");
                var invoiceTitle = $("#invoiceTitle").val().trim();
                var invoiceTaxPayerNum = $("#invoiceTaxPayerNum").val().trim();
                var invoiceType = $(".dt p em.checkbox-active").attr("data-invoice-type");
                if(isNeedInvoice == 'Y'){
                    if(!invoiceTitle){
                        alert("请输入发票抬头");
                        return false;
                    }
                    if(!invoiceTaxPayerNum){
                        alert("请输入发票税号");
                        return false;
                    }
                }
                $.ajax({
                    url: "${webRoot}/cart/saveInvoiceInfo.json",
                    data:{cartType: "${cartType}", isNeedInvoice: isNeedInvoice, invoiceTitle: invoiceTitle, invoiceTaxPayerNum: invoiceTaxPayerNum, invoiceType: invoiceType},
                    dataType: "json",
                    success:function(data) {
                        if (data.success){
                            window.location.href = "${webRoot}/wap/shoppingcart/orderAdd.ac?carttype=${cartType}&handler=${handler}&isCod=${isCod}&time=" + new Date().getTime();
                        }else {
                            alert("保存发票信息失败");
                        }
                    },
                    error:function(XMLHttpRequest, textStatus) {
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(result.errorObject.errorText);
                        }
                    }
                });
            });
        })();
    });
</script>
</body>
</html>
