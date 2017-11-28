//领券
function receiveCoupon(ruleLinke,obj) {

    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url: webPath.webRoot+"/member/getCoupon.json",
        data:{
            ruleLinke: ruleLinke
        },
        dataType: "json",
        success: function(data) {
            if (data.success == true) {
                showTips("领取成功!");
                $(obj).html("立即使用");
                $(obj).removeClass("btn1") ;
                $(obj).addClass("btn2");
                $(obj).attr('onclick',"window.location.href='/wap/productList.ac'");

            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showTips(result.errorObject.errorText);
                return;
            }
        }
    });
}


jQuery(function($) {
    $(document).ready(function () {
            var _this = this;
        // 加载分页
        var readedpage = 1;//当前滚动到的页数
        $("#couponList").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".item",
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function (newElements) {
            if (readedpage > webPath.lastPageNumber) {//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#couponList").infinitescroll({state: {isDone: true}, extraScrollPx: 50});
            }
            readedpage++;

        });
    });

});

/**
 * 提示对话框
 * @param tips 对话框显示的内容
 */
function showTips(tips) {
    $("#tipSpan").text(tips);
    $("#tipDiv").show();
    setTimeout(function () {
        $("#tipDiv").hide();
    }, 1000);
}