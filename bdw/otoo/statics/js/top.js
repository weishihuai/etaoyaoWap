/**
 * Created by Administrator on 2015/06/17.
 */

//商品分类
$(document).ready(function() {
    showLoginId();//获取用户名

    if (Top_Path.topParam == "index" || Top_Path.topParam == "list" || Top_Path.topParam == "detail" || Top_Path.topParam == "channel") {
        if (window.screen.width < 1200) {
            $("body").removeClass("q");
        }
    } else {
        $("body").addClass("q");
    }

    //搜索点击事件
    $("#search").click(function () {
        searchKeyword();
    });


    /*表单提交按钮键盘回车事件 start*/
    $("body").bind('keyup', function (event) {
        if (event.keyCode == 13) {
            $('#search').click();
        }
    });
    /*表单提交按钮键盘回车事件 end*/

    var fristRel = $(".category").attr("rel");
    //判断是否是首页
    if (fristRel != 'index') {
        $(this).find(".dd").hide();
    }
    $(".dd").find(".control").hover(function () {
        var index = $(this).find(".index").text();
        $("#con" + index).show().siblings(".con").hide();
        $(this).addClass("cur").siblings(".control").removeClass("cur");
    }, function () {
        $(".dd .con").hide();
        $(".control").removeClass("cur");
    });

    //我的宝得下拉现实
    $(".myAcunnt").hover(function () {
        $(this).addClass("cur");
        $(this).find(".item_popup").show();
    }, function () {
        $(this).removeClass("cur");
        $(this).find(".item_popup").hide();
    })

    //关注我们
    $(".wechatQr").hover(function () {
        $(this).addClass("cur2");
        $(this).find(".item_popup2").show();
    }, function () {
        $(this).removeClass("cur2");
        $(this).find(".item_popup2").hide();
    });

    //商品分类显示
    $(".category").hover(function () {
        $(this).find(".dd").show();
    }, function () {
        var rel = $(this).attr("rel");
        if (rel == "index") {
            return true;
        } else {
            $(this).find(".dd").hide();
        }
    });
});

//商品搜索
function searchKeyword() {
    var keyword = $("#keyword").val();
    if ($.trim(keyword) == '') {
        alert("请输入关键字");
        return;
    }
    window.location.href = webPath.webRoot + "/otoo/productList.ac?keyword=" + keyword;
}


//获取用户名
var showLoginId = function () {
    var exitUrl = Top_Path.webUrl + "/member/exit.ac?sysUserId=";
    var timestamp = Date.parse(new Date());
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type: "GET",
        url: Top_Path.webRoot + "/pickedup/showLoginId.json?cdntime=" + timestamp,
        data: {},
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                //alert("成功");
                $('#showUserId').html(
                    '您好，<a href="' + Top_Path.webUrl + '/module/member/index.ac">' + data.login_id + '</a>，欢迎来到' + Top_Path.webName + '[<a href="' + exitUrl + data.user_id + '" title="退出">退出</a>]'
                );
            } else if (data.success == "false") {
                //alert("失败");
                $('#showUserId').html(
                    '您好，欢迎来到' + Top_Path.webName + '！[<a class="cur" href="' + Top_Path.webUrl + '/login.ac" title="登录">登录</a>] [<a class="color" href="' + Top_Path.webUrl + '/register.ac" title="免费注册">免费注册</a>]'
                );
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}
$(document).ready(function () {
    showLoginId();//获取用户名

    $(".wechatQr").hover(function () {
        $(this).addClass("cur2");
        $(this).find(".item_popup2").show();
    }, function () {
        $(this).removeClass("cur2");
        $(this).find(".item_popup2").hide();
    });

    $(".myAcunnt").hover(function () {
        $(this).addClass("cur");
        $(this).find(".item_popup").show();
    }, function () {
        $(this).removeClass("cur");
        $(this).find(".item_popup").hide();
    });
});


