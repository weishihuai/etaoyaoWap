$(function () {
    $("#pageUp").click(function(){
        if(paramData.page==1){
            breadJDialog("当前已是第一页",1000,"10px",true);
            return;
        }
        var page=parseInt(paramData.page)-1;
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&page="+paramData.page+"&sort="+paramData.sort;
    });

    $("#pageDown").click(function(){
        if(paramData.page==paramData.totalCount){
            breadJDialog("当前已是最后一页",1000,"10px",true);
            return;
        }
        var page=parseInt(paramData.page)+1;
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&page="+paramData.page+"&sort="+paramData.sort;
    });

    //搜索
    $("#searchProductBtn").click(function(){
        var searchTxt = $.trim($("#productKeyWord").val());
        if($("#search").hasClass("sShop")){
            //搜索门店
            window.location.href=paramData.webRoot+"/citySend/storeList.ac?lat="+paramData.lat+"&lng="+paramData.lng+"&keyword="+searchTxt+"&page=1";
        }else{
            //搜索商品
            window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId=1&keyword="+searchTxt+"&page=1";
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


    //收藏商品与取消商品收藏
    $(".AddTomyLikeBtn").click(function(){
        var obj = $(this);
        var isCollect = $(obj).attr("value");
        var productId =$(obj).attr("productId");
        if(productId == '' || productId == undefined){
            return ;
        }
        //判断当前用户是否收藏该商品
        if(isCollect == "true"){
            $.ajax({
                type:"POST",url:paramData.webRoot+"/member/delUserProductCollect.json",
                data:{items:productId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        breadJDialog("取消收藏成功!",1300,"10px",true);
                        $(obj).removeClass("selected");
                        $(obj).attr("value","false");
                        $(obj).html("收藏");
                    }else{
                        breadJDialog("系统错误,请刷新重新操作!",1300,"10px",true);
                    }
                }
            });
        }else{
            $.get(paramData.webRoot+"/member/collectionProduct.json?productId="+productId,function(data){
                if(data.success == "false"){
                    if(data.errorCode == "errors.login.noexist"){

                    }
                    if(data.errorCode == "errors.collection.has"){
                        $(obj).addClass("selected");
                        $(obj).attr("value","true");
                    }
                }else if(data.success == true){
                    $(obj).addClass("selected");
                    breadJDialog("商品收藏成功!",1300,"10px",true);
                    $(obj).attr("value","true");
                    $(obj).html("取消");
                }
            });
        }
    });


    /*单规格商品加入购物车 start*/
    $(".addCartBtn").click(function () {
        var addbtn = $(this);
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        if(skuId==""){
            breadJDialog("请选择商品规格",1300,"10px",true);
            return;
        }
        if(num==""){
            breadJDialog("请填写购买数量",1300,"10px",true);
            return;
        }
        $.ajax({
            url: paramData.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    breadJDialog("加入购物车成功", 1300, "20px", true);
                    loadHideCart();
                } else {
                    showLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadJDialog(result.errorObject.errorText,2000,"20px",true);
                }
            }
        });

    });
    /*加入购物车 end*/
});


function chageSortBySalesVolumn(obj) {
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&page="+paramData.page+"&sort=down&order=salesVolume,desc";
    } else {
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&page="+paramData.page+"&sort=up&order=salesVolume,asc";
    }
}

function chageSortBySalesVolumn2(obj) {
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&page="+paramData.page+"&sort=down&order=salesVolume,desc";
    } else {
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&page="+paramData.page+"&sort=up&order=salesVolume,asc";
    }
}


function chageSortByPrice(obj) {
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&page="+paramData.page+"&sort=down&order=minPrice,desc";
    } else {
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&page="+paramData.page+"&sort=up&order=minPrice,asc";
    }
}

function chageSortByPrice2(obj) {
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&page="+paramData.page+"&sort=down&order=minPrice,desc";
    } else {
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId="+paramData.categoryId+"&q="+paramData.q+"&page="+paramData.page+"&sort=up&order=minPrice,asc";
    }
}

function deleteCategory(index){
    var url = $(".firstCategory"+(index-1)).attr("href");
    if(url == undefined){
        window.location.href = paramData.webRoot+"/citySend/productList.ac?lat="+paramData.lat+"&orgIds="+paramData.orgIds+"&lng="+paramData.lng+"&categoryId=1";
    }else{
        window.location.href = url;
    }
}

/*显示更多分类*/
function showMoreCategory(){
    $(".extraAttr").show();
    $("#packUpCategory").show();
    $("#showMoreCategory").hide();
}
/*隐藏更多分类*/
function hideTheCategory(){
    $(".extraAttr").hide();
    $("#packUpCategory").hide();
    $("#showMoreCategory").show();
}

//没有标题和按钮的提示框
function breadJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal,         // 非模态，即不显示遮罩层
        autoMiddle:true
    });
    return dialog;
}

function showMoreAttrs(index){
    $(".rows"+index+" .extraAttr").show();//中间的空格必须
    $(".row_m"+index).hide();
    $(".row_h"+index).show();
}

function hideTheAttr(index){
    $(".rows"+index+" .extraAttr").hide();
    $(".row_h"+index).hide();
    $(".row_m"+index).show();
}

//登录提示框
function showLoginLayer(){
    var dialog = jDialog.confirm('<span style="margin-left: 10px">您还没有登录!</span>',{
        type : 'highlight',
        text : '登录',
        handler : function(button,dialog) {
            dialog.close();
            window.location.href = paramData.webRoot + "/login.ac";
        }
    },{
        type : 'normal',
        text : '取消',
        handler : function(button,dialog) {
            dialog.close();
        }
    });
    return dialog;
}

function loadHideCart(){
    $("#oldCart").load(paramData.webRoot+"/template/bdw/citySend/ajaxload/mainCartLoad.jsp",{carttype:"store",p:Top_Path.topParam},function(){
        $("#cartLayer").css("right", "0px");
        $("#allStoreCart").css("display","none");
        $("#cartContent").css("right","-1260px");
    });
}
