$(document).ready(function(){
    $(".saveInvoice").click(function(){

        var invoiceTypeValue=$(".invoiceType").val();
        var invoiceTitle= $.trim($("#invoiceTitle").val());
        var isNeedInvoice = invoiceTitle ==  '' ? 'N' : 'Y';
        var invoiceCont=$(".invoiceCont").val();
        if(invoiceTitle==''){
//            alert('填写发票抬头');
            popover("invoiceTitle","bottom","","请填写发票抬头");
            return false;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/saveInvoice.json",
            data:{isNeedInvoice:isNeedInvoice,
                invoiceType:invoiceTypeValue,
                invoiceCont:invoiceCont,
                invoiceTitle:invoiceTitle,
                invoiceEntNm:"",invoiceTaxPayerNum:"",invoiceEntAddr:"",invoiceEntTel:"",invoiceEntBank:"",invoiceBackAccount:""
            },
            dataType: "json",
            success:function(data) {
                window.location.href = webPath.webRoot+"/wap/shoppingcart/orderadd.ac?carttype="+webPath.carttype+"&handler="+webPath.handler+"&time="+(new Date()).getTime();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });
});