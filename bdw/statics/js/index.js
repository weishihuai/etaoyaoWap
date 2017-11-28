$(document).ready(function () {

    var swiper01 = new Swiper('.goods-box', {
        slidesPerView: 5,
        loop : false
    });
    $('#promotion-prev').click(function(){
        swiper01.swipePrev();
    });
    $('#promotion-next').click(function(){
        swiper01.swipeNext();
    });

    var roteSwiper = new Swiper('.roteAdv',{
        slidesPerView: 1,
        loop : true,
        autoplay:3000,
        pagination : '.pagination',
        paginationClickable :true,
        autoplayDisableOnInteraction : false,
    });
    $(".main-banner-prev").click(function(){
        roteSwiper.swipePrev();
    });
    $(".main-banner-next").click(function(){
        roteSwiper.swipeNext();
    });

    countDown();


    //图片预加载：只要img标签中有data-original属性的都需要预加载
    $("img.lazy").lazyload(
        {
            effect: "fadeIn",
            failure_limit : 5,
            threshold : 200
        }
    );

    /*main-banner轮换广告*/
    /*$('#roteAdv').cycle({
        fx: 'scrollHorz',
        speed: 'fast',
        timeout: 5000,
        pager: '#nav',
        prev:'.main-banner-prev',
        next:'.main-banner-next',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            var count = index + 1;
            if (index == 0) {
                return '<a href="javascript:;" id="c' + count + '" class="cur">' + count + '</a>'
            } else {
                return '<a href="javascript:;" id="c' + count + '">' + count + '</a>'
            }
        },
        after: function (currSlideElement, nextSlideElement, options, forwardFlag) {
            $("#nav").find("a").removeClass("cur");
            $("#c" + nextSlideElement.id).addClass("cur");
            //$(".bannerBox").css("background",$("#" + nextSlideElement.id).attr("color-data"));
        }
    });*/

    $(".floorNav").hover(function(){
        var floorCount = $(this).attr("fSec");
        var ulCount = $(this).attr("uSec");
        $(".floorUl"+floorCount).css("display","none");
        $("#floorUl"+floorCount+ulCount).css("display","block");
        $(".floorNav"+floorCount).removeClass("cur");
        $(this).addClass("cur");
    });

    $(".noticeTab").click(function(){
        var rel = $(this).attr("rel");
        $(".noticeTab").removeClass("cur");
        $(".noticeBox").hide();
        $(this).addClass("cur");
        $(".noticeBox"+rel).show();
    });

    $(".recommendPrdRow").hover(function () {
            var rel = $(this).attr("rel");
            $(this).parent().parent().parent().parent().find(".recommendPrdRow").parent().removeClass("cur");
            $(this).parent().addClass("cur");
            $(this).parent().parent().parent().parent().find(".recommendPrdBox").hide();
            $(this).parent().parent().parent().parent().find(".recommendPrdBox" + rel).show();
        }, function () {
        }
    );
    //促销活动
    $(".tab-tit").find("a").click(function(){
        $(this).addClass("cur").siblings().removeClass("cur");
        var tab = $(this).attr("tab");
        $("#tab-cont"+tab).show().siblings().hide();
    });

    //人体图
    $(".male").click(function(){
        if(!$(".male").hasClass("active")){
            $(".female").removeClass("active");
            $(".male").addClass("active");
            if($(".front").hasClass("active")){
                $(".rt-top").children(".pic").css("display","none");
                $(".maleFront").css("display","block");
            }
            else{
                $(".rt-top").children(".pic").css("display","none");
                $(".maleBack").css("display","block");
            }
        }
    });

    $(".female").click(function(){
        if(!$(".female").hasClass("active")){
            $(".male").removeClass("active");
            $(".female").addClass("active");
            if($(".front").hasClass("active")){
                $(".rt-top").children(".pic").css("display","none");
                $(".femaleFront").css("display","block");
            }
            else{
                $(".rt-top").children(".pic").css("display","none");
                $(".femaleBack").css("display","block");
            }
        }
    });

    $(".front").click(function(){
        if(!$(".front").hasClass("active")){
            $(".back").removeClass("active");
            $(".front").addClass("active");
            if($(".female").hasClass("active")){
                $(".rt-top").children(".pic").css("display","none");
                $(".femaleFront").css("display","block");
            }
            else{
                $(".rt-top").children(".pic").css("display","none");
                $(".maleFront").css("display","block");
            }
        }
    });

    $(".back").click(function(){
        if(!$(".back").hasClass("active")){
            $(".front").removeClass("active");
            $(".back").addClass("active");
            if($(".female").hasClass("active")){
                $(".rt-top").children(".pic").css("display","none");
                $(".femaleBack").css("display","block");
            }
            else{
                $(".rt-top").children(".pic").css("display","none");
                $(".maleBack").css("display","block");
            }
        }
    });

    $(".mesLiLeft").click(function(){
        if(!$(this).hasClass("cur")){
            $(".mesLiRight").removeClass("cur");
            $(this).addClass("cur");
            $(".rightTab").css("display","none");
            $(".leftTab").css("display","block");
        }
    });

    $(".mesLiRight").click(function(){
        if(!$(this).hasClass("cur")){
            $(".mesLiLeft").removeClass("cur");
            $(this).addClass("cur");
            $(".leftTab").css("display","none");
            $(".rightTab").css("display","block");
        }
    });

});

//促销商品倒计时函数
function countDown(){
    window.setInterval(function () {
        for(var i=1;i<promotionAmount+1;i++){
            var day = 0,
                hour = 0,
                minute = 0,
                second = 0; //时间默认值
            var startDate = new Date();
            var endDate = $("#promotion"+i).attr("endDate");
            endDate = endDate.replace(new RegExp("-","gm"),"/");
            var intDiff = ((new Date(endDate)).getTime()-startDate.getTime())/1000;
            //alert(intDiff);
            if (intDiff > 0) {
                day = Math.floor(intDiff / (60 * 60 * 24));
                hour = Math.floor(intDiff / (60 * 60)) - (day * 24);
                minute = Math.floor(intDiff / 60) - (day * 24 * 60) - (hour * 60);
                second = Math.floor(intDiff) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
                if (minute <= 9) minute = '0' + minute;
                if (second <= 9) second = '0' + second;
                $('#day' + i).text(day + "天");
                $('#hour' + i).text(hour + '时');
                $('#minute' + i).text(minute + '分');
                $('#second' + i).text(second + '秒');
                intDiff--;
            }
            else{
                $("#promotionDiv" + i).text("活动已结束");
            }
        }
    }, 1000);
}

//品牌中换一批
function changeBrands(obj){
    var isFirst = $(obj).attr("isFirst");
    var brandCount = parseInt($("#brandUl").attr("brandSize"));//品牌总数
    //总页数
    var totalPage = 0;
    if(brandCount%11>0){
        totalPage = parseInt(brandCount/11)+1;
    }else{
        totalPage = parseInt(brandCount/11);
    }

    var currentPage = parseInt($(obj).attr("page"));//当前页数,默认是第一页

    if(isFirst == 'true'){
        currentPage=1;
    }

    $(".bad").css("display", "none");//所有不可见
    if(currentPage >= totalPage){//最后一页
        currentPage = 0;
    }
    var begin = currentPage*11+1;
    var end = (currentPage+1)*11;

    for(var i=begin; i<=end; i++){
        $(".brand" + i).css("display", "block");
    }
    $(obj).attr("page", currentPage+1);
    $(obj).attr("isFirst", "false");
}

