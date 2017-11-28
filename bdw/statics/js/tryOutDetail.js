/**
 * Created by admin on 2016/11/22.
 */

$(document).ready(function(){
    imallCountdown(webPath.endTimeLimit, webPath.systemTime);
    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [ o[this.name] ];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    //申请弹窗
    $("#apply").click(function(){
        if(webPath.isLogin == "false"){
            alert("请先登录");
            location.href = webPath.webRoot + "/login.ac";
            return;
        }
        $("#userIntegal").html($(this).attr("integal"));
        $(".overlay").show();
    });

    $(".applyClose").click(function(){
        $(".overlay").hide();
    });

    // 试用详情tab
    $(".minute-menu>li").click(function(){
        var $li = $(this);
        $li.addClass("cur").siblings().removeClass("cur");

        var tab = $li.attr("tab");
        $("."+tab+"-cont").show().siblings(".tab_cont").hide();
    });

    //变更收货id
    $(".receiver").click(function(){
        $(this).parent().addClass("cur").siblings().removeClass("cur");
        $("#selReceiverId").val($(this).attr("receiverId"));
    });

    //变更协议内容
    $(".accept").click(function(){
        if($(this).hasClass("cur")){
            $(".accept").removeClass("cur");
        }else{
            $(".accept").addClass("cur");
        }

    });
});


//添加申请
function sendPayIntegral() {
    if (webPath.isLogin == "false") {
        alert("请先登录");
        location.href = webPath.webRoot + "/login.ac";
        return;
    }
    var text = $('#integralText').val();
    var receiverId = $('#selReceiverId').val();
    var accept = $(".accept").hasClass("cur");
    if (!accept) {
        alert("请确认同意协议内容");
        return false;
    }

    if (jQuery.trim(text) == "" || jQuery.trim(text) == null) {
        alert("请输入理由");
        return false;
    }
    if(jQuery.trim(text).length > 128){
        alert("申请理由不能超过128个字符");
        return false;
    }

    if (jQuery.trim(receiverId) == "" || jQuery.trim(receiverId) == null) {
        if (window.confirm("没有选择收货地址，是否进入添加收货地址页面？")) {
            location.href = webPath.webRoot + "/module/member/myAddressBook.ac?pitchOnRow=2";
            return false;
        } else {
            return false;
        }

    }
    $('#applyReason').val(text);
    $('#receiverId').val(receiverId);
    var data = $('#addFrom').serializeObject();
    $.ajaxPost(webPath.webRoot + "/freeTrial/addFreeTrialApply.json", _ObjectToJSON("post", data),
        function (result) {
            if (handleResult(result)) {
                alert("您的申请已经成功提交，系统已扣除您的积分。请等待我们系统管理员的审核，如果您能够幸运的成为体验试用用户，我们将及时通知您");
                $('#integralPay').hide();
                $("#applyFreeTrial").html('<a href="' + webPath.webRoot + '/module/member/myFreeTrialApplyList.ac" class="btn had">查看我的申请</a>');
                window.location.reload();
            }
        })
}

function imallCountdown(entTime, systemTime) {
    var showCoutdown = $("#countdownTime");
    var sh;
    var endtimeStr = entTime.replace(/-/g, "/");
    var endTime = new Date(endtimeStr);
    var nowtime = new Date(systemTime);
    var leftsecond = parseInt((endTime.getTime() - nowtime.getTime()) / 1000);
    if(leftsecond > 0){
        sh = setInterval(function () {
            if(leftsecond <= 0){
                showCoutdown.html("剩余时间：<i>过期</i>");
                clearInterval(sh);
                window.location.reload();
            }
            fresh(showCoutdown, leftsecond);
            leftsecond -= 1;
        }, 1000);
    }
}
function fresh(showCoutdown, leftsecond) {
    var d = parseInt(leftsecond / 3600 / 24);
    var h = parseInt((leftsecond / 3600) % 24);
    var m = parseInt((leftsecond / 60) % 60);
    var s = parseInt(leftsecond % 60);
    showCoutdown.html("剩余时间<span>" + d + "</span>天<span>" + h + "</span>时<span> " + m + " </span>分<span> " + s + "</span>秒");
}
