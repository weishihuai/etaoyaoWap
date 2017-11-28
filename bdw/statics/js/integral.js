/**
 * 积分列表页分页跳转
 **/
$(document).ready(function () {


    //积分类别选择
    $(".cho-cont .integralModeBtn").click(function () {
        if (!$(this).hasClass("cur")) {
            $(".cho-cont .integralCashModeBtn").removeClass("cur");
            $(this).addClass("cur");
            $(".r_Data .p3").css("display", "none");
            $(".r_Data .p2").css("display", "block");
        }
    });
    $(".cho-cont .integralCashModeBtn").click(function () {
        if (!$(this).hasClass("cur")) {
            $(".cho-cont .integralModeBtn").removeClass("cur");
            $(this).addClass("cur");
            $(".r_Data .p2").css("display", "none");
            $(".r_Data  .p3").css("display", "block");
        }
    });


    $("#pageUp").click(function () {
        if (parseInt(data.page) - 1 == 0) {
            alert("当前已是第一页");
            return;
        }
        data.page = parseInt(data.page) - 1;
        /*goToUrl(data.webRoot + "/integral/integralList.ac?categoryId=" + data.categoryId + "&min=" + data.min + "&max=" + data.max + "&page=" + page);*/
        goToUrl(data.webRoot + "/jfhg.ac?categoryId=" + data.categoryId + "&min=" + data.min + "&max=" + data.max + "&page=" + page);
    });

    $("#pageDown").click(function () {
        if (parseInt(data.page) + 1 > parseInt(data.lastPageNumber)) {
            alert("当前已是最后一页");
            return;
        }
        data.page = parseInt(data.page) + 1;
        /*goToUrl(data.webRoot + "/integral/integralList.ac?categoryId=" + data.categoryId + "&min=" + data.min + "&max=" + data.max + "&page=" + page);*/
        goToUrl(data.webRoot + "/jfhg.ac?categoryId=" + data.categoryId + "&min=" + data.min + "&max=" + data.max + "&page=" + page);
    });
});

/**
 * 重置筛选
 * */
function resetValue() {
    $("#min").val("");
    $("#max").val("");
}

function searchIntegral() {
    var min = $.trim($("#min").val());
    var max = $.trim($("#max").val());
    var matchStr = /^\d+$/;
    if (matchStr.test(max) == false || matchStr.test(min) == false) {
        alert("请输入正确的积分范围！");
        return false;
    }
    setTimeout(function () {
        $('#integralForm').submit();
    }, 1)
}

//加载联动地址栏函数声明
var addrSelect;

