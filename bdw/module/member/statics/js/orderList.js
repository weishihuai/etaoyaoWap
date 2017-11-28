$(document).ready(function(){

    $(".countDown").each(function() {
        fresh($(this));
    });

    countDown=setInterval(function(){
        $(".countDown").each(function() {
            fresh($(this));
        });
    },1000);


    $("#missingCancle").click(function(){
        easyDialog.close();
    });

    $("#mistakeCancle").click(function(){
        easyDialog.close();
    });

    $("#mistakeBtn").click(function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        var orderitemId = $("#mistakeOrderitemId").val();
        var mistakeNum = $("#mistakeNum").val();
        var mistakeNumReal = $("#mistakeNumReal").val();
        if(mistakeNum.length<=0){
            alert("输入框不能为空!");
            return false;
        }
        var reg = /^\d+$/ ;
        if(!reg.test(mistakeNum)){
            alert("只能输入非负整数！");
            return false;
        }
        if(mistakeNum>mistakeNumReal){
            alert("申请个数不能超过购买个数！");
            return false;
        }
        if(mistakeNum==0){
            alert("申请个数不能为0！");
            return false;
        }
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/mistakeApply/save.json?orderitemId="+orderitemId +"&mistakeNum="+mistakeNum,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.reload();
                    },1)
                }else if(data.success == "false"){
                    alert(data.msg);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("发错申请失败！");
            }
        });
    });

    $("#missingBtn").click(function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        var orderitemId = $("#missingOrderitemId").val();
        var missingNum = $("#missingNum").val();
        var missingNumReal = $("#missingNumReal").val();
        if(missingNum.length<=0){
            alert("输入框不能为空!");
            return false;
        }
        var reg = /^\d+$/ ;
        if(!reg.test(missingNum)){
            alert("只能输入非负整数！");
            return false;
        }
        if(missingNum>missingNumReal){
            alert("申请个数不能超过购买个数");
            return false;
        }
        if(missingNum==0){
            alert("申请个数不能为0！");
            return false;
        }
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/missingApply/save.json?orderitemId="+orderitemId+"&missingNum="+missingNum,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.reload();
                    },1)
                }else if(data.success == "false"){
                    alert(data.msg);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("漏发申请失败！");
            }
        });
    });

     $(".selectAllNotPayOrder").click(function(){
         if($(this).attr("checked")=="checked"){
             $(".select").each(function(){
                 $(this).attr("checked",true);
             });
         }else{
             $(".select").each(function(){
                 $(this).attr("checked",false);
             });
         }
     });

    getFocus  = function(obj,eqmsg){
        if(eqmsg==$(obj).val()){
            $(obj).val("");
        }
    };
    lostFocus= function(obj,msg){
        if($(obj).val()==''){
            $(obj).val(msg);
        }
    };

    // 订单删除
    $(".deleteOrderBtn").click(function(){
        var orderId = $(this).attr("orderId");

        if(confirm("你确定删除此订单吗?")){
            $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
            $.ajax({
                url: webPath.webRoot + "/order/delete.json?orderId=" + orderId ,
                type: "POST",
                success: function(data){
                    $(".overlay").show();
                    setTimeout(function() {
                        $(".overlay").hide();
                        window.location.href = webPath.webRoot + "/module/member/orderList.ac?pitchOnRow=" + webPath.pitchOnRow + "&page=" + webPath.page+"&time="+new Date().getTime();
                    },4000)
                },
                error: function(XMLHttpRequest, textStatus){
                    if(XMLHttpRequest.status == 500){
                        var message = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(message.errorObject.errorText);
                    }
                }
            });
        }
        return false;
    });
});


function fresh(t){
    var RemainTime = t.attr("lastPayTime");
    var orderId = t.attr("orderId");
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    if(leftsecond<=0){
        clearInterval(countDown);
        window.location.reload();
    }else{
        d=parseInt(leftsecond/3600/24);
        h=parseInt((leftsecond/3600)%24);
        m=parseInt((leftsecond/60)%60);
        s=parseInt(leftsecond%60);
        $("#orderId"+orderId).html("<span>支付还剩：</span><b class='timeColor'>" + h + "</b> 时<b class='timeColor'>" + m + "</b> 分 <b class='timeColor'>" + s + "</b> 秒");
    }
}


/**
 * 查询近一个月/一个月前的订单
 **/
function selectOrder(){
    var searchField=$("#searchField").val();
    if(searchField=='商品名称、商品编号、订单编号'){
        $("#searchField").attr("value",'');
    }
    setTimeout(function(){
        $('#serachForm').submit();
    },1)
}

/*合并支付*/
function mergerPayment(){
    var items = [];
    var i=0;
    $(".select").each(function(){
        if($(this).attr("checked")=="checked"){
            items[i]=$(this).val();
            i++;
        }
    });
    if(items.length==0){
        alert("您还没有选择任何订单!");
        return;
    }
    var orderIds = items.join(",");
    setTimeout(function(){
        window.location.href=webPath.webRoot+"/shoppingcart/cashier.ac?orderIds="+orderIds;
    },1);
}

/*
 * 取消订单
 * */
function cancelOrder(orderId,url){
    if(confirm("您确认要取消此订单么?")){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/order/cancel.json?orderId="+orderId ,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.href = webPath.webRoot+"/module/member/"+url+".ac?time="+new Date().getMilliseconds();
                    },1)
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("取消订单失败！");
            }
        });
    }
    return false;

}

/*
*  漏发申请
* */
function missing_apply(orderitemId,missingNumReal){
    $("#missingOrderitemId").val(orderitemId);
    $("#missingNumReal").val(missingNumReal);
    easyDialog.open({
        container: 'missingApplyBtn',//这个是要被弹出来的div标签的ID值
        fixed: true
    });
}

/*
 *  发错申请
 * */
function mistake_apply(orderitemId,mistakeNumReal){
    $("#mistakeOrderitemId").val(orderitemId);
    $("#mistakeNumReal").val(mistakeNumReal);
    easyDialog.open({
        container: 'mistakeApplyBtn',//这个是要被弹出来的div标签的ID值
        fixed: true
    });
}

/*
* 确认收货
* */
function buyerSigned(thisObject,orderId){
    if(confirm("您确认收货了吗?")){
        $(thisObject).attr("onclick", "javascript:;");
        $(thisObject).html("正在提交");
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/order/buyerSigned.json?orderId="+orderId ,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.reload();
                    },1)
                } else if (data.isSigned == "true") {
                    alert("该订单已经确认收货了");
                    window.location.reload();
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("确认收货失败！");
            }
        });
    }
    return false;

}


//查询当前的订单状态
function confirmStatus(orderId){
    $.ajax({
        type:"GET" ,url:webPath.webRoot+"/order/confirmOrderStatus.json",
        data:{orderId:orderId},
        dataType:"json",
        success:function(data) {
            if(data.success == "true"){
                if(data.isPayed == "true"){
                    alert("该订单已经支付过了!");
                }else{
                    location.href = webPath.webRoot+"/shoppingcart/cashier.ac?orderIds="+orderId;
                }
            }else {
                alert("抱歉，系统异常,请重新去支付");
            }
        }
    });
}