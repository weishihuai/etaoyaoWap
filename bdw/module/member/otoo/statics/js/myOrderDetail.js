$(function () {
	//判断是否有可以退款的券,若没有,隐藏申请退款按钮
	var checkboxArray = $("input[type=checkbox]");
	if(checkboxArray.length==0){
		$("#applyRefund").hide();
	}
});

var refundLayer;

//显示申请退款弹出框
/*function applyRefund(couponId) {
	$("#productNameSpan").html($("#applyRefundItemId" + couponId).attr("productNameData"));
	$("#couponNumSpan").html($("#applyRefundItemId" + couponId).attr("couponNumData"));
	$("#productPriceSpan").html("￥" + $("#applyRefundItemId" + couponId).attr("productPriceData"));
	$("#applyRefundBtn").attr("couponIdData", couponId);
	refundLayer = $.layer({
		type: 1,
		area: ['auto', 'auto'],
		title: false,
		//move: '.e-tit',
		move: false,
		border: [1],
		shadeClose: false,
		moveType: 1,
		page: {dom: '#refund'},
		bgcolor: "none"
	});
}*/

var couponIds = new Array();
var couponIdStr;
var coupons = new Array();
var couponStr;
var totalPrice = 0 ;
var productName
function checkCoupon(couponIndex){
	//券Id
	var couponId = $(".applyRefundItemId"+couponIndex).attr("couponId");
	//商品名称
	productName = $(".applyRefundItemId"+couponIndex).attr("productNameData");
	//券号
	var couponNum = $(".applyRefundItemId"+couponIndex).attr("couponNumData");
	//券金额
	var couponPrice = parseFloat($(".applyRefundItemId"+couponIndex).attr("productPriceData"));

	if($(".applyRefundItemId"+couponIndex).attr("checked")=="checked"){
		totalPrice += couponPrice;
		coupons.push(couponNum);
		couponIds.push(couponId);
	}else{
		totalPrice -= couponPrice;
		var i = coupons.indexOf(couponNum);
		coupons = removeElement(i,coupons);
		couponIds = removeElement(i,couponIds);
	}
	couponStr = coupons.toString();
	couponIdStr = couponIds.toString();
}

//删除数组中的指定元素
function removeElement(index,array)
{
	if(index>=0 && index<array.length)
	{
		for(var i=index; i<array.length; i++)
		{
			array[i] = array[i+1];
		}
		array.length = array.length-1;
	}
	return array;
}

function applyRefund(){
	if(couponIds.length == 0){
		alert("请选择要退款的消费券!");
		return;
	}
	$("#productNameSpan").html(productName);
	$("#couponNumSpan").html(couponStr);
	$("#productPriceSpan").html("￥" + totalPrice);
	refundLayer = $.layer({
		type: 1,
		area: ['auto', 'auto'],
		title: false,
		//move: '.e-tit',
		move: false,
		border: [1],
		shadeClose: false,
		moveType: 1,
		page: {dom: '#refund'},
		bgcolor: "none"
	});
}

//申请退款
function applyRefundBtn(){
	var refundReason = $("#otooRefundReason").val();
	if(refundReason.length < 5){
		alert("您输入的内容太短了，请说多几句。");
		return;
	}
	if(refundReason.length > 200 ){
		alert("请输入少于255个字符！");
		return;
	}
	$("#applyRefundBtn").attr("class", "submitted");
	$("#applyRefundBtn").attr("onclick", "javascript:;");
	$.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
	$.ajax({
		type: "GET",
		dataType: "json",
		data: {
			couponIds: couponIdStr,
			otooRefundReason: refundReason
		},
		url: webPath.webRoot + "/otoo/coupons/applyRefund.json",
		success: function (data) {
			if (data.success == "true") {
				alert("申请成功");
				$("input[type=checkbox]").attr("checked",false);//刷新后依然有checkbox被选中,因此强制去除checkbox被选中
				window.location.reload();

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

/*function applyRefundBtn(){
	var couponId = $("#applyRefundBtn").attr("couponIdData");
	var otooRefundReasonValue = $("#otooRefundReason").val();
	$("#applyRefundBtn").attr("class", "submitted");
	$("#applyRefundBtn").attr("onclick", "javascript:;");
	$.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
	$.ajax({
		type: "GET",
		dataType: "json",
		data: {
			couponId: couponId,
			otooRefundReason: otooRefundReasonValue
		},
		url: webPath.webRoot + "/otoo/coupons/applyRefund.json",
		success: function (data) {
			if (data.success == "true") {
				alert("申请成功");
				window.location.reload();
			}
		},
		error: function (XMLHttpRequest, textStatus) {
			if (XMLHttpRequest.status == 500) {
				var result = eval("(" + XMLHttpRequest.responseText + ")");
				alert(result.errorObject.errorText);
			}
		}

	});
}*/

//关闭所有弹出层
function hideLayer() {
	layer.closeAll();
}


//还原订单
function returnOrder(orderId) {
	if (window.confirm("确认要还原订单？")) {
		$.ajax({
			type: "POST",
			url: webPath.webRoot + "/otoo/otooOrder/updateOrderStatus.json",
			data: {"orderId": orderId, "delete": "N"},
			async: false,//同步
			success: function (data) {
				if (data.success = "true") {
					alert("还原订单成功!");
					window.location.href = webPath.webRoot + "/module/member/otoo/myOrderList.ac?pitchOnRow=47&isDeleted=Y";
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
}

