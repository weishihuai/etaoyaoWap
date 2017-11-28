$(document).ready(function() {
    $(".return").click(function(){
        $('.rebate').removeClass('cur');
        $('.return').addClass('cur');
        $("#rebate_div").hide();
        $("#return_div").show();
    });
    $(".rebate").click(function(){
        $('.return').removeClass('cur');
        $('.rebate').addClass('cur');
        $("#return_div").hide();
        $("#rebate_div").show();
    });

    $(".addressSelect").ld({
        ajaxOptions : {"url" :webPath.webRoot+"/member/addressBook.json"},
        defaultParentId:9
    });

    $("#btnAdd").click(function(){
        $("#branchBank").val($("#province").find('option:selected').text() +$("#country").find('option:selected').text() +$("#txtbranch").val());
        $("#cashForm").submit();
    });
    $.formValidator.initConfig({theme:"ArrowSolidBox",formID:"cashForm",
        onError:function(msg){},inIframe:true,
        ajaxForm:{
            dataType:"json",url:webPath.webRoot+"/member/saveCashWithdrawalRequest.json",type :"POST",
            buttons:$("#btnAdd"),
            error: function(jqXHR, textStatus, errorThrown){
                if(textStatus == "error"){
                    try{
                        var result = eval("("+jqXHR.responseText+")");
                        alert(result.errorObject.errorText);
                    }catch(err) {
                        alert(alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown));
                        return;
                    }
                }
            },
            success : function(data){
                if(data.errorCode == "errors.login.noexist"){
                    if(confirm("您尚未登陆，请登陆!")){
                        window.location.href=webPath.webRoot+"/login.ac";
                    }
                    return;
                }
                if(data.errorCode == "errors.comment.notOrder"){
                    alert("订单号不存在，请确定退货编号无误");
                    return;
                }
                if(data.errorCode == "errors.not.user"){
                    orderNumTipErrorShow("退货编号不属于您的账号，不能申请");
                    return false;
                }
                if(data.errorCode == "errors.present.has.use"){
                    orderNumTipErrorShow("退货编号已申请提现或者正在等待审核，不能重复申请");
                    return;
                }
                if(data.errorCode == "errors.not.amount"){
                    alert("您的账户余额不足，不能申请提现");
                    return;
                }
                if(data.success == true){
                    alert("您申请提现提交成功");
                    window.location.reload();
                    $("#cashForm").each(function(){
                        this.reset();
                    });
                    return;
                }
            }
        }
    });

    $("#applyUserName").formValidator({onShow:"请输入申请人姓名",onFocus:"请输入申请人姓名"})
            .inputValidator({min:2,max:24,onError:"请输入字符长度2~24位的申请人姓名"});
    /*$("#amount").formValidator({onShow:"请输入10位数内申请金额",onFocus:"请输入申请金额"})
            .inputValidator({min:1,regExp:"num",max:10,onError:"您输入的申请金额格式不正确"});*/
    $("#bankUserName").formValidator({onShow:"请输入银行用户姓名",onFocus:"请输入银行用户姓名"})
            .inputValidator({min:2,max:24,onError:"请输入字符长度2~24位的银行用户姓名"});
    $("#bankAccount").formValidator({onShow:"请输入24位数的银行账号",onFocus:"请输入银行账号"})
               .inputValidator({min:1,max:24,empty:{leftempty:false,rightempty:false,emptyerror:"银行账号两边不能有空符号"},onError:"请输入24位数的确认银行账号"});
   	$("#bankAccount_again").formValidator({onShow:"请输入24位数的银行账号",onFocus:"请输入银行账号"})
               .inputValidator({min:1,max:24,empty:{leftempty:false,rightempty:false,emptyerror:"银行账号两边不能有空符号"},onError:"请输入24位数的确认银行账号 "})
               .compareValidator({desID:"bankAccount",operateor:"=",onError:"2次银行账号不一致"});
    $("#reason").formValidator({onShow:"请输入最少5位长度原因",onFocus:"请输入最少5位长度原因"})
            .inputValidator({min:5,max:256,onError:"您输入原因长度需要在5~256位之间"});
/*    $(":radio[name='typeCode']").formValidator({tipID:"typeCodeTip",onShow:"请选择提现类型",onFocus:"请选择提现类型",onCorrect:"输入正确",defaultValue:["1"]})
            .inputValidator({min:1,max:1,onError:"请选择提现类型"});*/
    $("#txtbranch").formValidator({onShow:"请完善银行信息",onFocus:"请完善银行信息"})
            .functionValidator( {fun:function(val){checkBank();}});
    $("#orderNum").formValidator({onShow:"请填写退货单编号",onFocus:"请填写退货单编号"})
            .functionValidator({fun:function(val){checkOrderNum()}});
});

var orderNumTipErrorShow = function(errorText){
    $("#orderNumTipError .onError_top").html(errorText);
    $("#orderNumTipCorrect").hide();
    $("#orderNumTipError").show();
};

var orderNumTipCorrectShow = function(){
    $("#orderNumTipError").hide();
    $("#orderNumTipCorrect").show();
};

var checkOrderNum = function(){
    var orderNum = $("#orderNum").val();
    if(orderNum == null || orderNum == ''){
        orderNumTipErrorShow("请填写退货单编号");
        return false;
    }
    $.ajax({
        dataType : "json",
        url:webPath.webRoot+"/member/withdrawalReqOrderAmout.json?orderNum="+orderNum,
        success:function(data){
            if (data.success == true) {
                $("#amount").val(data.amount);
                orderNumTipCorrectShow();
                return true;
            }
            if(data.success == false){
                if(data.errorCode == "errors.login.noexist"){
                    orderNumTipErrorShow("您尚未登陆，点击 <a style='color:blur;' href='"+webPath.webRoot+"'/login.ac>登 陆</a>");
                    if(confirm("您尚未登陆，请登陆!")){
                        window.location.href=webPath.webRoot+"/login.ac";
                    }
                    return false;
                }
                if(data.errorCode == "errors.comment.notOrder"){
                    orderNumTipErrorShow("退货编号不存在或者该退货编号未被处理");
                    return false;

                }
                if(data.errorCode == "errors.not.user"){
                    orderNumTipErrorShow("退货编号不属于您的账号，不能申请");
                    return false;
                }
                if(data.errorCode == "errors.present.has.use"){
                    orderNumTipErrorShow("退货编号已申请提现或者正在等待审核，不能重复申请");
                    return false;
                }
                if(data.errorCode == "errors.not.amount"){
                    orderNumTipErrorShow("您的账户余额不足，不能申请提现");
                    return false;
                }
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                orderNumTipErrorShow("请输入合法的退货订单编号！");
                return false;
            }
        }
    });
};

var checkBank = function(){
    if($("#bankCode").val()==""||$("#province").val()==""||$("#country").val()==""||$("#txtbranch").val()==''){
        $("#bankCodeTipCorrect").hide();
       $("#bankCodeTipError").show();
        return false;
    }else{
        $("#bankCodeTipError").hide();
        $("#bankCodeTipCorrect").show();
        return true;
    }
};
