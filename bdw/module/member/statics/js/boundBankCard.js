$(document).ready(function () {

    $("input").keypress(function () {
        $("#alert").hide();
        $("#alert1").hide();
        $("#alert2").hide();
        $("#alert3").hide();
    });

    $("#btnAdd").click(function () {
        var userName = $.trim($("#userName").val());
        var bankCardNum = $.trim($("#bankCardNum").val());
        var userTelephone = $.trim($("#userTelephone").val());
        var userIdentityCardNum = $.trim($("#userIdentityCardNum").val());
        var userBankCardId = $.trim($("#userBankCardId").val());


        if (userName == "" || userName == null) {
            alertMsg("请输入持卡人姓名", "#alert");
            return;
        } else {
            $("alert").hide();
        }
        if (userName.length < 2 || userName.length > 30) {
            alertMsg("持卡人姓名的长度为2-30个字", "#alert");
            return;
        }
        if (bankCardNum == "" || bankCardNum == null) {
            alertMsg("银行卡号码不能为空", "#alert1");
            return;
        } else if (bankCardNum.length < 16 || bankCardNum.length > 19 ) {
            alertMsg("银行卡号长度必须在16到19之间！", "#alert1");
            return;
        } else {
            var strT = /^\d+(\.\d+)?$/;
            if (!strT.test(bankCardNum)) {
                alertMsg("请输入数字", "#alert1");
                return;
            }
            $("alert1").hide();
        }

        //var strT = /^\d+(\.\d+)?$/;

        if (userTelephone == "" || userTelephone == null) {
            alertMsg("手机号必填", "#alert2");
            return;
        } else {
            var strP = /^\d+(\.\d+)?$/;
            if (!strP.test(userTelephone)) {
                alertMsg("请输入数字", "#alert2");
                return;
            }
            if (userTelephone.length != 11) {
                alertMsg("长度至少是 11", "#alert2");
                return;
            }
            if (userTelephone.length > 11) {
                alertMsg("您输入的手机长度超出范围", "#alert2");
                return;
            }
        }
        if (userIdentityCardNum == "" || userIdentityCardNum == null) {
            alertMsg("身份证号码不能为空！", "#alert3");
            $(".personId_adde").hide();
            return;

        } else {
            var regIdNum = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            if (regIdNum.test(userIdentityCardNum) === false) {
                alertMsg("身份证输入不合法", "#alert3");
                $(".personId_adde").hide();
                return false;
            }

        }

        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type: "POST",
            url: dataValue.webRoot + "/member/yzuserbankcard/saveOrUpdate.json",
            data: {
                userName: userName,
                bankCardNum: bankCardNum,
                userTelephone: userTelephone,
                userIdentityCardNum: userIdentityCardNum,
                userBankCardId: userBankCardId
            },
            dataType: "json",
            success: function (data) {
                if (data.success == true) {
                    alert("绑定银行卡成功");
                    location.reload();
                    $("#userName").attr("value", "");
                    $("#userTelephone").attr("value", "");
                    $("#bankCardNum").attr("value", "");
                    $("#userIdentityCardNum").attr("value", "");
                    $("#userBankCardId").attr("value", "");
                }
                if (data.success == false) {
                    alert(data.msg);
                    return false;
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                alert("服务器异常，请稍后重试。")
            }
        });
    });

    //删除操作
    $(".delete").click(function(){
        if (confirm("您是否要删除该银行卡的绑定?")) {
            $.ajax({
                type: "post",
                url: dataValue.webRoot + "/member/deleteUserBankCard.json?id=" + $.trim($(this).attr("userBankCardIdUpdate")),
                success: function (data) {
                    if (data.success == true) {
                        alert("删除绑定的银行卡成功");
                        location.reload();
                    } else {
                        alert(data.msg);
                        location.reload();
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }
        return false;
    });


    //编辑操作
    $(".update").click(function(){
        $.ajax({
            type: "post",
            url: dataValue.webRoot + "/member/findUserBankCardById.json",
            data: {id:$.trim($(this).attr("userBankCardIdUpdate"))},
            dataType: "json",
            success: function (data) {
                $("#userName").attr("value", data.result.userName);
                $("#userTelephone").attr("value", data.result.userTelephone);
                $("#bankCardNum").attr("value", data.result.bankCardNum);
                $("#userIdentityCardNum").attr("value", data.result.userIdentityCardNum);
                $("#userBankCardId").attr("value", data.result.userBankCardId);
            }
        });

    });
});


//编辑用户银行卡绑定
function btnAlt(userBankCardId) {
    $.ajax({
        type: "post",
        url: dataValue.webRoot + "/member/findUserBankCardById.json",
        data: {id: userBankCardId},
        dataType: "json",
        success: function (data) {
            $("#userName").attr("value", data.result.userName);
            $("#userTelephone").attr("value", data.result.userTelephone);
            $("#bankCardNum").attr("value", data.result.bankCardNum);
            $("#userIdentityCardNum").attr("value", data.result.userIdentityCardNum);
            $("#userBankCardId").attr("value", data.result.userBankCardId);
        }
    });
}


// 提示控制 start
function alertMsg(errorMsg, element) {
    $(element).show();
    $(element).html(errorMsg);
}
//提示控制 end
