//退出
function shopExit() {
	$.ajax({
		type: "GET",
		url: webPath.webRoot + "/member/exitShop.json",
		dataType: "json",
		success: function (data) {
			if (data.success == "true") {
				location.href = webPath.webRoot + "/otoo/otooCoupon/couponsLogin.ac";
			} else {
				alert("退出异常");
				location.href = webPath.webRoot + "/otoo/otooCoupon/couponsLogin.ac";
			}
		}
	})
}
