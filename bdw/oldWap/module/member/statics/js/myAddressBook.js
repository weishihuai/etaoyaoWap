$(function(){
    $(".default").click(function(){
        if($(this).hasClass("cur")){
            return;
        }
        var receiveAddrId = $(this).attr("receiveAddrId");
        //var obj = $(this);
        $.ajax({
            type:"get",
            url:dataValue.webRoot+"/member/setDefaultReceiveAddr.json?receiveAddrId=" + receiveAddrId ,
            success:function() {
                //只有success才改变样式
                //$(".default").removeClass("cur");
                //obj.addClass("cur");
                window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac?time='+(new Date()).getTime();
                //window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac';
            },
            error:function() {
                xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
            }
        });
    });

    $(".del").click(function(){
        var receiveAddrId = $(this).attr("receiveAddrId");
        xyPop({
            id: "pop_msg",
            title: "删除地址",
            content: "你确定要删除此收货地址吗！",
            type: "confirm",
            padding: 15,
            btn: ["取消","确定"],
            btn1: function(){
            },
            btn2: function(){
                $.ajax({
                    type:"post" ,
                    url:dataValue.webRoot+"/member/deleteUserAddress.json?id=" + receiveAddrId ,
                    success:function() {
                        xyPop({content:'删除成功!',type:'success',btn:['确定'],
                            onClose:function(){
                                window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac?time='+(new Date()).getTime();
                            },
                            btn1:function(){
                                window.location.href = dataValue.webRoot+'/wap/module/member/myAddressBook.ac?time='+(new Date()).getTime();
                            }}
                        );
                    },
                    error:function() {
                        xyPop({content:'系统繁忙，请稍后重试!',type:'error'});
                    }
                });
            },
            fixed: true
        });
    });
});



