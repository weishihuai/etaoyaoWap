$(function(){
    $("#withdrawAllBtn").click(function(){

        var $userBalance = $("#userBalance").text();
        $("#withdrawAllValue").val(parseInt($userBalance));
    });

    $("#choosePayWay").click(function(){
        var $href=$(this).attr("href");
        window.location.href =$href;
    });

    $("#next").click(function(){
        var $userBalance = $("#userBalance").text();
        var $withdrawAllValue= $("#withdrawAllValue").val();
        var regExp = /^[1-9][0-9]*[\u5143]?$/;

        if( $withdrawAllValue == ''){
            alert("请输入申请金额");
            return false;
        }

        if(!regExp.test( $withdrawAllValue)){
            alert("请输入正整数的申请金额");
            return false;
        }

        if(parseInt( $withdrawAllValue) > parseInt($userBalance)){
            alert("提现金额不能大于现金账户总金额");
            return false;
        }
        if(webParams.rebateMoneyFloor != '' && parseInt($withdrawAllValue) < parseInt(webParams.rebateMoneyFloor)){
            alert("提现金额不能小于提现金额下限，提现金额下限为" + webParams.rebateMoneyFloor);
            return false;
        }

        if(webParams.rebateMoneyUpper != '' && parseInt($withdrawAllValue) > parseInt(webParams.rebateMoneyUpper)){
            alert("提现金额不能大于提现金额上限，提现金额上限为" + webParams.rebateMoneyUpper);
            return false;
        }
        window.location.href = webParams.webRoot+"/wap/module/member/cps/cpsApplyPwd.ac?withdrawalWayCode="+webParams.withdrawalWayCode+"&amount="+$withdrawAllValue;

        return true;
    });



});