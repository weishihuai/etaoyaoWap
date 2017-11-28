
var addrOrderSelect;//加载地区

// <%--加载地区 start--%>
function loadAddrArea() {
    return  $(".addressOrderSelect").ld({ajaxOptions : {"url" : webParams.webRoot+"/member/addressBook.json"},
        defaultParentId:9,
        style:{"width": 100}
    });
}


$(function(){

    $("#leftProductDetail").load(webParams.webRoot + "/template/bdw/citySend/ajaxload/addOrderProductDetail.jsp",{orgId:webParams.orgId,carttype:webParams.carttype},function(){});
    $("#mainContent").load(webParams.webRoot + "/template/bdw/citySend/ajaxload/addOrderReload.jsp",{orgId:webParams.orgId,isCod:webParams.isCodStr,carttype:webParams.carttype},function(){});

    //收货地址
    $("#showMoreAddress").live("click",function () {
        $(".uaddItem").css("display", "block");
        $(".uaddItem").addClass("sindex");
        $(".showAddr").hide();
        $(".hideAddr").show();
    });

    $("#hideMoreAddress").live("click",function () {
        $(".uaddItem").css("display", "none");
        $(".uaddItem").removeClass("sindex");
        $(".addr1").css("display", "block");
        $(".addr2").css("display", "block");
        $(".addr1").addClass("sindex");
        $(".addr2").addClass("sindex");
        $(".showAddr").show();
        $(".hideAddr").hide();
    });

    //优惠券
    $("#showCoupon").live("click",function () {
        //当前是否已展开
        if($("#allUserCoupon").css("display")=='block'){
            $(this).find("i").removeClass("icon-minus");
            $(this).find("i").addClass("icon-plus");
            $("#allUserCoupon").hide();
        }else{
            var num = $(this).attr("couponNum");
            if(num<=0) {
                breadOrderJDialog("没有可用的优惠券",1200,"10px",true);
                return;
            }
            $(this).find("i").addClass("icon-minus");
            $(this).find("i").removeClass("icon-plus");
            $("#allUserCoupon").show();
        }
    });


    $("#hideCoupon").live("click",function () {
        //当前是否已展开
        if($("#usedCoupon").css("display")=='block'){
            $(this).find("i").removeClass("icon-minus");
            $(this).find("i").addClass("icon-plus");
            $("#usedCoupon").hide();
        }else{
            $(this).find("i").addClass("icon-minus");
            $(this).find("i").removeClass("icon-plus");
            $("#usedCoupon").show();
        }
    });

    //发票
    $("#showInvoice").live("click",function () {
        var isAlSave = $("#sinvoice").css("display") == 'block';
        if($("#invoiceDetail").css("display") == 'block'){
            $("#invoiceDetail").hide();
            if(isAlSave){
                $(this).addClass("sel");
            }else{
                $(this).removeClass("sel");
            }
        }else{
            $(this).addClass("sel");
            $("#invoiceDetail").show();
            if(isAlSave){
                var invTitle = $(".invTitle").html();
                var entName = $(".entName").html();
                var invCont = $(".invCont").html();
                $(this).addClass("sel");
                if(undefined != invTitle && null != invTitle && invTitle!=""){
                    if(invTitle == '个人'){
                        $("#personal").addClass("sel");
                        $("#company").removeClass("sel");
                        $("#saveInvoice").attr("titleType","0")
                    }
                    if(invTitle == '公司'){
                        $("#personal").removeClass("sel");
                        $("#company").addClass("sel");
                        $("#saveInvoice").attr("titleType","1")
                    }
                }
                if(undefined != entName && null != entName && entName!=""){
                    $("#entName").val(entName);
                }
                if(undefined != invCont && null != invCont && invCont!=""){
                    $(".selectedInvoice").html(invCont);
                    $("#saveInvoice").attr("invoiceContent",cont);
                }
            }
        }
    });

    //发票内容选择
    $("#company").live("click",function () {
        $("#personal").removeClass("sel");
        $(this).addClass("sel");
        $("#cpyName").show();
        $("#saveInvoice").attr("titleType","1");
    });

    $("#personal").live("click",function () {
        $("#company").removeClass("sel");
        $(this).addClass("sel");
        $("#cpyName").hide();
        $("#saveInvoice").attr("titleType","0");
    });

    $("#downSwith").live("click",function () {
        if($(".down-data").css("display","none")){
            $(".down-data").show();
        }else{
            $(".down-data").hide();
        }
    });

    $("#dataList li").live("click",function () {
        var cont = $(this).attr("cont");
        $(".selectedInvoice").text(cont);
        $(".selectedInvoice").attr("invoticeValue",cont);
        $(".down-data").hide();
        if(cont == '发票内容' || cont =='不选'){
            $("#saveInvoice").attr("invoiceContent","");
        }else{
            $("#saveInvoice").attr("invoiceContent",cont);
        }
    });

    //保存发票信息(貌似没有实际保存)
    $("#saveInvoice").live("click",function(){
        var isNeedInvoice;
        if($("#showInvoice").hasClass("sel")){
            isNeedInvoice = "Y";
        }else{
            isNeedInvoice = "N";
        }

        var invoiceTitle;
        var invoiceEntNm=$("#cpyName").val();

        var invoiceTitleType = $(this).attr("titleType");
        if("0"==invoiceTitleType){
            invoiceTitle = "个人";
        }
        if("1"==invoiceTitleType){
            if(undefined == invoiceEntNm || null == invoiceEntNm || ""==invoiceEntNm){
                breadOrderJDialog("请输入公司名称",1200,"10px",true);
                return;
            }
            invoiceTitle = "公司";
        }

        //发票内容
        var invoiceContent=$(this).attr("invoiceContent");
        $.ajax({
            url:webParams.webRoot+"/cart/saveInvoice.json",
            data:{isNeedInvoice:isNeedInvoice,
                invoiceCont:invoiceContent,
                invoiceTitle:invoiceTitle,
                invoiceEntNm:invoiceEntNm
            },
            dataType: "json",
            success:function(data) {
                breadOrderJDialog("发票添加成功",1200,"10px",true);
                var invoiceInfo = "发票信息：[ 发票抬头：<b class='invTitle'>"+invoiceTitle+"</b>, ";
                if(undefined != invoiceEntNm && null!=invoiceEntNm && invoiceEntNm!=""){
                    invoiceInfo += "公司名称：<b class='entName'>"+invoiceEntNm+"</b>, ";
                    $("#invoiceEntNm").val(invoiceEntNm);//公司名称
                }
                invoiceInfo += "发票内容：<b class='invCont'>" + invoiceContent + "</b> ]";
                $("#sinvoice p").html(invoiceInfo);
                $("#sinvoice").css("display","block");
                $("#isNeedInvoice").val("Y");//需要发票
                $("#invoiceTitle").val(invoiceTitle);//发票抬头
                $("#invoiceCont").val(invoiceContent);//发票内容
                $("#invoiceDetail").hide();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadOrderJDialog(result.errorObject.errorText,1200,"10px",true);
                }
            }
        });
    });

    $("#address-ul li").live("click", function () {
        $("#address-ul li").removeClass("active");
        $(this).addClass("active");
        var orgid = $(this).attr("orgid");
        var receiveAddrId = $(this).attr("receiverAddrId");
        setDefaultAddress(this,receiveAddrId,orgid);
    });

    addrOrderSelect = loadAddrArea();
    //添加新地址
    $("#addNewAddresss").live("click",function(){
        $("#layerTitle").html("添加收货地址");
        $("#addrAddayer").show();
        clearAddressContent();
        $("#receiverName").bind("blur", userNameTri);
        initAddReceiver();
    });

    //修改地址
    $("#updateAddress").live("click",function(){
        $("#layerTitle").html("修改收货地址");
        btnAlt($(this).attr("receiverAddrId"));
    });

    //关闭弹窗
    $("#closeAddAddrLayer").click(function(){
        $("#addrAddayer").hide();
        clearAddressContent();
    });

    //删除地址
    $("#deleteAddress").live("click",function () {
        var obj = $(this);
        var dialog = jDialog.confirm('<span style="margin-left: 10px">确认删除该条收货地址吗?</span>',{
            type : 'highlight',
            text : '确定',
            handler : function(button,dialog) {
                dialog.close();
                var reciverAddrId = obj.attr("receiverAddrId");
                $.ajax({
                    type:"post" ,
                    url:webParams.webRoot+"/member/deleteUserAddress.json?id=" + reciverAddrId ,
                    success:function() {
                        reload();
                        breadOrderJDialog("删除成功",1200,"10px",true);
                    }
                });
            }
        },{
            type : 'normal',
            text : '取消',
            handler : function(button,dialog) {
                dialog.close();
            }
        });
        return dialog;
    });

    //提交订单
    $(".submitOrder").live("click",function(){
        //1.收货地址是否选择
        var hasActiveNum = 0;
        var addrItemList = $(".uaddItem");
        addrItemList.each(function(){
            var strClass = $(this).attr("class");
            var strs = strClass.split(" ");
            var hasClass = $.inArray("active", strs);
            if(hasClass!=-1){
                //存在
            }else{
                hasActiveNum += 1;//不存在
            }
        });
        if(addrItemList.length == hasActiveNum){
            breadJDialog("请选择收货地址!",1200,"10px",true);
            return  false;
        }

        //判断选择的收货地址是否可以配送
        var selectedAddress = $(".uaddItem").find(".errorTxt");
        var htmlValue = selectedAddress.html();
        if(undefined != htmlValue && null != htmlValue && "" != htmlValue){
            breadJDialog("地址不支持配送，请重新选择!",1200,"10px",true);
            return  false;
        }


        if(!validatorDelivery()){
            breadJDialog("配送方式未选择!",1200,"10px",true);
            return false;
        }

        if(orderData.productTotal<1){
            breadJDialog("购物车中没有可购买的商品!",1200,"10px",true);
            return false;
        }
        setTimeout($("#orderForm").submit(),10)
    });

    $("#cancelAddrBtn").live("click",function(){
        $("#addrAddayer").hide();
        clearAddressContent();
    });

    //新增收货地址
    $("#saveReceiverAddrBtn").click(function(){
        var name = $.trim($("#receiverName").val());
        var mobile = $.trim($("#receiverMobile").val());
        var zoneId = $("#receiverZone").val();
        var addr = $.trim($("#receiverAddress").val());
        var receiveAddrId = $("#receiveAddrId").val();

        name = name.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        name = name.replace(/<.*?>/g, "");
        mobile = mobile.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        mobile = mobile.replace(/<.*?>/g, "");
        addr = addr.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        addr = addr.replace(/<.*?>/g, "");

        if(undefined == name || null == name || "" == name){
            $("#newAlert1").html("收货人不能为空");
            breadJDialog("收货人不能为空!",1200,"10px",true);
            return;
        }else if(!(/^[\d|A-z|\u4E00-\u9FFF]{2,30}$/.test(name))){
            breadJDialog("只可以输入2-30个字符中文,字母,数字!",1200,"10px",true);
            return;
        }else{

        }

        if(undefined == mobile || null == mobile || "" == mobile){
            breadJDialog("手机号码不能为空!",1200,"10px",true);
            return;
        }else{
            if(mobile.length != 11){
                breadJDialog("手机号长度只能是11位数字!",1200,"10px",true);
                return;
            }else{
                var strP=/^13[0-9]{9}|15[0-99][0-9]{8}|18[0-9][0-9]{8}|147[0-9]{8}|177[0-9]{8}|170[0-9]{8}$/;
                if(!strP.test(mobile)){
                    breadJDialog("请输入正确的手机号码!",1200,"10px",true);
                    return;
                }
            }
        }

        if(undefined == addrLat1 || null == addrLat1 || ""==addrLat1) {
            console.log(addrLat1);
            breadJDialog("请输入正确的收货地址",1200,"10px",true);
            return;
        }

        if(undefined == addrLng1 || null == addrLng1 || ""==addrLng1) {
            breadJDialog("请输入正确的收货地址",1200,"10px",true);
            console.log(addrLng1);
            return;
        }

        var data ={
            name:name,
            addr:addr,
            mobile:mobile,
            zoneId :zoneId,
            receiveAddrId:receiveAddrId
        };
        data.addrLat = addrLat1;
        data.addrLng = addrLng1;

        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url:webParams.webRoot+"/member/receiverAddress/saveOrUpdate.json",
            data: data,
            dataType: "json",
            success:function(data) {
                if (data.success == true) {
                    if(undefined != receiveAddrId && null != receiveAddrId && "" != receiveAddrId){
                        breadOrderJDialog("修改成功",1200,"10px",true);
                    }else{
                        breadOrderJDialog("添加成功",1200,"10px",true);
                    }
                    $("#addrAddayer").hide();
                    reload();
                    clearAddressContent();
                }
                if(data.success == false){
                    if(data.errorCode == "errors.login.noexist"){
                        breadJDialog("您的收货地址已满10个，不能再继续添加!",2000,"30px",true);
                        return false;
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                breadJDialog("服务器异常，请稍后重试!",2000,"30px",true);
            }
        });

    });


    //保存配送方式
    $(".saveDelivery").live("change",function(){
        var deliveryId=$(this).val();
        if(deliveryId==undefined || deliveryId==0){
            breadJDialog("配送方式未选择",2000,"30px",true);
        }
        var carttype=$(this).attr("carttype");
        var orgId=$(this).attr("orgid");
        $.ajax({
            url:webParams.webRoot+"/cart/saveDeliveryRuleId.json",
            data:{type:carttype,deliveryRuleId:deliveryId,orgId:orgId},
            dataType: "json",
            success:function(data) {
                reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadJDialog(result.errorObject.errorText,2000,"30px",true);
                }
            }
        });
    });

    //保存备注信息(貌似没用)
    $("#orderRemark").live("blur",function(){
        var remark=  $(this).val();
        var orgId=$(this).attr("orgid");
        var type=$(this).attr("carttype");
        $("#remark").val(remark);
        $.ajax({
            url:webParams.webRoot+"/cart/saveRemark.json",
            data:({remark:remark,orgId:orgId,type:type}),
            success:function(data){

            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadJDialog(result.errorObject.errorText,2000,"30px",true);

                }
            }
        })
    });

});

