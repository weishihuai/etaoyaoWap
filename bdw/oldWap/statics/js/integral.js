$(document).ready(function(){
    $(".btn-danger2").click(function(){
        var isLogin=$(this).attr("isLogin");
        if(isLogin=="true"){
            window.location.href=webPath.webRoot+"/wap/login.ac";
            return false;
        }
/*        var userIntegral=parseFloat($(this).attr("userIntegral"));
        var price=parseFloat($(this).attr("price"));
        if(userIntegral<price){
            alert("对不起,您的积分不足,无法兑换");
//            popover("myIntegral","bottom","温馨提示","对不起,您的积分不足,无法兑换");
            return false;
        }*/
        var objectid=$(this).attr("objectid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var type=$(this).attr("protype");
        var btnId = $(this).attr("id");
       window.location=webPath.webRoot+"/wap/integralDetails.ac?integralProductId="+objectid;

/*        if(type=="0"){
            $.ajax({
                url:webPath.webRoot+"/cart/add.json",
                data:{type:carttype,objectId:objectid,quantity:num,handler:handler},
                dataType: "json",
                success:function(data) {
                    window.location.href=webPath.webRoot+"/wap/shoppingcart/cart.ac?carttype="+carttype+"&handler="+handler;
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }else{
            confirm("您确认要兑换此购物券吗？",{onSuccess:function(){
                $.ajax({
                    url:webPath.webRoot+"/cart/add.json",
                    data:{type:carttype,objectId:objectid,quantity:num,handler:handler},
                    dataType: "json",
                    success:function(data) {
                        popover(btnId,"top","","兑换成功");

                    },
                    error:function(XMLHttpRequest, textStatus) {
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(result.errorObject.errorText);
                        }
                    }
                });
            }});
        }*/
    });
});