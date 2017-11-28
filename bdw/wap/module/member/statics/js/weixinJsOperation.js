$(function(){
    var signUrl = location.href.split('#')[0];
    signUrl = encodeURIComponent(signUrl);
    $.ajax({
        type:"POST",
        url: dataValue.webRoot+"/wxsdk/getWeixinJsConfig.json",
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
                    jsApiList: ['chooseImage', 'uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
            }else{
                alert("初始化失败，请稍后再试");
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

function chooseImage(count){
    var serverIdArray = null;
    wx.chooseImage({
        count: count, // 默认9
        sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
        success: function (res) {
            var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
            if(!isEmpty(localIds)){
                var len = localIds.length;
                serverIdArray = new Array(len);
                for(var i=0;i<len;i++){
                    wx.uploadImage({
                        localId: localIds[i], // 需要上传的图片的本地ID，由chooseImage接口获得
                        isShowProgressTips: 1, // 默认为1，显示进度提示
                        success: function (res) {
                            serverIdArray[i] = res.serverId; // 返回图片的服务器端ID
                        }
                    });
                }
            }
        }
    });

    return serverIdArray;
}

//判空
function isEmpty(obj){
    if(obj==undefined || obj==null){
        return true;
    }else{
        return false;
    }
}