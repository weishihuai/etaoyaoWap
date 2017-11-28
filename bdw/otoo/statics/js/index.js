

//清空商品的cookie
function clearHistoryProductsCookie(){
    $.get(webPath.webRoot+"/member/clearProductsCookie.json",function(data){
        window.location.reload();
    });
}

$(document).ready(function(){
    /*最近浏览-置顶*/
    var navH = $("#topMenu").offset().top;
    var navW = $("#topMenu").offset().left;
    $(window).scroll(function(){
        //获取滚动条的滑动距离
        var scroH = $(this).scrollTop();
        //滚动条的滑动距离大于等于定位元素距离浏览器顶部的距离，就固定，反之就不固定
        if(scroH>=navH){
            $("#topMenu").css({"position":"fixed","top":0,"left":navW});
        }else if(scroH<navH){
            $("#topMenu").css({"position":"static"});
        }
    });

    /*轮换广告*/
    $('#croImg').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 5000,
        pause : 1,
        prev:'.prev',
        next : '.next',
        pager: '#croNum',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            var count = index + 1;
            if (index == 0) {
                return '<a href="javascript:;" id="c' + count + '" class="cur"></a>'
            } else {
                return '<a href="javascript:;" id="c' + count + '"></a>'
            }
        },
        after: function (currSlideElement, nextSlideElement, options, forwardFlag) {
            var a = $("#croNum").find("a").attr("class", "");
            $("#c" + nextSlideElement.id).attr("class", "cur");
        }
    });
});