/**
 * Created by Administrator on 2015/06/08.
 */

$(document).ready(function(){
    //点击查询事件
    $("#search").click(function(){

        var couponsNumber = $("#couponsNumber").val();
        couponsNumber = $.trim(couponsNumber);
        var userTell = $("#userTell").val();
        userTell = $.trim(userTell);

        var flagCouponsNumber = checkCouponNum(couponsNumber);
        var flagUserTell = checkUserTell(userTell);

        if (flagCouponsNumber && flagUserTell) {
            $("#searchFrom").submit();
        }
    });

});

//根据状态查找
function StatusSearch(num){
    $("#status").val(num);
    $("#searchFrom").submit();

}



var checkCouponNum = function (numValue) {
	if (numValue != '') {
        var reg = /^\d{16}$/;
        if (!reg.test(numValue)) {
            $("#couponsNumber_error").text("消费劵号为16位数字").show();
            return false;
        }
	}
    $("#couponsNumber_error").hide();
	return true;
};


var checkUserTell = function (userTell) {
	if (userTell != '') {
        var regCode = /^1(\d{10})$/;
        if (!regCode.test(userTell)) {
            $("#userTell_error").text("手机号码为11位数字").show();
            return false;
        }
	}
    $("#userTell_error").hide();
	return true;
};
