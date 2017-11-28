$(document).ready(function(){

    $(":radio").click(function(){
        if($(this).attr("store")!=null){
            $("#storeType").val($(this).attr("store"));
        }
    });

    /*确认页面刷新则重新复制*/
    InfDetail();

    /*查看图片*/
    $(".watch1").click(function(){
        var url =  $(this).parent().find(".put6").val();
        if($.trim(url)!=""){
            window.open(url);
        }else{
            alert("请先上传图片!");
        }
    });
    $(".watch2").click(function(){
        var url =  $(this).parent().find(".put6").val();
        if($.trim(url)!=""){
            window.open(url);
        }else{
            alert("请先上传图片!");
        }
    });
    $(".watch3").click(function(){
        var url =  $(this).parent().find(".put6").val();
        if($.trim(url)!=""){
            window.open(url);
        }else{
            alert("请先上传图片!");
        }
    });


    /*表单各模块的显示和隐藏*/
    var url = window.location.href;
    var indexNum = url.indexOf("#");
    if(indexNum>=-1&&shopInfNext()){
        var urlStr  =url.substring(indexNum+1,url.length);
        if(urlStr=="Num"){
            $(".shopInf_div").hide();
            $(".company_div").show();
            $(".info_div").hide();
            $(".detailMsg").hide();
            $("#process").removeClass();
            $("#process").addClass("nav1");
        }
        if(urlStr=="Num2"){
            $(".shopInf_div").hide();
            $(".company_div").hide();
            $(".info_div").show();
            $(".detailMsg").hide();
            $("#process").removeClass();
            $("#process").addClass("nav2");
        }
        if(urlStr=="Num3"){
            $(".shopInf_div").hide();
            $(".company_div").hide();
            $(".info_div").hide();
            $(".detailMsg").show();
            $("#process").removeClass();
            $("#process").addClass("nav3");
        }
    }else{
        $(".shopInf_div").show();
        $(".company_div").hide();
        $(".info_div").hide();
        $("#process").removeClass();
        $("#process").addClass("nav");
    }

    /*成立日期*/
    $('#companyCreateDateString').focus(function(){
        WdatePicker();
    });

    /*营业执照有效期*/
    $('#start_date').focus(function(){
        WdatePicker();
    });
    $('#end_date').focus(function(){
        WdatePicker();
    });

    /*店铺信息 验证开始*/
    $("#invitationCodeNum").bind("blur", invitationCodeNumTri);
    $("#name").bind("blur", nameTri);
    $("#shopNm").bind("blur", shopNmTri);
    $("#mobile").bind("blur", mobileTri);
    $("#subDomain").bind("blur", subDomainTri);
    $("#email").bind("blur", emailTri);
    //$("#post").bind("blur", postTri);
    //$("#cz_q").bind("blur", cz_qTri);$("#cz_h").bind("blur", cz_hTri);$("#cz_f").bind("blur", cz_fTri);
    //$("#dh_q").bind("blur", dh_qTri);$("#dh_h").bind("blur", dh_hTri);$("#dh_f").bind("blur", dh_fTri);
    //$("#contractNumber").bind("blur", contractNum_fTri);

    /*图片上传*/
    photo("photoFileId","upload_pic","tip","upload","upLoad_btn");
    photo("photoFileId2","upload_pic2","tip2","upload2","upLoad_btn2");
    photo("photoFileId3","upload_pic3","tip3","upload3","upLoad_btn3");
} );

/*是否有实体店checkbox选择控制*/
function setCheck(obj,isOffline){
    $("input[name='isOffline']").removeAttr("checked");
    $(obj).attr("checked",true);
    $(".isOffLineShop").attr("value",isOffline);
}

