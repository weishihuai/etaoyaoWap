$(function(){
    //服务态度
    $(".grade .serviceAttitude .star a").click(function () {
        /*if (!webParams.orderComment) {
            return;
        }*/
        $(this).parent().removeClass().addClass('star ' + $(this).attr('class'));
        var level = $(this).attr('class').match(/([0-9])+/g);
        $(this).parent().prev('input[type="hidden"]').val(parseInt(level[0]));
    });
    //发货速度
    $(".grade .sendOutSpeed .star a").click(function () {
       /* if (!webParams.orderComment) {     //当订单已评价时，点击星星不改变
            return;
        }*/
        $(this).parent().removeClass().addClass('star ' + $(this).attr('class'));
        var level = $(this).attr('class').match(/([0-9])+/g);
        console.log($(this).attr('class'));
        $(this).parent().prev('input[type="hidden"]').val(parseInt(level[0]));
    });
    // 宝贝描述
    $(".grade .majorLevel .star a").click(function () {
       /* if (!webParams.orderComment) {     //当订单已评价时，点击星星不改变
            return;
        }*/
        $(this).parent().removeClass().addClass('star ' + $(this).attr('class'));
        var level = $(this).attr('class').match(/([0-9])+/g);
        $(this).parent().prev('input[type="hidden"]').val(parseInt(level[0]));
    });
    // 商品评分
    $(".grade .goodScore .star a").click(function () {
        /* if (!webParams.orderComment) {     //当订单已评价时，点击星星不改变
         return;
         }*/
        $(this).parent().removeClass().addClass('star ' + $(this).attr('class'));
        var level = $(this).attr('class').match(/([0-9])+/g);
        $(this).parent().prev('input[type="hidden"]').val(parseInt(level[0]));
    });
    // 移除评价内容
    $(".judgeContent").click(function(){
        clearAreaText(".judgeContent","欢迎您发表原创并对其它用户有参考价值的商品评价。",function(){
            $(".judgeContent").empty();
        });
    });
    // 提交事件触发
    $(".commit").click(function(){
        clearAreaText(".judgeContent","欢迎您发表原创并对其它用户有参考价值的商品评价。",function(){
            $(".judgeContent").empty();
            return false;
        });
        // 获取评论内容
        var goodScore =  $("input[name='goodScore']").val();
        var judgeContent = $.trim($(".judgeContent").val());
        if(judgeContent.length < 4){
            //prdCommentLAlertDialog("您输入的内容太短了，请说多几句。");
            alert("您输入内容不能少于4个字符。");
            return;
        }
        if(judgeContent.length > 255 ){
           // prdCommentLAlertDialog("请输入少于255个字符");
            alert("请输入少于255个字符");
            return;
        }
        $(".commit").unbind("click");
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/frontend/comment/addProductComment.json",
            data:{objectId:webPath.productId,gradeLevel:goodScore,commentCont:judgeContent,isAnonymousComment:'Y'},
            dataType:"json",
            async: false,//同步
            success:function(data){
                if(data.success == false){
                    if(data.errorCode == "errors.login.noexist"){
                        showPrdCommentUserLogin();
                        return;
                    }
                    if(data.errorCode == "errors.comment.notOrder"){
                        alert("您已进行过评论或未购买此商品");
                    }
                }else if(data.success == true){
                    $(".commit").html("正在提交");
                    //$("#commentForm").submit();
                    window.location.href = webPath.webRoot + "/wap/module/member/orderDetail.ac?id=" + webPath.orderId;
                }
            },
            error:function(data){
                alert("对不起,提交评论失败");
                //prdCommentLAlertDialog("对不起,提交评论失败");
            }
        });
    });
});

var clearAreaText = function(id,areaStr,do_fn){
    if($(id).val() == areaStr){
        do_fn();
        return false;
    }
    return true;
};

// 店铺评价
var ajaxShopComment = function(){
    // 获取评价的数据
    var value = ajaxComment();
    $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
    $.ajax({
        type : "post",
        url:webPath.webRoot+"/member/saveProductCommentAndShopRating.json",
        data: _ObjectToJSON("post",value),
        async: false,
        success:function(msg) {
            showSuccess("评论成功");
            window.location.href = webPath.webRoot + "/wap/module/member/orderDetail.ac?id="+ value.orderId;
            //goToUrl(webPath.webRoot+"/module/member/orderDetail.ac?id="+orderId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
        }
    });

};

var ajaxComment = function(){

    var orderId = webPath.orderId;
    var productDescrSame =   $("input[name='majorLevel']").val();
    var sellerSendOutSpeed = $("input[name='sendOutSpeed']").val();
    var sellerServiceAttitude = $("input[name='serviceAttitude']").val();

    return {
        orderId:orderId, productDescrSame:productDescrSame, sellerSendOutSpeed:sellerSendOutSpeed, sellerServiceAttitude: sellerServiceAttitude,
    }
};

//最普通最常用的alert对话框，默认携带一个确认按钮
/*var prdCommentLAlertDialog = function(dialogTxt){
    var commentAlertDialog = jDialog.alert(dialogTxt);
};*/
