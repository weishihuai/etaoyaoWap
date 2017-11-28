$(function(){
    $("#copyUrl").click(function(){
        $('#sysMsg').show();
        $('.copy-modal-dialog .copy-modal-body').text(webParams.bdUrl);
    });

    $('.copy-modal-footer').click(function(){
        $('#sysMsg').hide();
    });
});

//分享到新浪微博
function shareSinaWeibo(title, url, picurl){
    var sharesinastring='http://v.t.sina.com.cn/share/share.php?title='+encodeURIComponent(title)+'&url='+encodeURIComponent(url)+'&content=utf-8&sourceUrl='+encodeURIComponent(url)+'&pic='+encodeURIComponent(picurl);
    window.open(sharesinastring,'newwindow','height=400,width=400,top=100,left=100');
}

//关闭分享页
function closeSharePage(){
    parent.shareHtml = $('.bdselect_share_bg').get(0).outerHTML + $('.bdselect_share_box').get(0).outerHTML + $('.sr-bdimgshare').get(0).outerHTML;
    $('.bdselect_share_bg').remove();
    $('.bdselect_share_box').remove();
    $('.sr-bdimgshare').remove();
    $("#share-sec").parent().hide();
}

//关闭链接复制
function hideMeg(){
    $('#sysMsg').hide();
}