/*图片上传*/
function photo(photoFileId,upload_pic,tip,upload,upLoad_btn){
    var options  = {
        dataType:'html',
        success:function(responseText, statusText, xhr, $form){
            try{
                var result = eval("("+responseText+")");
                if(result.success == "false"){
                    alert("您提交的图片格式不正确");

                }else if(result.success == "true"){
                    $("#"+photoFileId).attr("value",$.trim(result.fileId));
                    /*  $("#"+upload_pic).attr("value",$.trim(result.url));*/
                    $("#"+upload_pic).attr("value",$.trim(pageValue.webRoot+"/upload/"+result.fileId));
                    $("#"+tip).dialog('close');
                    if(upload_pic=="upload_pic"){
//                        $(".picDetail1").attr("value",$.trim(result.url));
                        $(".picDetail1").attr("value",$.trim(pageValue.webRoot+"/upload/"+result.fileId));
                    }
                    if(upload_pic=="upload_pic2"){
                        $(".picDetail2").attr("value",$.trim(pageValue.webRoot+"/upload/"+result.fileId));
                    }
                    if(upload_pic=="upload_pic3"){
                        $(".picDetail3").attr("value",$.trim(pageValue.webRoot+"/upload/"+result.fileId));
                    }

                }
            }catch(err){
                alert("您上传的图片不符合规格,请上传.jpg格式文件");
            }
        }
    };
    $('#'+upload).submit(function() {
        $(this).ajaxSubmit(options);
        return false;
    });
    $("#"+upLoad_btn).click(function(){
        $("#"+tip).dialog({
            buttons:{
                '确定':function() {
                    $("#"+upload).submit();
                },
                '取消':function() {
                    $("#"+tip).dialog('close');
                }
            }
        });
    });
}

/*店铺信息填写，点击下一步*/
var shopInfNext = function(){
    if(pageValue.isOpenInviteCode){
        if(!invitationCodeNumTri()){
            return false;
        }
    }
    if(!nameTri()||!shopNmTri()||!mobileTri()||!subDomainTri()||!emailTri()||!cz_qTri()||!cz_hTri()||!cz_fTri() ||!dh_qTri()||!dh_hTri()||!dh_fTri()){
        return false;
    }

    if($("#cz_q").val()==""){
        $("#fax").attr("value","");
    }else{
        var cZhen = $("#cz_q").val()+"-"+$("#cz_h").val()+"-"+$("#cz_f").val();
        $("#fax").attr("value",cZhen);
    }

    if($("#dh_q").val()==""){
        $("#tel").attr("value","");
    }else{
        var dHua = $("#dh_q").val()+"-"+$("#dh_h").val()+"-"+$("#dh_f").val();
        $("#tel").attr("value",dHua);
    }



    $("#process").removeClass();
    $("#process").addClass("nav1");
    $(".shopInf_div").hide();
    $(".company_div").show();
    $(".info_div").hide();
    $(".detailMsg").hide();
    return true;
};

//营业执照经营范围
var businessScopeTri = function(){
    var businessScopeDesc = $.trim($("#businessScopeDesc").val());
    if(undefined != businessScopeDesc && null != businessScopeDesc && "" != businessScopeDesc && businessScopeDesc.length>512){
        alert("营业执照经营范围不能超过512个字符");
        return false;
    }
    return true;
};

/*公司信息填写，点击下一步*/
var companyInfNext = function(){
    if(!yz_fTri()||!zj_fTri()||!regAddr_fTri()||!ceoAddr_fTri()||!businessScopeTri()){
        return false;
    }
    if(!principalMobile()){
        return false;
    }
    /*if(!contractNum_fTri()){
        return false;
    }*/
    $("#process").removeClass();
    $("#process").addClass("nav2");
    $(".shopInf_div").hide();
    $(".company_div").hide();
    $(".info_div").show();
    $(".detailMsg").hide();
};

/*资质信息填写，点击下一步*/
var infoNext = function(){
    InfDetail();     //资质信息填写完点击下一步，则必须将前面所填的汇总到下一个页面进行确认
    $("#process").removeClass();
    $("#process").addClass("nav3");
    $(".shopInf_div").hide();
    $(".company_div").hide();
    $(".info_div").hide();
    $(".detailMsg").show();
};

/*返回上一步，链接为#时显示第一个信息输入框*/
var preDiv = function(){
    $("#process").removeClass();
    $("#process").addClass("nav");
    $(".shopInf_div").show();
    $(".company_div").hide();
    $(".info_div").hide();
    $(".detailMsg").hide();
};



/*邀请码*/
var invitationCodeNumTri = function () {
    var oPosTri = $("#invitationCodeNum"), vPosTri = $.trim(oPosTri.val());
    if (vPosTri == "") {
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入邀请码！", position:"2-1" });
        return false;
    } else {
        $.powerFloat.hide();
        return true;
    }
};

