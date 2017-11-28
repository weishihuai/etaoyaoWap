/**
 * 商家入驻流程2-表单验证方法集
 * Created by chencheng on 2017/6/30.
 */

$(document).ready(function () {

});



/*检查商家名称是否已被使用*/
function isShopNmUsed(theShopNm) {
    var isUsed = false;
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/shop/sysShopInfFront/checkShopNm.json",
        data: {shopNm: theShopNm},
        async: false,//同步
        success: function (data) {
            if (data.success === "true") {
                showSuccess("#shopNmTip");
            } else {
                showTip("#shopNmTip", "门店名称已被使用!");
                isUsed = true;
            }
        },
        error: errorFun
    });
    return isUsed;
}


/*检查用户选择的所属连锁企业ID与连锁企业名称是否匹配*/
function isOutletCompanyExist(outletCompanyId,outletCompanyNm) {
    var isExist = true;
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/shop/sysShopInfFront/checkOutletCompanyNm.json",
        data: {outletCompanyId: parseInt(outletCompanyId) , outletCompanyNm: outletCompanyNm},
        async: false,//同步
        success: function (data) {
            if (data.success === "true") {
                showSuccess("#outletCompanyNmTip");
            } else {
                showTip("#outletCompanyNmTip", "请选择所属连锁!");
                isExist = false;
            }
        },
        error: errorFun
    });
    return isExist;
}


//检查门店类型
var checkStoreType = function () {
    var storeType = $.trim($("#storeType").val());
    if (!storeType || isNaN(storeType)) {
        showTip("#storeTypeTip", "请选择门店类型!");
        return false;
    }
    checkStoreTypeMatch();
    showSuccess("#storeTypeTip");
    putToLocalStorage("outletRegisterData.shopInf.storeType", storeType);
    return true;
};

function checkStoreTypeMatch(){
    //0:连锁加盟 1:连锁自营  2: 单体自营
    if($("select#storeType").val() == '0' || $("select#storeType").val() == '1'){
        $(".cb-mc .mc-item").eq(1).show();
    }else if($("select#storeType").val() == '2'){
        $("#outletCompanyNm").val("");
        $("#outletCompanyNm").attr("outletCompanyId","");
        $(".cb-mc .mc-item").eq(1).hide();
        putToLocalStorage("outletRegisterData.shopInf.outletCompanyId", null);
        putToLocalStorage("outletRegisterData.shopInf.outletCompanyNm", null);
    }
}


//检查所属连锁
var checkOutletCompanyNm = function () {
    //0:连锁加盟 1:连锁自营  2: 单体自营
    if($("select#storeType").val() == '0' || $("select#storeType").val() == '1'){
        var outletCompanyNm = $.trim($("#outletCompanyNm").val());
        var outletCompanyId = $("#outletCompanyNm").attr("outletCompanyId");
        if (!outletCompanyNm || !outletCompanyId) {
            showTip("#outletCompanyNmTip", "请选择所属连锁!");
            return false;
        }
        if (!isOutletCompanyExist(outletCompanyId,outletCompanyNm)) {
            return false;
        }

        showSuccess("#outletCompanyNmTip");
        putToLocalStorage("outletRegisterData.shopInf.outletCompanyId", outletCompanyId);
        putToLocalStorage("outletRegisterData.shopInf.outletCompanyNm", outletCompanyNm);
    }
    return true;

};

//检查商家名称
var checkShopNm = function () {
    var shopNm = $.trim($("#shopNm").val());
    if (!shopNm) {
        showTip("#shopNmTip", "请输入门店全称!");
        return false;
    }
    if (shopNm.length < 2) {
        showTip("#shopNmTip", "门店全称不能少于两位!");
        return false;
    }
    if (isShopNmUsed(shopNm)) {
        return false;
    }

    showSuccess("#shopNmTip");
    putToLocalStorage("outletRegisterData.shopInf.shopNm", shopNm);
    return true;
};

