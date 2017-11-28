$(function(){
    //输入框内容清除
    $('.clear').click(function () {
        var next = $(this).next();
        if (next != undefined) {
            next.val("");
        }
    });

    // 提交申请
    $("#applyToCash").click(function(){
        var $validateCode = $.trim($("#validateCode").val());
        var $amount = $.trim(webParams.amount);
        var $withdrawalWayCode = $.trim(webParams.withdrawalWayCode);

        if($validateCode == undefined || $validateCode == null || $validateCode == ''){
            alert("请输入验证码");
            return false;
        }

        $.ajax({
            type: "POST",
            data: {validateCode:$validateCode, amount: $amount,withdrawalWayCode : $withdrawalWayCode},
            url: webParams.webRoot + "/promoteMember/applyReturnCash4Wap.json",
            success: function (data) {
                if(data.success == "true"){
                    window.location.href = webParams.webRoot+"/wap/module/member/cps/cpsApplied.ac";
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });

});


/*发送短信验证码 start*/
var leftSeconds = 120;//倒计时时间120秒
var intervalId;//倒数时间对象
var sendValidateCount = 1;//点击发送次数控制
var sendValidateSwitch = false;//取消订单发送短信开关
var btnObj;//这个对象是必须声明的
var sendValidateNum = function (thisBtn) {
    if(leftSeconds != 120){//修改为120秒倒计时
        return false;
    }

    btnObj = thisBtn;
    //发送短信
    sendValidateSwitch = true;//用于取消订单开关判断
    $('#second').addClass("count");//设置按钮不可用

    sendValidateCode();
};

var countDown = function () {//倒计时方法
    if (leftSeconds <= 0) {
        $('#second').text("发送验证码"); //当时间<=0的时候改变按钮的value
        $('.validate-btn').removeClass("count");//如果时间<=0的时候按钮可用
        clearInterval(intervalId); //取消由 setInterval() 设置的 timeout
        leftSeconds = 120;
        return;
    }

    leftSeconds--;
    $('#second').text("等待" + leftSeconds + "秒");
};

//发送验证码
var sendValidateCode = function () {
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type: "POST",
        url: webParams.webRoot + "/member/sendValidateCode.json",
        data: {},
        dataType: "json",
        async: false,//同步
        success: function (data) {
            if (data.success == "true") {
                //发送成功
                //禁用按钮,开始倒数
                $('.validate-btn').addClass("count");//设置按钮不可用
                intervalId = setInterval("countDown()", 1000);//调用倒计时的方法
            } else if (data.success == "false") {
                //当第一次发送失败的时候,不进行倒数,而是变成"重新发送",当点击"重新发送"的时候,还发送失败就开始进行倒数
                sendValidateCount++;
                $('.validate-btn').removeClass("count");//设置按钮可用
                $('.validate-btn').attr("value", "重新发送");
                if (sendValidateCount > 2) {
                    sendValidateCount = 1;
                    $('.validate-btn').addClass("count");//设置按钮不可用
                    intervalId = setInterval("countDown()", 1000);//调用倒计时的方法
                }
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText == "验证码错误"){
                    alert(result.errorObject.errorText);
                    return;
                }
                alert(result.errorObject.errorText);
            }
        }
    });
};