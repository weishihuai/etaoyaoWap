$(document).ready(function(){
        $('.control-next').click(function () {
            $(".cont-box ul").animate({marginLeft:"-240px"},600, function () {
                $(".cont-box ul>li").eq(0).appendTo($(".cont-box ul"));
                $(".cont-box ul").css('marginLeft','0px');
            });
        })

        $('.control-prev').click(function () {
            $(".cont-box ul").css('marginLeft','-240px');
            $(".cont-box ul>li").eq(3).prependTo($(".cont-box ul"));
            $(".cont-box ul").animate({marginLeft:"0px"},600);
        })

});

/*显示/隐藏更多筛选*/
function showMoreCategory(){
    if($("#showMore").html() == '更多筛选'){
        $("#product").show();
        $("#type").show();
        $("#time").show();
        $("#zone").show();
        $("#showMore").html("收起筛选");
    }else if($("#showMore").html() == '收起筛选'){
        $("#product").hide();
        $("#type").hide();
        $("#time").hide();
        $("#zone").hide();
        $("#showMore").html("更多筛选");
    }
}

/*显示/隐藏更多招商类型*/
function showMoreType(){
    if($("#showMuch").html() == '更多'){
        $("#more").show();
        $("#few").hide();
        $("#showMuch").html("收起");
    }else if($("#showMuch").html() == '收起'){
        $("#more").hide();
        $("#few").show();
        $("#showMuch").html("更多");
    }
}

/*显示/隐藏更多招商区域*/
function showMoreZone(){
    if($("#showMoreZone").html() == '更多'){
        $("#zoneMore").show();
        $("#zoneFew").hide();
        $("#showMoreZone").html("收起");
    }else if($("#showMoreZone").html() == '收起'){
        $("#zoneMore").hide();
        $("#zoneFew").show();
        $("#showMoreZone").html("更多");
    }
}

function AutoScroll(){
    $(".cont-box ul").animate({marginLeft:"-240px"},600, function () {
        $(".cont-box ul>li").eq(0).appendTo($(".cont-box ul"));
        $(".cont-box ul").css('marginLeft','0px');
    });
}
$(function(){
    setInterval(AutoScroll,5000);
});







