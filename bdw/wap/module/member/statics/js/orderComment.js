$(document).ready(function () {
    //星星评价
    $(".dd-item").find("span").click(function () {
        var obj = $(this);
        obj.addClass("s");
        obj.prevAll("span").addClass("s");
        obj.nextAll("span").removeClass("s");

    });
    // 改变评价内容
    $(".addCommentTextArea").keyup(function () {
        var len = $.trim($(this).val()).length;
        var commentLength = $(this).siblings("span");
        if (len > 250) {
            $(this).val($(this).val().substring(0, 250));
            commentLength.text("250/250");
        } else {
            // commentTextArea.val(commentLengthConst);
            commentLength.text(len + "/250");
        }
    });


});
function removePic(obj) {

    var fileId = $(obj).find("img").attr("fileid");
    var fileIds = $(obj).parent().find('input').val();
    var fileIdList=fileIds.split(","); //字符分割
    if(fileIdList.indexOf(fileId)!=-1){
        $.each(fileIdList,function(index,item){
            // index是索引值（即下标）   item是每次遍历得到的值；
            if(item==fileId){
                fileIdList.splice(index,1);
            }
        });
    }
    $(obj).parent().find('input').first().val(fileIdList.join(","));
    $('.add-pic-btn').css('display', 'block');
    $(obj).remove();
}



$(function () {

    $('.add-pic-btn').each(function () {
        var serverIdArray = null;
        var _this = $(this);
        var _file = _this.prev('input');
        if (webPath.isWeixin == 'Y') {//微信端
            $('#' + $(_this).attr('id')).click(function () {
                wx.chooseImage({
                    count: 5, // 默认9
                    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
                    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
                    success: function (res) {

                        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
                        if (!isEmpty(localIds)) {
                            var len = localIds.length;
                            serverIdArray = new Array(len);
                            var oldLen = _this.parent().find('.pic-item').length;
                            var total = len + oldLen;
                            if (total > 5) {
                                alert("最多上传5张图片");
                                return;
                            }
                            if (total == 5) {
                                $('.add-pic-btn').css('display', 'none');
                            }

                            for(var i=0;i<len;i++){


                                wx.uploadImage({
                                    localId: localIds[i], // 需要上传的图片的本地ID，由chooseImage接口获得
                                    isShowProgressTips: 1, // 默认为1，显示进度提示
                                    success: function (res) {

                                        $.ajax({
                                            type: "POST",
                                            url: webPath.webRoot + "/member/uploadFromWeixin.json",
                                            data: {'mediaId': res.serverId},
                                            dataType: 'json',
                                            success: function (msg) {
                                                if (msg.success == 'true') {
                                                    var imgUrl = msg.sourceUrl;
                                                    var fileId = msg.fileId;

                                                    if (_file.val().length == 0) {
                                                        _file.val(fileId);
                                                    } else {
                                                        _file.val(_file.val() + ',' + fileId);
                                                    }
                                                    var html = "<div class='pic-item' style=' z-index: 2;' onclick='removePic(this)'>" +
                                                        "<img fileid='" +
                                                        fileId +
                                                        "' src='" +
                                                        imgUrl +
                                                        "' ></div>";
                                                    _this.before(html);
                                                } else {

                                                }
                                            },
                                            error: function (XMLHttpRequest, textStatus) {
                                                if (XMLHttpRequest.status == 500) {
                                                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                                                    alert(result.errorObject.errorText);
                                                    return false;
                                                }
                                            }
                                        });
                                    }
                                });
                            }

                        }
                    }
                });
            });
        } else {
            var uploader = new plupload.Uploader({                          //实例化一个plupload上传对象
                browse_button: $(this).attr('id'),                                //触发文件选择对话框的按钮，为那个元素id
                url: webPath.webRoot + '/member/uploadPhotoImg.ac',   //服务器端的上传页面地址
                flash_swf_url: webPath.webRoot + '/template/green/statics/js/plupload/Moxie.swf',       //swf文件，当需要使用swf方式进行上传时需要配置该参数
                silverlight_xap_url: webPath.webRoot + '/template/green/statics/js/plupload/Moxie.xap',// silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
                filters: [
                    {title: "image", extensions: "jpg,jpeg,gif,png"}
                ]
            });
            uploader.init();                                            //在实例对象上调用init()方法进行初始化
            uploader.bind('FilesAdded', function (loader, files) {   //绑定各种事件，并在事件监听函数中做你想做的事
                var len = _this.parent().find('.pic-item').length;
                var total = len + files.length;
                if (total > 5) {
                    uploader.splice();
                    alert("最多上传5张图片");
                    return;
                }
                if (total == 5) {
                    $('.add-pic-btn').css('display', 'none');
                }

                loader.start();                                          //调用实例对象的start()方法开始上传文件，当然你也可以在其他地方调用该方法
                showLoading(true);//显示正在加载中的遮罩层
            });
            uploader.bind('FileUploaded', function (up, file, res) {//上传完成后执行
                var res = $.parseJSON(res.response);
                if (res.success) {
                    showLoading(false);//隐藏遮罩层
                    if (_file.val().length == 0) {
                        _file.val(res.fileId);
                    } else {
                        _file.val(  _file.val() +','  +res.fileId);
                    }
                    var html = "<div class='pic-item' style=' z-index: 2;' onclick='removePic(this)'><img fileid='" +
                        res.fileId +
                        "' src='" +
                        res.url +
                        "' ></div>";
                    _this.before(html);
                }
            });
        }
    })

})


