/**
 * Created by admin on 2016/8/26.
 */

$(function(){
    $("#addCard").show();
    $("#cardChange").click(function(){
        var value = $(this).attr("value");
        if(value == undefined || value == "N"){
            $(this).attr("value","Y");
            $("#addCard").show();
        }else{
            $(this).attr("value","N");
            $("#addCard").hide();
        }

    });

    $("#bindCard").click(function(){
        var cardNum=$("#cardNum");
        var cardPwd=$("#cardPwd");
        if($.trim(cardNum.val())=="" || cardNum.val()==null ){
            showError('请输入卡号!');
            $(".add_btn").css({color: '#fff'});//不可以去掉，可能是因为引入插件的原因,导致样式变成黑色了
            return;
        }
        if($.trim(cardPwd.val())=="" || cardPwd.val()==null ){
            showError('请输入密码!');
            $(".add_btn").css({color: '#fff'});
            return;
        }
        $.ajax({
            url:dataValue.webRoot+'/member/bindCard.json?time=' + new Date().getTime(),
            data:({cardNum:cardNum.val(),password:cardPwd.val()}),
            type:'get',
            success:function(data){
                cardNum.val('');
                cardPwd.val('');
                showSuccess('充值成功!');
            },
            error:function(XMLHttpRequest, textStatus) {
                cardPwd.val('');
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
            }
        })
    });

});
function cardChange(cardId){
    showConfirm("您确定要立即绑定礼品卡吗?",function() {
        $.ajax({
            url:dataValue.webRoot+'/member/bindNow.json',
            data:({cardId:cardId}),
            type:'get',
            success: function (data) {
                window.location.reload();
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    showError("服务器繁忙，请稍候再试！");
                }
            }
        });
    });
}