//清除原有的地址信息
function clearAddressContent(){
    $("#receiverName").val("");
    $("#receiverMobile").val("");
    $("#receiverAddress").val("");
    $("#receiveAddrId").val("");
    $("#receiverAddrLat").val("");
    $("#receiverAddrLng").val("");
    $("#receiverProvince").attr("value","请选择");
    $("#receiverCity").attr("value","请选择");
    $("#receiverZone").attr("value","请选择");
    addrLat1 = null;
    addrLng1 = null;
    $(".newAlert1").html();
    $(".newAlert2").html();
    $(".newAlert3").html();
    $(".newAlert4").html();
    $(".newAlert1").hide();
    $(".newAlert2").hide();
    $(".newAlert3").hide();
    $(".newAlert4").hide();
}

//收货人
var userNameTri =  function(){
    var receiverName = $.trim($("#receiverName").val());
    if(undefined == receiverName || null == receiverName || "" == receiverName){
        $(".newAlert1").html("请输入收货人姓名");
        $(".newAlert1").show();
        return false;
    }else if(!(/^[\d|A-z|\u4E00-\u9FFF]{2,30}$/.test(receiverName))){
        $(".newAlert1").html("只可以输入2-30个字符中文,字母,数字！");
        $(".newAlert1").show();
        return false;
    }else{
        $(".newAlert1").html("");
        $(".newAlert1").hide();
        return true;
    }
};

