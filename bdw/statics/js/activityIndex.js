$(document).ready(function(){


    /*刷新倒计时开始*/
    $("input[name=time]").each(function() {
        fresh($(this));
    });

    sh=setInterval(function(){
        $("input[name=time]").each(function() {
            fresh($(this));
        });
    },1000);
    /*刷新倒计时结束*/

    /*列表时间倒计时 开始*/
    $("input[name=listPageTime]").each(function() {
        listFresh($(this));
    });

    sh=setInterval(function(){
        $("input[name=listPageTime]").each(function() {
            listFresh($(this));
        });
    },1000);
    /*列表时间倒计时 结束*/

    /*轮换广告开始*/
    $('#roteAdv').after("<div class='sMuber'><ul id='nav'>").cycle({
        fx:     'scrollLeft',
        speed:  'fast',
        timeout: 5000,
        pager:  '#nav',
      /*  before: function() { if (window.console) console.log(this.src); },*/
        pagerAnchorBuilder:function(index,slide){
            var count=index+1;
            if(index==0){
                return '<li><a href="javascript:;" id="c'+count+'" class="cur">'+count+'</a></li>'
            }else{
                return '<li><a href="javascript:;" id="c'+count+'">'+count+'</a></li>'
            }
        },
        after:function(currSlideElement, nextSlideElement, options, forwardFlag){
            var a= $("#nav").find("a").attr("class","");
            $("#c"+nextSlideElement.id).attr("class","cur");
        }
    });

    $("#mycarousel").jcarousel({
        scroll: 4,
        initCallback: mycarousel_initCallback,
        buttonNextHTML: null,
        buttonPrevHTML: null
    });
});

/*轮换广告结束*/
function mycarousel_initCallback(carousel) {
    var ctrlA=$('.jcarousel-control a').bind('click', function() {
        carousel.scroll($.jcarousel.intval($(this).attr("rel")));
        ctrlA.removeClass("cur");
        $(this).addClass("cur");
        return false;
    });
}
function listFresh(t){
    var RemainTime = t.val();
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    if(leftsecond<=0){
        //t.parent().find(".listPageTime").html("<b>活动已结束</b>");
         clearInterval(sh);
        window.location.reload();
    }else{
    	d=parseInt(leftsecond/3600/24);
        h=parseInt((leftsecond/3600)%24);
        m=parseInt((leftsecond/60)%60);
        s=parseInt(leftsecond%60);
    	t.parent().find(".listPageTime").html("<em>距活动结束还有</em><span>"+d+"</span>天<span>"+h+"</span>小时<span>"+m+"</span>分<span>"+s+"</span>秒");
    }
}

function fresh(t){
    var RemainTime = t.val();
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    if(leftsecond<=0){
        //t.parent().find(".lastTime").html("<b>活动已结束</b>");
        clearInterval(sh);
        window.location.reload();
    }else{
    	 d=parseInt(leftsecond/3600/24);
    	 h=parseInt((leftsecond/3600)%24);
    	 m=parseInt((leftsecond/60)%60);
    	 s=parseInt(leftsecond%60);
    	 t.parent().find(".lastTime").html("<b>"+d+"天"+h+"时"+m+"分"+s+"秒</b>");
    }
}

var tabSelect = function(alreadtTab,tabSelect){
    $(".alreadyTab").removeClass("cur");
    if(alreadtTab != null){
        $("#"+alreadtTab).addClass("cur");
    }
    if(tabSelect=='process' || "" == tabSelect){
        $(".processActivity").show();
        $(".lastActivity").hide();
        $(".alreadyActivity").hide();
        $(".menu").find("a").removeClass("cur");
        $(".process").addClass("cur");
    }
    if(tabSelect=='last'){
        $(".processActivity").hide();
        $(".lastActivity").show();
        $(".alreadyActivity").hide();
        $(".menu").find("a").removeClass("cur");
        $(".last").addClass("cur");
    }
    if(tabSelect=='already'){
        $(".processActivity").hide();
        $(".lastActivity").hide();
        $(".alreadyActivity").show();
        $(".menu").find("a").removeClass("cur");
        $(".already").addClass("cur");
    }
};


