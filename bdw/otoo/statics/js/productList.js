$(function(){
    /*最近浏览-置顶*/
    var navH = $("#topMenu").offset().top;
    var navW = $("#topMenu").offset().left;
    $(window).scroll(function(){
        //获取滚动条的滑动距离
        var scroH = $(this).scrollTop();
        //滚动条的滑动距离大于等于定位元素距离浏览器顶部的距离，就固定，反之就不固定
        if(scroH>=navH){
            $("#topMenu").css({"position":"fixed","top":0,"left":navW});
        }else if(scroH<navH){
            $("#topMenu").css({"position":"static"});
        }
    });

    //是否是代金券,免预约
    $("input[type=checkbox]").each(function(){
        $(this).click(function(){
            var subscribe = $("#otooIsAvoidSubscribe").attr("checked");
            var isCoupon = $("#otooIsCoupon").attr("checked");
            if(subscribe == "checked" && isCoupon !="checked"){
                toggleTab("otooIsAvoidSubscribe");
                return;
            }
            if(subscribe !="checked" && isCoupon == "checked"){
                toggleTab("otooIsCoupon");
                return;
            }
            if(subscribe == "checked" && isCoupon == "checked"){
                toggleTab2("otooIsAvoidSubscribe","otooIsCoupon");
                return;
            }
            if(subscribe != "checked" && isCoupon != "checked"){
                toggleTab();
                return;
            }
        });
    });

    //默认
    $("#defaultSort").click(function(){
        //是否免预约
        var subscribe = $("#otooIsAvoidSubscribe").attr("checked");
        //是否代金券
        var isCoupon = $("#otooIsCoupon").attr("checked");
        if(subscribe == "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&otooIsAvoidSubscribe=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&otooIsCoupon=Y";
            return;
        }
        if(isCoupon == "checked" && subscribe == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&otooIsAvoidSubscribe=Y"+"&otooIsCoupon=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId;
            return;
        }
    });

    //新品
    $("#newProduct").click(function(){
        //是否免预约
        var subscribe = $("#otooIsAvoidSubscribe").attr("checked");
        //是否代金券
        var isCoupon = $("#otooIsCoupon").attr("checked");
        if(subscribe == "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooLastOnSaleTime,desc"+"&otooIsAvoidSubscribe=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooLastOnSaleTime,desc"+"&otooIsCoupon=Y";
            return;
        }
        if(isCoupon == "checked" && subscribe == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooLastOnSaleTime,desc"+"&otooIsAvoidSubscribe=Y"+"&otooIsCoupon=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooLastOnSaleTime,desc";
            return;
        }
    });

    //销量
    $("#sale").click(function(){
        //是否免预约
        var subscribe = $("#otooIsAvoidSubscribe").attr("checked");
        //是否代金券
        var isCoupon = $("#otooIsCoupon").attr("checked");
        if(subscribe == "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooSalesVolume,desc"+"&otooIsAvoidSubscribe=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooSalesVolume,desc"+"&otooIsCoupon=Y";
            return;
        }
        if(isCoupon == "checked" && subscribe == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooSalesVolume,desc"+"&otooIsAvoidSubscribe=Y"+"&otooIsCoupon=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooSalesVolume,desc";
            return;
        }
    });

    $(".pre").click(function(){
        if(paramData.page==1){
            alert("当前已是第一页");
            return;
        }
        var page=parseInt(paramData.page)-1;
        /*            goToUrl(paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page+"&sort="+paramData.sort);*/
        window.location.href=webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order="+paramData.order+"&page="+page+"&sort="+paramData.sort;
    })

    $(".next").click(function(){
        if(paramData.page==paramData.totalCount){
            alert("当前已是最后一页");
            return;
        }
        var page=parseInt(paramData.page)+1;
        /*goToUrl(paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page+"&sort="+paramData.sort);*/
        window.location.href=webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order="+paramData.order+"&page="+page+"&sort="+paramData.sort;
    });

    //显示同级分类
    $(".firstCategory").hover(function(){
        $(this).addClass("title");
        $(".cr-cont").show();
    },function(e){
        $(".cr-cont").hide();
        $(".firstCategory").removeClass("title");
        $(".cr-cont").hover(function(){
            $(".firstCategory").addClass("title");
            $(".cr-cont").show();
        },function(){
            $(".firstCategory").removeClass("title");
            $(this).hide();
        });
    });

    //显示二级分类
    $(".seCategory").hover(function(){
        $(this).addClass("title");
        $(".sec-cont").show();
    },function(e){
        $(".sec-cont").hide();
        $(".seCategory").removeClass("title");
        $(".sec-cont").hover(function(){
            $(".seCategory").addClass("title");
            $(".sec-cont").show();
        },function(){
            $(".seCategory").removeClass("title");
            $(this).hide();
        });
    });


    //选中区域
    if($("#district a").hasClass("cur") && paramData.district !=null && paramData.district !=''){
        var selDistrict = $("#district a.cur").first().text();
        $(".district").html("<em>区域 : "+ selDistrict+"</em><i></i>");
        $(".dl-district").hide();

    }
    //选中商圈
    if($("#businessArea a").hasClass("cur") && paramData.areaId !=null && paramData.areaId !=''){
        var selArea = $("#businessArea a.cur").first().text();
        $(".b-area").html("<em>商圈 : "+ selArea+"</em><i></i>");
        $(".dl-area").hide();
    }
});


