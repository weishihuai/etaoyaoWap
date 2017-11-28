(function($){
    $.fn.pay=function(settings){
        var defaultSettings={
            payButtonId:"payButtonId",
            formId:"formId"
        };
        settings = $.extend(true,defaultSettings,settings);
        $("#"+settings.payButtonId).bind("click",function(){
            //提交支付表单
            setTimeout(function(){
                $("#"+settings.formId).submit();
            },0);

            return showDialog("请支付成功后才关闭窗口！",{
                "支付完成":function(){
                    window.location.href=webPath.webRoot+'/module/member/index.ac';
                },
                "支付失败":function(){
                    window.location.reload();
                }
            })
        });

        function showDialog(text,buttons){
            $("#tiptext").html(text);
            $("#tip").dialog({
                modal:true,
                buttons:buttons
            });

        }
    };
    $(document).ready(function(){
        $("body").append('<div style="display:none;" id="tip" class="box" title="系统提示" > <div align="center" id="tiptext" style="font-size: 14px;font-weight: bold;padding: 15px"></div> </div>');
    })
})(jQuery);