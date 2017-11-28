$(document).ready(function(){
    $("#search_btn").click(function(){
        var page = 1;
        var order = "";
        Top_Path.keyword = $.trim($("#put").val());
        var url = Top_Path.webRoot+"/wap/module/shop/index.ac?" +
            "shopId=" + Top_Path.shopId +
            "&shopCategoryId=" + Top_Path.shopCategoryId +
            "&q=" + Top_Path.q +
            "&page=" + page +
            "&keyword=" + Top_Path.keyword+
            "&order=" + order;
        window.location.href =url+"&time="+new Date().getTime();
    });


});
