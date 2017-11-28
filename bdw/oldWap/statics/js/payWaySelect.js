$(document).ready(function(){
    $("#onLinePayWay").on("click",function(){
        var collapseOne = $("#collapseOne");
        if(collapseOne.hasClass("in")){
            collapseOne.collapse('hide');
            $(".glyphicon-chevron-down").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
        }else{
            collapseOne.collapse('show');
            $(".glyphicon-chevron-up").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
        }
    });
})

var savePayWay = function(payWayId){
    $.ajax({
        url:webPath.webRoot+"/cart/savePayWay.json",
        data:{payWayId:payWayId},
        dataType: "json",
        success:function(data) {
            window.location.href = webPath.webRoot+"/wap/shoppingcart/orderadd.ac?carttype="+webPath.carttype+"&handler="+webPath.handler+"&payWayId="+payWayId+"&time="+(new Date()).getTime();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}