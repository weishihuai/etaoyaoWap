$(document).ready(function(){

    var page = 1;
    var order="";

    ///顶部搜索按钮,点击后获取焦点，去到搜索页面
    $("#listSearchBtn").click(function () {
        var url = paramData.webRoot+"/wap/module/shop/shopSearch.ac?" +
            "shopId=" + paramData.shopId +
            "&shopCategoryId=" + paramData.shopCategoryId +
            "&q=" + paramData.q +
            "&page=" + page +
            "&order=" + order;
        setTimeout(function () {
            window.location.href =url+"&time="+new Date().getTime();
        }, 1);
    });

    //商品收藏
    $(".star").click(function(){
        var obj = $(this);
        var productId = obj.attr("productId");
        if (productId == '' || productId == undefined) {
            return;
        }
        if(obj.attr("isCollect") == 'false'){
            $.get(paramData.webRoot + "/member/collectionProduct.json?productId=" + productId, function (data) {
                if (data.success == "false") {
                    if (data.errorCode == "errors.login.noexist") {
                        window.location.href = paramData.webRoot + "/wap/login.ac";
                    }
                    if (data.errorCode == "errors.collection.has") {
                        breadDialog("您已收藏此商品","ok",1000,false);
                    }
                } else if (data.success == true) {
                    $(obj).addClass("cur");
                    obj.attr("isCollect","true");
                    breadDialog("商品收藏成功","ok",1000,false);
                }
            });
        }
        else{
            $.ajax({
                type:"POST",url:paramData.webRoot+"/member/delUserProductCollect.json",
                data:{items:productId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        breadDialog("成功取消收藏","ok",1000,false);
                        obj.removeClass("cur");
                        obj.attr("isCollect","false");
                    }else{
                        breadDialog("系统错误,请刷新重新操作","alert",1000,false);
                    }
                }
            });
        }
    });

    //按销量排序的按钮
    $("#saleOrder").click(function(){
        $(".more").css("display","block");
        //var order;
        $("#priceOrder").children().removeClass("up");
        $("#priceOrder").children().removeClass("down");
        if(!$("#saleOrder").hasClass("cur")){
            $("#saleOrder").parent().children().removeClass("cur");
            $("#saleOrder").addClass("cur");
        }
        if(!$("#saleOrder").children().hasClass("up")){
            $("#saleOrder").children().addClass("up");
            $("#saleOrder").children().removeClass("down");
            order = "salesVolume,asc";
            page = 1;
        }
        else{
            $("#saleOrder").children().addClass("down");
            $("#saleOrder").children().removeClass("up");
            order = "salesVolume,desc";
            page = 1;
        }
        var url = "/wap/module/shop/shopProducts.ac?" +
            "shopId=" + paramData.shopId +
            "&shopCategoryId=" + paramData.shopCategoryId +
            "&q=" + paramData.q +
            "&page=" + page +
            "&keyword=" + paramData.keyword +
            "&order=" + order;
        $.ajax({
            url: url,
            success: function (data) {
                $("#productUl li").remove();
                $("#productUl").append(data);
            }
        });
    });

    //按价格排序的按钮
    $("#priceOrder").click(function(){
        $(".more").css("display","block");
        //var order;
        $("#saleOrder").children().removeClass("up");
        $("#saleOrder").children().removeClass("down");
        if(!$("#priceOrder").hasClass("cur")){
            $("#priceOrder").parent().children().removeClass("cur");
            $("#priceOrder").addClass("cur");
        }
        if(!$("#priceOrder").children().hasClass("up")){
            $("#priceOrder").children().addClass("up");
            $("#priceOrder").children().removeClass("down");
            order = "minPrice,asc";
            page = 1;
        }
        else{
            $("#priceOrder").children().addClass("down");
            $("#priceOrder").children().removeClass("up");
            order = "minPrice,desc";
            page = 1;
        }
        var url = "/wap/module/shop/shopProducts.ac?" +
            "shopId=" + paramData.shopId +
            "&shopCategoryId=" + paramData.shopCategoryId +
            "&q=" + paramData.q +
            "&page=" + page +
            "&keyword=" + paramData.keyword +
            "&order=" + order;
        $.ajax({
            url: url,
            success: function (data) {
                $("#productUl li").remove();
                $("#productUl").append(data);
            }
        });
    });

    //默认排序的按钮
    $("#defaultOrder").click(function(){
        $(".more").css("display","block");
        $("#saleOrder").children().removeClass("up");
        $("#saleOrder").children().removeClass("down");
        $("#priceOrder").children().removeClass("up");
        $("#priceOrder").children().removeClass("down");
        if(!$("#defaultOrder").hasClass("cur")){
            page = 1;
            order = '';
            $("#defaultOrder").parent().children().removeClass("cur");
            $("#defaultOrder").addClass("cur");
            var url = "/wap/module/shop/shopProducts.ac?" +
                "shopId=" + paramData.shopId +
                "&shopCategoryId=" + paramData.shopCategoryId +
                "&q=" + paramData.q +
                "&page=" + page +
                "&keyword=" + paramData.keyword;
            $.ajax({
                url: url,
                success: function (data) {
                    $("#productUl li").remove();
                    $("#productUl").append(data);
                }
            });
        }
    });

    //加载更多商品按钮
    $(".more").click(function(){
        $(".more").css("display","block");
        page++;
        var url = "/wap/module/shop/shopProducts.ac?" +
            "shopId=" + paramData.shopId +
            "&shopCategoryId=" + paramData.shopCategoryId +
            "&q=" + paramData.q +
            "&keyword=" + paramData.keyword +
            "&page=" + page +
            "&order=" + order;
        $.ajax({
            url: url,
            success: function (data) {
                //如果不以"</script>"结尾说明有数据，把数据拼接
                if(!(data.trim().endWith("</script>"))){
                    $("#productUl").append(data);
                }
                //没有数据时把"查看更多商品"按钮disable，并把字改成"没有更多商品了"
                else{
                    breadDialog("没有更多商品了!","alert",1000,false);
                    $(".more").css("display","none");
                }
            }
        });
    });
});


//这里是判断某字符串是否以特定字符串结尾的函数(比如判断hello是否以lo结尾)
String.prototype.endWith=function(endStr){
    var d=this.length-endStr.length;
    return (d>=0&&this.lastIndexOf(endStr)==d)
};




