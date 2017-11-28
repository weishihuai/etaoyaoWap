(function($){
    $(document).ready(function(){
        /*左边菜单栏 效果展示 start*/
        $(".showList").find("li").hover(function(){
            $(this).addClass("hover");
        },function(){
            $(this).removeClass("hover");
        })
        checkPage();
        $("#pageUp").click(function(){
            checkPage();
            if(paramData.page==1){
                alert("当前已是第一页");
                return;
            }
            var page=parseInt(paramData.page)-1;
            goToUrl(paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page);
//            window.location.href=paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page;
        })

        $("#pageDown").click(function(){
            checkPage();
            if(paramData.page==paramData.totalCount){
                alert("当前已是最后一页");
                return;
            }
            var page=parseInt(paramData.page)+1;
            goToUrl(paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page);
//            window.location.href=paramData.webRoot+"/productlist.ac?category="+paramData.category+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+page
        })

        $("#hotTopPro li").hover(function(){
            $("#hotTopPro li .detaiF").hide();
            $("#hotTopPro li .tit").show();
            $(this).find(".tit").hide();
            $(this).find(".detaiF").show();
        });
        $("#hotTopPro1 li").hover(function(){
            $("#hotTopPro1 li .detaiF").hide();
            $("#hotTopPro1 li .tit").show();
            $(this).find(".tit").hide();
            $(this).find(".detaiF").show();
        });
    });

    var hideHotTopProItem = function(){
        $("#hotTopPro .item").each(function(){
            $(this).children("h5").show();
            $(this).children(".info").hide();
        });
    };
    function checkPage(){
        if(paramData.page==paramData.totalCount||paramData.page+1==paramData.totalCount){
            $("#pageDown").find("img").attr("src",paramData.webRoot+"/template/bdw/statics/images/list_turnP_inB01.gif");
        }else{
            $("#pageDown").find("img").attr("src",paramData.webRoot+"/template/bdw/statics/images/list_turnP_inB02.gif");
        }
        if(paramData.page==1){
            $("#pageUp").find("img").attr("src",paramData.webRoot+"/template/bdw/statics/images/list_turnP_inF01.gif");
        }else{
            $("#pageUp").find("img").attr("src",paramData.webRoot+"/template/bdw/statics/images/list_turnP_inF02.gif");
        }
    }
})(jQuery);

//清空商品的cookie
var clearHistoryProductsCookie = function(){
    $.get(paramData.webRoot+"/member/clearProductsCookie.json",function(data){
        window.location.reload();
    });
};
var showUnSelections = function(){
    $(".unSelections").show();
    $("#showUnSelections").hide();
    $("#hideUnSelections").show();
};
var hideUnSelections = function(){
    $(".unSelections:gt(3)").hide();
    $("#hideUnSelections").hide();
    $("#showUnSelections").show();
};

//收藏商品
function AddTomyLikeBtn(productId){
    if(productId == '' || productId == undefined){
        return ;
    }
    $.get(paramData.webRoot+"/member/collectionProduct.json?productId="+productId,function(data){
        if(data.success == false){
            if(data.errorCode == "errors.login.noexist"){
                if(confirm("您尚未登陆，请登陆!")){
                    goToUrl(paramData.webRoot+"/login.ac");
                }
                return;
            }
            if(data.errorCode == "errors.collection.has"){
                alert("您已经收藏了此商品！");
                return;
            }
        }else if(data.success == true){
            var collectCount;
            if(paramData.productCollectCount == '' || paramData.productCollectCount == undefined){
                collectCount = 1
            }else{
                collectCount = parseInt(paramData.productCollectCount)+1
            }
            $("#productCollectCount").html(collectCount);
            alert("商品已成功收藏！");
            return;
        }
    });
}

function closeOrOpen(obj){
    var rel=$(obj).find("img").attr("rel");
    if(rel=="N"){
        $(obj).find("img").attr("src",paramData.webRoot+"/template/bdw/statics/images/list_eIco.gif");
        $(obj).parent().next().hide();
        $(obj).find("img").attr("rel","Y");
    }else{
        $(obj).find("img").attr("src",paramData.webRoot+"/template/bdw/statics/images/list_mIco.gif");
        $(obj).parent().next().show();
        $(obj).find("img").attr("rel","N");
    }
}
