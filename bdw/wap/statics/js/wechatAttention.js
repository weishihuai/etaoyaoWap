$(function () {

    $(".wechatAttentionBtn").click(function () {
        var display = $($(".att-tion")[0]).css('display');
        if (display == 'none') {
            $(".att-tion").fadeIn(200);
        } else {
            $(".att-tion").fadeOut(200);
        }

        var display = $($(".attention")[0]).css('display');
        if (display == 'none') {
            $(".attention").fadeIn(200);
        } else {
            $(".attention").fadeOut(200);
        }


    });
});


function hideWechatAttentionLayer() {
    var display = $($(".attention")[0]).css('display');
    if (display != 'none') {
        $(".attention").fadeOut(200);
        SetCookie("wechatAttentionLayerShowTime", 'isHide')
    }
}

function SetCookie(sName, sValue) {
    var Days = 1;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000  );
    document.cookie = sName + "=" + escape(sValue) + ";expires=" + exp.toGMTString();
}