$(function () {

    $("#back").click(function () {
        window.location.href=dataValue.webRoot+"/wap/module/member/index.ac?pIndex=member";
    });

    //微信端
    if(dataValue.isWeixin=='Y') { //微信端
        $('#btnUpload').click(function(){
            wx.chooseImage({
                count: 1, // 默认9
                sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
                sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
                success: function (res) {
                    var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
                    if(!isEmpty(localIds)){
                        wx.uploadImage({
                            localId: localIds[0], // 需要上传的图片的本地ID，由chooseImage接口获得
                            isShowProgressTips: 0, // 默认为1，显示进度提示
                            success: function (res) {
                                $.ajax({
                                    type: "POST",
                                    url: dataValue.webRoot + "/member/uploadUserIcoFromWeixin.json",
                                    data: {'mediaId': res.serverId},
                                    dataType:'json',
                                    success: function (msg) {
                                        if(msg.success=='true'){
                                            showTips("修改头像成功");
                                            setTimeout(function(){
                                                location.reload();
                                            },1000);
                                        }else{
                                            showTips("上传图片失败，请稍后再试");
                                        }
                                    },
                                    error:function(XMLHttpRequest, textStatus) {
                                        if (XMLHttpRequest.status == 500) {
                                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                                            showTips(result.errorObject.errorText);
                                            return false;
                                        }
                                    }
                                });
                            }
                        });
                    }
                }
            });
        });
    }else{
        //确定修改头像
        var uploader = new plupload.Uploader({                     //实例化一个plupload上传对象
            browse_button: 'btnUpload',                            //触发文件选择对话框的按钮，为那个元素id
            url: dataValue.webRoot + '/member/uploadUserIco.json',   //服务器端的上传页面地址
            flash_swf_url: dataValue.webRoot + '/template/green/statics/js/plupload/Moxie.swf',       //swf文件，当需要使用swf方式进行上传时需要配置该参数
            silverlight_xap_url: dataValue.webRoot + '/template/green/statics/js/plupload/Moxie.xap',// silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
            filters: [
                {title: "image", extensions: "jpg,jpeg,gif,png"}
            ]
        });
        uploader.init();                                            //在实例对象上调用init()方法进行初始化
        uploader.bind('FilesAdded', function (loader, files) {   //绑定各种事件，并在事件监听函数中做你想做的事
            loader.start();                                        //调用实例对象的start()方法开始上传文件，当然你也可以在其他地方调用该方法
        });
        uploader.bind('FileUploaded', function (up, file, res) {//上传完成后执行
            var res = $.parseJSON(res.response);
            if (res.success) {
                showTips("修改头像成功");
                setTimeout(function(){
                    window.location.reload();
                },1000);
            }
        });
    }
});

/*自定义弹出框*/
function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 1000);
}