/*店铺名称*/
var shopNmTri = function () {
    var oPosTri = $("#shopNm"), vPosTri = $.trim(oPosTri.val());
    if (vPosTri == "") {
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入店铺名称！", position:"2-1" });
        return false;
    }else if(!(/^[\d|A-z|\u4E00-\u9FFF]{2,30}$/.test(oPosTri.val()))){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"店铺名只可以输入2-30个字符中文,字母,数字", position:"2-1" });
        return false;
    }else if(!checkShopNm(vPosTri)){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"店铺名已被注册，请重新填写！", position:"2-1" });
        return false;
    }else {
        $.powerFloat.hide();
        return true;
    }
};


/*店铺姓名*/
var nameTri = function () {
    var oPosTri = $("#name"), vPosTri = $.trim(oPosTri.val());
    if (vPosTri == "") {
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入姓名！", position:"2-1" });
        return false;
    }else if(!(/^[\d|A-z|\u4E00-\u9FFF]{2,15}$/.test(oPosTri.val()))){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"姓名限制2-15个字符的中文,字母,数字", position:"2-1" });
        return false;
    }else {
        $.powerFloat.hide();
        return true;
    }
};
/*手机*/
var mobileTri = function () {
    var oPosTri = $("#mobile"), vPosTri = $.trim(oPosTri.val());
    if (vPosTri == "") {
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入手机号码！", position:"2-1" });
        return false;
    }else if(!(/^1(3|4|5|7|8)\d{9}$/.test(oPosTri.val()))){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入正确的手机号码！", position:"2-1" });
        return false;
    }else {
        $.powerFloat.hide();
        return true;
    }
};

/*域名*/
var subDomainTri = function () {
    var oPosTri = $("#subDomain"), vPosTri = $.trim(oPosTri.val());
    if (vPosTri != "" && !checkDomain(vPosTri)) {
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"域名已被注册，请重新填写！", position:"2-1" });
        return false;
    } else {
        $.powerFloat.hide();
        return true;
    }
};
/*邮箱*/
var emailTri = function () {
    var oPosTri = $("#email"), vPosTri = $.trim(oPosTri.val());
    if (vPosTri == "") {
        //oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入邮箱！", position:"2-1" });
        return true;
    } else if(!(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/.test(vPosTri))){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入正确的邮箱！", position:"2-1" });
    }else if(vPosTri.length > 64){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"邮箱地址过长！", position:"2-1" });
    } else {
        $.powerFloat.hide();
        return true;
    }
};


/*职位(暂时不需要验证)*/
var postTri = function () {
    var oPosTri = $("#post"), vPosTri = $.trim(oPosTri.val());
    if (vPosTri == "") {
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入职位！", position:"2-1" });
        return false;
    } else {
        $.powerFloat.hide();
        return true;
    }
};
/*传真区号*/
var cz_qTri = function () {
    var oPosTri = $("#cz_q"), vPosTri = $.trim(oPosTri.val());
    if(!(/^0\d{2,3}$/.test(vPosTri))&&vPosTri!=""){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入正确的区号！", position:"2-1" });
    } else {
        $.powerFloat.hide();
        return true;
    }
};
/*电话区号*/
var dh_qTri = function () {
    var oPosTri = $("#dh_q"), vPosTri = $.trim(oPosTri.val());
    if(!(/^0\d{2,3}$/.test(vPosTri))&&vPosTri!=""){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入正确的电话区号！", position:"2-1" });
    } else {
        $.powerFloat.hide();
        return true;
    }
};
/*传真号码*/
var cz_hTri = function () {
    var oPosTri = $("#cz_h"), vPosTri = $.trim(oPosTri.val());
    if(!(/^[1-9]\d*$/.test(vPosTri))&&vPosTri!=""){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入正确的号码！", position:"2-1" });
    } else {
        $.powerFloat.hide();
        return true;
    }
};
/*电话号码*/
var dh_hTri = function () {
    var oPosTri = $("#dh_h"), vPosTri = $.trim(oPosTri.val());
    if(!(/^[1-9]\d*$/.test(vPosTri))&&vPosTri!=""){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"请输入正确的号码！", position:"2-1" });
    } else {
        $.powerFloat.hide();
        return true;
    }
};
/*传真分机*/
var cz_fTri = function () {
    var oPosTri = $("#cz_f"), vPosTri = $.trim(oPosTri.val());
    var cZhen = $("#cz_q").val()+"-"+$("#cz_h").val()+"-"+$("#cz_f").val();
    if(!(/((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/.test(cZhen))&&vPosTri!=""){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"传真格式不正确！", position:"2-1" });
        return false;
    }else {
        $.powerFloat.hide();
        return true;
    }
};
/*电话分机*/
var dh_fTri = function () {
    var oPosTri = $("#dh_f"), vPosTri = $.trim(oPosTri.val());
    var dHua = $("#dh_q").val()+"-"+$("#dh_h").val()+"-"+$("#dh_f").val();
    if(!(/^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$/.test(dHua))&&vPosTri!=""){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"电话格式不正确！", position:"2-1" });
        return false;
    }else {
        $.powerFloat.hide();
        return true;
    }
};

