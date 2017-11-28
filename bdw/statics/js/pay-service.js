/** ***************获取当前的银行信息***************** */
function getCurrentBank() {
	return eval("(" + $("input:radio[name='bankRadio'][checked]").val() + ")");
}

/** ***************选择银行下一步时间***************** */
function currentBankPay() {
	bankPay(getCurrentBank());
}

function bankPayByBankCode(bankCode) {
	$("#bank_" + bankCode).attr("checked", "checked");
	var bank = $("#bank_" + bankCode).val();
	var bankJson = eval("(" + bank + ")");
	if (bankJson != undefined) {
		bankPay(bankJson);
	}
}


function showPaymentMethodSelect(){
	easyDialog.open({
		container: 'payMethods',
		fix:true
	});
}

function closePaymentMethodSelect(){
	easyDialog.close();
}


function bankPay(bank) {
	if (bank == undefined) {
		alert("请选择银行!");
		return;
	}
	$(".banklogo").find("img").attr("src", webPath.webRoot+"/template/bdw/statics/"+bank.imageUrl).attr("alt",  bank.channelName);
	$("#netpay").find(".list-bank").html("");
	$("#payMethods").show();
	//showPaymentMethodSelect();


	// 可以使用网银
	if (bank.commonDebit || bank.commonCredit) {
		var netpayHtml = "";
		if (bank.commonDebit) {
			netpayHtml = "<li class='fore2' onclick='chooseType(this)' >"
					+ "<input type='radio' name='typeRadio' value='1' class='jdradio'>"
					+ "<label>储蓄卡</label>" + "</li>";
			$("#msg-text").css("margin-left","285px");
		}
		if (bank.commonCredit) {
			netpayHtml = netpayHtml
					+ "<li class='fore2' onclick='chooseType(this)'  >"
					+ "<input type='radio' name='typeRadio' value='0' class='jdradio'>"
					+ "<label>信用卡</label>" + "</li>";
			$("#msg-text").css("margin-left","425px");
		}
		$("#netpay").find(".list-bank").html(netpayHtml);
		$("#netpay").show();
	}
}

function bankSelect(obj) {
	$(obj).addClass("select").find(".jdradio").attr("checked", "checked");
	$(obj).siblings().removeClass("select");
    $("#payWayId").val($("#isilverPayWayId").attr("payWayId"));
}

function chooseType(obj) {
	$(obj).parent().parent().addClass("current").siblings().removeClass(
			"current");
	$(obj).parent().parent().parent().find("li").each(function() {
		$(this).removeClass("select");
	});
	$(obj).addClass("select").find(".jdradio").attr("checked", "checked");
}

/** ****************新用户选择支付*********************** */
function submitChoosePay() {
	var type = $("input:radio[name='typeRadio'][checked]").val();
	var bank = getCurrentBank();
	var channelNo = "";
	var channelName = bank.channelName;
	$("#qwe").hide();
	if (type == undefined) {
		alert("请选择");
	} else if (type == 1 || type == 0) {
		var end = (bank.channelNo).indexOf("|");
		if (type == 1) {
			channelNo = (bank.channelNo).substring(0, end);
		} else if (type == 0) {
			channelNo = (bank.channelNo).substring(end + 1, (bank.channelNo).length);
		}

		$("#checkChannelNo").html("<input value='" + channelNo + "' name='bankCode' id='bankCode' type='text'/> <input value='" + channelName + "' name='bankName' id='bankName' type='text'/>");
		$("#payMethods").hide();


        setTimeout(function(){
            var isUseAccount=false;
            if($(".check").attr("checked")) {
                isUseAccount=true;
                $("#isUseAccount").val(isUseAccount)
            } else{
                isUseAccount=false;
                $("#isUseAccount").val(isUseAccount)

            }
            $("#goBank").submit();
        },0);

        return showDialog("请支付成功后才关闭窗口！",{
            "支付完成":function(){
                window.location.href=webPath.webRoot+'/module/member/index.ac';
            },
            "支付失败":function(){
                window.location.reload();
            }
        });
	}
}

function showDialog(text, buttons) {
	$("#tiptext").html(text);
	$("#tip").dialog({
		modal: true,
		buttons: buttons
	});
}

function submitChoosePay2() {
	$("#qwe").hide();
	var type = 1;
	var channelNo = 001;
	var channelName = "建设银行";

	$("#checkChannelNo").html("<input value='" + channelNo + "' name='bankCode' id='bankCode' type='text'/> <input value='" + channelName + "' name='bankName' id='bankName' type='text'/>");
	$("#payMethods").hide();

	setTimeout(function(){
		var isUseAccount=false;
		if($(".check").attr("checked")) {
			isUseAccount=true;
			$("#isUseAccount").val(isUseAccount)
		} else{
			isUseAccount=false;
			$("#isUseAccount").val(isUseAccount)

		}
		$("#goBank").submit();
	},0);

	return showDialog("请支付成功后才关闭窗口！",{
		"支付完成":function(){
			window.location.href=webPath.webRoot+'/module/member/index.ac';
		},
		"支付失败":function(){
			window.location.reload();
		}
	});
}
function submitChoosePayToBank(){
    submitChoosePay();
}

