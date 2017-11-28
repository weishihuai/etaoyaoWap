$(document).ready(function(){
    //$("#firstCate1").trigger("click");
});

function showSecondCate(num){
    $("#firstCate"+num).parent().children().removeClass("cur");
    $("#firstCate"+num).addClass("cur");
    $("#secondCate"+num).parent().children().css("display","none");
    $("#secondCate"+num).css("display","block");
}
