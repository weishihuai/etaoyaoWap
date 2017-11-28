$(function(){
    var signUrl = location.href.split('#')[0];
    signUrl = encodeURIComponent(signUrl);
    $.ajax({
        type:"POST",
        url: webPath.webRoot + "/wxsdk/getWeixinJsConfig.json",
        data:{'signUrl':signUrl},
        dataType:'json',
        success:function(msg) {
            if(msg.result == "success"){
                var weixinJsSdkConfig = msg.weixinJsSdkConfig;
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: weixinJsSdkConfig.appId, // 必填，公众号的唯一标识
                    timestamp: weixinJsSdkConfig.timestamp, // 必填，生成签名的时间戳
                    nonceStr: weixinJsSdkConfig.nonceStr, // 必填，生成签名的随机串
                    signature: weixinJsSdkConfig.signature,// 必填，签名，见附录1
                    jsApiList: webPath.weixinJsConfig.jsApiList // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
            }else{
                alert("初始化失败，请稍后再试。");
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
                return false;
            }
        }
    });
});