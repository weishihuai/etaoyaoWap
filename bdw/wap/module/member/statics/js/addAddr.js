$(function () {

    $(".site-select-box").on("click", ".dd ul li", function () {
        var parent = $(this).parent();
        parent.children("li").removeClass("cur");
        $(this).addClass("cur");
        var sysTreeNodeId = $(this).attr("data-sys-tree-node-id");
        var type = parent.attr("data-type");
        var sysTreeNodeNm = $(this).html();
        if (type == "area"){
            $(".dd-toggle p[data-type='area']").html(sysTreeNodeNm);
            var zoneId = $(".site-select-box ul[data-type='area'] li.cur").attr("data-sys-tree-node-id");
            if(!zoneId){
                alert("请选择完整的地区");
                return false;
            }
            $(".site-select-layer").hide();
            var result = "";
            $(".site-select-box ul.dd-list li.cur").each(function () {
                result += $(this).html();
            });
            $("#geocoderLocation").val($("#city li.cur").html() + "," + $("#area li.cur").html());
            $("#zoneId").val(zoneId);
            $("#addrPath").val(result);
        }else {
            $.ajax({
                async: false,
                data: {sysTreeNodeId: sysTreeNodeId},
                url: webPath.webRoot + "/member/addressBook.json",
                success: function (data) {
                    if (data.result.length > 0) {
                        var nextType = getNextType(type);
                        var html = "";
                        for (var i = 0; i < data.result.length; i++){
                            var d = data.result[i];
                            html += "<li data-sys-tree-node-id='"+ d.sysTreeNodeId +"'>"+ d.sysTreeNodeNm +"</li>";
                        }
                        $(".site-select-box .dd ul").hide();
                        $("ul[data-type='"+ nextType +"']").html("").html(html).show();
                        var curP = $(".site-select-box .dd p.cur");
                        if (nextType == "city"){
                            curP.html(sysTreeNodeNm);
                            curP.removeClass("cur");
                            if(curP.next("p").length > 0){
                                curP.next("p").addClass("cur").html("选择市");
                            }else {
                                $(".site-select-box .dd-toggle").append("<p data-type='"+ nextType +"' class='cur'>选择市</p>");
                            }
                        }else if(nextType == "area"){
                            curP.html(sysTreeNodeNm);
                            curP.removeClass("cur");
                            if(curP.next("p").length > 0){
                                curP.next("p").addClass("cur").html("选择区");
                            }else {
                                $(".site-select-box .dd-toggle").append("<p data-type='"+ nextType +"' class='cur'>选择区</p>");
                            }
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    var result  = eval("("+ XMLHttpRequest.responseText +")");
                    alert(result.errorObject.errorText);
                }
            });
        }

    }).on("click", ".dd-toggle p", function () {
        $(this).parent().children("p").removeClass("cur");
        $(this).addClass("cur");
        var type = $(this).attr("data-type");
        $(".site-select-box .dd ul").hide();
        $(".site-select-box .dd ul[data-type='"+ type +"']").show();
    });

    $(".site-select-box .close-btn").click(function () {
        $(".site-select-layer").hide();
    });


    $("#addrPath").click(function () {
        $(".site-select-layer").show();
    });

    $(".add-site-main input").bind("keyup", function (e) {
        checkInput();
    });

    var geocoder = new qq.maps.Geocoder({
        complete: function (result) {
            var location = result.detail.location;
            submit($("#name").val(), $("#addr").val(), $("#mobile").val(), $("#zoneId").val(), location.lat, location.lng);
        },
        error: function(){
            submit($("#name").val(), $("#addr").val(), $("#mobile").val(), $("#zoneId").val(), 0, 0);
            console.log("定位失败");
        }
    });

    $(".m-sub a").click(function () {
        if($(this).hasClass("disable")){
            return false;
        }

        var name = $("#name").val();
        var mobile = $("#mobile").val();
        var zoneId = $("#zoneId").val();
        var addr = $("#addr").val();
        geocoder.getLocation($("#geocoderLocation").val() + "," + addr);
    });

    function submit(name, addr, mobile, zoneId, lat, lng) {
        $.ajax({
            type: "POST",
            url: webPath.webRoot + "/member/receiverAddress/saveOrUpdate.json",
            data: {receiveAddrId: $("#id").val(), name:name, addr:addr, mobile:mobile, zoneId :zoneId, addrLat:lat, addrLng:lng},
            success:function(data) {
                if (data.success) {
                    if (webPath.redirectUrl){
                        window.location.href = decodeURIComponent(webPath.redirectUrl);
                    }else {
                        window.location.href = webPath.webRoot + "/wap/module/member/addrManage.ac";
                    }
                } else {
                    if(data.errorCode == "errors.login.noexist"){
                        alert("您的收货地址已满10个，不能再继续添加!");
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                var result  = eval("("+ XMLHttpRequest.responseText +")");
                alert(result.errorObject.errorText);
            }
        });
    }

    function checkInput() {
        if($("#name").val() && /^1\d{10}$/.test($("#mobile").val()) && $("#zoneId").val() && $("#addr").val()){
            $(".m-sub a").removeClass("disable");
        }else {
            $(".m-sub a").addClass("disable");
        }
    }

    function getNextType(type) {
        if (type == "province"){
            return "city";
        }else if (type == "city"){
            return "area";
        }
        return "";
    }
});

function goToBottom() {
    $('html, body').animate({
        scrollTop: $("#addr").offset().top-150
    }, 300);
}