//手机号码
var userMobileTri =  function(){
    var receiverMobile = $.trim($("#receiverMobile").val());
    if(undefined == receiverMobile || null == receiverMobile || "" == receiverMobile){
        $(".newAlert2").html("请输入手机号");
        $(".newAlert2").show();
        return false;
    }else if(receiverMobile.length != 11){
        $(".newAlert2").html("手机号长度只能是11位数字");
        $(".newAlert2").show();
    }
    else if(!(/^13[0-9]{9}|15[0-99][0-9]{8}|18[0-9][0-9]{8}|147[0-9]{8}|177[0-9]{8}|170[0-9]{8}$/.test(receiverMobile))){
        $(".newAlert2").html("请输入正确的手机号码!");
        $(".newAlert2").show();
        return false;
    }else{
        $(".newAlert2").html("");
        $(".newAlert2").hide();
        return true;
    }
};

//使用购物券
function useCoupon(carttype, couponId, orgId){
    var couponIds = [];
    couponIds.push(couponId);
    $.ajax({
        type: "POST",
        url: webParams.webRoot + "/member/couponFront/useCoupons.json",
        traditional: true,
        data: {couponIds: eval(couponIds), orgId: orgId, type: carttype},
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                reload();
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                breadJDialog(result.errorObject.errorText,2000,"30px",true);
            }
        }
    });
}