//清空商品的cookie
function clearHistoryProductsCookie(){
    $.get(webPath.webRoot+"/member/clearProductsCookie.json",function(data){
        window.location.reload();
    });
}

//价格排序
function changeSortByPrice(obj) {
    //是否免预约
    var subscribe = $("#otooIsAvoidSubscribe").attr("checked");
    //是否代金券
    var isCoupon = $("#otooIsCoupon").attr("checked");
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        if(subscribe == "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,desc"+"&page="+paramData.page+"&sort=down"+"&otooIsAvoidSubscribe=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,desc"+"&page="+paramData.page+"&sort=down"+"&otooIsCoupon=Y";
            return;
        }
        if(isCoupon == "checked" && subscribe == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,desc"+"&page="+paramData.page+"&sort=down"+"&otooIsAvoidSubscribe=Y"+"&otooIsCoupon=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,desc"+"&page="+paramData.page+"&sort=down";
            return;
        }

    } else {
        if(subscribe == "checked" && isCoupon != "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,asc"+"&page="+paramData.page+"&sort=up"+"&otooIsAvoidSubscribe=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,asc"+"&page="+paramData.page+"&sort=up"+"&otooIsCoupon=Y";
            return;
        }
        if(isCoupon == "checked" && subscribe == "checked"){
            window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,asc"+"&page="+paramData.page+"&sort=up"+"&otooIsAvoidSubscribe=Y"+"&otooIsCoupon=Y";
            return;
        }
        if(subscribe != "checked" && isCoupon != "checked"){
            window.location.href =webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,asc"+"&page="+paramData.page+"&sort=up";
            return;
        }
    }
}

function deleteCategory(){
    var url = $(".firstCategory").attr("href");
    if(url == undefined){
        window.location.href = webPath.webRoot + "/otoo/index.ac";
    }else{
        window.location.href = url;
    }
}

/*显示更多分类*/
function showMoreCategory(){
    $(".extraAttr").show();
    $("#hideMore").show();
    $("#showMore").hide();
}
/*隐藏更多分类*/
function hideTheCategory(){
    $(".extraAttr").hide();
    $("#hideMore").hide();
    $("#showMore").show();
}

//tab切换
function toggleTab(checkFlag){
    if(checkFlag != null && checkFlag != ''){
        $("#toggleTab a").each(function(){
            if($(this).attr("class").indexOf("-cur")>0){
                var index = $(this).index()+1;
                if(index == 1){
                    window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&"+checkFlag+"=Y";
                }
                if(index == 2){
                    window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooLastOnSaleTime,desc"+"&"+checkFlag+"=Y";
                }
                if(index == 3){
                    window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooSalesVolume,desc"+"&"+checkFlag+"=Y";
                }
                if(index == 4){
                    var sort = paramData.sort;
                    if(sort==null||sort=="up"||sort=="") {
                        window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,desc"+"&page="+paramData.page+"&sort=down"+"&"+checkFlag+"=Y";
                    }else{
                        window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,asc"+"&page="+paramData.page+"&sort=up"+"&"+checkFlag+"=Y";
                    }
                }
            }
        });
    }else{
        $("#toggleTab a").each(function(){
            if($(this).attr("class").indexOf("-cur")>0){
                var index = $(this).index()+1;
                if(index == 1){
                    window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId;
                }
                if(index == 2){
                    window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooLastOnSaleTime,desc";
                }
                if(index == 3){
                    window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooSalesVolume,desc";
                }
                if(index == 4){
                    var sort = paramData.sort;
                    if(sort==null||sort=="up"||sort=="") {
                        window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,desc"+"&page="+paramData.page+"&sort=down";
                    }else{
                        window.location.href =webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,asc"+"&page="+paramData.page+"&sort=up";
                    }
                }
            }
        });
    }
}

/*既是代金券又是免预约*/
function toggleTab2(otooIsAvoidSubscribe,otooIsCoupon){
    $("#toggleTab a").each(function(){
        if($(this).attr("class").indexOf("-cur")>0){
            var index = $(this).index()+1;
            if(index == 1){
                window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&"+otooIsAvoidSubscribe+"=Y"+"&"+otooIsCoupon+"=Y";
            }
            if(index == 2){
                window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooLastOnSaleTime,desc"+"&"+otooIsAvoidSubscribe+"=Y"+"&"+otooIsCoupon+"=Y";
            }
            if(index == 3){
                window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooSalesVolume,desc"+"&"+otooIsAvoidSubscribe+"=Y"+"&"+otooIsCoupon+"=Y";
            }
            if(index == 4){
                var sort = paramData.sort;
                if(sort==null||sort=="up"||sort=="") {
                    window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,desc"+"&page="+paramData.page+"&sort=down"+"&"+otooIsAvoidSubscribe+"=Y"+"&"+otooIsCoupon+"=Y";
                }else{
                    window.location.href = webPath.webRoot+"/otoo/productList.ac?categoryId="+paramData.categoryId+"&q="+paramData.q+"&keyword="+paramData.keyword+"&district="+paramData.district+"&areaId="+paramData.areaId+"&order=otooDiscountPrice,asc"+"&page="+paramData.page+"&sort=up"+"&"+otooIsAvoidSubscribe+"=Y"+"&"+otooIsCoupon+"=Y";
                }
            }
        }
    });
}

function showUnSelections (){
    $(".m1_rows_e").show();
    $(".m1_more").hide();
    $(".m1_coll").show();
};
function hideUnSelections (){
    $(".m1_rows_e").hide();
    $(".m1_coll").hide();
    $(".m1_more").show();
};

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