//检查法定代表人
var checkLegalPerson = function () {
    var legalPerson = $.trim($("#legalPerson").val());
    var cat =  /^([\u4E00-\u9FA5]{1,8}·?[\u4E00-\u9FA5]{1,8})$/;
    if (!legalPerson) {
        showTip("#legalPersonTip", "请输入法定代表人!");
        return false;
    }
    if(!cat.test(legalPerson)){
        showTip("#legalPersonTip", "姓名格式不正确!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.legalPerson", legalPerson);
    showSuccess("#legalPersonTip");
    return true;
};

//检查注册资金
var checkRegCapital = function () {
    var $regCapital = $("#regCapital");
    var regCapital = $.trim($regCapital.val());
    if (regCapital.lastIndexOf(WAN_YUAN) >= 0){//验证时需要去掉万元
        regCapital = regCapital.substring(0,regCapital.lastIndexOf(WAN_YUAN));
    }
    var regex = /^[1-9]\d*$/;
    if (!regCapital) {
        showTip("#regCapitalTip", "请输入注册资金!");
        return false;
    }
    if (!regex.test(regCapital)) {
        showTip("#regCapitalTip", "注册资金只能填写正整数!");
        return false;
    }
    $regCapital.val(regCapital+WAN_YUAN);
    putToLocalStorage("outletRegisterData.shopInf.regCapital", regCapital);
    showSuccess("#regCapitalTip");
    return true;
};


//检查门店地址区域
var checkOutletAddrZoneId = function () {
    var outletAddrZoneId = $.trim($("#outletAddrZoneId").val());
    if (!outletAddrZoneId || isNaN(outletAddrZoneId)){
        showTip("#outletAddrZoneIdTip", "请选择地址地区");
        return false;
    }

    if(isExistChildren(outletAddrZoneId)){
        showTip("#outletAddrZoneIdTip", "请选择地址地区");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.zoneId", outletAddrZoneId);
    showSuccess("#outletAddrZoneIdTip");
    return true;
};

//地区是否含有子节点地区名称
function isExistChildren(zoneId) {
    var isExist = false;
    $.ajax({
        type:"post" ,url:webPath.webRoot+"/member/addressBook.json",
        data:{sysTreeNodeId:zoneId},
        dataType:"json",
        async: false,//同步
        success:function(data) {
            if (data) {
                var defaultValue = data.result;
                if(defaultValue.length > 0){
                    isExist = true;
                    if (defaultValue.length === 1 && (defaultValue[0].sysTreeNodeId === 0 || defaultValue[0].sysTreeNodeNm === '无')){
                        isExist = false;
                    }
                }
            }
        }
    });
    return isExist;
}

//检查仓库发货详细地址
var checkOutletAddr = function () {
    var contactAddr = $.trim($("#contactAddr").val());
    if (!contactAddr) {
        showTip("#contactAddrTip", "请输入详细地址!");
        return false;
    }
    if (contactAddr.length > 128) {
        showTip("#contactAddrTip", "地址最多输入128个字符!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.contactAddr", contactAddr);
    showSuccess("#contactAddrTip");
    return true;
};

//检查门店手机
var checkOutletMobile = function () {
    var mobile = $.trim($("#mobile").val());
    var strP = /^1[0-9]{10}$/;
    if (!mobile) {
        showTip("#mobileTip", "请输入门店手机!");
        return false;
    }
    if (!strP.test(mobile)) {
        showTip("#mobileTip", "手机号码格式错误!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.mobile", mobile);
    showSuccess("#mobileTip");
    return true;
};


var checkTelQu = function () {
    var dh_q = $.trim($("#dh_q").val());
    if (!dh_q) {
        showTelTpError('#dh_qTipError');
        showTip("#dh_qTip", "请输入电话号码!");
        return false;
    }
    if(!(/^0\d{2,3}$/.test(dh_q))){
        showTelTpError('#dh_qTipError');
        showTip("#dh_qTip", "电话号码格式错误!");
        return false;
    }
    showSuccess("#dh_qTip");
    return true;
};

var showTelTpError = function (obj) {
    $(obj).css("display","block");
    $(obj).siblings(".message").css("display","none");
};


var checkTelNum = function () {
    var dh_h = $.trim($("#dh_h").val());
    if (!dh_h) {
        showTelTpError('#dh_hTipError');
        showTip("#dh_hTip", "请输入电话号码!");
        return false;
    }
    if(!(/^[1-9]\d*$/.test(dh_h))){
        showTip("#dh_hTip", "电话号码格式错误!");
        showTelTpError('#dh_hTipError');
        return false;
    }
    showSuccess("#dh_hTip");
    return true;
};


var checkTelFen = function () {
    var dh_q = $.trim($("#dh_q").val());
    var dh_h = $.trim($("#dh_h").val());
    var dh_f = $.trim($("#dh_f").val());
    if (!dh_q) {
        showTelTpError('#dh_qTipError');
        showTip("#dh_qTip", "请输入电话号码!");
        return false;
    }
    if (!dh_h) {
        showTelTpError('#dh_qTipError');
        showTip("#df_fTip", "请输入电话号码!");
        return false;
    }
    var tel = dh_q+"-"+dh_h+"-"+dh_f;
    if(!dh_f){
        tel = dh_q+"-"+dh_h;
    }

    if(!(/^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$/.test(tel))&&dh_f!=""){
        showTelTpError('#dh_fTipError');
        showTip("#dh_fTip", "电话格式不正确！");
        return false;
    }
    showSuccess("#dh_fTip");
    putToLocalStorage("outletRegisterData.shopInf.tel", tel);
    return true;
};


//检查经营范围
var checkBusinessRange = function () {
    var businessRangeIds = '';
    var $businessRange= $("#businessRange");
    $businessRange.find("input[type=checkbox]:checked").each(function (index,item) {
        businessRangeIds += ','+item.value;
    });
    if (businessRangeIds.length > 0){
        businessRangeIds = businessRangeIds.substring(1);
    }
    if (!businessRangeIds) {
        //默认显示营业执照
        $(".licenseFile").removeClass('isNeed').hide();
        $(".licenseFile").eq(0).addClass('isNeed').show();
        showTip("#businessRangeTip", "请选择经营范围!");
        return false;
    }
    showSuccess("#businessRangeTip");
    $businessRange.css("border","");//不是输入框，需要手动去除border

    putToLocalStorage("outletRegisterData.shopInf.businessRange", businessRangeIds);
    return true;
};

//检查运营负责人
var checkCompanyContactCeo = function () {
    var companyContactCeo = $.trim($("#companyContactCeo").val());
    var res =  /^([\u4E00-\u9FA5]{1,8}·?[\u4E00-\u9FA5]{1,8})$/;
    if (!companyContactCeo) {
        showTip("#companyContactCeoTip", "请输入运营负责人!");
        return false;
    }
    if(!res.test(companyContactCeo)){
        showTip("#companyContactCeoTip", "姓名格式不正确!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.companyContactCeo", companyContactCeo);
    showSuccess("#companyContactCeoTip");
    return true;
};

//检查运营负责人手机
var checkCompanyContactPhone = function () {
    var companyContactPhone = $.trim($("#companyContactPhone").val());
    var strP = /^1[0-9]{10}$/;
    if (!companyContactPhone) {
        showTip("#companyContactPhoneTip", "请输入运营负责人手机!");
        return false;
    }
    if (!strP.test(companyContactPhone)) {
        showTip("#companyContactPhoneTip", "手机号码格式错误!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.companyContactPhone", companyContactPhone);
    showSuccess("#companyContactPhoneTip");
    return true;
};

//检查运营负责人邮箱
var checkCompanyContactEmail = function () {
    var companyContactEmail = $.trim($("#companyContactEmail").val());
    if (!companyContactEmail) {
        showTip("#companyContactEmailTip", "请输入运营负责人邮箱!");
        return false;
    }
    var reMail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
    if (!reMail.test(companyContactEmail)) {
        showTip("#companyContactEmailTip", "邮箱地址格式错误!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.companyContactEmail", companyContactEmail);
    showSuccess("#companyContactEmailTip");
    return true;
};

//检查运营负责人微信
var checkCompanyContactWeChat = function () {
    var companyContactWeChat = $.trim($("#companyContactWeChat").val());
    if (!companyContactWeChat) {
        showTip("#companyContactWeChatTip", "请输入运营负责人微信!");
        return false;
    }
    var reWeChat = /^([a-zA-Z0-9_-])+$/;
    if (!reWeChat.test(companyContactWeChat)) {
        showTip("#companyContactWeChatTip", "微信号码格式错误!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.companyContactWeChat", companyContactWeChat);
    showSuccess("#companyContactWeChatTip");
    return true;
};

//检查运营负责人微信
var checkCompanyContactQQ = function () {
    var companyContactQQ = $.trim($("#companyContactQQ").val());
    if (!companyContactQQ) {
        showTip("#companyContactQQTip", "请输入运营负责人QQ!");
        return false;
    }
    var reQQ = /^([0-9]){4,}$/;
    if (!reQQ.test(companyContactQQ)) {
        showTip("#companyContactQQTip", "QQ号码格式错误!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.companyContactQQ", companyContactQQ);
    showSuccess("#companyContactQQTip");
    return true;
};

//检查店长
var checkCompanyCeo = function () {
    var companyCeo = $.trim($("#companyCeo").val());
    var res =  /^([\u4E00-\u9FA5]{1,8}·?[\u4E00-\u9FA5]{1,8})$/;
    if (!companyCeo) {
        showTip("#companyCeoTip", "请输入店长!");
        return false;
    }
    if(!res.test(companyCeo)){
        showTip("#companyCeoTip", "姓名格式不正确!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.companyCeo", companyCeo);
    showSuccess("#companyCeoTip");
    return true;
};

//检查店长手机
var checkCeoMobile = function () {
    var ceoMobile = $.trim($("#ceoMobile").val());
    var strP = /^1[0-9]{10}$/;
    if (!ceoMobile) {
        showTip("#ceoMobileTip", "请输入店长手机!");
        return false;
    }
    if (!strP.test(ceoMobile)) {
        showTip("#ceoMobileTip", "手机号码格式错误!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.ceoMobile", ceoMobile);
    showSuccess("#ceoMobileTip");
    return true;
};

//检查执业药师
var checkQualityManagement = function () {
    var qualityManagement = $.trim($("#qualityManagement").val());
    var res =  /^([\u4E00-\u9FA5]{1,8}·?[\u4E00-\u9FA5]{1,8})$/;
    if (!qualityManagement) {
        showTip("#qualityManagementTip", "请输入驻店执业药师!");
        return false;
    }
    if(!res.test(qualityManagement)){
        showTip("#qualityManagementTip", "姓名格式不正确!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.qualityManagement", qualityManagement);
    showSuccess("#qualityManagementTip");
    return true;
};

//检查执业药师手机
var checkQualityManagementMobile = function () {
    var qualityManagementMobile = $.trim($("#qualityManagementMobile").val());
    var strP = /^1[0-9]{10}$/;
    if (!qualityManagementMobile) {
        showTip("#qualityManagementMobileTip", "请输入执业药师手机!");
        return false;
    }
    if (!strP.test(qualityManagementMobile)) {
        showTip("#qualityManagementMobileTip", "手机号码格式错误!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.qualityManagementMobile", qualityManagementMobile);
    showSuccess("#qualityManagementMobileTip");
    return true;
};

//检查开户银行
var checkClearingBank = function () {
    var clearingBank = $.trim($("#clearingBank").val());
    if (!clearingBank) {
        showTip("#clearingBankTip", "请输入开户银行名称!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.clearingBank", clearingBank);
    showSuccess("#clearingBankTip");
    return true;
};

//检查银行账户
var checkClearingBankAccountName = function () {
    var clearingBankAccountName = $.trim($("#clearingBankAccountName").val());
    if (!clearingBankAccountName) {
        showTip("#clearingBankAccountNameTip", "请输入银行户名!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.clearingBankAccountName", clearingBankAccountName);
    showSuccess("#clearingBankAccountNameTip");
    return true;
};

//检查银行账号
var checkClearingBankAccount = function () {
    var clearingBankAccount = $.trim($("#clearingBankAccount").val());
    if (!clearingBankAccount) {
        showTip("#clearingBankAccountTip", "请输入银行账号!");
        return false;
    }
/*    var temp = clearingBankAccount.replace(/\s+/g, '');//清除中间的空格
    var reg = /^\d*$/;
    if (!reg.test(temp)){
        showTip("#clearingBankAccountTip", "请输入有效的银行账号!");
        return false;
    }*/
    putToLocalStorage("outletRegisterData.shopInf.clearingBankAccount", clearingBankAccount);
    showSuccess("#clearingBankAccountTip");
    return true;
};

//检查支行名称
var checkBranchName = function () {
    var branchName = $.trim($("#branchName").val());
    if (!branchName) {
        showTip("#branchNameTip", "请输入支行名称!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.branchName", branchName);
    showSuccess("#branchNameTip");
    return true;
};

//检查发票抬头
var checkInvoiceTitle = function () {
    var invoiceTitle = $.trim($("#invoiceTitle").val());
    if (!invoiceTitle) {
        showTip("#invoiceTitleTip", "请输入发票抬头!");
        return false;
    }
    var regx = /^[\u4e00-\u9fa5 ]{2,30}/;
    if(!regx.test(invoiceTitle)){
        showTip("#invoiceTitleTip","发票抬头格式不正确");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.invoiceTitle", invoiceTitle);
    showSuccess("#invoiceTitleTip");
    return true;
};

//检查发票税号
var checkInvoiceNumber = function () {
    var invoiceNumber = $.trim($("#invoiceNumber").val());
    if (!invoiceNumber) {
        showTip("#invoiceNumberTip", "请输入发票税号!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.invoiceNumber", invoiceNumber);
    showSuccess("#invoiceNumberTip");
    return true;
};

//检查发票地址
var checkInvoiceAddress = function () {
    var invoiceAddress = $.trim($("#invoiceAddress").val());
    if (!invoiceAddress) {
        showTip("#invoiceAddressTip", "请输入发票地址!");
        return false;
    }
    if (invoiceAddress.length > 128) {
        showTip("#invoiceAddressTip", "地址最多输入128个字符!");
        return false;
    }
    putToLocalStorage("outletRegisterData.shopInf.invoiceAddress", invoiceAddress);
    showSuccess("#invoiceAddressTip");
    return true;
};

//检查发票电话
var checkInvoicePhone = function () {
    var invoicePhone = $.trim($("#invoicePhone").val());
    if (!invoicePhone) {
        showTip("#invoicePhoneTip", "请输入发票电话!");
        return false;
    }

    putToLocalStorage("outletRegisterData.shopInf.invoicePhone", invoicePhone);
    showSuccess("#invoicePhoneTip");
    return true;
};


//检查发票开户银行
var checkInvoiceBank = function () {
    var $invoiceBank = $("#invoiceBank");
    var invoiceBank = $.trim($invoiceBank.val());
    if ($invoiceBank.is(":visible")) {//隐藏时不用验证
        if (!invoiceBank) {
            showTip("#invoiceBankTip", "请输入开户银行!");
            return false;
        }
    }

    putToLocalStorage("outletRegisterData.shopInf.invoiceBank", invoiceBank);
    showSuccess("#invoiceBankTip");
    return true;
};

//检查发票银行账户
var checkInvoiceBankCode = function () {
    var $invoiceBankCode = $("#invoiceBankCode");
    var invoiceBankCode = $.trim($invoiceBankCode.val());
    if ($invoiceBankCode.is(":visible")) {//隐藏时不用验证
        if (!invoiceBankCode) {
            showTip("#invoiceBankCodeTip", "请输入银行账号!");
            return false;
        }
    }

/*    var temp = invoiceBankCode.replace(/\s+/g, '');//清除中间的空格
    var reg = /^\d*$/;
    if (!reg.test(temp)){
        showTip("#invoiceBankCodeTip", "请输入有效的银行账号!");
        return false;
    }*/

    putToLocalStorage("outletRegisterData.shopInf.invoiceBankCode", invoiceBankCode);
    showSuccess("#invoiceBankCodeTip");
    return true;
};

//检查资质列表
var checkLicense = function () {
    var licenses =  [];
    var isValid = true;
    $(".licenseFile").each(function (index, item) {
        var $item = $(item);
        if ($item.hasClass('isNeed') && $item.is(":visible")){//只验证class含有isNeed、并且显示出来的资质
            var allowblank = $item.hasClass('allowblank');//是否允许为空，允许为空表示不做必填验证
            var itemId = $item.attr('id');

            //验证图片
            var fileIds = '';
            var fileUrls = '';
            if ($item.find(".pic").length < 2){
                if (!allowblank) {
                    showLicenseTip(itemId, '请上传图片!');
                    isValid = false;
                    return false;
                }
            }else {
                $item.find(".pic").each(function () {
                    var $img = $(this).find('img');
                    if ($img.length > 0) {
                        var fileId = $($img[0]).attr('fileId');
                        var fileUrl = $($img[0]).attr('src');
                        if (fileId) {
                            fileIds += ',' + fileId;
                            fileUrls += ',' + fileUrl;
                        }
                    }
                })
            }
            if (fileIds.length > 1){
                fileIds = fileIds.substring(1);
                fileUrls = fileUrls.substring(1);
            }

            //验证证件号码
            var num = '';
            var $num = $("#"+itemId+"_Num");
            if ($num.length > 0){
                if (!allowblank && !$num.val()){
                    showLicenseTip(itemId, '请填写证件号码!');
                    isValid = false;
                    return false;
                }else {
                    num = $num.val();
                }
            }

            //验证开始有效期
            var startDateString = '';
            var $startDateString = $("#"+itemId+"_startDateString");
            if ($startDateString.length > 0 && $startDateString.hasClass('isNeed')){
                if (!allowblank && !$startDateString.val()){
                    showLicenseTip(itemId, '请选择证件开始时间!');
                    isValid = false;
                    return false;
                }else {
                    startDateString = $startDateString.val();
                }
            }

            //验证结束有效期
            var endDateString = '';
            var $endDateString = $("#"+itemId+"_endDateString");
            if ($endDateString.length > 0 && $endDateString.hasClass('isNeed')){
                if (!allowblank && !$endDateString.val()){
                    showLicenseTip(itemId, '请选择证件结束时间!');
                    isValid = false;
                    return false;
                }else {
                    endDateString = $endDateString.val();
                }
            }

            if (startDateString && endDateString){
                var tempStart = new Date(startDateString.replace(/-/g,'/'));
                var tempEnd = new Date(endDateString.replace(/-/g,'/'));
                if (tempStart >= tempEnd){
                    showLicenseTip(itemId, '有效期范围错误!');
                    isValid = false;
                    return false;
                }
            }

            //是否长期
            var isLongTime = 'N';
            var $isLongTime = $("#"+itemId+"_isLongTime");
            if ($isLongTime.length > 0){
               if ($isLongTime.is(":checked")){
                   isLongTime = 'Y';
                   endDateString = startDateString;//如果长期，结束时间与开始时间一致
               }
            }

            //资质名称
            var sysLicenseNm = '';
            var $licenseNm = $("#"+itemId+"_Nm");
            if ($licenseNm.length > 0){
                sysLicenseNm = $licenseNm.val();
            }

            //新增资质对象
            var license = {
                fileId:fileIds,
                fileUrl:fileUrls,
                startDateString:startDateString,
                endDateString:endDateString,
                qualificationNum:num,
                isLongtime:isLongTime,
                licenseNo:itemId,
                sysLicenseNm:sysLicenseNm
            };
            licenses.push(license);

            putToLocalStorage("outletRegisterData.licenses", licenses);
            showSuccess("#"+itemId+"Tip");
            $item.css("border","");//不是输入框，需要手动去除border
        }
    });

    return isValid;
};

//显示资质错误提醒
function showLicenseTip(itemId, tip) {
    showTip("#"+itemId+"Tip", tip);
    var $item = $('#'+itemId);
    $item.css("border","");//不是输入框，需要手动去除border
}

//验证所有组件
function checkShopInf() {

    if (!checkStoreType()){
        return false;
    }
    if (!checkOutletCompanyNm()){
        return false;
    }
    if (!checkShopNm()){
        return false;
    }
    if (!checkLegalPerson()){
        return false;
    }
    if (!checkRegCapital()){
        return false;
    }
    if (!checkTelQu()){
        return false;
    }
    if (!checkTelNum()){
        return false;
    }
    if (!checkTelFen()){
        return false;
    }
    if (!checkOutletAddr()){
        return false;
    }
    if (!checkBusinessRange()){
        return false;
    }
    if (!checkCompanyContactCeo()){
        return false;
    }
    if(!checkOutletMobile()){
        return false;
    }
    if (!checkCompanyContactPhone()){
        return false;
    }
    if (!checkCompanyContactEmail()){
        return false;
    }
    if (!checkCompanyContactWeChat()){
        return false;
    }
    if (!checkCompanyContactQQ()){
        return false;
    }
    if (!checkCompanyCeo()){
        return false;
    }
    if (!checkCeoMobile()){
        return false;
    }
    if (!checkQualityManagement()){
        return false;
    }
    if (!checkQualityManagementMobile()){
        return false;
    }
    if (!checkClearingBank()){
        return false;
    }
    if (!checkBranchName()){
        return false;
    }
    if (!checkClearingBankAccountName()){
        return false;
    }
    if (!checkClearingBankAccount()){
        return false;
    }
    if (!checkInvoiceTitle()){
        return false;
    }
    if (!checkInvoiceNumber()){
        return false;
    }
    if (!checkInvoiceAddress()){
        return false;
    }
    if (!checkInvoicePhone()){
        return false;
    }
    if (!checkInvoiceBank()){
        return false;
    }
    if (!checkInvoiceBankCode()){
        return false;
    }
    if (!checkLicense()){
        return false;
    }
    return true;
}