$(function(){
    $("#pageUp").click(function(){
        if(paramData.page==1){
            breadJDialog("当前已是第一页",1000,"30px",true);
            return;
        }
        var page=parseInt(paramData.page)-1;
        window.location.href=paramData.webRoot+"/citySend/storeList.ac?lat="+paramData.lat+"&lng="+paramData.lng+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page+"&sort="+paramData.sort;
    });

    $("#pageDown").click(function(){
        if(paramData.page==paramData.totalCount){
            breadJDialog("当前已是最后一页",1000,"30px",true);
            return;
        }
        var page=parseInt(paramData.page)+1;
        window.location.href=paramData.webRoot+"/citySend/storeList.ac?lat="+paramData.lat+"&lng="+paramData.lng+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page+"&sort="+paramData.sort;
    });

    //搜索门店
    $("#searchShopBtn").click(function(){
        var searchTxt = $.trim($("#shopKeyWord").val());
        //if(undefined == searchTxt || null == searchTxt || "" == searchTxt) {
        //    breadJDialog("请输入搜索内容",2000,"30px",true);
        //    return;
        //}
        if($("#search").hasClass("sShop")){
            //搜索门店
            window.location.href=paramData.webRoot+"/citySend/storeList.ac?lat="+paramData.lat+"&lng="+paramData.lng+"&keyword="+searchTxt+"&page=1";
        }else{
            //搜索商品
            window.location.href=paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&lng="+paramData.lng+"&orgIds="+paramData.orgIds+"&keyword="+ searchTxt+"&categoryId=1";
        }
    });

    $("#searchShop").click(function(){
        $("#search").removeClass("sProduct");
        $("#search").addClass("sShop");
        $("#search").text("搜门店");
    });

    $("#searchProduct").click(function(){
        $("#search").removeClass("sShop");
        $("#search").addClass("sProduct");
        $("#search").text("搜商品");
    });
});


//没有标题和按钮的提示框
function breadJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}

function checkShopIsSupport(obj){
    var isSupport = $(obj).attr("isSupport");
    var shopName = $(obj).attr("shopName");
    var orgId = $(obj).attr("orgId");
    var distinct = $(obj).attr("distinct");
    if(isSupport == 'N'){
        breadJDialog(shopName+"  暂不支持购买",1000,"10px",true);
        return false;
    }
    window.location.href = paramData.webRoot + "/citySend/storeDetail.ac?orgId=" + orgId + "&distinct="+distinct;
}
