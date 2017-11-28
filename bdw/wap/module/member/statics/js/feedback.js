$(function () {
    //选择反馈类型
   $(".fill-main .fill-type").find("a").click(function () {
        $(this).addClass("selected").siblings().removeClass("selected");
   });
});

/**
 * 改变反馈内容
 */
function changeFeedbackCont() {
    var feedback = $("#feedbackCont");
    var feedbackLen = $("#feedbackContLength");
    var feedbackCont = $.trim(feedback.val());
    var confirmBtn = $("#confirmBtn");
    if (feedbackCont.length > 255) {
        feedback.val(feedbackCont.substring(0,255));
        feedbackLen.text("255/255");
    } else {
        feedback.val(feedbackCont);
        feedbackLen.text(feedbackCont.length+"/255");
    }
    if (undefined === feedbackCont || null === feedbackCont || "" === feedbackCont || feedbackCont.length === 0) {
        confirmBtn.addClass("disable");
    } else {
        confirmBtn.removeClass("disable");
    }
}

/**
 * 提交反馈内容
 */
function submitFeedback() {
    var confirmBtn = $("#confirmBtn");
    var errorMsg = $("#errorMsg");

    if(confirmBtn.attr("class") === "disable"){
        return;
    } else {
        confirmBtn.addClass("disable");
    }

    var feedbackCont = $.trim($("#feedbackCont").val());
    if (undefined === feedbackCont || null === feedbackCont || "" === feedbackCont || feedbackCont.length === 0) {
        errorMsg.text("描述不能为空").show();
        confirmBtn.removeClass("disable");
        setTimeout(function () {
            errorMsg.hide();
        },1000);
        return;
    }

    if (feedbackCont.length >255) {
        errorMsg.text("描述字符请在255字内").show();
        confirmBtn.removeClass("disable");
        setTimeout(function () {
            errorMsg.hide();
        }, 1000);
        return;
    }

    //获取选中的反馈类型
    var complainType = '建议';
    $(".fill-main .fill-type").find("a").each(function () {
        if ($(this).hasClass("selected")) {
            complainType = $(this).text();
        }
    });

    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:webPath.webRoot + "/frontend/comment/addComplaintSuggest.json",
        data:{complainCont:feedbackCont,complainType:complainType},
        dataType:"json",
        async: false,
        success:function(data){
            if(data.success === "false"){
                errorMsg.text("反馈失败").show();
                confirmBtn.removeClass("disable");
                setTimeout(function () {
                    errorMsg.hide();
                }, 1000);
            }else if(data.success === "true"){
                window.location.href = webPath.webRoot + '/wap/module/member/feedbackList.ac';
            }
        },
        error:function(data){
            errorMsg.text("反馈失败").show();
            confirmBtn.removeClass("disable");
            setTimeout(function () {
                errorMsg.hide();
            }, 1000);
        }
    });
}