/*验证选择配送方式*/
var validatorDelivery = function(){
    var returnBool = true;
    $(".saveDelivery").each(function(){
        if($(this).find("option:selected").val()-0 <= 0){
            returnBool = false;
        }
    });
    return returnBool;
};

//使用购物券
function clearCoupon(carttype, couponId, orgId){
    $.ajax({
        type:"POST",
        url:webParams.webRoot+"/member/couponFront/cancelUseCoupon.json",
        traditional:true,
        data:{couponId:couponId,orgId:orgId,type:carttype},
        dataType: "json",
        success:function(data) {
            if(data.success=="true"){
                reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                breadJDialog(result.errorObject.errorText,2000,"30px",true);
            }
        }
    });
}


//编辑地址
function btnAlt(receiverAddrId) {
    var zoneId;
    $.ajax({
        type:"post" ,
        url:webParams.webRoot+"/member/findAddressById.json",
        data:{id:receiverAddrId},
        dataType:"json",
        success:function(data) {
            $("#receiverName").val(data.result.name);
            $("#receiverMobile").val(data.result.mobile);
            $("#receiverAddress").val(data.result.addr);
            $("#receiveAddrId").val(data.result.receiveAddrId);
            addrLat = data.result.addrLat;
            addrLng = data.result.addrLng;
            addrLat1 = data.result.addrLat;
            addrLng1 = data.result.addrLng;
            if(!(addrLat || addrLng)){
                breadOrderJDialog("未选定具体位置，请编辑所在位置重新选定",1200,"10px",true);
                initAddReceiver();
            }else{
                initReceiver();
            }
            zoneId = data.result.zoneId;
            setAddrNm(zoneId, data.result.addr);
        }
    });
    $("#addrAddayer").show();
}


