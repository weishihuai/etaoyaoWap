/**
 * Created by chencheng on 2017/10/25.
 * 底部导航
 */
$(function () {


    $('#QrCode').click(function(){
        $('#qr-code-share-div').show();
    });
    $('#qr-code-share-div').click(function(){
        $('#qr-code-share-div').hide();
    });



    var $footerMakeMoney = $("#foot_makeMoney");
    var $footerCpsMe = $("#foot_cpsMe");

     if(footer.pIndex === 'cpsMe') {
        $footerCpsMe.addClass("home active").siblings().removeClass("active");
        $("#foot_cpsMe > a > i").removeClass("icon-tixian").addClass("icon-tixian_s");
        $("#foot_makeMoney > a > i").removeClass("icon-makeMoney_s").addClass("icon-makeMoney");
    }else {
         // footer.pIndex==""||footer.pIndex === 'makeMoney'
        $footerMakeMoney.addClass("home active").siblings().removeClass("active");
        $("#foot_makeMoney > a > i").removeClass("icon-makeMoney").addClass("icon-makeMoney_s");
        $("#foot_cpsMe > a > i").removeClass("icon-tixian_s").addClass("icon-tixian");
    }
});