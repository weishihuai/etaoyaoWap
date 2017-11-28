$(document).ready(function() {

    //头部的轮换广告 start
    $('#roteAdv').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 6000,
        pager: '#nav',
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
            var a = $("#nav").find("a").attr("class", "");
            $("#c" + nextSlideElement.id).attr("class", "cur");
            $(".ch_banner").css("background", $("#" + nextSlideElement.id).attr("color-data"));
        }
    });
    //头部的轮换广告 end




    //粮油调味轮换广告 start
    $('#wjf_f1_Center_slide_adv1').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 0,
        pager: '#wjf_f1_Center_slide_adv1_btn',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            return '<a href="javascript:;"></a>';
        }
    });
    //粮油调味轮换广告 end



    //食品饮料轮换广告 start
    $('#wjf_f2_Center_slide_adv1').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 0,
        pager: '#wjf_f2_Center_slide_adv1_btn',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            return '<a href="javascript:;"></a>';
        }
    });
    //食品饮料轮换广告 end


    //母婴用品轮换广告 start
    $('#wjf_f3_Center_slide_adv1').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 0,
        pager: '#wjf_f3_Center_slide_adv1_btn',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            return '<a href="javascript:;"></a>';
        }
    });
    //母婴用品轮换广告 end

    //居家生活轮换广告 start
    $('#wjf_f4_Center_slide_adv1').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 0,
        pager: '#wjf_f4_Center_slide_adv1_btn',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            return '<a href="javascript:;"></a>';
        }
    });
    //居家生活轮换广告 end

    //美容护理轮换广告 start
    $('#wjf_f5_Center_slide_adv1').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 0,
        pager: '#wjf_f5_Center_slide_adv1_btn',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            return '<a href="javascript:;"></a>';
        }
    });
    //美容护理轮换广告 end

    //文体类轮换广告 start
    $('#wjf_f6_Center_slide_adv1').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 0,
        pager: '#wjf_f6_Center_slide_adv1_btn',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            return '<a href="javascript:;"></a>';
        }
    });
    //文体类轮换广告 end


    //服装鞋包轮换 start
    $('#wjf_f7_Center_slide_adv1').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 0,
        pager: '#wjf_f7_Center_slide_adv1_btn',
        before: function () {
            //if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            return '<a href="javascript:;"></a>';
        }
    });
    //服装鞋包轮换 end

    $(".b_info").hover(function () {
        $(this).addClass("cur");
        $(this).children(".i_popup").show();
    },function(){
        $(this).removeClass("cur");
        $(this).children(".i_popup").hide();
    });

    try {
        var scrollPic_banner = new ScrollPic();
        scrollPic_banner.scrollContId = "left_adv"; //内容容器ID
        scrollPic_banner.arrLeftId = "left_adv_r";//左箭头ID
        scrollPic_banner.arrRightId = "left_adv_l"; //右箭头ID
        scrollPic_banner.frameWidth = 235;//显示框宽度(容器大小不一样,这个经常改)
        scrollPic_banner.pageWidth = 235; //翻页宽度(翻阅一张图片的宽度,根据图片大小不同而调整,一般是一张图片的宽度加上两张图片的间距的数值,也可以翻阅多张,比如我要一下子翻阅4张,则是220X4=880即可.)
        scrollPic_banner.speed = 10; //移动速度(单位毫秒，越小越快)
        scrollPic_banner.space = 5; //每次移动像素(单位px，越大越快)
        scrollPic_banner.autoPlay = false; //自动播放
        scrollPic_banner.autoPlayTime = 5; //自动播放间隔时间(秒)
        scrollPic_banner.initialize(); //初始化
    } catch (e) {
        //console.log("切换广告异常" + e);
    }
});
