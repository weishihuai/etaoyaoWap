/**
 * 商家入驻流程2
 * Created by chencheng on 2017/6/30.
 */

var shipperAddrSelect;//仓库地址选择器
var WAN_YUAN = '万元';

$(document).ready(function () {
    initData();//初始化数据
    addListener();//初始化事件
    binUploader();//上传绑定

});

//初始化数据
function initData() {
    //仓库地址
    shipperAddrSelect = loadShipperAddr();
    var shipperAddrZoneId = getByLocalStorage("shopRegisterData.shipperAddr.zoneId");
    if (shipperAddrZoneId){
        $("#shipperAddrZoneId").val(shipperAddrZoneId);
        setShipperAddrNm(shipperAddrZoneId);
    }
    var shipperAddrDetail = getByLocalStorage("shopRegisterData.shipperAddr.addr");
    if (shipperAddrDetail){
        $("#shipperAddrDetail").val(shipperAddrDetail);
    }

    //商家基本资料
    var shopInf = getByLocalStorage("shopRegisterData.shopInf");
    if (shopInf){
        for(var key in shopInf){
            $("#"+key).val(shopInf[key]);
        }
    }
    // 注册资金
    var regCapital = getByLocalStorage("shopRegisterData.shopInf.regCapital");
    if (regCapital) {
        $("#regCapital").val(regCapital + WAN_YUAN);
    }
    //发票类型
    var invoiceType = getByLocalStorage("shopRegisterData.shopInf.invoiceType");
    if (invoiceType){
        setInvoiceType(invoiceType);
    }else {
        setInvoiceType(0)
    }

    //资质列表
    var licenses = getByLocalStorage("shopRegisterData.licenses");
    if (licenses){
        for(var i=0; i < licenses.length; i++){
            var license = licenses[i];
            var itemId = license.licenseNo;

            $("#"+itemId+"_Num").val(license.qualificationNum);
            $("#"+itemId+"_startDateString").val(license.startDateString);
            $("#"+itemId+"_endDateString").val(license.endDateString);
            if (license.isLongtime && license.isLongtime === 'Y'){
                isLongTime(itemId,'Y');
            }

            if (!license.fileId || !license.fileUrl){
                continue;
            }
            var fileIds = license.fileId.split(",");
            var fileUrls = license.fileUrl.split(",");
            for (var j=0; j < fileIds.length ; j++){
                addPicBeforeUploadBtn(itemId+"_upload", fileIds[j], fileUrls[j]);
            }
        }
    }

    //经营范围
    var businessRangeIds = getByLocalStorage("shopRegisterData.shopInf.businessRange");
    if (businessRangeIds ){
        $("#businessRange").find("input[type=checkbox]").removeAttr('checked');
        var ids = businessRangeIds.split(',');
        for (var i = 0 ; i < ids.length ; i++) {
            $("#businessRange_"+ids[i]).attr('checked',true);
        }
        loadLicense(businessRangeIds);//加载资质列表
    }


}

