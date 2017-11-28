//<![CDATA[


window.onload=function(){
    if(document.documentElement.scrollHeight <= document.documentElement.clientHeight)
    {
        bodyTag = document.getElementsByTagName('body')[0];
        bodyTag.style.height = document.documentElement.clientWidth / screen.width * screen.height + 'px';
    }
    setTimeout(function() { window.scrollTo(0, 1) }, 0);
};


//
//]]>
$(document).ready(function(){
    $(".flyout-btn").click(function() {
        $(".flyout-btn").toggleClass("btn-rotate");
        $(".flyout").find("a").removeClass();
        return $(".flyout").removeClass("flyout-init fade").toggleClass("expand");
    });

    $(".flyout").find("a").click(function() {
        $(".flyout-btn").toggleClass("btn-rotate");
        $(".flyout").removeClass("expand").addClass("fade");
        return $(this).addClass("clicked");
    });
    $("toTop").click(function(e) {
        //以1秒的间隔返回顶部
        $('body,html').animate({scrollTop:0},500);
    });
});