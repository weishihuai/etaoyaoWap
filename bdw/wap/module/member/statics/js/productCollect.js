/**
 * Created by pjx on 2017/10/23.
 */

jQuery(function($) {
    $(document).ready(function () {
        // 加载分页
        var currentPage = 1;//当前滚动到的页数
        $("#main").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".item" , //选择的是你要加载的那一个块（每次载入的数据放的地方）
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function(newElements) {
            if(currentPage > dataValue.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#main").infinitescroll({state:{isDone:true},extraScrollPx: 50});
            }
            currentPage++;
        });
    });
});

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

function collect(productId){
  if($("#product_"+productId).hasClass("checkbox-active")){
      $("#product_"+productId).removeClass("checkbox-active");
  }else {
      $("#product_"+productId).addClass("checkbox-active");
  }
}

function cancelAll(){
    var  productIdStr="";
    $(".item").each(function(){
       if($(this).find("em").hasClass("checkbox-active")){
           productIdStr +=$(this).find("em").attr("productId")+",";
       }
    });
    if(productIdStr==""){
        alert("您还未选中取消收藏商品！");
        return;
    }
    tj(productIdStr);
}


function closeCancelCollect(){
    var box =$(".cancel-collect-box");
    box.css("display", "none");
    box.attr("productId",null);
    $(".bianyi").css("pointer-events","auto");
}

function  tj(productIdStr){
    $.ajax({
        type: "POST",
        async: true,
        data:{"items":productIdStr},
        url:dataValue.webRoot + "/member/delUserProductCollect.json",
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

function cancelCellect(productId){
    if($(".cancel-collect-box").attr("productId")==null) {
        $(".cancel-collect-box").css("display", "block");
        $(".cancel-collect-box").attr("productId", productId);
        $(".bianyi").css("pointer-events","none");
    }
}

function cancelOne(){
    var productIdStr= $(".cancel-collect-box").attr("productId")+",";
    tj(productIdStr);
    $(".cancel-collect-box").removeAttr("productId");
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