$(function(){
    $(".cardTab").click(function(){
       if(!$(this).hasClass("cur")){
           var isBind = $(this).attr("isBind");
           window.location.href = dataValue.webRoot + "/module/member/myCard.ac?pitchOnRow=18&isBind=" + isBind;
       }
    });

    //"绑定礼品卡"按钮事件
    $("#bindCard").click(function(){
        var cardNum = $("#cardNum").val().trim();
        var cardPsw = $("#cardPsw").val().trim();
        if($.trim(cardNum)=="" || cardNum==null ){
            cardAlertDialog("请输入卡号");
            return
        }
        if($.trim(cardPsw)=="" || cardPsw==null ){
            cardAlertDialog("请输入密码");
            return
        }

        var bindDialog = jDialog.confirm('<span style="margin-left: 10px">您确定要礼品卡充值吗!</span>',{
            type : 'highlight',
            text : '确定',
            handler : function(button,bindDialog) {
                bindDialog.close();
                $.ajax({
                    url:dataValue.webRoot+'/member/bindCard.json',
                    data:({cardNum:cardNum,password:cardPsw}),
                    type:'get',
                    success:function(){
                        var callbackDialog = jDialog.alert('绑定成功!',{
                            type : 'highlight',
                            text : '确定',
                            handler : function(button,callbackDialog) {
                                callbackDialog.close();
                                window.location.reload();
                            }
                        });
                    },
                    error:function(XMLHttpRequest) {
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            cardAlertDialog(result.errorObject.errorText);
                        }
                    }
                })
            }
        },{
            type : 'normal',
            text : '取消',
            handler : function(button,bindDialog) {
                bindDialog.close();
            }
        });
    });

    //"立即绑定"按钮事件
    $(".bindNow").click(function(){
        var cardId = $(this).attr("cardId");

        var bindNowDialog = jDialog.confirm('<span style="margin-left: 10px">您确定要立即绑定礼品卡吗!</span>',{
            type : 'highlight',
            text : '确定',
            handler : function(button,bindNowDialog) {
                bindNowDialog.close();
                $.ajax({
                    url:dataValue.webRoot+'/member/bindNow.json',
                    data:({cardId:cardId}),
                    type:'get',
                    success:function(){
                        var callbackDialog = jDialog.alert('绑定成功!',{
                            type : 'highlight',
                            text : '确定',
                            handler : function(button,callbackDialog) {
                                callbackDialog.close();
                                window.location.reload();
                            }
                        });
                    },
                    error:function(XMLHttpRequest) {
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            cardAlertDialog(result.errorObject.errorText);
                        }
                    }
                })
            }
        },{
            type : 'normal',
            text : '取消',
            handler : function(button,bindNowDialog) {
                bindNowDialog.close();
            }
        });

    });
});


//最普通最常用的alert对话框，默认携带一个确认按钮
var cardAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};


