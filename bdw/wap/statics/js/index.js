$(document).ready(function(){
    //轮播图
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        autoplay: 5000,
        loop: true,
        slidesPerView: 1
    });
});

function scrollToTop(){
    $('body,html').animate({scrollTop:0},1000);
}

$(window).scroll(showTopSearch);
function showTopSearch(){
    var sTop = $(window).scrollTop();
    var scBox2 = $(".sc-box2");
    if(sTop<$(".sc-box1").height()){
        scBox2.slideUp("1000");
    }
    if(sTop>=$(".sc-box1").height()){
        scBox2.slideDown("1000");
    }
    showBackTopBtn();
}

function showBackTopBtn(){
    if($(window).scrollTop() >= $(".popularity").offset().top){
        $(".back-top").css("display","block");
    }
    if($(window).scrollTop() < $(".popularity").offset().top){
        $(".back-top").css("display","none");
    }
}

/**
 * 倒计时
 * @param intDiff 总秒数
 */
function timer(intDiff){
    window.setInterval(function(){
        var day=0,
            hour=0,
            minute=0,
            second=0;//时间默认值
        if(intDiff > 0){
            day = Math.floor(intDiff / (60 * 60 * 24));
            hour = Math.floor(intDiff / (60 * 60)) - (day * 24);
            minute = Math.floor(intDiff / 60) - (day * 24 * 60) - (hour * 60);
            second = Math.floor(intDiff) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
        }else{
            $("#promotionDate").hide();
            return;
        }
        if (hour <= 9) hour = '0' + hour;
        if (minute <= 9) minute = '0' + minute;
        if (second <= 9) second = '0' + second;
        $("#promotionDate").html(day +"天 " + hour + ":" + minute + ":" + second);
        intDiff--;
    }, 1000);
}