/**
 * 提交评论
 */
function submitComment(obj) {
    $(obj).attr('onclick', '');
    $(obj).css('background-color', '#C2C2C2');

    var orderId = $('#orderId').val();

    //商品评价
    var productArray = [];
    for (var i = 0; i < webPath.orderItemsNum; i++) {
        var productId = $('#productId_' + i).val();
        var commentGrade = $('#commentGrade_' + i + ' span.s').length;
        var commentCont = $('#addCommentTextArea_' + i).val() || "";
        var commentPictures = $('#commentPictList_' + i).val();

        var productDescrSame = $('#productDescrSame span.s').length;//宝贝相似度
        var sellerServiceAttitude = $('#sellerServiceAttitude span.s').length;//服务态度
        var sendOutSpeed = $('#sendOutSpeed span.s').length;//发货速度

        var ret = /^[1-9]\d*$/;

        if (!productId || !orderId) {
            alert("请刷新页面");
            $(obj).attr('onclick', 'submitComment(this)');
            $(obj).css('background-color', '#FF6B00');
            return;
        }

        if (!commentGrade || !ret.test(commentGrade) || commentGrade > 5 || commentGrade < 1) {
            alert("请您输入商品评分");
            $(obj).attr('onclick', 'submitComment(this)');
            $(obj).css('background-color', '#FF6B00');
            return;
        }

        if (commentCont.length < 5) {
            alert("您输入的内容太短了，请说多几句。");
            $(obj).attr('onclick', 'submitComment(this)');
            $(obj).css('background-color', '#FF6B00');
            return;
        }


        var productArr = {
            objectId: productId,
            gradeLevel: commentGrade,
            commentCont: commentCont,
            commentPictList: commentPictures,
        };

        productArray.push(productArr);
    }
    ;


    if (!productDescrSame || !ret.test(productDescrSame) || productDescrSame > 5 || productDescrSame < 1) {
        alert("请对宝贝相似度进行评分");
        $(obj).attr('onclick', 'submitComment(this)');
        $(obj).css('background-color', '#FF6B00');
        return;
    }
    if (!sellerServiceAttitude || !ret.test(sellerServiceAttitude) || sellerServiceAttitude > 5 || sellerServiceAttitude < 1) {
        alert("请对服务态度进行评分");
        $(obj).attr('onclick', 'submitComment(this)');
        $(obj).css('background-color', '#FF6B00');
        return;
    }
    if (!sendOutSpeed || !ret.test(sendOutSpeed) || sendOutSpeed > 5 || sendOutSpeed < 1) {
        alert("请对发货速度进行评分");
        $(obj).attr('onclick', 'submitComment(this)');
        $(obj).css('background-color', '#FF6B00');
        return;
    }

    //店铺评价
    var shopGrade = {
        productDescrSame: productDescrSame,//宝贝相似度
        sellerServiceAttitude: sellerServiceAttitude,//服务态度
        sendOutSpeed: sendOutSpeed,//发货速度
    };
    var newboj = {
        orderId: orderId,//订单id
        productDescrSame: productDescrSame,//宝贝相似度
        sellerServiceAttitude: sellerServiceAttitude,//服务态度
        sellerSendOutSpeed: sendOutSpeed,//发货速度
        sysCommentList: productArray
    };


    $.ajax({
        type: "POST",
        contentType: "application/json",
        data: _ObjectToJSON("post", newboj),
        url: webPath.webRoot + "/member/saveProductCommentAndShopRating.json",
        success: function (data) {
            alert("评价成功！");
            window.location.href=webPath.webRoot+"/wap/module/member/myOrders.ac?status="+webPath.status
        },
        error: function (XMLHttpRequest, textStatus) {
            $(obj).attr('onclick', 'submitComment(this)');
            $(obj).css('background-color', '#FF6B00');
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    })
}