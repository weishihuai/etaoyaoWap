$(function(){
    if(myValue.is=='Y') {
        $('.coupontab').removeClass('cur');
        $('#usedTab').addClass('cur');
    }else{
        if(myValue.is=='N') {
            $('.coupontab').removeClass('cur');
            $('#unUseTab').addClass('cur');
        }else {
            $('.coupontab').removeClass('cur');
            $('#canceledTab').addClass('cur');
        }
    }
    $("#bindCoupon").click(function(){
        var cardNum=$("#cardNum");
        var cardPwd=$("#cardPwd");
        if($.trim(cardNum.val())=="" || cardNum.val()==null ){
            couponAlertDialog("请输入购物券编号");
            return
        }
        if($.trim(cardPwd.val())=="" || cardPwd.val()==null ){
            couponAlertDialog("请输入购物券密码");
            return
        }
        $.ajax({
            url:dataValue.webRoot+'/member/bindCoupon.json?time=' + new Date().getTime(),
            data:({cardNum:cardNum.val(),password:cardPwd.val()}),
            type:'post',
            success:function(data){
                cardNum.val('');
                cardPwd.val('');
                var callbackDialog = jDialog.alert('绑定成功!',{
                    type : 'highlight',
                    text : '确定',
                    handler : function(button,callbackDialog) {
                        callbackDialog.close();
                        window.location.reload();
                    }
                });
            },
            error:function(XMLHttpRequest, textStatus) {
//                cardNum.val('');
                cardPwd.val('');
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //var error = eval("(" + result + ")");
                    couponAlertDialog(result.errorObject.errorText);

                }
            }
        })
    });
    $('.used').hide();
    $('.canceled').hide();
    $('.unUse').show();
    $('#unUseTab').click(function(){
        $('.coupontab').removeClass('cur');
        $('#unUseTab').addClass('cur');
        location.href=dataValue.webRoot+'/template/bdw/module/member/myCoupon.jsp?is=N';

    });
    $('#usedTab').click(function(){
        $('.coupontab').removeClass('cur');
        $('#usedTab').addClass('cur');
        location.href=dataValue.webRoot+'/template/bdw/module/member/myCoupon.jsp?is=Y';
    });
    $('#canceledTab').click(function(){
        $('.coupontab').removeClass('cur');
        $('#canceledTab').addClass('cur');
        location.href=dataValue.webRoot+'/template/bdw/module/member/myCoupon.jsp?is=null';
    });

    //查看券使用规则说明
    $(".thead-tbl-coupon").mouseover( function() {
        $(this).removeClass("coupon-out");
        $(this).addClass("coupon-hover");
        $(this).find(".useRuleState").removeClass('defaultBtn');
        $(this).find(".useRuleState").addClass('hoverBtn');

    }).mouseout( function(){
        $(this).removeClass("coupon-hover");
        $(this).addClass("coupon-out");
        $(this).find(".useRuleState").removeClass('hoverBtn');
        $(this).find(".useRuleState").addClass('defaultBtn');

    });

    $(".useRuleState").click(function () {
        var num = $(this).attr("num");
        var ruleNum = "#rule"+num;
        $.layer({
            type: 1,
            shade: [0.3, '#555'],
            area: ['auto', 'auto'],
            title: "购物券使用说明",
            border: [5, 0.3, '#000'],
            closeBtn: [0, true],
            shadeClose: true,
            fadeIn: 200,
            page: {dom : ruleNum}
        });
    });
});



//最普通最常用的alert对话框，默认携带一个确认按钮
var couponAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};


