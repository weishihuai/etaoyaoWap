/**
 * 商家入驻流程3
 * Created by hjh on 2017/6/30.
 */

$(document).ready(function () {
    initData();//初始化数据
});

//初始化数据
function initData() {

    var outletAddrZoneId = getByLocalStorage("outletRegisterData.shopInf.zoneId");
    if (outletAddrZoneId){
        setOutletAddrNm(outletAddrZoneId);
    }
    var contactAddrDetail = getByLocalStorage("outletRegisterData.shopInf.contactAddr");
    var  outletAddrAll = $("#outletAddrAll").html();
    if (contactAddrDetail){
        $("#outletAddrAll").html(outletAddrAll+contactAddrDetail);
    }

    //商家基本资料
    var shopInf = getByLocalStorage("outletRegisterData.shopInf");
    if (shopInf){
        for(var key in shopInf){
            $("#"+key).html(shopInf[key]);
        }
    }

    var storeType = getByLocalStorage("outletRegisterData.shopInf.storeType");
    if(storeType){
        if(storeType == '0'){
            $("#storeType").html("连锁直营");
        } else if(storeType == '1'){
            $("#storeType").html("连锁加盟");
        } else if(storeType == '2'){
            $("#storeType").html("单体自营");
        }
    }

    //门店类型为单体自营 则隐藏所属连锁企业
    var outletCompanyNm = getByLocalStorage("outletRegisterData.shopInf.outletCompanyNm");
    if(!outletCompanyNm){
       $("#outletCompanyNm").parent().parent().hide();
    }


    //用户基本资料
    var userInfList = getByLocalStorage("outletRegisterData.userInf");
    if (userInfList){
        for(var user in userInfList){
            $("#"+user).html(userInfList[user]);
        }
    }
    //发票类型
    var invoiceType = getByLocalStorage("outletRegisterData.shopInf.invoiceType");
    if (invoiceType && invoiceType == 1){
        $("#invoiceType").html('专用增值税发票');
        $("#invoiceBankItem").show();
        $("#invoiceBankCodeItem").show();
    }else {
        $("#invoiceType").html('普通增值税发票');
        $("#invoiceBankItem").hide();
        $("#invoiceBankCodeItem").hide();
    }

    //经营范围
    var businessRangeIds = getByLocalStorage("outletRegisterData.shopInf.businessRange");
    if (businessRangeIds ){
        var ids = businessRangeIds.split(',');
        for (var i = 0 ; i < ids.length ; i++) {
            $("#businessRange_"+ids[i]).show();
        }
    }

    //三证合一，需要放在经营范围之后，因为经营范围方法会隐藏掉资质的显示
    var threeInOne = getByLocalStorage("outletRegisterData.isThreeInOne");
    if (threeInOne && threeInOne == "Y"){
        $("#isThreeInOne").html("多证合一营业执照");
    }else {
        $("#isThreeInOne").html("普通营业执照");
    }

    var licenses = getByLocalStorage("outletRegisterData.licenses");
    if(licenses){
        buildLicensesHtml(licenses);
    }
}

function buildLicensesHtml(licenses) {

    for(var i = 0; i < licenses.length; i++) {
        if (!licenses[i].fileId){
            continue;
        }
        var label = '';
        var qualificationNum = '';

     /*   label = "<label style='height: auto'>" + licenses[i].sysLicenseNm +  "</label>";
        $("#licenses").append("<div class='box-item'>"+label + "</div>");*/

        label = "<label style='height: auto'>资质名称:</label>";
        var sysLicenseNm = " <div class='mrt'> <span >" + licenses[i].sysLicenseNm + "</span> </div>"
        $("#licenses").append("<div class='box-item'>"+ label + sysLicenseNm+  "</div>");


        label = "<label style='height: auto'>证件号:</label>";
        if (licenses[i].qualificationNum) {
            qualificationNum = " <div class='mrt'> <span >" + licenses[i].qualificationNum + "</span> </div>"
        }
        $("#licenses").append("<div class='box-item'>"+ label + qualificationNum+  "</div>");


        if(licenses[i].startDateString){
            var startDateString = (new Date(licenses[i].startDateString)).getTime();
            startDateString = new Date(startDateString).format("yyyy年MM月dd日");
            var timeRange;
            if(null != licenses[i].isLongtime && licenses[i].isLongtime == "Y" ){
                 timeRange   = " <div class='mrt'> <span >" + startDateString+" 至 长期</span> </div>"
            }else{
                var endDateString = (new Date(licenses[i].endDateString)).getTime();
                endDateString = new Date(endDateString).format("yyyy年MM月dd日");
                 timeRange   = " <div class='mrt'> <span >" + startDateString+" 至 "+endDateString +"</span> </div>"
            }
            $("#licenses").append("<div class='box-item'><label>有效期:</label>" + timeRange+  "</div>");
        }

        var photo = "";
        if(licenses[i].fileId){
            var files = licenses[i].fileId.split(",");
            for(var j = 0 ; j < files.length ;j++){
                var index = files[j].lastIndexOf('.');
                var src_100 = imgRootUrl+ files[j].substring(0,index) +"_100X100" + files[j].substring(index,files[j].length ) ;
                var href = imgRootUrl+files[j];
                photo  = photo +" <div class='pic'  onclick='showImg(\""+href+"\")' ><img src=\'"+src_100 +"\' alt=''></div>";
                //var label = "证照";
                if(j != 0 ){
                    label = " ";
                }
            }
            $("#licenses").append( "<div class='box-item'><label>证照:</label> <div class='mrt'> "+ photo+  " </div> </div>");
        }
        $("#licenses").append( "<br><br>");
    }
}

function showImg(url){
    if(url){
        window.open(url);
    }
}
//设置地区名称
function setOutletAddrNm(zoneId) {
    $.ajax({
        type:"post" ,url:webPath.webRoot+"/common/zoneNm.json",
        data:{zoneId:zoneId},
        dataType:"json",
        async: false,//同步
        success:function(data) {
            if (data) {
                var defaultValue = [data.provinceNm, data.cityNm, data.zoneNm];
                $("#outletAddrAll").html(data.provinceNm+data.cityNm+data.zoneNm);
            }
        }
    })
}


//提交资料
function saveShopInf() {
    var licenses = getByLocalStorage('outletRegisterData.licenses');
    if (licenses){
        licenses.reverse();
        putToLocalStorage('outletRegisterData.licenses',licenses);
    }
    var outletRegisterData = getByLocalStorage('outletRegisterData');
    $.ajax({
        type:'post',
        url:webPath.webRoot+'/shop/sysShopInfFront/saveFrontOutletApply.json',
        data:"_method=post&json="+JSON.stringify(outletRegisterData),
        dataType:'json',
        contentType:'application/json',
        async:false,//同步
        success:function (data) {
            putToLocalStorage("outletRegisterData",null);//清空本地储存
            location.href = webPath.webRoot+"/shop/register/registerOutletStep04.ac"
        },
        error:errorFun
    })
}

function errorFun(XMLHttpRequest, textStatus) {
    if (XMLHttpRequest.status === 500) {
        var result = eval("(" + XMLHttpRequest.responseText + ")");
        showErrorWin(result.errorObject.errorText);
    }
}