/*邮政*/
var yz_fTri = function () {
    var oPosTri = $("#zipcode"), vPosTri = $.trim(oPosTri.val());
    var strT=/^\d+(\.\d+)?$/;
    if(vPosTri!=null && vPosTri!=""){
        if(!strT.test(vPosTri)){
            oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"邮政编码格式不正确！", position:"2-1" });
            return false;
        }
        if(vPosTri.length!=6 && vPosTri!=""){
            oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"邮政编码格式不正确！", position:"2-1" });
            return false;
        }else {
            $.powerFloat.hide();
            return true;
        }
    }else{
        return true;
    }
};

/*公司负责人手机*/
var principalMobile    = function () {
    var ceoMobile = $("#ceoMobile"), ceoMobileValue = $.trim(ceoMobile.val());
    if(ceoMobileValue!=null && ceoMobileValue!=""){
        if(!(/^1(3|4|5|7|8)\d{9}$/.test(ceoMobileValue))){
            ceoMobile.powerFloat({ eventType:null, targetMode:"remind", target:"请输入正确的手机号码！", position:"2-1" });
        } else {
            $.powerFloat.hide();
            return true;
        }
    }else{
        return true;
    }
};

/*注册资金*/
var zj_fTri = function () {
    var oPosTri = $("#regCapital"), vPosTri = $.trim(oPosTri.val());
    if(!(/^\d+(\.\d+)?$/.test(vPosTri)) && vPosTri!=""){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"注册资金格式不正确！", position:"2-1" });
        return false;
    } else if(!(/^\d{0,9}(\.\d{0,2})?$/.test(vPosTri)) && vPosTri!=""){
        oPosTri.powerFloat({ eventType:null, targetMode:"remind", target:"整数部分不超过9位,小数部分不超过2位", position:"2-1" });
        return false;
    } else{
        $.powerFloat.hide();
        return true;
    }
};

/* 商家注册地址 */
var regAddr_fTri = function(){
    var regAddr = $("#regAddr"), vRegAddr = $.trim(regAddr.val());
    if(vRegAddr.length > 128){
        regAddr.powerFloat({ eventType:null, targetMode:"remind", target:"公司注册地址不能超过128位", position:"2-1" });
        return false;
    } else{
        $.powerFloat.hide();
        return true;
    }

};
/* 联系地址 */
var ceoAddr_fTri = function(){
    var ceoAddr = $("#ceoAddr"), vCeoAddr = $.trim(ceoAddr.val());
    if(vCeoAddr.length > 64){
        ceoAddr.powerFloat({ eventType:null, targetMode:"remind", target:"联系地址不能超过64位", position:"2-1" });
        return false;
    } else{
        $.powerFloat.hide();
        return true;
    }

};

/*合同编号*/
/*var contractNum_fTri = function () {
    var contractNum = $("#contractNumber"), vcontractNum = $.trim(contractNum.val());
    if(vcontractNum == ""){
        contractNum.powerFloat({ eventType:null, targetMode:"remind", target:"请输入合同编号！", position:"2-1" });
        return false;
    }
    else if(!(/^\d+(\.\d+)?$/.test(vcontractNum)) && vcontractNum!=""){
        contractNum.powerFloat({ eventType:null, targetMode:"remind", target:"合同编号格式不正确！", position:"2-1" });
        return false;
    }else if(!checkContractNum(vcontractNum)){
        contractNum.powerFloat({ eventType:null, targetMode:"remind", target:"合同编号重复！", position:"2-1" });
        return false;
    } else {
        $.powerFloat.hide();
        return true;
    }
};*/


