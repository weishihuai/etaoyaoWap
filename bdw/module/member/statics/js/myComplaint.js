$(function(){
    $(".mc-nav a").click(function(){
        $(".mc-nav a").removeClass("cur");
        $(".cont-box").css("display","none");
        $(this).addClass("cur");
        $(".tipMsg").html("");
        $(".cont").val("");
        $(".advice" + $(this).attr("rel")).css("display","block");
    });
});


function sendComment(obj){
    var commentCont = $.trim($("#commentCont").val());
    commentCont=commentCont.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig,"");
    commentCont=commentCont.replace(/<.*?>/g,"");
    var parentCustMessageId = $(obj).attr("parentCustMessageId");
    console.log(parentCustMessageId);
    if(commentCont.length > 255 || commentCont.length < 5){
        messageAlertDialog("留言内容在5-255位字符之间！");
        return false;
    }
    if (commentCont.replace(/(^\s*)|(\s*$)/g, "")==""){
        messageAlertDialog("留言内容不能为空字符！");
        return false;
    }
    if(commentCont == "您对网站的留言?我们会及时向您反馈!"){
        return false;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",url:_toPath.webRoot + "/frontend/comment/addMessage.json",
        data:{messageCont:commentCont,parentCustMessageId:parentCustMessageId},
        dataType:"json",
        success:function(data){
            if (data.success == "true") {
                $("#commentCont").attr("value","您对网站的留言?我们会及时向您反馈!");
                showConfirmReload("您的留言已发送，我们会及时反馈!");
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                messageAlertDialog(result.errorObject.errorText);
            }
        }
    });
}


function sendSuggestComment(){
    var commentCont = $.trim($(".suggest").val());
    commentCont=commentCont.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig,"");
    commentCont=commentCont.replace(/<.*?>/g,"");
    if(commentCont.length > 255 || commentCont.length < 5){
        messageAlertDialog("建议内容在5-255位字符之间！");
        return false;
    }
    /*if (commentCont.replace(/(^\s*)|(\s*$)/g, "")==""){
        alert("建议内容不能为空字符！");
        return false;
    }*/
    if(!checkMemberNameSuggest() || !checkMemberTelSuggest()){
        messageAlertDialog("请完善提交信息！");
        return;
    }
    if(commentCont == "您对网站的建议?我们会及时向您反馈!"){
        messageAlertDialog("请输入建议内容！");
        return false;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",url:_toPath.webRoot + "/frontend/comment/addComplaintSuggest.json",
        data:{complainCont:commentCont,complainType:'建议',memberName:$(".memberNameSuggest").val(), memberTel:$(".memberTelSuggest").val()},
        dataType:"json",
        success:function(data){
            if (data.success == "true") {
                $(".commentCont").attr("value","您对网站的建议?我们会及时向您反馈!");
                showConfirmReload("您的建议已发送，我们会及时反馈!");
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            messageAlertDialog("系统错误,请重新输入!");
        }
    });
}

function sendComplainComment(){
    var commentCont = $.trim($(".complain").val());
    commentCont=commentCont.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig,"");
    commentCont=commentCont.replace(/<.*?>/g,"");
    if(commentCont.length > 255 || commentCont.length < 5){
        messageAlertDialog("投诉内容在5-255位字符之间！");
        return false;
    }
    /*if (commentCont.replace(/(^\s*)|(\s*$)/g, "")==""){
     alert("建议内容不能为空字符！");
     return false;
     }*/
    if(!checkMemberNameComplain() || !checkMemberTelComplain()){
        messageAlertDialog("请完善提交信息！");
        return;
    }
    if(commentCont == "您对网站的投诉?我们会及时向您反馈!"){
        messageAlertDialog("请输入投诉内容！");
        return false;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",url:_toPath.webRoot + "/frontend/comment/addComplaintSuggest.json",
        data:{complainCont:commentCont,complainType:'投诉',memberName: $.trim($(".memberNameComplain").val()), memberTel: $.trim($(".memberTelComplain").val())},
        dataType:"json",
        success:function(data){
            if (data.success == "true") {
                $(".commentCont").attr("value","您对网站的投诉?我们会及时向您反馈!");
                showConfirmReload("您的投诉已发送，我们会及时反馈!");
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            messageAlertDialog("系统错误,请重新输入!");
        }
    });
}

function clearMsgCont(){
    var cont = $(".commentCont");
    if(cont.val() == '您对网站的留言?我们会及时向您反馈!'){
        cont.attr("value", "");
    }
    return false;
}
function alertMessage(message,buttons){
    $("#tiptext").html(message);
    $("#tip").dialog({
        buttons:buttons
    });
    return false;
}
function checkMemberNameSuggest(){
    var memberName = $(".memberNameSuggest").val();
    if(memberName == ""){
        $(".memberNameSuggest").next().html("请输入姓名");
        return false;
    }
    /*if(memberName.replace(/(^\s*)|(\s*$)/g, "")=="")
     {
     $("#memberName").next().html("输入的名字不能为空格");
     return false;
     }*/
    $(".memberNameSuggest").next().html("");
    return true;
}
function checkMemberTelSuggest(){
    var memberTel = $(".memberTelSuggest").val();
    var regxt = /^1(3|4|5|7|8)\d{9}$/;
    /*if(memberTel == ""){
        $(".memberTelSuggest").next().html("请输入您的手机号码");
        return false;
    }
    if(!regxt.test(memberTel)){
        $(".memberTelSuggest").next().html("请输入正确的手机号码");
        return false;
    }*/
    $(".memberTelSuggest").next().html("");
    return true;
}
function checkMemberNameComplain(){
    var memberName = $(".memberNameComplain").val();
    /*if(memberName == ""){
        $(".memberNameComplain").next().html("请输入姓名");
        return false;
    }*/
    /*if(memberName.replace(/(^\s*)|(\s*$)/g, "")=="")
     {
     $("#memberName").next().html("输入的名字不能为空格");
     return false;
     }*/
    $(".memberNameComplain").next().html("");
    return true;
}
function checkMemberTelComplain(){
    var memberTel = $(".memberTelComplain").val();
    var regxt = /^1(3|4|5|7|8)\d{9}$/;
   /* if(memberTel == ""){
        $(".memberTelComplain").next().html("请输入您的手机号码");
        return false;
    }
    if(!regxt.test(memberTel)){
        $(".memberTelComplain").next().html("请输入正确的手机号码");
        return false;
    }*/
    $(".memberTelComplain").next().html("");
    return true;
}

//最普通最常用的alert对话框，默认携带一个确认按钮
var messageAlertDialog = function(dialogTxt){
    var commentAlertDialog = jDialog.alert(dialogTxt);
};

function showConfirmReload(dialogTxt){
    var adviceConfirmDialog = jDialog.alert(dialogTxt,{
        type : 'highlight',
        text : '确定',
        handler : function(button,callbackDialog) {
            callbackDialog.close();
            window.location.reload();
        }
    });
}

function addParentCustMessageId(parentCustMessageId){
    $("#publish").attr("parentCustMessageId", parentCustMessageId);
}
