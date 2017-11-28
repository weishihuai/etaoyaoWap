document.ready = function (callback) {
    ///兼容FF,Google
    if (document.addEventListener) {
        document.addEventListener('DOMContentLoaded', function () {
            document.removeEventListener('DOMContentLoaded', arguments.callee, false);
            callback();
        }, false)
    }
    //兼容IE
    else if (document.attachEvent) {
        document.attachEvent('onreadytstatechange', function () {
            if (document.readyState == "complete") {
                document.detachEvent("onreadystatechange", arguments.callee);
                callback();
            }
        })
    }
    else if (document.lastChild == document.body) {
        callback();
    }


    /*$(".icon-ms").trigger("click");*/
};
function resizeFontSize(){
    var clientWidth = document.body.clientWidth;
    var x = 0;
    /*if(clientWidth >= 1024){
        x = '32px';
    }else */if(clientWidth <= 320){
        x = '10px';
    }else{
        x = clientWidth * 0.03125 + 'px';
    }
    document.querySelector('html').setAttribute('style','font-size: '+ x +';');
}
document.ready(resizeFontSize);
window.onresize =  function(){
    setTimeout(function(){
        resizeFontSize();
    }, 400);
};

$(function () {
    //更多优惠
    $(".moreDiscountBtn").click(function() {
        var moreBtn = $(this);
        var subjectSectionId = moreBtn.attr("subjectSectionId");
       //判断是否还有正在抢购的活动，如果没有，显示最近的即将开始的活动
        var marketingActivityId = moreBtn.attr("activityId");
        var processTab = $("#activityTab li[progress='true']");
        var unProcessTab = $("#activityTab li[progress='false']");
        var processArray = [];
        var unProcessArray = [];
        if(processTab.length > 1){
            processTab.each(function () {
                var li = $(this);
                var activityId = li.attr("marketingActivityId");
                if(activityId != marketingActivityId){
                    processArray.push(activityId);
                }
            });
            if(processArray.length >= 1){
                window.location.href=webPath.webRoot+"/wap/limitActivity.ac?activityId="+processArray[0]+"&subjectSectionId="+subjectSectionId;
            }else{
                webToast("亲,没有更多活动了!","middle",3000);
            }
        }else{
            //显示即将开始
            if(unProcessTab.length > 1){
                unProcessTab.each(function () {
                    var unLi = $(this);
                    var activityId = unLi.attr("marketingActivityId");
                    unProcessArray.push(activityId);
                });
                if(unProcessArray.length >= 1){
                    window.location.href=webPath.webRoot+"/wap/limitActivity.ac?activityId="+unProcessArray[0]+"&subjectSectionId="+subjectSectionId;
                }else{
                    webToast("亲,没有更多活动了!","middle",3000);
                }
            }else{
                webToast("亲,没有更多活动了!","middle",3000);
            }
        }
    });

    //开抢提醒（因微信端关注后没有手机号码，所以开抢提醒暂时注释掉）
    //$(".remindBtn").click(function() {
    //    var remindBtn = $(this);
    //    //商品ID
    //    var productId = remindBtn.attr("productId");
    //    //活动ID
    //    var marketingActivityId = remindBtn.attr("marketingActivityId");
    //
    //    $.ajax({
    //        url: webPath.webRoot + "/member/savePromotionNotice.json",
    //        data: {marketingActivityId: marketingActivityId,productId:productId},
    //        dataType: "json",
    //        success: function (data) {
    //            var result = data.result;
    //            if (result == "nologin") {
    //                goToUrl(webPath.webRoot + "/wap/login.ac");
    //                return;
    //            }
    //            if(result == true){
    //                webToast("提醒登记成功!","middle",2000);
    //
    //            }else{
    //                webToast("您已经登记过了!","middle",2000);
    //            }
    //        },
    //        error: function (XMLHttpRequest, textStatus) {
    //            if (XMLHttpRequest.status == 500) {
    //                var result = eval("(" + XMLHttpRequest.responseText + ")");
    //                alert(result.errorObject.errorText);
    //            }
    //        }
    //    });
    //});

});

var goToUrl = function (url) {
    setTimeout(function () {
        window.location.href = url
    }, 1)
};


//2016年8月19日 lhw，活动开始倒计器
$.extend($.fn,{
    fnTimeCountDown:function(d){
        this.each(function(){
            var $this = $(this);
            var o = {
                sec: $this.find(".sec"),
                mini: $this.find(".mini"),
                hour: $this.find(".hour"),
                day: $this.find(".day"),
                month:$this.find(".month"),
                year: $this.find(".year")
            };
            var f = {
                zero: function(n){
                    var _n = parseInt(n, 10);//解析字符串,返回整数
                    if(_n > 0){
                        if(_n <= 9){
                            _n = "0" + _n
                        }
                        return String(_n);
                    }else{
                        return "00";
                    }
                },

                dv: function(){
                    //d = d || Date.UTC(2050, 0, 1); //如果未定义时间，则我们设定倒计时日期是2050年1月1日
                    var _d = $this.data("end") || d;
                    var now = new Date(), endDate = new Date(_d);
                    //现在将来秒差值
                    var dur = (endDate - now.getTime()) / 1000;
                    var mss = endDate - now.getTime();
                    var pms = {
                        sec: "00",
                        mini: "00",
                        hour: "00",
                        day: "00",
                        month: "00",
                        year: "0"
                    };
                    if(mss > 0){
                        pms.sec = f.zero(dur % 60);
                        pms.mini = Math.floor((dur / 60)) > 0? f.zero(Math.floor((dur / 60)) % 60) : "00";
                        pms.hour = Math.floor((dur / 3600)) > 0? f.zero(Math.floor((dur / 3600)) % 24) : "00";
                        pms.day = Math.floor((dur / 86400)) > 0? f.zero(Math.floor((dur / 86400)) % 30) : "00";
                        //月份，以实际平均每月秒数计算
                        pms.month = Math.floor((dur / 2629744)) > 0? f.zero(Math.floor((dur / 2629744)) % 12) : "00";
                        //年份，按按回归年365天5时48分46秒算
                        pms.year = Math.floor((dur / 31556926)) > 0? Math.floor((dur / 31556926)) : "0";
                    }else{
                        pms.year=pms.month=pms.day=pms.hour=pms.mini=pms.sec="00";
                        //setTimeout(function () {
                        //window.location.reload();
                        //}, 1);
                        //alert('结束了');
                        //window.location.reload();
                        return;
                    }
                    return pms;
                },
                ui: function(){
                    if(o.sec){
                        o.sec.html(f.dv().sec);
                    }
                    if(o.mini){
                        o.mini.html(f.dv().mini);
                    }
                    if(o.hour){
                        o.hour.html(f.dv().hour);
                    }
                    if(o.day){
                        o.day.html(f.dv().day);
                    }
                    if(o.month){
                        o.month.html(f.dv().month);
                    }
                    if(o.year){
                        o.year.html(f.dv().year);
                    }
                    setTimeout(f.ui, 0.1);
                }
            };
            f.ui();
        });
    }
});