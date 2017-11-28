
$(document).ready(function() {
    $("#selectCategroy").click(function(){
        $("#modalCateFilter").removeClass("modal");
    });
    $("#selectCategroy1").click(function(){
        $("#modalCateFilter").removeClass("modal");
    });
    $(".search").click(function(){
        var keyword = $(this).attr("keyword");
        window.location.href = webPath.webRoot + "/wap/module/member/cps/searchPromotionProducts.ac?keyword=" + keyword;
    });
    $(".modal-dropback").click(function(){
        $("#modalCateFilter").addClass("modal");
        $("#searchFilter").addClass("modal");
    });
    $(".categroyUl li").click(function(){
        $(".categroyUl li").removeClass("active");
        $(this).addClass("active");
        $("#sureCategroy").attr("categoryId",$(this).attr("categoryId"));
    });
    $("#sureCategroy").click(function(){
        var categoryId = $(this).attr("categoryId");
        window.location.href = webPath.webRoot + "/wap/module/member/cps/cpsAllPromotionProducts.ac?categoryId=" + categoryId;
        $("#modalCateFilter").addClass("modal");
    });

    //分页
    var readedpage = 1;//当前滚动到的页数
    var lastPageNumber = webPath.lastPageNumber;
    $("#main").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".good-list" ,
        animate: true,
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50
    }, function(newElements) {
        readedpage++;
        if(readedpage > webPath.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
            $("#page-nav").remove();
            $("#main").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }
    });
    $(".cpsShare").click(function(){
        var $shareId = $(this).attr("shareId");
        $("#loadDiv").load(webPath.webRoot + "/wap/module/member/cps/cpsWapExtension.ac?shareId="+$shareId);
    });

    $(document).scroll(function(){
        var tabTop = $("#normalDiv").offset().top;
        var scro = $(document).scrollTop();
        if(scro > tabTop){
            $('#fixedDiv').show();
        }else{
            $('#fixedDiv').hide();
        }
    });
});

function goThisHref(href){
    window.location.href = href;
}