/**
 * Created by pjx on 2017/10/24.
 */

jQuery(function($) {
    $(document).ready(function () {
        // 加载分页
        var currentPage = 1;//当前滚动到的页数

        $("#main").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".item",
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function (newElements) {
            if (currentPage > dataValue.lastPageNumber) {//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#main").infinitescroll({state: {isDone: true}, extraScrollPx: 50});
            }
            currentPage++;
        });
    });
});

function hideCollectBox(){
    var collectBox = $(".cancel-collect-box");
    collectBox.hide();
    collectBox.attr("shopInfId",null);
}


function collectEdit(){
    if($(".collect-main").hasClass("collect-bj")) {
        $(".bianyi").text("编辑");
        $(".checkbox").css("display", "none");
        $(".btn-box").css("display", "none");
        $(".cancel").css("display", "block");
        $(".collect-main").removeClass("collect-bj");
    }else {
        $(".bianyi").text("完成");
        $(".checkbox").css("display", "block");
        $(".btn-box").css("display", "block");
        $(".cancel").css("display", "none");
        $(".collect-main").addClass("collect-bj");
    }
}

function collect(shopInfId){
    if($("#shop_"+shopInfId).hasClass("checkbox-active")){
        $("#shop_"+shopInfId).removeClass("checkbox-active");
    }else {
        $("#shop_"+shopInfId).addClass("checkbox-active");
    }
}

function cancelAll(){
    var  shopInfIdStr="";
    $(".item").each(function(){
        if($(this).find(".checkbox").hasClass("checkbox-active")){
            shopInfIdStr +=$(this).find(".checkbox").attr("shopInfId")+",";
        }
    });
    if(shopInfIdStr==""){
        alert("您还未选中店铺！");
        return;
    }
    tj(shopInfIdStr);
}

function  tj(shopInfIdStr){
    $.ajax({
        type: "POST",
        async: true,
        data:{"items":shopInfIdStr},
        url:dataValue.webRoot + "/member/delUserShopCollect.json",
        success: function (data) {
            if (data.success == "true") {
                alert("取消收藏成功！");
                window.location.reload();
            }
            if (data.success == "false") {
                alert("取消收藏失败！");
                window.location.reload();
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            alert("系统错误！");
            window.location.reload();
        }
    });
}

function cancelCellect(shopInfId){
    if($(".cancel-collect-box").attr("shopInfId")==null) {
        $(".cancel-collect-box").css("display", "block");
        $(".cancel-collect-box").attr("shopInfId", shopInfId);
        $(".bianyi").css("pointer-events","none");
    }
}

function closeCancelCollect(){
    var box =$(".cancel-collect-box");
    box.css("display", "none");
    box.attr("shopInfId",null);
    $(".bianyi").css("pointer-events","auto");
}

function cancelOne(){
    var shopInfIdStr= $(".cancel-collect-box").attr("shopInfId")+",";
    tj(shopInfIdStr);
    $(".cancel-collect-box").removeAttr("shopInfId");
    $(".bianyi").attr("onclick","collectEdit()");
}

function selectAll(){
    if($(".checkboxAll").hasClass("checkboxAll-active")) {
        $(".item").each(function () {
            $(this).find("em").removeClass("checkbox-active");
        });
        $(".checkboxAll").removeClass("checkboxAll-active");
    }else {
        $(".item").each(function () {
            $(this).find("em").addClass("checkbox-active");
        });
        $(".checkboxAll").addClass("checkboxAll-active");
    }
}