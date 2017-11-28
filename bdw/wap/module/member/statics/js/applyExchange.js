/**
 * Created by chencheng on 2017/10/26.
 */
var uploader;//上传控件
$(function () {
    //初始化上传事件
    initUpload();

    //显示收货地址列表
    $("#receiverAddr").click(function () {
        $(".address-layer").show();
    });

    //切换选中地址
    $("#addrList").find("a").click(function () {
        $("#addrList").find("a").removeClass('selected');
       $(this).addClass("selected");
    });

    //确认选择地址
    $("#selectingAddr").click(function () {
        var $selectedAddr = $("#addrList").find('.selected');
        var addrNm = $selectedAddr.find('.addrNm').html();
        var addrMobile = $selectedAddr.find('.addrMobile').html();
        var addrStr = $selectedAddr.find('.addrStr').html();

        $("#name").html(addrNm);
        $("#tel").html(addrMobile);
        $("#receiverAddr").html(addrStr);

        $(".address-layer").hide();
    });

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
    $("#exchangeNum").change(function () {
        var exchangeNum = $(this).val();
        var canExchangeNum = applyExchangeData.canExchangeNum;
        if (isNaN(exchangeNum)){
            exchangeNum = canExchangeNum;
        }else {
            exchangeNum = parseInt(exchangeNum);
        }

        if (exchangeNum <= 1){
            exchangeNum = 1;
        }
        if (exchangeNum >= canExchangeNum) {
            exchangeNum = canExchangeNum;
        }

        if (exchangeNum > 1){
            $("#exchangeNum_subtract").removeClass('no-click')
        }else {
            $("#exchangeNum_subtract").addClass('no-click');
        }
        if (exchangeNum < canExchangeNum){
            $("#exchangeNum_add").removeClass('no-click')
        }else {
            $("#exchangeNum_add").addClass('no-click');
        }

        $(this).val(exchangeNum);
    });

    //减换货数量
    $("#exchangeNum_subtract").click(function () {
        var canExchangeNum = applyExchangeData.canExchangeNum;
        var exchangeNum = $("#exchangeNum").val();
        if (isNaN(exchangeNum)){
            exchangeNum = canExchangeNum;
        }else {
            exchangeNum = parseInt(exchangeNum);
        }

        exchangeNum--;//数量减
        if (exchangeNum <= 1){
            exchangeNum = 1;
        }
        if (exchangeNum > 1){
            $("#exchangeNum_subtract").removeClass('no-click')
        }else {
            $("#exchangeNum_subtract").addClass('no-click');
        }
        if (exchangeNum < canExchangeNum){
            $("#exchangeNum_add").removeClass('no-click')
        }else {
            $("#exchangeNum_add").addClass('no-click');
        }
        $("#exchangeNum").val(exchangeNum);

    });

    //加换货数量
    $("#exchangeNum_add").click(function () {
        var canExchangeNum = applyExchangeData.canExchangeNum;
        var exchangeNum = $("#exchangeNum").val();
        if (isNaN(exchangeNum)){
            exchangeNum = canExchangeNum;
        }else {
            exchangeNum = parseInt(exchangeNum);
        }

        exchangeNum++;//数量加
        if (exchangeNum >= canExchangeNum) {
            exchangeNum = canExchangeNum;
        }
        if (exchangeNum > 1){
            $("#exchangeNum_subtract").removeClass('no-click')
        }else {
            $("#exchangeNum_subtract").addClass('no-click');
        }
        if (exchangeNum < canExchangeNum){
            $("#exchangeNum_add").removeClass('no-click')
        }else {
            $("#exchangeNum_add").addClass('no-click');
        }
        $("#exchangeNum").val(exchangeNum);
    });

    //发起申请
    $("#applyExchange").click(function () {
        var value = getValue();
        if (value) {
            doApplyExchange(value);
        }
        // console.log(getValue())
    });

});

function initUpload() {
    uploader = new plupload.Uploader({
        browse_button:'uploadPhoto',
        url: applyExchangeData.webRoot + '/member/uploadPhotoImg.json',
        flash_swf_url: applyExchangeData.webRoot + '/template/bdw/statics/js/plupload/Moxie.swf',
        silverlight_xap_url: applyExchangeData.webRoot + '/template/bdw/statics/js/plupload/Moxie.xap',
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
    var quantity = $("#exchangeNum").val();
    if (!quantity || isNaN(quantity) || quantity < 1){
        alert('请输入正确的换货数量');
        return null;
    }

    var name = $.trim($("#name").html());
    var tel = $.trim($("#tel").html());
    var receiverAddr = $.trim($("#receiverAddr").html());
    if (!name || !tel || !receiverAddr){
        alert('请选择换货收货地址');
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
            orderItemId: applyExchangeData.orderItemId,
            quantity: quantity,
            combinedProductId: applyExchangeData.combinedProductId > 0 ? applyExchangeData.combinedProductId : null
        }
    ];

    var data = {
        orderId: applyExchangeData.orderId,
        name:name,
        tel: tel,
        descr: descr,
        typeCode: 0,//0-换货、1-退货
        receiverAddr: receiverAddr,
        photoFileId: photoFileId,
        orderItems: items
    };

    return data;
}

function doApplyExchange(postData){
    $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
    $.ajax({
        type: "POST",
        url: applyExchangeData.webRoot + "/afterSale/add.json",
        data: JSON.stringify(postData),
        async: false,
        success: function (resutl) {
            if (resutl && resutl.errorCode && resutl.errorCode === "errors.comment.notOrder") {
                alert("您的订单尚未完成，请完成后再申请！");
                return;
            }
            if (resutl && resutl.success && resutl.success === 'true') {
                setTimeout(function(){window.location.href = applyExchangeData.webRoot+'/wap/module/member/exchangeList.ac'},1)
            }
        },
        error:function (result) {
            var errorObject = eval("("+result.responseText+")");
            alert(errorObject.errorObject.errorText)
        }
    });
}