$(document).ready(function () {
    /*弹出层*/
    /*$("#addAddress").click(function(){
     showMyAddress();
     });*/
    $(".closeMyAddress").click(function () {
        hideMyAddress()
    });
    var showMyAddress = function () {
        easyDialog.open({
            container: 'myAddress',
            fixed: false,
            /*        yesFn : btnFn,*/
            noFn: true
        });
    };
    var hideMyAddress = function () {
        easyDialog.close();
        $('#userAddrForm')[0].reset();
    };

    //加载联动地址栏
    addrSelect = $(".addressSelect").ld(
        {
            ajaxOptions: {"url": webPath.webRoot + "/member/addressBook.json"},
            defaultParentId: 9,
            style: {"width": 100}
        });
    //选择地址栏
    $(".selectAddres").find("input").click(function () {
        var path = $(this).attr("addressPath");
        $(".showAddress_path").val(path);
        var paths = path.split("-");
        var provinceNm = paths[2];
        var cityNm = paths[3];
        var zoneNm = paths[4];
        var name = $(this).attr("addrname");
        var addrmobile = $(this).attr("addrmobile");
        var addrzip = $(this).attr("addrzip");
        var address = $(this).attr("address");
        var addrtel = $(this).attr("addrtel");
        addrSelect.ld("api").selected([$.trim(provinceNm), $.trim(cityNm), $.trim(zoneNm)]);

        $("#receiverName").val(name);
        $("#receiverAddr").val(address);
        $("#receiverMobile").val(addrmobile);
        $("#receiverZipcode").val(addrzip);
        $("#receiverTel").val(addrtel);

    });

    //选中数量验证
    $(".prd_subNum").click(function () {
        var value = $(".prd_num").val();
        var num = parseInt(value) - 1;
        if (num == 0) {
            return;
        }
        $(".prd_num").val(num);
        $(".addcart").attr("num", num);
    });

    $(".prd_num").change(function () {
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);

        }
    });

    $(".prd_addNum").click(function () {
        var value = $(".prd_num").val();
        var num = parseInt(value) + 1;
        $(".prd_num").val(num);
    });

    /*积分兑换提交表单*/
    $("#saveAddress").click(function () {
        if ($("#receiverZipcode").val() == "") {
            setTimeout(function () {
                $("#receiverZipcodeTip").empty();
            }, 30);
        }
        if ($("#receiverTel").val() == "") {
            setTimeout(function () {
                $("#receiverTelTip").empty();
            }, 30);
        }
        $('#userAddrForm').submit();
    });
    //积分兑换
    $(".addcart").click(function () {
        var isLogin = $(this).attr("isLogin");
        if (isLogin == "true") {
            goToUrl(webPath.webRoot + "/login.ac");
            return;
        }
        //获取账户余额
        var userIntegral = parseFloat($(this).attr("userIntegral"));
        //获取固定积分
        var price = parseFloat($(this).attr("price"));
        //获取部分积分
        var exchangeIntegral = parseFloat($(this).attr("exchangeIntegral"));
        //获取交换类型
        var integralExchangeType = $(".cho-cont .cur").attr("integralExchangeType");
        //获取选择的数量
        var prd_num = parseInt($(".prd_num").val());
        //固定积分 判断 积分是否足够
        if (integralExchangeType == '0' && userIntegral < price * prd_num) {
            alert("对不起,您的积分不足,无法兑换");
            return;
        }
        //部分积分+现金 判断 积分是否足够
        if (integralExchangeType == '1' && userIntegral < exchangeIntegral * prd_num) {
            alert("对不起,您的积分不足,无法兑换");
            return;
        }

        var objectid = $(this).attr("objectid");
        //var num=$(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        var type = $(this).attr("type");
        var usernum = parseInt($(this).attr("num"));
        //判断库存，购买的数量是否超过库存
        if (usernum < 0 || usernum < prd_num) {
            alert("对不起,库存不足");
            return;
        }
        //积分商品ID、数量
        $("#oid").val(objectid);

        if (type == "0") {
            //  showMyAddress();
            goToUrl(webPath.webRoot + "integralOrderadd.ac?integralProductId=" + objectid + "&integralExchangeType=" + integralExchangeType + "&num=" + prd_num);
            // window.location.href=webPath.webRoot+"integralOrderadd.ac?integralProductId="+objectid+"&num="+prd_num+"&integralExchangeType="+integralExchangeType;
        } else {
            if (confirm("您确认要兑换此购物券吗？")) {
                $.ajax({
                    url: webPath.webRoot + "/cart/add.json",
                    data: {type: carttype, objectId: objectid, quantity: num, handler: handler},
                    dataType: "json",
                    success: function (data) {
                        alert("兑换成功,请到会员专区查看");
                        goToUrl(webPath.webRoot + "/module/member/myCoupon.ac?menuId=51543");
                    },
                    error: function (XMLHttpRequest, textStatus) {
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(result.errorObject.errorText);
                        }
                    }
                });
            }
        }


    });

    //加载地址表单验证控件
    $.formValidator.initConfig({
        formID: "userAddrForm", theme: 'ArrowSolidBox', onError: function (msg) {
            alert(msg)
        }, inIframe: true, ajaxForm: {
            dataType: "json",
            url: webPath.webRoot + "/integralOrder/addOrder.json",
            buttons: $("#saveAddress"),
            async: true,
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    hideMyAddress();
                    alert(result.errorObject.errorText);
                }
            },
            //error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
            success: function (data) {
                hideMyAddress();
                alert("提交订单成功");
                window.location.href = webPath.webRoot + "/module/member/integralOrderList.ac";
//            hideMyAddress();
            }
        }
    });

    /*新地址验证*/
    $("#receiverName").formValidator({
        onShow: "请输入收货人姓名",
        onFocus: "输入收货人的姓名（中文2~5个字，英文4~10个字母）"
    }).inputValidator({min: 4, max: 10, onError: "请正确输入您的姓名（中文2~5个字，英文4~10个字母）"});

    $("#zone").formValidator({
        onShow: "请输入收货人所在地",
        onFocus: "请输入收货人所在地"
    }).inputValidator({min: 1, onError: "地区信息不完整！"});


    $("#receiverAddr").formValidator({
        onShow: "请输入收货地址",
        onFocus: "请输入收货地址"
    }).inputValidator({min: 1, max: 125, onError: "请输入少于125个字符！"});

    $("#receiverMobile").formValidator({
        onShow: "请输入手机号码"
        , onFocus: "请输入手机号码",
        tipCss: {width: 200}, tipID: "receiverMobileTip"
    }).
        inputValidator({min: 11, max: 11, onError: "手机号码必须是11位的,请确认"}).
        regexValidator({regExp: "mobile", dataType: "enum", onError: "你输入的手机号码格式不正确"});

    $("#receiverTel").formValidator({
        empty: true, onShow: "请输入你的联系电话，可以为空哦",
        onFocus: "格式例如：0577-88888888", tipCss: {width: 200}
    }).regexValidator({regExp: "^(([0\\+]\\d{2,3}-)?(0\\d{2,3})-)?(\\d{7,8})(-(\\d{3,}))?$", onError: "你输入的联系电话格式不正确"});

    $("#receiverZipcode").formValidator({
        empty: true,
        onShow: "请输入正确的邮政编码",
        onFocus: "有助于快速确定送货地址"
    }).inputValidator({min: 6, max: 6, onError: "您输入的邮政编码有误"});

});

function removeTheSign(Obj, tip) {
    if ($(Obj).val() == "") {
        setTimeout(function () {
            $("#" + tip).empty();
        }, 30);
    }
}
