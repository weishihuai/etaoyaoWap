$(document).ready(function(){
  /*  wx.config({
        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId: webPath.appId, // 必填，公众号的唯一标识
        timestamp: webPath.timestamp, // 必填，生成签名的时间戳
        nonceStr: webPath.nonceStr, // 必填，生成签名的随机串
        signature: webPath.signature,// 必填，签名，见附录1
        jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareQZone', 'onMenuShareWeibo'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    });*/

    wx.ready(function(){
        //微信分享到朋友圈
        wx.onMenuShareTimeline({
            title: webPath.title, // 分享标题
            desc: webPath.desc, // 分享描述
            link:  webPath.shareUrl, // 分享链接
            imgUrl: webPath.imgUrl, // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
                $('#guide').hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $('#guide').hide();
            }
        });

        //微信分享好友
        wx.onMenuShareAppMessage({
            title: webPath.title, // 分享标题
            desc: webPath.desc, // 分享描述
            link: webPath.shareUrl, // 分享链接
            imgUrl: webPath.imgUrl, // 分享图标
            type: "link", // 分享类型,music、video或link，不填默认为link
            dataUrl: "", // 如果type是music或video，则要提供数据链接，默认为空
            success: function () {
                // 用户确认分享后执行的回调函数
                $('#guide').hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $('#guide').hide();
            }
        });

        //分享到QQ空间
        wx.onMenuShareQZone({
            title: webPath.title, // 分享标题
            desc: webPath.desc, // 分享描述
            link:  webPath.shareUrl, // 分享链接
            imgUrl: webPath.imgUrl, // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
                $('#guide').hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $('#guide').hide();
            }
        });

        //分享到QQ
        wx.onMenuShareQQ({
            title: webPath.title, // 分享标题
            desc: webPath.desc, // 分享描述
            link: webPath.shareUrl, // 分享链接
            imgUrl: webPath.imgUrl, // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
                $('#guide').hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $('#guide').hide();
            }
        });

        //分享到腾讯微博
        wx.onMenuShareWeibo({
            title: webPath.title, // 分享标题
            desc: webPath.desc, // 分享描述
            link: webPath.shareUrl, // 分享链接
            imgUrl: webPath.imgUrl, // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
                $('#guide').hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $('#guide').hide();
            }
        });
    });
});