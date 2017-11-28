$(document).ready(function(){
    $("#search_btn").click(function(){
        var searchValue = $.trim($("#put").val());
        if(undefined != searchValue && null != searchValue && "" != searchValue){
            window.location.href = Top_Path.webRoot+"/wap/shop/shopProductList.ac?keyword="+searchValue+"&category=1"+"&shopId="+Top_Path.shopId;
        } else {
            window.location.href = Top_Path.webRoot+"/wap/shop/shopProductList.ac?category=1&shopId="+Top_Path.shopId;
        }
    });
});