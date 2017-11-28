$(document).ready(function(){
    $('.newComment').upMove('.jvf_index_dianp_con',2);
    $(".img-a-title").css("opacity","0");
    $(".banner").hover(function(){
        $(this).find(".p-img").css("opacity","0.5");
    },function(){
        $(this).find(".p-img").css("opacity","1");
    })
        $(".itemsHover").find(".itemHover").hover(function(){
            $(this).parent().parent().parent().parent().find(".itemHover").css("opacity","0.5");
            $(this).css("opacity","0");
        },function(){
            $(".itemHover").css("opacity","0");
        })

//    $(".itemsHover2").find(".itemHover2").hover(function(){
//        $(this).parent().parent().parent().find(".itemHover2").css("opacity","0.5");
//        $(this).css("opacity","0");
//    },function(){
//        $(".itemHover2").css("opacity","0");
//    })
    $('#roteAdv').after("<div class='mub'><ul id='nav'>").cycle({
        fx:     'scrollLeft',
        speed:  'fast',
        timeout: 5000,
        pager:  '#nav',
        before: function() { if (window.console) console.log(this.src); },
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
        scroll: 1,
        initCallback: init,
        buttonNextHTML: null,
        buttonPrevHTML: null
    });

    $('#tehui_roteAdv').after("<div class='mub'><ul id='nav1'>").cycle({
        fx:     'scrollLeft',
        speed:  'fast',
        timeout: 5000,
        pager:  '#nav1',
        before: function() { if (window.console) console.log(this.src); },
        pagerAnchorBuilder:function(index,slide){
            var count=index+1;
            if(index==0){
                return '<li><a href="javascript:;" id="f'+count+'" class="cur">'+count+'</a></li>'
            }else{
                return '<li><a href="javascript:;" id="f'+count+'">'+count+'</a></li>'
            }
        },
        after:function(currSlideElement, nextSlideElement, options, forwardFlag){
//                    var sm=$(".s-m").attr("class","s-m");
//                    $("#f"+nextSlideElement.id).attr("class","s-m hover");
            var a= $("#nav1").find("a").attr("class","");
            $("#f"+nextSlideElement.id).attr("class","cur");
//                    var a= $("#nav").find("a").attr("class","");
//                    $("#c"+nextSlideElement.id).attr("class","cur");
        }
    });

    $('#tehui_roteAdv2').after("<div class='mub'><ul id='nav2'>").cycle({
        fx:     'scrollLeft',
        speed:  'fast',
        timeout: 5000,
        pager:  '#nav2',
        before: function() { if (window.console) console.log(this.src); },
        pagerAnchorBuilder:function(index,slide){
            var count=index+1;
            if(index==0){
                return '<li><a href="javascript:;" id="f2'+count+'" class="cur">'+count+'</a></li>'
            }else{
                return '<li><a href="javascript:;" id="f2'+count+'">'+count+'</a></li>'
            }
        },
        after:function(currSlideElement, nextSlideElement, options, forwardFlag){
            var a= $("#nav2").find("a").attr("class","");
            $("#f2"+nextSlideElement.id).attr("class","cur");
        }
    });

    $(".addItem").hover(function(){
        $(this).parent().parent().find(".layout_sbj_list").show();
        $(this).parent().parent().find(".layout_sbj_list").hover(function(){
            $(this).show();
        },function(){
            $(this).hide();
        })
    },function(){
        $(this).parent().parent().find(".layout_sbj_list").hide();
    })
        $("#mycarousel").find("ul").css("left","0")
})

function init(carousel) {
    $('#mycarousel-next').bind('click', function() {
        carousel.next();
        return false;
    });
    $('#mycarousel-prev').bind('click', function() {
        carousel.prev();
        return false;
    });
}

function topTabHover(tab,showItem){
    $(".topTab").removeClass("cur");
    $(tab).addClass("cur");
    $(".tabItem").hide();
    $(showItem).show();
}

function prdTabHover(obj,obj2,tab,showItem){
    $(obj).removeClass("cur");
    $(tab).addClass("cur");
    $(obj2).hide();
    $(tab).parent().parent().parent().parent().find(showItem).show();
}
