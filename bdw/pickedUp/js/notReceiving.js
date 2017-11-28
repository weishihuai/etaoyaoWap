$(function () {

    //显示收货窗口
    $(".myIsReceiving").click(function () {
        var orderNumText = $(this).parents('.myIsReceivingParent').find('.d_num').html();
        var receiverNameText = $(this).parents('.myIsReceivingParent').find('.d_name').html();
        var mobileText = $(this).parents('.myIsReceivingParent').find('.d_pho').html();
        var addressText = $(this).parents('.myIsReceivingParent').find('.d_add').html();
        $('#orderNumText').html(orderNumText);
        $('#receiverNameText').html(receiverNameText);
        $('#mobileText').html(mobileText);
        $('#addressText').html(addressText);
        easyDialog.open({
            container: 'myReceivingBox',//这个是要被弹出来的div标签的ID值
            fixed: true
        });
    });

    //隐藏收货窗口
    $('.myCancel').click(function () {
        $('#orderNumText').html('');
        $('#receiverNameText').html('');
        $('#mobileText').html('');
        $('#addressText').html('');
        easyDialog.close();//关闭弹出层
    });


    //搜索
    $("#search").click(function () {
        var orderNum = $("#myOrderNum").val();
        if (orderNum == "请输入订单编号") {
            orderNum = "";
        }
        var nameValue = $("#myOrderName").val();
        if (nameValue == "请输入姓名") {
            nameValue = "";
        }
        var mobile = $("#myOrderMobile").val();
        if (mobile == "请输入手机号码") {
            mobile = "";
        }
        orderNum = $.trim(orderNum);
        nameValue = $.trim(nameValue);
        mobile = $.trim(mobile);
        location.href = webPath.webRoot + "/pickedUp/notReceiving.ac?orderNum=" + orderNum + "&receiverName=" + nameValue + "&Mobile=" + mobile;
    });


    //取消显示收货窗口
    $(".myCancel").click(function () {
        $(".myReceivingBox").css("display", "none");
    });

    //验收订单
    $(".YesReceiving").click(function () {
        var nowOrderNum = $('#orderNumText').html();

        $.ajax({
            type: "GET",
            url: webPath.webRoot + "/pickedup/myReceiving.json",
            data: {orderNum: nowOrderNum},
            dataType: "json",
            success: function (data) {
                if (data.result == true) {
                    $(".myReceivingBox").css("display", "none");
                    location.href = webPath.webRoot + "/pickedUp/notReceiving.ac";
                } else {
                    alert(data.result);
                }
            }
        });
    });

})
