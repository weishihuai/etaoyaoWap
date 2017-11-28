/**
 * Created by admin on 2016/8/26.
 */
$(function(){

    $("#needInvoice").click(function(){
        var value = $(this).attr("value");
        if(value == undefined || value == "N"){
            $(this).attr("value","Y");
            $("#addCoupon").show();
        }else{
            $(this).attr("value","N");
            $("#addCoupon").hide();
        }

    });
    $("#bindCoupon").click(function(){
        var cardNum=$("#cardNum");
        var cardPwd=$("#cardPwd");
        if($.trim(cardNum.val())=="" || cardNum.val()==null ){
            xyPop.msg('请输入优惠券号!',{type:'warning',time:2});
            $(".add_btn").css({color: '#fff'});//不可以去掉，可能是因为引入插件的原因,导致样式变成黑色了
            return;
        }
        if($.trim(cardPwd.val())=="" || cardPwd.val()==null ){
            xyPop.msg('请输入优惠券密码!',{type:'warning',time:2});
            $(".add_btn").css({color: '#fff'});
            return;
        }
        $.ajax({
            url:dataValue.webRoot+'/member/bindCoupon.json?time=' + new Date().getTime(),
            data:({cardNum:cardNum.val(),password:cardPwd.val()}),
            type:'post',
            success:function(data){
                cardNum.val('');
                cardPwd.val('');
                xyPop({content:'绑定成功!',type:'success',btn:['确定'],
                    onClose:function(){
                        window.location.reload();
                    },
                    btn1:function(){
                        window.location.reload();
                    }}
                );
            },
            error:function(XMLHttpRequest, textStatus) {
                cardPwd.val('');
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        })
    });

    $(".useRuleState").click(function () {
        var couponId = $(this).attr("couponId");
        var element = "#couponId"+couponId;
        $('html,body').addClass('ovfHiden'); //使网页不可滚动
        $(element).show();
    });

    $(".closeLay").click(function () {
        var couponId = $(this).attr("couponId");
        var element = "#couponId"+couponId;
        $(element).hide();
        $('html,body').removeClass('ovfHiden'); //使网页恢复可滚
    });
});