//设置同城送方式（因为设置后也是一个默认的配送方式，所以在此做判断）
function setDefaultAddress(obj,receiverAddrId, orgId){
    var selectObj = $(obj);
    $.ajax({
        type:"get",
        url:webParams.webRoot+"/member/setDefaultCitySendReceiveAddr.json",
        data:{receiveAddrId:receiverAddrId,sysOrgId:orgId},
        success:function(data) {
            if(data.success == 'true'){
                selectAddressFun(receiverAddrId,selectObj,"store");//默认是同城配送
            }else{
                if (data.errorCode != undefined && data.errorCode == 'login') {
                    breadJDialog("请先登录!",2000,"30px",true);
                } else {
                    breadJDialog("请重新选择配送地址!",2000,"30px",true);
                }
            }
        }
    });
}


//设置地址
function setAddrNm(zoneId,address) {
    $.ajax({
        type:"post" ,url:webParams.webRoot+"/member/zoneNm.json",
        data:{zoneId:zoneId},
        dataType:"json",
        success:function(data) {
            var defaultValue = [data.provinceNm,data.cityNm,data.zoneNm];
            addrOrderSelect.ld("api").selected(defaultValue);
            var addrPlace = data.cityNm + "," + data.zoneNm + address;
            locationGeocoder.getLocation(addrPlace);

        }
    })
}


function breadOrderJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal,         // 非模态，即不显示遮罩层
        autoMiddle:true
    });
    return dialog;
}

/*-------------------------地图地址----------------------------------*/

var locationMarker,locationMap,locationGeocoder = null;
var addrLat,addrLng = null;
var addrLat1,addrLng1 = null;

function initReceiver() {
    var center = new qq.maps.LatLng(addrLat, addrLng);
    locationMap = new qq.maps.Map(document.getElementById('receiverAddrMap'), {
        center: center,
        zoom: 13
    });

    locationGeocoder = new qq.maps.Geocoder({
        complete: function (result) {
            locationMap.setCenter(result.detail.location);
            locationMarker.setPosition(result.detail.location);
            addrLat1 = locationMap.getCenter().getLat();
            addrLng1 = locationMap.getCenter().getLng();
        },
        error: function(){
            breadJDialog("出错了，请输入正确的地址!",2000,"30px",true);
        }
    });
    locationMarker = new qq.maps.Marker({
        //设置Marker的位置坐标
        position: center,
        //设置显示Marker的地图
        map: locationMap,
        //设置Marker被添加到Map上时的动画效果为反复弹跳
        animation: qq.maps.MarkerAnimation.BOUNCE,
        //设置Marker被添加到Map上时的动画效果为从天而降
        //animation:qq.maps.MarkerAnimation.DROP
        //设置Marker被添加到Map上时的动画效果为落下
        //animation:qq.maps.MarkerAnimation.DOWN
        //设置Marker被添加到Map上时的动画效果为升起
        //animation:qq.maps.MarkerAnimation.UP
        draggable: true
    });
    qq.maps.event.addListener(locationMarker, 'dragend', function(event) {
        addrLat1 = event.latLng.getLat();
        addrLng1 = event.latLng.getLng();
    });

}

var initAddReceiver = function() {
    var center = new qq.maps.LatLng(39.916527, 116.397128);

    locationMap = new qq.maps.Map(document.getElementById('receiverAddrMap'), {
        center: center,
        zoom: 13
    });

    var citylocation = new qq.maps.CityService({
        //设置地图
        map : locationMap,
        complete : function(results){
            locationMap.setCenter(results.detail.latLng);
            locationMarker.setPosition(results.detail.latLng);
        }
    });
    citylocation.searchLocalCity();
    //调用地址解析类
    locationGeocoder = new qq.maps.Geocoder({
        complete : function(result){
            locationMap.setCenter(result.detail.location);
            locationMarker.setPosition(result.detail.location);
            addrLat1 = locationMap.getCenter().getLat();
            addrLng1 = locationMap.getCenter().getLng();
        },
        error: function(){
            breadJDialog("出错了，请输入正确的地址!",2000,"30px",true);
        }
    });
    locationMarker = new qq.maps.Marker({
        //设置Marker的位置坐标
        position: center,
        //设置显示Marker的地图
        map: locationMap,
        //设置Marker被添加到Map上时的动画效果为反复弹跳
        animation: qq.maps.MarkerAnimation.BOUNCE,
        //设置Marker被添加到Map上时的动画效果为从天而降
        //animation:qq.maps.MarkerAnimation.DROP
        //设置Marker被添加到Map上时的动画效果为落下
        //animation:qq.maps.MarkerAnimation.DOWN
        //设置Marker被添加到Map上时的动画效果为升起
        //animation:qq.maps.MarkerAnimation.UP
        draggable: true
    });
    qq.maps.event.addListener(locationMarker, 'dragend', function(event) {
        addrLat1 = event.latLng.getLat();
        addrLng1 = event.latLng.getLng();
    });

};

