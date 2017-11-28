/*
$(document).ready(function(){
    /!**
     * 团购分类选择时样式控制
     *!/
    $(".group").find("a").removeClass("cur");
    $("#"+pageData.categoryId).addClass("cur");

    /!**
     * 团购Tab选择样式控制
     * @param obj
     * @param paramVal
     *!/
    $(".tab").removeClass("cur");
    if(pageData.tSelect=='process'){
        $(".process").show();
        $(".already").hide();
        $(".now").find("a").addClass("cur");
    } else{
        $(".process").hide();
        $(".already").show();
        $(".ready").find("a").addClass("cur");
    }

    $("#more").click(function(){
        $(".node").css("display","");
        $("#more").css("display","none");
        $("#hide").css("display","");
    });
    $("#hide").click(function(){
        $(".node").css("display","none");
        $("#more").css("display","");
        $("#hide").css("display","none");
    })
});
*/

$(document).ready(function(){
    $("img").lazyload({
        effect: "fadeIn",
        threshold: 300,
        failurelimit : 10
    });

    <!--焦点图-->
    TabLT(1,"z",$("#focus-cont"),$("#focus-cont li"),2,$("#focus-prev"),$("#focus-next"),1,$("#focus-slider"),"a",0,"","",1,"",300,1,2500);

    $(".sort").click(function(){
        $(".allsort").remove("cur");
        $(".sort").remove("cur");
        $(this).addClass("cur");
    });

    $(".more").click(function(){
        if($(this).text()=="更多"){
            $("#all").css("height","auto");
            $(".more").removeClass("up");
            $(".more").addClass("down");
            $(".more").html("收起");
        }else{
            $("#all").css("height","47px");
            $(".more").removeClass("down");
            $(".more").addClass("up");
            $(".more").html("更多");
        }
    });

});