//初始化事件
function addListener() {
    //下一步
    $("#btnNext").click(function () {
        if (checkShopInf() === true) {
            window.location.href = webPath.webRoot+"/shop/register/registerShopStep03.ac";
        }
    });

    //选择经营范围
    $("#businessRange").find("input[type=checkbox]").click(function () {
        if (checkBusinessRange()) {
            loadLicense(getByLocalStorage("shopRegisterData.shopInf.businessRange"));
        }
    });

    //检查店铺名称
    $("#shopNm").blur(function () {
        checkShopNm();
    });

    //检查企业类型
    $("#customerTypeId").change(function () {
        if (checkCustomerTypeId()){
            loadLicense(getByLocalStorage("shopRegisterData.shopInf.businessRange"));
        }
    });

    //检查企业全称
    $("#companyNm").blur(function () {
        checkCompanyNm();
    });

    //检查法定代表人
    $("#legalPerson").blur(function () {
        checkLegalPerson();
    });

    //检查注册资金
    $("#regCapital").blur(function () {
        checkRegCapital();
    }).focus(function () {
        var $regCapital = $("#regCapital");
        var regCapital = $.trim($regCapital.val());
        if (regCapital.lastIndexOf(WAN_YUAN) >= 0){//输入时需要去掉万元
            regCapital = regCapital.substring(0,regCapital.lastIndexOf(WAN_YUAN));
        }
        $regCapital.val(regCapital);
    });

    //检查企业经营地址
    $("#regAddr").blur(function () {
        checkRegAddr();
    });

    //检查是否有实体店
    $("#isOffLineShop").change(function () {
        checkIsOffLineShop();
    });

    //检查仓库发货地址区域
    $(".shipperAddrSelect").change(function () {
        $("#shipperAddrZoneId").val($(this).val());
        checkShipperAddrZoneId();
    });

    //检查仓库发货详细地址
    $("#shipperAddrDetail").blur(function () {
        checkShipperAddrDetail();
    });

    //检查运营负责人
    $("#companyContactCeo").blur(function () {
        checkCompanyContactCeo();
    });

    //检查运营负责人手机
    $("#companyContactPhone").blur(function () {
        checkCompanyContactPhone();
    });

    //检查运营负责人邮箱
    $("#companyContactEmail").blur(function () {
        checkCompanyContactEmail();
    });

    //检查运营负责人邮箱
    $("#companyContactWeChat").blur(function () {
        checkCompanyContactWeChat();
    });

    //检查运营负责人QQ
    $("#companyContactQQ").blur(function () {
        checkCompanyContactQQ();
    });

    //检查企业负责人
    $("#companyCeo").blur(function () {
        checkCompanyCeo();
    });

    //检查企业负责人手机
    $("#ceoMobile").blur(function () {
        checkCeoMobile();
    });

    //检查质量负责人
    $("#qualityManagement").blur(function () {
        checkQualityManagement();
    });

    //检查质量负责人手机
    $("#qualityManagementMobile").blur(function () {
        checkQualityManagementMobile();
    });

    //检查开户银行
    $("#clearingBank").blur(function () {
        checkClearingBank();
    });

    //检查银行户名
    $("#clearingBankAccountName").blur(function () {
        checkClearingBankAccountName();
    });

    //检查银行卡号
    $("#clearingBankAccount").blur(function () {
        checkClearingBankAccount();
    });

    //检查支行名称
    $("#branchName").blur(function () {
        checkBranchName();
    });

    //检查发票抬头
    $("#invoiceTitle").blur(function () {
        checkInvoiceTitle();
    });

    //检查发票税号
    $("#invoiceNumber").blur(function () {
        checkInvoiceNumber();
    });

    //检查发票地址
    $("#invoiceAddress").blur(function () {
        checkInvoiceAddress();
    });

    //检查发票电话
    $("#invoicePhone").blur(function () {
        checkInvoicePhone();
    });

    //检查发票开户银行
    $("#invoiceBank").blur(function () {
        checkInvoiceBank();
    });

    //检查发票银行账户
    $("#invoiceBankCode").blur(function () {
        checkInvoiceBankCode();
    });

    //检查资质列表
    $(".licenseFile ").click(function () {
        checkLicense();
    });

    //是否长期
    $("#BusinessLicenseCertificate_isLongTime").click(function () {
        if ($(this).is(':checked')) {
            isLongTime('BusinessLicenseCertificate','Y');
        }else {
            isLongTime('BusinessLicenseCertificate','N');
        }
    });
}


//是否三证合一
function isThreeInOne(flag) {
    var $TaxRegistrationCertificate = $("#TaxRegistrationCertificate");
    var $OrganizationCodeCertificate = $("#OrganizationCodeCertificate");
    if (flag === 'Y') {
        $TaxRegistrationCertificate.hide();
        $OrganizationCodeCertificate.hide();
        $("#isThreeInOne_N").removeAttr('checked');
        $("#isThreeInOne_Y").attr('checked',true);
        putToLocalStorage("shopRegisterData.isThreeInOne", 'Y')
    } else {
        if ($TaxRegistrationCertificate.hasClass('isNeed')){
            $TaxRegistrationCertificate.show();
        }
        if ($OrganizationCodeCertificate.hasClass('isNeed')){
            $OrganizationCodeCertificate.show();
        }
        $("#isThreeInOne_Y").removeAttr('checked');
        $("#isThreeInOne_N").attr('checked',true);
        putToLocalStorage("shopRegisterData.isThreeInOne", 'N')
    }
}

function setInvoiceType(invoiceType) {
    if (invoiceType && invoiceType == 1){
        $("#invoiceType_vat").attr('checked',true);
        $("#invoiceType_normal").removeAttr('checked');
        $("#invoiceBankItem").show();
        $("#invoiceBankCodeItem").show();
        putToLocalStorage("shopRegisterData.shopInf.invoiceType",1);
    }else{
        $("#invoiceType_normal").attr('checked',true);
        $("#invoiceType_vat").removeAttr('checked');
        $("#invoiceBankItem").hide();
        $("#invoiceBankCodeItem").hide();
        putToLocalStorage("shopRegisterData.shopInf.invoiceType",0);
    }
}