/*function checkContractNum(contractNum){
    var flagD = false;
    $.ajax({
        type:"POST",
        url:pageValue.webRoot+"/shop/sysShopInfFront/checkContractNum.json",
        data: "contractNum="+contractNum,
        async:false,
        success:function(msg) {
            if (msg.success == "true") {
                flagD = true;
            } else {
                flagD = false;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
            flagD = false;
        }
    });
    return flagD;
}*/

/*信息汇总显示*/
var InfDetail= function(){
    if($("#cz_q").val()==""){
        var cZhen = "";
    }else{
        var cZhen = $("#cz_q").val()+"-"+$("#cz_h").val()+"-"+$("#cz_f").val();
    }

    if($("#dh_q").val()==""){
        var dHua = "";
    }else{
        var dHua = $("#dh_q").val()+"-"+$("#dh_h").val()+"-"+$("#dh_f").val();
    }
    $(".name").html($("#name").val());
    $(".shopNm").html($("#shopNm").val());
    $(".mobile").html($("#mobile").val());
    $(".subDomain").html($("#subDomain").val());
    $(".email").html($("#email").val());
    $(".post").html($("#post").val());
    $(".fax").html(cZhen);
    $(".tel").html(dHua);
    $(".legalPerson").html($("#legalPerson").val());
    $(".regAddr").html($("#regAddr").val());
    $(".ceoAddr").html($("#ceoAddr").val());
    $(".companyCeo").html($("#companyCeo").val());
    $(".ceoMobile").html($("#ceoMobile").val());
    $(".companyCreateDateString").html($("#companyCreateDateString").val());
    $(".companyNm").html($("#companyNm").val());
    $(".regCapital").html($("#regCapital").val());
    $(".zipcode").html($("#zipcode").val());
    $(".shop-start").html($("#start_date").val());
    $(".shop-end").html($("#end_date").val());
    //$(".contractNumber").html($("#contractNumber").val());
    if($(".isOffLineShop").val()=="Y"||$(".isOffLineShop").val()==""){
        $(".isOffLineShop").html("有实体店");
    }else{
        $(".isOffLineShop").html("没有实体店");
    }
    $(".businessScopeDesc").html($("#businessScopeDesc").val());
};

var toSubmit = function(){
    easyDialog.open({
        container : {
            header : '提示',
            content : '<div>您确认要提交该申请么？</div>',
            yesFn : saveOrUpdateShopInf,
            noFn : true
        }
    });
};

var saveOrUpdateShopInf = function(){
    if(pageValue.isOpenInviteCode){
        if(!invitationCodeNumTri()){
            return;
        }
    }
    if(!shopNmTri()||!nameTri()||!mobileTri()||!subDomainTri()||!emailTri()||!cz_qTri()||!cz_hTri()||!cz_fTri() ||!dh_qTri()||!dh_hTri()||!dh_fTri()/*||!contractNum_fTri()*/){
        return;
    }
    var value = $("#shopInfForm").formToArray();

    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        type:"POST",
        url:pageValue.webRoot+"/shop/sysShopInfFront/saveOrUpdateShopInf.json",
        data: value,
        success:function(msg) {
            if (msg.success == "true") {
                alert("申请成功");
                window.location.href = pageValue.webRoot+"/shopRegisterSuccess.ac";
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
};

function checkShopNm(shopNm){
    var flag = false;
    $.ajax({
        type:"POST",
        url:pageValue.webRoot+"/shop/sysShopInfFront/checkShopNm.json",
        data:"shopNm=" + shopNm,
        async:false,
        success:function(msg) {
            if (msg.success == "true") {
                flag = true;
            } else {
                flag = false;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
            flag = false;
        }
    });
    return flag;
}

function checkDomain(subDomain){
    var flagD = false;
    $.ajax({
        type:"POST",
        url:pageValue.webRoot+"/shop/sysShopInfFront/checkDomain.json",
        data: "subDomain="+subDomain,
        async:false,
        success:function(msg) {
            if (msg.success == "true") {
                flagD = true;
            } else {
                flagD = false;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
            flagD = false;
        }
    });
    return flagD;
}
