/**
 * Created by GJS on 2016/3/17.
 */
/*$(document).ready(function() {

    /!**
     * 监听回车键，回车时登录*!/
    $("body").bind('keyup',function(event) {
        if(event.keyCode==13){
            var newsKeyword=$("#newsKeyword").val();
            if(newsKeyword != null && newsKeyword != ""){
                window.location.href=webPath.webRoot+"/newsList.ac?newsKeyword="+newsKeyword;
            }
        }
    });

});*/

function searchNews(){
    var newsKeyword=$("#newsKeyword").val();
    window.location.href=webPath.webRoot+"/newsList.ac?newsKeyword="+newsKeyword;
}

function edit(item){
    $(item).parent().addClass("focus");
}
function removeEdit(item){
    $(item).parent().removeClass("focus");
}