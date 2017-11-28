/**
 * Created by chencheng on 2017/10/30.
 */
var uploader;//上传控件
$(function () {
    //初始化上传事件
    initUpload();

    //问题描述
    $("#descr").keyup(function () {
        var value = $.trim($(this).val());
        if (value.length >= 120){
            value = value.substring(0,120);
            $("#descriptionNum").html(value.length + "/120").addClass('orange');
        }else {
            $("#descriptionNum").html(value.length + "/120").removeClass('orange');
        }
        $(this).val(value);
    });

    //换货数量改变
    $("#returnNum").change(function () {
        var returnNum = $(this).val();
        var canReturnNum = applyReturnData.canReturnNum;
        if (isNaN(returnNum)){
            returnNum = canReturnNum;
        }else {
            returnNum = parseInt(returnNum);
        }

        if (returnNum <= 1){
            returnNum = 1;
        }
        if (returnNum >= canReturnNum) {
            returnNum = canReturnNum;
        }

        if (returnNum > 1){
            $("#returnNum_subtract").removeClass('no-click')
        }else {
            $("#returnNum_subtract").addClass('no-click');
        }
        if (returnNum < canReturnNum){
            $("#returnNum_add").removeClass('no-click')
        }else {
            $("#returnNum_add").addClass('no-click');
        }

        $(this).val(returnNum);
    });

    //减换货数量
    $("#returnNum_subtract").click(function () {
        var canReturnNum = applyReturnData.canReturnNum;
        var returnNum = $("#returnNum").val();
        if (isNaN(returnNum)){
            returnNum = canReturnNum;
        }else {
            returnNum = parseInt(returnNum);
        }

        returnNum--;//数量减
        if (returnNum <= 1){
            returnNum = 1;
        }
        if (returnNum > 1){
            $("#returnNum_subtract").removeClass('no-click')
        }else {
            $("#returnNum_subtract").addClass('no-click');
        }
        if (returnNum < canReturnNum){
            $("#returnNum_add").removeClass('no-click')
        }else {
            $("#returnNum_add").addClass('no-click');
        }
        $("#returnNum").val(returnNum);

    });

    //加换货数量
    $("#returnNum_add").click(function () {
        var canReturnNum = applyReturnData.canReturnNum;
        var returnNum = $("#returnNum").val();
        if (isNaN(returnNum)){
            returnNum = canReturnNum;
        }else {
            returnNum = parseInt(returnNum);
        }

        returnNum++;//数量加
        if (returnNum >= canReturnNum) {
            returnNum = canReturnNum;
        }
        if (returnNum > 1){
            $("#returnNum_subtract").removeClass('no-click')
        }else {
            $("#returnNum_subtract").addClass('no-click');
        }
        if (returnNum < canReturnNum){
            $("#returnNum_add").removeClass('no-click')
        }else {
            $("#returnNum_add").addClass('no-click');
        }
        $("#returnNum").val(returnNum);
    });

    //发起申请
    $("#applyReturn").click(function () {
        var value = getValue();
        if (value) {
            doApplyReturn(value);
        }
        // console.log(getValue())
    });

});

function initUpload() {
    uploader = new plupload.Uploader({
        browse_button:'uploadPhoto',
        url: applyReturnData.webRoot + '/member/uploadPhotoImg.json',
        flash_swf_url: applyReturnData.webRoot + '/template/bdw/statics/js/plupload/Moxie.swf',
        silverlight_xap_url: applyReturnData.webRoot + '/template/bdw/statics/js/plupload/Moxie.xap',
        filters:[
            {title:'image',extensions:'jpg,jpeg,gif,png'}
        ]
    });
    //初始化
    uploader.init();

    //文件添加到上传队列后
    uploader.bind('FilesAdded', function (loader, files) {
        loader.start();
    });

    //某个文件准备开始上传
    uploader.bind('BeforeUpload', function (uploader,file,responseObject) {
        $("#uploadPhoto").hide();
        $("#photoFileId").show();
        window.uploader.refresh();
    });

    //某个文件的上传进度
    uploader.bind('UploadProgress', function (uploader,file) {
        var $photoFileId = $("#photoFileId");
        $photoFileId.find('.percent').html(file.percent+"%").show();
        $photoFileId.find('.del-btn').hide();
    });

    //上传完成后执行
    uploader.bind('FileUploaded', function (up, file, res) {
        var result = $.parseJSON(res.response);
        if (result.success) {
            var $photoFileId = $("#photoFileId");
            $photoFileId.find('img').attr('src',result.url);
            $photoFileId.attr('data-fileid',result.fileId);
            $photoFileId.find('.percent').hide();
            $photoFileId.find('.del-btn').show();
        }
        window.uploader.refresh();
    });

    //上传错误执行
    uploader.bind('Error', function (up, file, res) {
        var result = $.parseJSON(res.response);
        if(result.errorObject && result.errorObject.errorText){
            alert(result.errorObject.errorText);
        }
    });


    //删除上传图片
    $("#photoFileId").find('.del-btn').click(function () {
        var $photoFileId = $("#photoFileId");
        $photoFileId.hide();
        $("#uploadPhoto").show();
        window.uploader.refresh();
        $photoFileId.find('img').attr('src',"");
        $photoFileId.attr('data-fileid',"");
        $photoFileId.find('.percent').hide();
        $photoFileId.find('.del-btn').hide();
    });
}

function getValue() {
    var quantity = $("#returnNum").val();
    if (!quantity || isNaN(quantity) || quantity < 1){
        alert('请输入正确的退货数量');
        return null;
    }

    var name = $.trim($("#name").html());
    if (!name){
        alert('请填写联系人姓名');
        return null;
    }
    var tel = $.trim($("#tel").html());
    if (!tel){
        alert('请填写联系手机号码');
        return null;
    }
    var descr = $.trim($("#descr").val());
    if (!descr || descr.length < 5){
        alert('问题描述最少5个字');
        return null;
    }

    var photoFileId = $.trim($("#photoFileId").attr('data-fileid'));

    var items = [
        {
            orderItemId: applyReturnData.orderItemId,
            quantity: quantity,
            combinedProductId: applyReturnData.combinedProductId > 0 ? applyReturnData.combinedProductId : null
        }
    ];

    var data = {
        orderId: applyReturnData.orderId,
        name:name,
        tel: tel,
        descr: descr,
        typeCode: 1,//0-换货、1-退货
        photoFileId: photoFileId,
        orderItems: items
    };

    return data;
}

function doApplyReturn(postData){
    $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
    $.ajax({
        type: "POST",
        url: applyReturnData.webRoot + "/afterSale/add.json",
        data: JSON.stringify(postData),
        async: false,
        success: function (resutl) {
            if (resutl && resutl.errorCode && resutl.errorCode === "errors.comment.notOrder") {
                alert("您的订单尚未完成，请完成后再申请！");
                return;
            }
            if (resutl && resutl.success && resutl.success === 'true') {
                setTimeout(function(){window.location.href = applyReturnData.webRoot+'/wap/module/member/returnList.ac'},1)
            }
        },
        error:function (result) {
            var errorObject = eval("("+result.responseText+")");
            alert(errorObject.errorObject.errorText)
        }
    });
}

