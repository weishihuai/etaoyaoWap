/**
 * Created by lhw on 2016/12/29.
 */
jQuery(function($) {
    $(document).ready( function() {
        // 滚动搜索栏固定
        var divOffsetTop = $(".search-box").offset().top;
        $(window).scroll(function(){
            var scrollTop = $(this).scrollTop();
            if(scrollTop > divOffsetTop){
                $("#searchTxt").css("background-color", "#efefef");
                $(".search-box").attr("style", "position:fixed;top:0;width:100%;padding-right: 6.8rem;z-index:10;");
            }else{
                $("#searchTxt").css("background-color", "white");
                $(".search-box").attr("style", "padding-right: 6.8rem;");
            }
        });
        // 清除搜索内容
        $(".clear").click(function(){
            $("#searchTxt").val("");
        });
        // 搜索
        $("#searchBtn").click(function(){
            var searchTxt = $.trim($("#searchTxt").val());
            if (isEmpty(searchTxt)) {
                showError("请输入商品名或店铺名");
                return;
            }
            $("#searchForm").submit();
        });
        // 加载分页
        var readedpage = 1;//当前滚动到的页数
        $("#mainList").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".search-list" ,
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function(newElements) {
            if(readedpage > dataValue.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#mainList").infinitescroll({state:{isDone:true},extraScrollPx: 50});
            }
            readedpage++;
        });
    });
});

// 跳转到店铺
function gotoStore(obj){
    var orgId = $(obj).attr("orgId");
    var isSupportBuy = $(obj).attr("isSupportBuy");
    if (isEmpty(orgId)) {
        return;
    }
    if (isEmpty(isSupportBuy) || 'Y' != isSupportBuy) {
        showError("该店铺不支持购买");
        return;
    }
    window.location.href = dataValue.webRoot + "/wap/citySend/storeIndex.ac?orgId=" + orgId;
}

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}