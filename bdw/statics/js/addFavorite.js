function addBookmark(title, url)
{

    if (window.sidebar) {
        try{
            window.sidebar.addPanel(title, url, "");
        } catch(e) {

        }
    } else if(document.all) {
        window.external.AddFavorite(url, title);
    } else if(window.opera && window.print) {
        return true;
    }else{
        alert("收藏失败！请使用Ctrl+D进行收藏");
    }
}
$(function(){
    $("#fav").click(function(){
        addBookmark(document.title, $("#fav").attr("href"));
    })
})
