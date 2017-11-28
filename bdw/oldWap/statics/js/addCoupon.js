$(document).ready(function(){
    $(".addNewCoupon").click(function(){
        var couponNum=$("#couponNum");
        var couponPsw=$("#couponPsw");
        if($.trim(couponNum.val())=="" || couponNum.val()==null ){
            alert("请输入卡号")
            return

        }
        if($.trim(couponPsw.val())=="" || couponPsw.val()==null ){
            alert("请输入密码")
            return
        }
        $.ajax({
            url:webPath.webRoot+"/cart/addNewCoupon.json",
            data:({couponNum:couponNum.val(),couponPsw:couponPsw.val(),type:webPath.carttype}),
            success:function(data){
                window.location.href = webPath.webRoot+"/wap/shoppingcart/orderadd.ac?carttype="+webPath.carttype+"&handler="+webPath.handler+"&time="+(new Date()).getTime();
            },
            error:function(XMLHttpRequest, textStatus) {
                couponNum.val('');
                couponPsw.val('')
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    })
});