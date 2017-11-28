$(document).ready(function(){
    ///顶部搜索按钮,点击后获取焦点，去到搜索页面
    $("#search_btn").click(function () {
        var searchFields=document.getElementById("put");
        if(searchFields.value==null || searchFields.value==""||searchFields.value=="内置关键字搜索"){
            $("#alert").removeClass("sr-only");
            $("#alert").text("请输入搜索关键字!");
            return false;
        }
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
        setTimeout(function () {
            window.location.href =url+"&time="+new Date().getTime();
        }, 1);
    });

    $("body").bind('keyup',function(event) {
        if(event.keyCode==13){
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
            setTimeout(function () {
                window.location.href =url+"&time="+new Date().getTime();
            }, 1);
        };
    });
});