$(document).ready(function(){

    //参团时判断是否登录
    $("#cantuan").click(function () {
        $.ajax({
            url:webPath.webRoot+"/cart/canTuan.json",
            type:'POST',
            success:function(data) {
                if(data.success == "true"){
                    $('#numModel').modal('show');
                }else{
                    location.href = webPath.webRoot+"/wap/login.ac";
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

    //加入团购商品
    $(".addcart").click(function(){
        var objectid=$(this).attr("objectid");
        var num=$("#num").val();
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        if(undefined ==num || null == num || "" == num || parseInt(num)<=0){
            alert("请输入购买数量");
            return;
        }
        /*if (objectid == "") {
         alert("请选择商品规格");
         return;
         }*/
        //如果没有选择任何规格,给用户提示
        if($(".specSelect").size() != selectSpecValues.length){
            alert("请选择商品规格");
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/tuanAdd.json",
            data:{type:carttype,objectId:objectid,quantity:num,handler:handler},
            dataType: "json",
            success:function(data) {
                if(data.success == "true"){
                    window.location.href=webPath.webRoot+"/wap/shoppingcart/orderadd.ac?handler=groupBuy&carttype=groupBuy&isCod=N";
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

    //数量改变
    $("#num").change(function(){
        //每次操作先清空错误日志
        $(".msg").html("");
        var stockNum = $("#stockNum").val();
        if(undefined != stockNum || "" != stockNum || null != stockNum || null != parseInt(stockNum)){
            var num = $("#num");
            var quantity = num.val();
            var numCheck = /^[0-9]*$/;
            if (!numCheck.test(quantity)) {
                //alert("请输入数字");
                $(".msg").html("请输入数字");
                num.val(1);
                return;
            }
            //如果库存大于1,并且购买数量没有超过库存
            if(parseInt(stockNum) > 0 && parseInt(quantity) < parseInt(stockNum)){
                $(".groupPrd_addNum").removeClass("lock");
            }
            //如果库存大于1,并且购买数量等于库存
            if(parseInt(stockNum) > 1 &&parseInt(quantity) == parseInt(stockNum)){
                $(".groupPrd_addNum").addClass("lock");
                $(".groupPrd_subNum").removeClass("lock");
            }
            if(quantity <= 0){
                num.val(1);
                $(".groupPrd_subNum").addClass("lock");
                $(".msg").html("数量不能小于0");
                //alert("数量不能小于0");
                return;
            }
            if(parseInt(quantity) > parseInt(stockNum)){
                num.val(stockNum);
                $(".groupPrd_addNum").addClass("lock");
                $(".msg").html("最多只能购买"+stockNum+"件");
                //alert("该商品数量不足");

            }


        }
    });
    //数量减少,当超过库存时，增加数量的按钮不能用，当数量时1时，减少数量不能用
    $(".groupPrd_subNum").click(function(){
        //每次操作先清空错误日志
        $(".msg").html("");
        var stockNum = $("#stockNum").val();
        if(undefined != stockNum || "" != stockNum || null != stockNum || null != parseInt(stockNum)){
            if(stockNum == 0){
                $(".groupPrd_subNum").addClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                $(".msg").html("最多只能购买"+stockNum+"件");
                //alert("该商品数量不足");
                return;
            }
            var num = $("#num");
            var quantity = $("#num").val();
            if (quantity == 1) {
                $(this).addClass("lock");
                return;
            }
            var newQuantity = parseInt(quantity) - 1;
            if(newQuantity == 1){
                $(this).addClass("lock");
                num.val(1);
                return;
            }if(parseInt(newQuantity) < parseInt(stockNum)){
                $(".groupPrd_addNum").removeClass("lock");
            }
            num.val(newQuantity);

        }
    });
    //数量添加
    $(".groupPrd_addNum").click(function(){
        //每次操作先清空错误日志
        $(".msg").html("");
        var stockNum = $("#stockNum").val();
        if(undefined != stockNum || "" != stockNum || null != stockNum || null != parseInt(stockNum)){
            if(parseInt(stockNum) == 0){
                $(".groupPrd_subNum").addClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                $(".msg").html("最多只能购买"+stockNum+"件");
                //alert("该商品数量不足");
                return;
            }
            var num = $("#num");
            var quantity = $("#num").val();
            if (parseInt(quantity) > parseInt(stockNum)) {
                $(".groupPrd_subNum").removeClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                num.val(stockNum);
                $(".msg").html("最多只能购买"+stockNum+"件");
                //alert("该商品数量不足");
                return;
            }
            var newQuantity = parseInt(quantity) + 1;
            if (newQuantity > parseInt(stockNum)) {
                $(".groupPrd_subNum").removeClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                num.val(stockNum);
                $(".msg").html("最多只能购买"+stockNum+"件");
                //alert("该商品数量不足");
                return;
            }if (newQuantity == parseInt(stockNum)) {
                $(".groupPrd_subNum").removeClass("lock");
                $(".groupPrd_addNum").addClass("lock");
                num.val(stockNum);
                return;
            }
            if(parseInt(newQuantity) < parseInt(stockNum)){
                $(".groupPrd_subNum").removeClass("lock");
            }
            num.val(newQuantity);
        }
    });
});