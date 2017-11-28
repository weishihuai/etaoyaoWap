

jQuery(function($) {
    $(document).ready(function () {
        // 加载分页
        var currentPage = 1;//当前滚动到的页数
        $("#intergal-list").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".dd-item" , //选择的是你要加载的那一个块（每次载入的数据放的地方）
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function(newElements) {
            currentPage++;

            if(currentPage > dataValue.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("<a class='show-more' href='javascript:;'>仅显示最近半年积分记录</a>").appendTo("#main");
            }else{
                $(".show-more").remove();

                if(currentPage > 1){
                    if($(".show-more").length < 1){
                        $("<a class='show-more' href='javascript:;'>仅显示最近半年积分记录</a>").appendTo("#main");
                    }
                }

            }
        });
    });
});