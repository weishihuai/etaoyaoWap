/**
 * Created by HZR on 2015/6/10.
 */
(function($){
    $(document).ready(function(){
        //主轮换广告
        $('#bannerMain').after("<div class='slider' id='nav' style='z-index: 999;'>").cycle({
            fx:     'scrollHorz',
            speed:  'fast',
            timeout: 3000,
            pager:  '#nav',
            before: function() { if (window.console) console.log(this.src); },
            pagerAnchorBuilder:function(index,slide){
                var count=index+1;
                if(index==0){
                    return '<a id="c'+count+'"  class="cur" href="javascript:;" style="z-index: 999;">'+'</a>'
                }else{
                    return '<a id="c'+count+'" href="javascript:;" >'+'</a>'
                }
            },
            after:function(currSlideElement, nextSlideElement, options, forwardFlag){
                var a= $("#nav").find("a").attr("class","");
                $("#c"+nextSlideElement.id).attr("class","cur");
            }
        });
    });
})(jQuery);
















