//是否长期
function isLongTime(licenseNo, isLongTime) {
    var $isLongTime = $("#"+licenseNo+"_isLongTime");
    var $endDateString = $("#"+licenseNo+"_endDateString");
    var $longTime = $("#"+licenseNo+"_longTime");
    if (isLongTime === 'Y'){
        $isLongTime.attr('checked',true);
        $endDateString.removeClass('isNeed');
        $endDateString.hide();
        $longTime.show();
    }else {
        $isLongTime.removeAttr('checked');
        $endDateString.addClass('isNeed');
        $endDateString.show();
        $longTime.hide();
    }
}

//根据选择的经营范围显示相应的资质填写框
function loadLicense(businessRangeIds) {
    checkCustomerTypeId();
    var customerTypeId = getByLocalStorage("shopRegisterData.shopInf.customerTypeId");

    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/shop/sysShopInfFront/listLicenseByBusinessRangeIds.json",
        data: {customerTypeId:customerTypeId, businessRangeIds: businessRangeIds},
        async:false,//同步
        success: function (data) {
            if (data.success === "true") {
               if (data.result && data.result.length > 0){
                   var licenses = data.result;
                   //显示相关资质填写框
                   $(".licenseFile").removeClass('isNeed').hide();
                   $("#licenseType").hide();
                   for (var i= 0, len = licenses.length; i < len; i++){
                       $("#"+licenses[i].licenseNo).addClass('isNeed').show();//给每个必填的资质添加isNeed类
                       if (licenses[i].licenseNo === 'BusinessLicenseCertificate'){//如果包含营业执照，需要显示三证合一单选按钮
                           $("#licenseType").show();
                       }
                   }
               }
            }
        },
        error: errorFun
    });

    //三证合一
    var threeInOne = getByLocalStorage("shopRegisterData.isThreeInOne");
    if (threeInOne){
        isThreeInOne(threeInOne);
    }else {
        isThreeInOne('N');//默认不是三证合一
    }
}

//初始化仓库地址
function loadShipperAddr() {
    return  $(".shipperAddrSelect").ld({ajaxOptions : {"url" : webPath.webRoot+"/member/addressBook.json"},
        defaultParentId:9,style:{"width": 100}
    });
}

//设置地区名称
function setShipperAddrNm(zoneId) {
    $.ajax({
        type:"post" ,url:webPath.webRoot+"/common/zoneNm.json",
        data:{zoneId:zoneId},
        dataType:"json",
        success:function(data) {
            if (data) {
                var defaultValue = [data.provinceNm, data.cityNm, data.zoneNm];
                shipperAddrSelect.ld("api").selected(defaultValue);
            }
        }
    })
}

//绑定图片上传事件
function binUploader() {
    $(".licenseFile").each(function (index, item) {
       var itemId = $(item).attr("id");
        binUploaderToBtn(itemId+"_upload");
    });
}

//添加图片并绑定重新上传事件
function addPicBeforeUploadBtn(uploadBtnId, fileId, fileUrl){
    var $btnUpload = $("#"+uploadBtnId);
    var html = '<div class="pic" ><img src="'+fileUrl+'" alt="" fileId="'+fileId+'" ><a href="javascript:;" class="reappear" onclick="deleteImg(this)">删除</a> </div>';
    $btnUpload.html("继续上传");
    $btnUpload.parent().before(html);//往上传按钮前面添加一个图片
    var $reUpload = $btnUpload.parent().prev().find('.reappear');
    var $img = $btnUpload.parent().prev().find('img');
    /*binReUploaderToBtn($reUpload[0]);//绑定重新上传事件*/
    $img.click(function () {
        showImg($(this).attr('fileId'));
    })
}

function deleteImg(obj) {
    var $img = $(obj).parent().find("img")[0];
    $img.remove();
    var $divs = $(obj).parent().parent().find("div");
    if($divs.size() == 3){
        $divs.find("a").html("点击上传")
    }
    $(obj).parent().remove();

}

