$(function () {
    wx.ready(function(){
        //微信分享到朋友圈
        wx.onMenuShareTimeline({
            title: webPath.title, // 分享标题
            desc: webPath.desc, // 分享描述
            link:  webPath.shareUrl, // 分享链接
            imgUrl: webPath.imgUrl, // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
                $("#share").hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $("#share").hide();
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
                $("#share").hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $("#share").hide();
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
                $("#share").hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $("#share").hide();
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
                $("#share").hide();
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                $("#share").hide();
            }
        });
    });
});