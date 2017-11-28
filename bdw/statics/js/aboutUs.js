/**
 * Created by GJS on 2016/3/22.
 */

$(document).ready(function(){
    $(".article").click(function(){
        $(".main-lt a").removeClass("cur");
        $(this).addClass("cur");
    });

    $(".title").click(function(){
        if($(this).next().css("display")=='block'){
            $(this).next().slideUp();
        }else if($(this).next().css("display")=='none'){
            $(this).next().slideDown();
        }
    })
})