//绑定上传事件到按钮
function binUploaderToBtn(buttonId){
    var uploader = new plupload.Uploader({
        browse_button: buttonId,                                   //触发文件选择对话框的按钮的ID
        url: webPath.webRoot + '/member/uploadPhotoImg.json',             //服务器端的上传页面地址
        flash_swf_url: webPath.webRoot + '/template/default/statics/js/plupload/Moxie.swf',       //swf文件，当需要使用swf方式进行上传时需要配置该参数
        silverlight_xap_url: webPath.webRoot + '/template/default/statics/js/plupload/Moxie.xap',//silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
        filters: [
            {title: "image", extensions: "jpg,jpeg,gif,png"}
        ]
    });
    uploader.init();  //初始化

    //文件添加到上传队列后
    uploader.bind('FilesAdded', function (loader, files) {
        loader.start(); //开始上传文件
    });

    //某个文件准备开始上传
    uploader.bind('BeforeUpload', function (uploader,file,responseObject) {
        beforeUpload(buttonId,file);
    });

    //某个文件的上传进度
    uploader.bind('UploadProgress', function (uploader,file) {
        showUploadProgress(file);
    });

    //上传完成后执行
    uploader.bind('FileUploaded', function (up, file, res) {
        var result = $.parseJSON(res.response);
        if (result.success) {
            fileUploaded(file, result);
        }
    });

    //上传错误执行
    uploader.bind('Error', function (up, file, res) {
        var result = $.parseJSON(res.response);
        if(result.errorObject && result.errorObject.errorText){
            showErrorWin(result.errorObject.errorText);
        }
    });
}

//准备上传
function beforeUpload(uploadBtnId,file){
    var $btnUpload = $("#"+uploadBtnId);
    var html = '<div class="pic" ><img src="" alt="" fileId="" id="'+file.id+'"><a href="javascript:;" onclick="deleteImg(this)"class="reappear"></a></div>';
    $btnUpload.html("继续上传");
    $btnUpload.parent().before(html);//往上传按钮前面添加一个图片
}

//显示上传进度
function showUploadProgress(file) {
    var reappears = $("#"+file.id).parent().find(".reappear");
    if (reappears.length > 0){
        $(reappears[0]).html(file.percent+"%");
    }
}

//上传完成
function fileUploaded(file, result) {
    var $img = $("#"+file.id);
    if ($img.length > 0){
        $img.attr('src',result.url).attr('fileId', result.fileId);
        $img.click(function () {
            showImg($img.attr("fileId"));
        });

        var reappears = $("#"+file.id).parent().find(".reappear");
        if (reappears.length > 0){
            $(reappears[0]).html("删除");
        }
       /* binReUploaderToBtn(reappears[0]);*/
    }
    checkLicense();//资质验证
}
/*
//绑定重新上传事件到按钮
function binReUploaderToBtn(buttonObject){
    var uploader = new plupload.Uploader({
        browse_button: buttonObject,                                   //触发文件选择对话框的按钮的ID
        url: webPath.webRoot + '/member/uploadPhotoImg.json',             //服务器端的上传页面地址
        flash_swf_url: webPath.webRoot + '/template/default/statics/js/plupload/Moxie.swf',       //swf文件，当需要使用swf方式进行上传时需要配置该参数
        silverlight_xap_url: webPath.webRoot + '/template/default/statics/js/plupload/Moxie.xap',//silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
        filters: [
            {title: "image", extensions: "jpg,jpeg,gif,png"}
        ]
    });
    uploader.init();  //初始化

    uploader.bind('FilesAdded', function (loader, files) {
        loader.start(); //开始上传文件
    });

    //某个文件准备开始上传
    uploader.bind('BeforeUpload', function (uploader,file,responseObject) {
        var $btnUpload = $(buttonObject);
        $btnUpload.siblings('img').attr('id',file.id);
    });

    //某个文件的上传进度
    uploader.bind('UploadProgress', function (uploader,file) {
        showUploadProgress(file);
    });

    //上传完成后执行
    uploader.bind('FileUploaded', function (up, file, res) {
        var result = $.parseJSON(res.response);
        if (result.success) {
            var $btnUpload = $(buttonObject);
            $btnUpload.siblings('img').attr('src',result.url).attr('fileId',result.fileId);
            $btnUpload.html("重新上传");
        }
        checkLicense();//资质验证
    });

    //上传错误执行
    uploader.bind('Error', function (up, file, res) {
        var result = $.parseJSON(res.response);
        if(result.errorObject && result.errorObject.errorText){
            showErrorWin(result.errorObject.errorText);
        }
    });
}*/

function showImg(fileId) {
    window.open(webPath.webRoot+"/upload/"+fileId);
}














