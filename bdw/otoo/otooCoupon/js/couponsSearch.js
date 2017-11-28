$(document).ready(function () {
	var errorMsg = $("#errorMsg").val();
	if ($.trim(errorMsg) != '') {
		$("#showErrorInfoDiv").html(errorMsg);
	}
	//点击查询事件
	$("#search").click(function () {
		var couponsNumber = $("#couponsNumber").val();
		couponsNumber = $.trim(couponsNumber);
		/*var code = $("#code").val();
		code = $.trim(code);*/

		var flagCouponsNumber = checkCouponNum(couponsNumber);
		//var flagCode = checkCode(code);

		if (flagCouponsNumber /*&& flagCode*/) {
			$("#searchFrom").submit();
		}

	});


	$("#couponsNumber").focus(function () {
		$("#couponsNumber_error").hide();
		/*$("#code_error").css("margin-left", "340");*/
	}).blur(function () {
		var couponsNumber = $("#couponsNumber").val();
		couponsNumber = $.trim(couponsNumber);
		checkCouponNum(couponsNumber);
	});

	/*$("#code").focus(function () {
		$("#code_error").hide();
	}).blur(function () {
		var code = $("#code").val();
		code = $.trim(code);
		checkCode(code);
	});*/

});


var checkCouponNum = function (numValue) {
	if (numValue == '') {
		$("#couponsNumber_error").text("请输入消费劵号").show();
		/*$("#code_error").css("margin-left", "20");*/
		return false;
	}

	var reg = /^\d{16}$/;
	if (!reg.test(numValue)) {
		$("#couponsNumber_error").text("消费劵号为16位数字").show();
		/*$("#code_error").css("margin-left", "20");*/
		return false;
	}

	var numSubValue1 = numValue.substr(0, 4);
	var numSubValue2 = numValue.substr(4, 4);
	var numSubValue3 = numValue.substr(8, 4);
	var numSubValue4 = numValue.substr(12, 4);
	var newNumValue = numSubValue1 + "&nbsp;&nbsp;&nbsp;" + numSubValue2 + "&nbsp;&nbsp;&nbsp;" + numSubValue3 + "&nbsp;&nbsp;&nbsp;" + numSubValue4;

	$('#showNumDiv span').html(newNumValue);

	return true;
};


/*var checkCode = function (codeValue) {
	if (codeValue == '') {
		$("#code_error").text("请输入验证码").show();
		return false;
	}

	var regCode = /^\d{4}$/;
	if (!regCode.test(codeValue)) {
		$("#code_error").text("验证码为4位数字").show();
		return false;
	}

	return true;

};*/


var useCouponFunction = function (thisObject) {
	if (confirm("您确认要使用吗?")) {
		var otooCouponId = $(thisObject).attr("otooCouponId");
		$(thisObject).attr("class", "submittedBtn");
		$(thisObject).attr("onclick", "javascript:;");

		$.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
		$.ajax({
			type: "POST",
			url: webPath.webRoot + "/otoo/coupons/useCouponFunction.json",
			data: {
				otooCouponId: otooCouponId
			},
			dataType: "json",
			success: function (data) {
				if (data.success == "true") {
					alert("使用成功");
					window.location.href = webPath.webRoot + "/otoo/otooCoupon/couponsSearch.ac";
				} else if (data.success == "false") {
					alert(data.msg);
					$(thisObject).attr("class", "submitBtn");
					$(thisObject).attr("onclick", "useCouponFunction(this)");
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

};

/*改变验证码*/
/*var changValidateCode = function () {
	$("#validateCodeImg").attr("src", webPath.webRoot + "/ValidateCode?" + Math.random());
};*/

