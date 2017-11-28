$(document).ready(function(){
    if(t == "all"){
        $("#allBrank").removeClass();
        $("#allCategory").addClass("cur");
        $("#brank").hide();
        $("#categoryList").show();
    }
    $("#allCategory").hover(function(){
        $("#allBrank").removeClass();
        $("#allCategory").addClass("cur");
        $("#brank").hide();
        $("#categoryList").show();
    },function(){
    });
    $("#allBrank").hover(function(){
        $("#allCategory").removeClass();
        $("#allBrank").addClass("cur");
        $("#categoryList").hide();
        $("#brank").show();
    },function(){
    });
    $("#Other .r .box tr").hover(function(){
        $(this).parent().children("tr").each(function(){
           $(this).removeClass("hover");
        });
       $(this).addClass("hover");
    });
});

/**列表移动选择效果*/
function setEachOverStyle(obj){
     $(obj).addClass("cur");
}
function setEachOutStyle(obj){
    $(obj).removeClass("cur");
}