function analyzeAddress(){
    var  province=document.getElementById("receiverProvince");
    var provinceIndex=province.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var provinceName = province.options[provinceIndex].text;

    var  city=document.getElementById("receiverCity");
    var cityIndex=city.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var cityName = city.options[cityIndex].text;

    var  zone=document.getElementById("receiverZone");
    var zoneIndex=zone.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var zoneName = zone.options[zoneIndex].text;

    var addr = document.getElementById("receiverAddress").value;
    var selectedNum = 0;
    if(undefined != provinceName && provinceName != "" && provinceName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != cityName && cityName != "" && cityName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != zoneName && zoneName != "" && zoneName !='请选择'){
        selectedNum+=1;
    }

    if(undefined != addr && addr != ""){
        selectedNum+=1;
    }

    if(selectedNum == 4){
        var place = cityName + "," + zoneName + "," + addr;
        //通过getLocation();方法获取位置信息值
        locationGeocoder.getLocation(place);
    }
}

//因为用户可能第一次修改选择地址后，对地址进行二次修改，此时不会定位正确的地址;
//省级
function proviceSelected(obj){
    analyzeAddress();

}
//市级
function citySelected(obj){
    analyzeAddress();
}
//地区
function areaSelected(obj){
    analyzeAddress();
}



/*选中订单地址*/
var selectAddressFun = function(receiveAddrId,li,type){
    var cartType = type;
    var selectAddress = li;
    $.ajax({
        url:webParams.webRoot+"/cart/updateReceiver.json",
        data:({type:cartType,receiveAddrId:receiveAddrId,isCod:orderData.isCod}),
        async: false,
        success:function(data){
            if(data.success == "true"){
                $("#address-ul li").removeClass("active");
                selectAddress.addClass("active");
                //配送方式处理
                if(data.result == null){
                    return false;
                }
                checkInvalidCartItem(eval(data.unSupportDeliveryItemKeys));
                var deliveryRule = eval(data.result);

                for(var i = 0 ; i < deliveryRule.length; i++){
                    var saveDelivery = $(".saveDelivery[orgid="+deliveryRule[i].orgId+"]");
                    if(deliveryRule[i].deliveryRuleVoList.length == 0){
                        saveDelivery.hide();
                        //saveDelivery.next(".operationMsg").html("该地区不支持货到付款");
                    }else{
                        saveDelivery.show();
                        //saveDelivery.next(".operationMsg").hide();
                        var deliveryRuleVoList = deliveryRule[i].deliveryRuleVoList;
                        saveDelivery.empty();
                        saveDelivery.append('<option value="0">请选择配送方式</option>');
                        for(var drListIndex = 0;drListIndex < deliveryRuleVoList.length;drListIndex++){
                            var drv = deliveryRuleVoList[drListIndex];
                            var valueId = drv.deliveryRule.deliveryRuleId;
                            var valueNm = drv.deliveryRuleNm;
                            saveDelivery.append('<option value="'+valueId+'">'+valueNm+'</option>');
                        }
                    }
                }
                reload();
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

var checkInvalidCartItem=function(unSupportDeliveryItemKeys){
    if(invalidCartItems.length!=unSupportDeliveryItemKeys.length){
        window.location.reload();
    }
    //相同数量
    var sameCount = 0;
    for(var i=0;i<invalidCartItems.length;i++){
        for(var c=0;c<unSupportDeliveryItemKeys.length;c++){
            if(invalidCartItems[i]==unSupportDeliveryItemKeys[c]){
                sameCount++;
            }
        }
    }

    if(sameCount!=unSupportDeliveryItemKeys.length){
        window.location.reload();
    }
};

function reload(){
    $("#isNeedInvoice").val("N");
    $("#invoiceEntNm").val("");
    $("#invoiceTitle").val("");
    $("#invoiceCont").val("");
    $("#mainContent").load(webParams.webRoot + "/template/bdw/citySend/ajaxload/addOrderReload.jsp",{orgId:webParams.orgId,isCod:webParams.isCodStr,carttype:webParams.carttype},function(){});
}


//没有标题和按钮的提示框
function breadJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}





