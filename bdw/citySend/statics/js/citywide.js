
var addrSelect;//加载地区

// <%--加载地区 start--%>
function loadAddr() {
    return  $(".addressSelect").ld({ajaxOptions : {"url" : webParams.webRoot+"/member/addressBook.json"},
        defaultParentId:9,
        style:{"width": 100}
    });
}

$(document).ready(function(){

    $.cookie("addr", "", {
        path: "/"
    });

    var cityLocation,geocoder,map,searchService = null,prev = "", marker = null;
    var markerBuffer = [];

    geocoder = new qq.maps.Geocoder({
        complete:function(result){
            var detail = result.detail;
            var nearPois = detail.nearPois;
            var address = detail.address;
            var lat = detail.location.lat;
            var lng = detail.location.lng;
            var city = detail.addressComponents.city.replace("市", "");
            for(var i=0; i<zoneData.length; i++){
                if(zoneData[i].name == city){
                    $("#city-toggle").data("zoneId", zoneData[i].zoneId);
                }
            }
            $("#city-toggle").html(city);
            $(".g-city").html(city);
            getOrg(webParams.orgId);
        }
    });

    var center = new qq.maps.LatLng(39.916527,116.397128);
    map = new qq.maps.Map(document.getElementById('map'),{
        center: center,
        zoom: 12
    });

    var infoWin = new qq.maps.InfoWindow({
        map: map,
        zIndex:11
    });

    cityLocation = new qq.maps.CityService({
        complete : function(result){
            $("#cityToggle").blur();
            $("#cityToggle").val("");
            $(".city-dropdown").hide();
            $(".shop-dropdown").hide();
            $("#keyword").val("");
            map.setCenter(result.detail.latLng);
            var city = result.detail.name.replace("市", "");
            var zoneId;
            for(var i=0; i<zoneData.length; i++){
                if(zoneData[i].name == city){
                    zoneId = zoneData[i].zoneId;
                    $("#city-toggle").data("zoneId", zoneId);
                    break;
                }
            }
            $("#city-toggle").html(city);
            $(".g-city").html(city);
            init(zoneId, result.detail.latLng.lat, result.detail.latLng.lng, map);
        }
    });
    if(webParams.orgId && webParams.lat && webParams.lng){
        var latLng = new qq.maps.LatLng(webParams.lat, webParams.lng);
        geocoder.getAddress(latLng);
    }else{
        cityLocation.searchLocalCity();
    }


    searchService = new qq.maps.SearchService({
        pageCapacity: 10,
        autoExtend: false,
        complete: function(result){
            var pois = result.detail.pois;
            $("#search-result li").remove();
            for(var i=0;i<pois.length;i++){
                var p = pois[i];
                var name = p.name;
                var addr = p.address;
                var latlng = p.latLng;
                //拼接通过输入地址获取的地址列表
                $("#search-result").append("<li><a class='re' addr='"+addr+"-"+name+"' lat='"+latlng.lat+"' lng='"+latlng.lng+"' href='javascript:;' style='cursor:pointer;'>" + name + "</a></li>");
            }
        },
        error: function(){
            $("#search-result li").remove();
        }
    });

    /*qq.maps.event.addListener(map, 'click', function(event) {
     var latLng = event.latLng;
     geocoder.getAddress(latLng);
     });*/

    $("#keyword").focus(function(){
        $(".city-dropdown").slideUp();
    });

    $('#keyword').bind("propertychange input",function(event){
        var kw = $(this).val();
        $('#cityBox').show();
        if($.trim(kw) == ""){
            $("#cityBox").hide();
            $(".shop-dropdown").hide();
            return;
        }

        if(webParams.mapkey.trim().length==0||webParams.mapkey==null){
            search(kw);
        }else{
            apisMapQQSearch(kw);
        }
    });


    $("#addressList .btn-org").live("click",function(){
        var lat = $(this).attr("lat");
        var lng = $(this).attr("lng");
        var addr = $(this).attr("addr");
        //var latLng = new qq.maps.LatLng(lat, lng);
        //geocoder.getAddress(latLng);
        $("#addressLayer").hide();
        $(".shop-dropdown").hide();
        $("#keyword").val("");
        dealCookie("addr", addr);
        searchOrg(lat, lng, {lat:lat, lng:lng, addr:addr});
    });

    function apisMapQQSearch(keyword){
        var cm = $("#city-toggle").text();
        $.ajax({
            type: "GET",
            url: "http://apis.map.qq.com/ws/place/v1/search?boundary=region("+cm+",0)&keyword="+keyword+"&key="+webParams.mapkey+"&output=jsonp",
            dataType: "jsonp",
            jsonp:"callback",
            jsonpCallback:"QQmap",
            success: function(json){
                $("#search-result a").remove();
                $.each(json.data, function(i, item) {
                    $("#search-result").append("<li><a class='re' addr='"+item.address+"-"+item.title+"' lat='"+item.location.lat+"' lng='"+item.location.lng+"' href='javascript:;'>" + item.title + "</a></li>");
                });
            }
        });
    }

    $("#keyword").keydown(function(e){
        if(e.keyCode == 38){//向上
            if($("#search-result a.cur").length == 0){
                var last = $("#search-result a:last");
                last.addClass("cur");
                $("#keyword").val(last.text());
                $("#search-result")[0].scrollTop = $("#search-result")[0].scrollHeight;
            }else{
                var obj = $("#search-result a.cur");
                if(obj.index() > 4){
                    $("#search-result")[0].scrollTop =  $("#search-result")[0].scrollTop - $("#search-result a").outerHeight(true);
                }
                obj.removeClass("cur");
                if(obj.prev("a").length != 0){
                    obj.prev().addClass("cur");
                    $("#keyword").val(obj.prev().text());
                }else{
                    var last = $("#search-result a:last");
                    last.addClass("cur");
                    $("#keyword").val(last.text());
                    $("#search-result")[0].scrollTop = $("#search-result")[0].scrollHeight;
                }
                return false;
            }
        }else if(e.keyCode == 40){
            if($("#search-result a.cur").length == 0){
                var first = $("#search-result a:first");
                first.addClass("cur");
                $("#keyword").val(first.text());
            }else{
                var obj = $("#search-result a.cur");
                if(obj.index() >= 4){
                    $("#search-result")[0].scrollTop =  $("#search-result")[0].scrollTop + $("#search-result a").outerHeight(true);
                }
                obj.removeClass("cur");
                if(obj.next("a").length != 0){
                    obj.next("a").addClass("cur");
                    $("#keyword").val(obj.next().text());
                }else{
                    var first = $("#search-result a:first");
                    first.addClass("cur");
                    $("#keyword").val(first.text());
                    $("#search-result")[0].scrollTop = 0;
                }
            }
        }else if(e.keyCode == 13){
            enterPress();
        }
        e.stopPropagation();
    });

    $("#cityToggle").autocomplete({
        source: zoneData,
        focus: function( event, ui ) {
            $( "#cityToggle" ).val( ui.item.name );
            return false;
        },
        select: function( event, ui ) {
            $( "#cityToggle" ).val( ui.item.name );
            cityLocation.searchCityByName(ui.item.name + "市");
            return false;
        }
    }).data( "autocomplete" )._renderItem = function( ul, item ) {
        return $( "<li></li>" )
            .data( "item.autocomplete", item )
            .append( "<a>" + item.name +"</a>" )
            .appendTo( ul );
    };

    $("#cityToggle").bind("keydown", function(e){
        if(e.keyCode == 13 && $(".ui-autocomplete").css("display") == "block"){
            var obj = $(".ui-autocomplete .ui-corner-all:first");
            var city = obj.text();
            cityLocation.searchCityByName(city + "市");
        }
    });

    $("#se").click(function(){
        var obj = $(".ui-autocomplete .ui-corner-all:first");
        if($(".ui-autocomplete").css("display") == "block" && obj){
            cityLocation.searchCityByName(obj.text() + "市");
        }
    });

    $("#search-result li").live("click", function(){
        $(this).addClass("cur");
        enterPress();
        $("#keyword").val($(this).text());
    });

    $(".bot-ct .city-item").live("click", function(){
        var city = $(this).attr("cm");
        cityLocation.searchCityByName(city + "市");
        $("#city-toggle").data("zoneId", $(this).attr("zoneid"));
    });


    $("#search").click(function(){
        var kw = $("#keyword").val();
        if(!kw ||kw.trim().length == 0){
            breadJDialog("请输入配送地址",1000,"10px",true);
            return false;
        }
        if(webParams.mapkey.trim().length==0||webParams.mapkey==null){
            search(kw);
        }else{
            apisMapQQSearch(kw);
        }
        enterPress();
    });

    $(".shop-dropdown .shops-w").live("click", function(){
        var lat = $(this).attr("lat");
        var lng = $(this).attr("lng");
        var orgId = $(this).attr("orgId");
        var isSupport =  $(this).attr("isSupport");
        $("#isSupport"+orgId).attr("isSupport",isSupport);
        //设置属性
        $(".marker_"+orgId).trigger("click");
        $(".pr-td").hide();
    });

    $(".info-window a").live("click", function(){
        var lat = $(this).attr("lat");
        var lng = $(this).attr("lng");
        var zoneId = $("#city-toggle").data("zoneId");
        var addr = $(this).attr("addr");
        if(lat && lng){
            window.open(webParams.webRoot + "/citySend/storeList.ac?lat="+lat +"&lng="+lng);
        }
    });


    $(document).bind("click", function(e){
        if(!$(e.target).is("#keyword")){
            $("#search-result").hide();
        }
    });

    $("#city-toggle").click(function(){
        $(".city-dropdown").slideToggle();
    });

    $(".btn-addr").click(function(){
        $(".locate-dropdown").show();
        $(".city-dropdown").slideUp();
    });

    $(".layer .close").click(function(){
        $(this).parents(".layer").hide();
    });

    $(".hover").hover(function(){
        $(this).addClass("cur");
    }, function(){
        $(this).removeClass("cur");
    });

    function enterPress(){
        var obj = $("#search-result a.cur");
        if($("#search-result a").length == 0){
            return false;
        }
        if(obj.length == 0){
            obj = $("#search-result a:first");
        }
        $("#cityBox").hide();
        var lat = obj.attr("lat");
        var lng = obj.attr("lng");
        var name = obj.text();
        var addr = obj.attr("addr");
        load($("#city-toggle").data("zoneId"), lat, lng, addr);
        searchOrg(lat, lng, {lat:lat, lng:lng, addr:addr});
        //showInfoWin(lat, lng, name, addr);
    }

    function search(kw){
        var cm = $("#city-toggle").text();
        searchService.setLocation(cm);
        searchService.search(kw);
    }

    function load(zoneId, lat, lng, keyword){
        $.get(webParams.webRoot + "/citySend/loadCityWide.ac", {zoneId:zoneId, lat:lat, lng: lng, keyword: keyword}, function(data){
            dealCookie("addr", keyword);
            $(".shop-dropdown").html('');
            $(".shop-dropdown").append(data);
            $(".shop-dropdown").show();
        })
    }

    function showInfoWin(lat, lng, name, addr){
        var center = new qq.maps.LatLng(lat, lng);
        map.setCenter(center);
        var infoWin = new qq.maps.InfoWindow({
            map: map
        });
        if(marker){
            marker.setMap(null);
        }
        var zoneId = $("#city-toggle").data("zoneId");
        count(zoneId, lat, lng, function(count){
            marker = infoWin;
            infoWin.open();
            var content = "";
            if(count > 0){
                content = "<div class='info-window'><h3>"+name+"</h3><p>"+addr+"</p><span>附近门店<em>"+count+"</em></span><a addr='"+encodeURI(addr)+"' lat='"+lat+"' lng='"+lng+"' zoneId='" + zoneId + "' title='附近门店' href='javascript:;'>附近门店</a></div>"
            }else{
                content = "<div class='info-window'><h3>"+name+"</h3><p>"+addr+"</p><span>附近门店<em>"+count+"</em></span></div>"
            }
            infoWin.setContent(content);
            infoWin.setPosition(center);
            $("#cityBox").hide();
        });
    }

    function count(zoneId, lat, lng, callback){
        $.ajax({
            data: {zoneId:zoneId, lat:lat, lng: lng, keyword: ''},
            url: webParams.webRoot + "/citySend/count.json",
            async: false,
            success:function(data) {
                if(data.success == "true"){
                    callback(data.result);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    }

    //地图初始化时显示当前定位市区的门店
    function init(zoneId, lat, lng, map){
        if(!zoneId || !map)return;
        $.ajax({
            data:{zoneId: zoneId, lat: lat, lng: lng},
            url: webParams.webRoot + "/citySend/load.json",
            success:function(data) {
                if(data.success == "true"){
                    clearMarker();
                    for(var i in data.result){
                        addMarker(data.result[i], i, true);
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    }

    function searchOrg(lat, lng, obj){
        if(!lat || !lng)return;
        $.ajax({
            data:{lat: lat, lng: lng},
            url: webParams.webRoot + "/citySend/search.json",
            success:function(data) {
                if(data.success == "true"){
                    clearMarker();
                    var position = new qq.maps.LatLng(lat, lng);
                    map.setCenter(position);
                    for(var i in data.result){
                        addMarker(data.result[i], i, false, obj);
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    }

    function getOrg(orgId){
        $.ajax({
            data:{id: orgId},
            url: webParams.webRoot + "/citySend/detail.json",
            success:function(data) {
                if(data.success == "true"){
                    clearMarker();
                    addMarker(data.result, 0, true);
                    setTimeout(function(){
                        $(".marker_"+orgId).trigger("click");
                    }, 100);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    }

    function addMarker(data, i, init, param){
        var position = new qq.maps.LatLng(data.outletLatStr || data.outletLat , data.outletLngStr || data.outletLng);
        var marker = new MyOverlay("marker_"+data.sysOrgId, position, parseInt(i)+1, data.shopNm,function(obj){
            infoWin.open();
            var content = "";var pic = data.shopPicUrl;
            if(undefined == pic || null == pic || ""== pic){
                pic = webParams.webRoot + "/template/bdw/statics/images/noPic_100X100.jpg";
            }else{
                pic = webParams.webRoot + "/upload/"+pic;
            }
            var href;
            if(param){
                var lng = param.lng;
                var lat = param.lat;
                href = webParams.webRoot+"/citySend/storeDetail.ac?orgId="+data.sysOrgId+"&lng="+lng+"&lat="+lat;
            }else{
                href = webParams.webRoot+"/citySend/storeDetail.ac?orgId="+data.sysOrgId;
            }
            var contactWay = data.tel;
            if(null == contactWay || "" == contactWay){
                contactWay = data.mobile;
            }
            if(null == contactWay || "" == contactWay){
                contactWay = "暂无联系方式";
            }
            var orgId = data.sysOrgId;
            content = "<div class='site'><div class='site-box'><div class='title elli'>"+data.shopNm+"</div><div class='pic'><img  width='100' height='100' src='"+pic+"'></div><a href='javascript:void(0);' class='ck-btn' isSupport ='"+data.isSupportBuy+"' orgName='"+data.shopNm+"' orgLink='"+href+"' id='isSupport"+orgId+"'>门店详情</a><div class='pa-rt'><div class='pa-add'><span>地址：</span>"+data.outStoreAddress+"</div> <div class='pa-call'><span>电话：</span>"+contactWay+"</div></div></div></div>";
            //}
            infoWin.setContent(content);
            infoWin.setPosition(obj.position);
            map.setCenter(obj.position);
       });
        marker.setMap(map);
        markerBuffer.push(marker);
        return marker;
    }


    //验证门店是否支持购买，若不支持购买则不能进入门店
    $(".ck-btn").live("click",function(){
        var isSupport = $(this).attr("isSupport");
        var orgName = $(this).attr("orgName");
        var orgLink = $(this).attr("orgLink");
        if(undefined != isSupport && null != isSupport && isSupport!=""){
            if(isSupport == 'N'){
                breadJDialog(orgName+"暂不支持购买,请选择其他门店!",1000,"10px",true);
                return;
            }
        }
        window.location.href = orgLink;


    });

    function clearMarker(){
        if(infoWin){
            infoWin.close();
        }
        for(var i=0;i<markerBuffer.length;i++){
            markerBuffer[i].setMap(null);
        }
        markerBuffer.length = 0;
    }

    function MyOverlay(classNm, position, content, title, clickFun){
        this.classNm = classNm;
        this.position = position;
        this.content = content;
        this.title = title;
        this.clickFun = clickFun;
    }

    MyOverlay.prototype = new qq.maps.Overlay();
    MyOverlay.prototype.construct = function(){
        var div = this.div = document.createElement("div");
        var style = this.div.style;
        style.position = "absolute";
        style.width = "26px";
        style.height = "33px";
        style.background = "url('/template/bdw/citySend/statics/images/addr-icon3.png') no-repeat";
        style.textAlign = "center";
        style.lineHeight = "26px";
        style.paddingTop = "2px",
        style.fontSize = "14px",
        style.right = "300px",
        style.color = "#fff",
        style.border = "none";
        style.cursor = "pointer";
        this.div.title = this.title;
        this.div.className = this.classNm;
        this.div.innerHTML = this.content;

        var panes = this.getPanes();
        panes.overlayMouseTarget.appendChild(div);
        var _this = this;
        this.div.onclick = function(){
            _this.clickFun(_this);
        }
    };
    MyOverlay.prototype.draw = function(){
        var projection = this.getProjection();
        var pixel = projection.fromLatLngToDivPixel(this.position);
        var style = this.div.style;
        style.left = pixel.x - 13.5 + "px";
        style.top = pixel.y - 16 + "px";
    };
    MyOverlay.prototype.destroy = function(){
        this.div.onclick = null;
        this.div.parentNode.removeChild(this.div);
        this.div = null;
    };


    //选择配送地址
    $("#selectAddr").click(function(){
        var userId = Top_Path.userId;
        if(undefined == userId || null == userId || "" == userId) {
            showUserLogin();
        }else{
            $("#addressLayer").show();
            initLocatedMap();
        }

    });

    //关闭地址弹窗
    $("#closeAddrLayer").click(function(){
        $("#addressLayer").hide();
    });

    $("#addAddr").click(function(){
        addrSelect = loadAddr();
        $("#addAddressLayer").show();
        clearAddressCont();

    });

    $("#cancelBtn").click(function(){
        $("#addAddressLayer").hide();
        clearAddressCont();
    });

    //新增收货地址
    $("#saveAddrBtn").click(function(){
        var name = $.trim($("#name").val());
        var mobile = $.trim($("#mobile").val());
        var zoneId = $("#zone").val();
        var city = $("#city").find("option:selected").text();
        var area = $("#zone").find("option:selected").text();
        var addr = $.trim($("#address").val());

        name = name.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        name = name.replace(/<.*?>/g, "");
        mobile = mobile.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        mobile = mobile.replace(/<.*?>/g, "");
        addr = addr.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig, "");
        addr = addr.replace(/<.*?>/g, "");

        if(undefined == name || null == name || "" == name){
            breadJDialog("收货人不能为空!",2000,"30px",true);
            return;
        }else{
            if(name.length<2||name.length>20){
                breadJDialog("收货人姓名的长度为2-20个字!",1200,"10px",true);
                return;
            }
        }

        if(undefined == mobile || null == mobile || "" == mobile){
            breadJDialog("手机号码不能为空!",1200,"10px",true);
            return;
        }else{
            if(mobile.length != 11){
                breadJDialog("手机号长度只能是11位数字!",1200,"10px",true);
                return;
            }else{
                var strP=/^13[0-9]{9}|15[0-99][0-9]{8}|18[0-9][0-9]{8}|147[0-9]{8}|177[0-9]{8}|170[0-9]{8}|176[0-9]{8}$/;
                if(!strP.test(mobile)){
                    breadJDialog("请输入正确的手机号码!",1200,"10px",true);
                    return;
                }
            }
        }


        if(undefined == zoneId || null == zoneId || "" == zoneId){
            breadJDialog("请输入收货人所在地!",1200,"10px",true);
            return;
        }else{
            if(zoneId == '请选择'){
                breadJDialog("请输入收货人所在地!",1200,"10px",true);
                return;
            }
        }

        if(undefined == addr || null == addr || "" == addr){
            breadJDialog("请输入配送地址!",1200,"10px",true);
            return;
        }else{
            if(addr.length>50){
                breadJDialog("请输入小于50个字符!",1200,"10px",true);
                return;
            }
        }

        if(undefined == newLat || null == newLat || ""==newLat) {
            breadJDialog("请输入正确的收货地址",1200,"10px",true);
            return;
        }

        if(undefined == newLng || null == newLng || ""==newLng) {
            breadJDialog("请输入正确的收货地址",1200,"10px",true);
            return;
        }

        var data ={
            name:name,
            addr:addr,
            mobile:mobile,
            zoneId :zoneId
        };

        data.addrLat = newLat;
        data.addrLng = newLng;

        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url:webParams.webRoot+"/member/receiverAddress/saveOrUpdate.json",
            data: data,
            dataType: "json",
            success:function(data) {
                if (data.success == true) {
                    var addressContent = "";
                    for(var i in data.result){
                        var addressProxy = data.result[i];
                        var addressPath = addressProxy.addressPath;
                        var addressStr = addressProxy.addressStr;
                        var lat = addressProxy.lat;
                        var lng = addressProxy.lng;
                        addressContent += "<li class='cur'><span class='elli'><em>"+addressPath+"</em>"+addressStr+"</span><a addr='"+addressPath+addressStr+"' lat='"+lat+"' lng='"+lng+"' class='btn btn-org' href='javascript:;' title='选择'>选择</a></li>";
                    }
                    newLat = null;
                    newLng = null;
                    $("#addressList").html(addressContent);
                    breadJDialog("保存地址成功!",2000,"30px",true);
                    $("#addressLayer").hide();
                    clearAddressCont();

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

    // 点击地图中进行附近店铺的收缩
    $(".main").click(function(){
        $(".pr-td").slideUp();
    });
    $(".pr-th").live('mouseover',function(){
        console.log(1);
        $(".pr-td").slideDown();
    });
});

function clearAddressCont(){
    $("#name").val("");
    $("#mobile").val("");
    $("#zone").val("");
    $("#province option[value='请选择']").attr("selected", true);
    $("#city option[value='请选择']").attr("selected", true);
    $("#zone option[value='请选择']").attr("selected", true);
    $("#address").val("");
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

var initGeocoder, initMap, initMarker = null;
var newLat, newLng = null;

var initLocatedMap = function() {
    var center = new qq.maps.LatLng(39.916527, 116.397128);

    initMap = new qq.maps.Map(document.getElementById('addMap'), {
        center: center,
        zoom: 13
    });

    var citylocation = new qq.maps.CityService({
        //设置地图
        map : initMap,
        complete : function(results){
            initMap.setCenter(results.detail.latLng);
        }
    });
    citylocation.searchLocalCity();
    //调用地址解析类
    initGeocoder = new qq.maps.Geocoder({
        complete : function(result){
            initMap.setCenter(result.detail.location);
            initMarker.setPosition(result.detail.location);
            newLat = initMap.getCenter().getLat();
            newLng = initMap.getCenter().getLng();
        },
        error: function(){
            breadJDialog("出错了，请输入正确的地址!",2000,"30px",true);
        }
    });
    initMarker = new qq.maps.Marker({
        //设置Marker的位置坐标
        position: center,
        //设置显示Marker的地图
        map: initMap,
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
    qq.maps.event.addListener(initMarker, 'dragend', function(event) {
        newLat = event.latLng.getLat();
        newLng = event.latLng.getLng();
    });

};


function locatedAddress(){
    var  province=document.getElementById("province");
    var provinceIndex=province.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var provinceName = province.options[provinceIndex].text;

    var  city=document.getElementById("city");
    var cityIndex=city.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var cityName = city.options[cityIndex].text;

    var  zone=document.getElementById("zone");
    var zoneIndex=zone.selectedIndex ;             // selectedIndex代表的是你所选中项的index
    var zoneName = zone.options[zoneIndex].text;

    var addr = document.getElementById("address").value;

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
        initGeocoder.getLocation(place);
    }
}

//因为用户可能第一次修改选择地址后，对地址进行二次修改，此时不会定位正确的地址;
//省级
function proviceSelected(obj){
    locatedAddress();

}
//市级
function citySelected(obj){
    locatedAddress();
}
//地区
function areaSelected(obj){
    locatedAddress();
}




