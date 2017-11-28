
$(function(){
    //快速导航
    $("#navBtn").click(function () {
        var display = $($(".nav-block")[0]).css('display');
        if(display=='none'){
            $(".nav-block").fadeIn(200);
        }else{
            $(".nav-block").fadeOut(200);
        }
    });
    $("#fastShow-layer").click(function () {
        var display = $($(".nav-block")[0]).css('display');
        if(display=='none'){
            $(".nav-block").fadeIn(200);
        }else{
            $(".nav-block").fadeOut(200);
        }
    });
});