function subFormSilverPay(){
	$("#paymentConfirm").submit();
}

function changPT() {
	document.getElementById("tab01").style.display = "none";
	document.getElementById("tab02").style.display = "block";
	$("#PTDIV").addClass("curr");
	$("#bankDIV").removeClass("curr");
	$("#down").hide();
	$("#moreNext").hide();
	$("input:radio[class='jdradio']:checked").attr("checked",false);
	$("input:radio[name='bankRadio']").each(function(){
		if($(this).attr("payWayId") == 5){
			$(this).addClass("select").attr("checked", "checked");
			$(this).siblings().removeClass("select");
			$("#payWayId").val($(this).addClass("select").attr("payWayId"));
		}else{
			$(this).removeClass("select").attr("checked",false);
		}
	});
	$("li").removeClass("select");
	$("#bankCode").val("");
}
function changBank(paywayId) {
    $("#checkChannelNo").html("<input value='" + paywayId + "' name='paywayId' id='paywayId' type='text'/>");
	document.getElementById("tab01").style.display = "block";
	document.getElementById("tab02").style.display = "none";
	$("#bankDIV").addClass( "curr");
	$("#PTDIV").removeClass("curr");
	if($("#down").attr("flag") == "Y"){
		$("#down").show();
		$("#up").hide();
	}else{
		$("#up").show();
		$("#down").hide();
	}
	$("input:radio[name='bankRadio']:checked").attr("checked",false);
	$("#moreNext").show();
}

function jdThickBoxclose() {
	$("#payMethods").hide();
	//closePaymentMethodSelect();
	$("#checkChannelNo").html("");
}

function submitPay() {
	if ($("input[name='platformRedio']:checked").val() != "1") {
		alert("目前只支持宝得网支付");
		return;
	}
	if ($("input[name='platformRedio']:checked").val() == "1") {

		$("#paymentConfirm").submit(); 
		
	}
}

function checkBankPay() {

	var userAmount = $(".userAmount").text();
	var orderTotalAmount = $(".orderTotalAmount").text();
	if ((parseFloat(userAmount) >= parseFloat(orderTotalAmount)) && ($(".check").attr("checked"))) {
		//如果预存款足够的话,则默认选择进行支付.
		submitChoosePay2();
	}else{
		currentBankPay();
	}
}

function changBankShow(str){
	if(str == "down"){
		$("#down").hide();
		$("#down").attr("flag","N");
		$("#up").show();
		$("#list-bank li").show();
	}else{
		$("#down").show();
		$("#down").attr("flag","Y");
		$("#up").hide();
		$("#list-bank li").filter(function(i){return i>11}).hide();
	}
}

function xinxiChangeBank(){
	$("#asd").hide();
	$("#qwe").show();
}

function xinxiChangeOtherMethod(){
	xinxiChangeBank();
	currentBankPay();
}

//订单查询
function BankOrderQuery(){
	var Prdordno = $("#serachPrdordno").val();
	var Merno = $("#serachMerno").val();
	var SignType = $("#SignType").val();
	var MD5Key = $("#MD5Key").val();
	$.ajax({
		dataType: "jsonp",
		url:"http://www.isilverpay.com/SilverPaymentTest/BankOrderQuery",
		data:"Prdordno="+Prdordno+"&Merno="+Merno+"&SignType="+SignType+"&MD5Key="+MD5Key,
		jsonp:"jsonp_callback",  
		success:function(data){
			var obj = data[0]; 
			if(obj.RSPMSG == "该商品订单信息不存在"){
				alert("该商品订单信息不存在");
				$("#PRDNAME").html("");
				$("#PAYDATE").html("");
				$("#PRDORDNO").html("");
				$("#ORDAMT").html("");
				$("#TRANTYPE").html("");
				$("#PAYTYPE").html("");
				$("#SIGNTYPE").html("");
				$("#BIZTYPE").html("");
				$("#MERNO").html("");
				return ;
			}else if(obj.RSPMSG == "交易成功"){
				$("#PRDNAME").html(obj.PRDNAME);
				$("#PAYDATE").html(obj.PAYDATE);
				$("#PRDORDNO").html(obj.PRDORDNO);
				$("#ORDAMT").html( parseInt(obj.ORDAMT)/100+" 元");
				if((obj.TRANTYPE=="20201")){
					obj.TRANTYPE = "宝得网支付"
				}else{
					obj.TRANTYPE = "B2C网银";
				}
				$("#TRANTYPE").html(obj.TRANTYPE);
				$("#PAYTYPE").html(obj.PAYTYPE);
				$("#SIGNTYPE").html(obj.SIGNTYPE);
				if((obj.BIZTYPE=="10")){
					obj.BIZTYPE = "普通交易"
				}
				$("#BIZTYPE").html(obj.BIZTYPE);
				$("#MERNO").html(obj.MERNO);
			}
		},
		async:true
	});

}

