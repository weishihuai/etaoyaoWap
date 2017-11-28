
$(document).ready(function () {
    /*图片轮播*/
    $(".proCarousel").slidelf1({
        "prev": "op-prev",
        "next": "op-next",
        "vertical": false,
        "speed": 300
    });
});

function goUrl(url){
    window.location.href = url;
}