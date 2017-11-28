
jQuery(function($) {
    $(document).ready(function () {

        // 加载分页
        var readedpage = 1;//当前滚动到的页数
        $("#myCouponList").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".item",
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function (newElements) {
            if (readedpage > dataValue.lastPageNumber) {//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#myCouponList").infinitescroll({state: {isDone: true}, extraScrollPx: 50});
            }
            readedpage++
        });

        $("#bindCoupon").click(function(){
            var cardNum=$("#cardNum");
            var cardPwd=$("#cardPwd");
            if($.trim(cardNum.val())=="" || cardNum.val()==null ){
                showTips("请输入购物券编号");
                return
            }
            if($.trim(cardPwd.val())=="" || cardPwd.val()==null ){
                showTips("请输入购物券密码");
                return
            }
            $.ajax({
                url:dataValue.webRoot+'/member/bindCoupon.json?time=' + new Date().getTime(),
                data:({cardNum:cardNum.val(),password:cardPwd.val()}),
                type:'post',
                success:function(data){
                    cardNum.val('');
                    cardPwd.val('');
                    showTips("绑定成功");
                    window.location.reload();
                },
                error:function(XMLHttpRequest, textStatus) {
//                cardNum.val('');
                    cardPwd.val('');
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        //var error = eval("(" + result + ")");
                        showTips(result.errorObject.errorText);

                    }
                }
            })
        });


    });


});

function cancelForm() {
    $('#cancelForm').css("display", "none");
    $("#cardNum").val('');
    $("#cardPwd").val('');
}
function showForm() {

    $('#cancelForm').css("display","block");
}

/**
 * 提示对话框
 * @param tips 对话框显示的内容
 */
function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 1000);
}