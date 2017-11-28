$(document).ready(function(){


    //选择商品
    var num=0;
    $(".cp").click(function(){

        if( $(this).hasClass("active")){
            $(this).removeClass("active");
            $(".chk-label").removeClass("active");
            num--;
            $("b").html(num);
        }else{
            $(this).addClass("active");
            num++;
           $("b").html(num);
            var cps = $(".cp");
            var flag=true;
            for( var i=0; i< cps.length;i++){
                if(!$(cps[i]).hasClass("active")){
                    flag=false ;
                    break;
                }
            }
            if(flag){
                $(".chk-label").addClass("active")
            }
        }
    });

    $(".inp").blur(function(){
        var num1=$(this).val();
        var reg = /^(0|[1-9][0-9]*)$/;
        if (!reg.test(num1)) {
             $(this).val(1);
              return;
        }
        var num2=$(this).parent().find("input").attr("num");
        if(num1<=0){
            $(this).val(1);
            return;
        }
        if(parseInt(num1)>=parseInt(num2)){
            $(this).val(num2);

        }
    });
    //全选
    $(".chk-label").click(function(){
        if( $(this).hasClass("active")){
            $(this).removeClass("active");
            $(".cp").removeClass("active");
             num=0;
            $("b").html(num);
        }else{
            $(this).addClass("active");
            $(".cp").addClass("active");
            var cps = $(".cp");
            num=cps.length;
            $("b").html(cps.length);
        }
    });
    $(".op-dec").click(function(){
        var productNum= $(this).parent().find("input").val();
        productNum--;
        $(this).parent().find("input").val(productNum);
        if(productNum<=1){
            $(this).parent().find("input").val(1);
        }
    });
    $(".op-add").click(function(){
        var productNum=$(this).parent().find("input").val();
        productNum++;
        $(this).parent().find("input").val(productNum);
        var num=$(this).parent().find("input").attr("num");
        //alert(num);
        if(productNum>=num){
            $(this).parent().find("input").val(num);
        }
    });


});
var selectPurchase = function(id){

    var cps = $(".cp");
    var nums=[];
    var itemIds=[];
    var noclick=0;
    if(cps.length==0){
        alert("该订单商品已经退换货了！");
        return;
    }
    for(var j=0;j<cps.length;j++){
        if($(cps[j]).hasClass("active")){
            var itemId=$(cps[j]).attr("orderItemId");
            itemIds.push(itemId);
            var inp=$(".inp");
               for(var i=0;i<inp.length;i++){
                   var inpItemid=$(inp[i]).attr("orderItemId");
                   if(itemId==inpItemid){
                      var num=$(inp[i]).val();
                       nums.push(num +":"+inpItemid);
                   }
               }
            noclick++;
        }
    }
    if(noclick<=0){
        alert("请选择要换货的商品！");
        return;
    }
    var numStr=JSON.stringify(nums);
    numStr =numStr.replace(/\"/g, "");
    numStr=numStr.replace(/[\[\]]/g,''); //4:306,3:308


    window.location.href = webPath.webRoot+"/wap/module/afterSaleService/applyPurchase.ac?numStr="+numStr+"&orderId="+id+"&isReturn="+false+"&orderItems="+itemIds;
    //goToUrl(webPath.webRoot + "/module/member/selectPurchase.ac");
};
