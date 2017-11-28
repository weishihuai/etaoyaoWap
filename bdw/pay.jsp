<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--<%@page import="com.silverpay.util.YZMD5"%>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>${webName}支付-请选择支付方式</title>
	<link rel="icon" href="images/ico.ico" type="image/x-icon" />
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<link rel="stylesheet" type="text/css" href="${webRoot}/template/bdw/statics/css/base.css" />
	<link rel="stylesheet" type="text/css" href="${webRoot}/template/bdw/statics/css/purchase.base.201307.css" />
	<link rel="stylesheet" type="text/css" href="${webRoot}/template/bdw/statics/css/purchase.cashier.css" />
	<link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="${webRoot}/template/bdw/statics/css/css.css" />
<%--		<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.2.6.pack.js"></script>--%>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
	<script type="text/javascript" charset="UTF-8" src="${webRoot}/template/bdw/statics/js/pay-service.js"></script>
	<script type="text/javascript">
		var webPath = {webRoot:"${webRoot}"};
		function init(){$("#list-bank li").filter(function(i){return i>11}).hide();}
		$(document).ready(function(){
			$("#order1").click(function(){
				$(".tab_1").show();
				$(".tab_2").hide();
				$(".tab_3").hide();
				$("#order1").addClass("curr");
				$("#order2").removeClass("curr");
				$("#order3").removeClass("curr");
			});
			$("#order2").click(function(){
				$(".tab_1").hide();
				$(".tab_2").show();
				$(".tab_3").hide();
				$("#order2").addClass("curr");
				$("#order1").removeClass("curr");
				$("#order3").removeClass("curr");
			});
			$("#order3").click(function(){
				$(".tab_1").hide();
				$(".tab_2").hide();
				$(".tab_3").show();
				$("#order3").addClass("curr");
				$("#order1").removeClass("curr");
				$("#order2").removeClass("curr");
			});
		});
	</script>
</head>
<body onload="init()">
	<div class="w main" style="width: 1000px;">
		<div data-widget="tabs" class="m tabs">
			<div class="mt">
				<ul class="tab">
					<li data-widget="tab-item" class="curr" id="order1"
						clstag="payment|keycount|paymenttab|bankcard" onclick="">
						建立商品订单
					</li>
					<li data-widget="tab-item" class="" id="order2"
						clstag="payment|keycount|paymenttab|platform" onclick="">
						订单查询
					</li>
					<li data-widget="tab-item" class="" id="order3"
						clstag="payment|keycount|paymenttab|platform" onclick="">
						退款
					</li>
				</ul>
			</div>
			<div data-widget="tab-content" style="display: block;" class="mc">
				<div class="tab_1">
					<div>
						<div class="">
							<form action="silverPayFormSend.jsp" method="post"
								id="paymentConfirm" target="_blank">
								<div style="width: 990px; height: auto; clear: both;">
									必填项
									<br>
									<ul class="ul_a">
										<li>
											商户号
											<input type="text" name="Merno" value="00000000000003"
												id="Merno" readonly="readonly"/>
										</li>
										<li>
											商品名称
											<input type="text" name="Prdordnam" value="s" id="Prdordnam" />
										</li>
										<li>
											订单金额
											<input type="text" name="Ordamt" value="0.01" id="Ordamt" />
											元
										</li>
										<li>
											下单日期
											<input type="text" name="Orddate" value="20140903"
												id="Orddate" />
										</li>
										<li>
											交易类型
											<input type="text" name="TranType" value="20102"
												id="TranType" readonly="readonly"/>
										</li>
										<li>
											商户订单号
											<input type="text" name="Prdordno" readonly="readonly"
												value="自动生成，必须唯一" id="Prdordno" />
										</li>
										<li>
											商户业务类型(固定)
											<input type="text" name="bizType" readonly="readonly"
												value="10" id="bizType" />
										</li>
										<li>
											支付方式（固定）
											<input type="text" name="Paytype" readonly="readonly"
												value="01" id="Paytype" />
										</li>
										<li>
											应答机制（固定）
											<input type="text" name="RespMode" readonly="readonly"
												value="3" id="RespMode" />
										</li>
										<li>
											商户加密方式（固定）
											<input type="text" name="Signtype" readonly="readonly"
												value="M" id="Signtype" />
										</li>
										<!-- <li>
											签名数据
											<input type="text" name="inMsg" value=""
												onblur="changInMsg();" id="inMsg" style="width: 800px;" />
										</li> -->
									</ul>
								</div>
								<div style="width: 990px; height: auto; clear: both;">
									选填
									<br>
									<ul class="ul_b">
										<li>
											返回returnurl
											<input type="text" name="Return_url"
												value="http://192.168.10.162:8081/TestSilverPayMent/Receive.jsp"
												id="Return_url" />
										</li>
										<li>
											服务器异步通知notifyurl
											<input type="text" name="notify_url" value="http://192.168.10.162:8081/TestSilverPayMent/GetBackNotifyServlet"
												id="notify_url" />
										</li>
									</ul>
								</div>
								<!-- 选择银行编号 -->
								<div id="checkChannelNo" style="display: none;"></div>
							</form>
							<p class="mb-tip">
								请您在提交订单后
								<span class="ftx-04">24小时</span>内完成支付，否则订单会自动取消。
							</p>
						</div>
					</div>
					<div data-widget="tabs" class="m tabs">
						<div class="mt">
							<ul class="tab">
								<li data-widget="tab-item" class="curr" id="bankDIV" clstag="payment|keycount|paymenttab|bankcard" onclick="changBank();">银行卡</li>
								<li data-widget="tab-item" class="" id="PTDIV" clstag="payment|keycount|paymenttab|platform" onclick="changPT();">支付平台</li>
							</ul>
						</div>
						<div class="mc">
							<div id="tab01" data-widget="tab-content" class="tabcon"
								style="display: block;">
								<h5 class="subtit">
									请选择银行(支持网银与快捷支付)
								</h5>
								<ul class="list-bank" id="list-bank">
									<li clstag="payment|keycount|bank|c-icbc"
										onclick="bankSelect(this)">
										<input id="bank_ICBC" type="radio" class="jdradio"
											value="{'channelNo':'003|004','channelCode':'ICBC','channelName':'工商银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'300','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'300','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/icbc_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-icbc" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-ccb"
										onclick="bankSelect(this)">
										<input id="bank_CCB" type="radio" class="jdradio"
											value="{'channelNo':'001|002','channelCode':'CCB','channelName':'建设银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'110','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'110','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'131','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/ccb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-ccb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-cmb"
										onclick="bankSelect(this)">
										<input id="bank_CMB" type="radio" class="jdradio"
											value="{'channelNo':'013|014','channelCode':'CMB','channelName':'招商银行','channelType':'20','isRoute':true,'commonCredit':{'agencyCode':'140','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'140','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'160','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/cmb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-cmb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-abc"
										onclick="bankSelect(this)">
										<input id="bank_ABC" type="radio" class="jdradio"
											value="{'channelNo':'007|008','channelCode':'ABC','channelName':'农业银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'010','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'300','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/abc_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-abc" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-bcom"
										onclick="bankSelect(this)">
										<input id="bank_BCOM" type="radio" class="jdradio"
											value="{'channelNo':'009|010','channelCode':'BCOM','channelName':'中国交通银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/bcom_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-bcom" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-gdb"
										onclick="bankSelect(this)">
										<input id="bank_GDB" type="radio" class="jdradio"
											value="{'channelNo':'030|031','channelCode':'GDB','channelName':'广东发展银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/gdb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-gdb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-boc"
										onclick="bankSelect(this)">
										<input id="bank_BOC" type="radio" class="jdradio"
											value="{'channelNo':'005|006','channelCode':'BOC','channelName':'中国银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'157','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'300','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/boc_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-boc" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-cmbc"
										onclick="bankSelect(this)">
										<input id="bank_CMBC" type="radio" class="jdradio"
											value="{'channelNo':'021|022','channelCode':'CMBC','channelName':'中国民生银行','channelType':'20','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'300','cardTypeCode':'2','activityId':0},'imageUrl':'images/logo/cmbc_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-cmbc" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-hxb"
										onclick="bankSelect(this)">
										<input id="bank_HXB" type="radio" class="jdradio"
											value="{'channelNo':'027|028','channelCode':'HXB','channelName':'华夏银行','channelType':'20','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/hxb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-hxb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-cib"
										onclick="bankSelect(this)">
										<input id="bank_CIB" type="radio" class="jdradio"
											value="{'channelNo':'019|020','channelCode':'CIB','channelName':'兴业银行','channelType':'20','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'300','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/cib_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-cib" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-ceb"
										onclick="bankSelect(this)">
										<input id="bank_CEB" type="radio" class="jdradio"
											value="{'channelNo':'023|024','channelCode':'CEB','channelName':'中国光大银行','channelType':'20','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'300','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/ceb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-ceb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-post"
										onclick="bankSelect(this)">
										<input id="bank_POST" type="radio" class="jdradio"
											value="{'channelNo':'011|012','channelCode':'POST','channelName':'邮政储蓄','channelType':'20','isRoute':true,'commonCredit':{'agencyCode':'121','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'120','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'imageUrl':'images/logo/post_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-post" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-citic"
										onclick="bankSelect(this)">
										<input id="bank_CITIC" type="radio" class="jdradio"
											value="{'channelNo':'015|016','channelCode':'CITIC','channelName':'中信银行','channelType':'20','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'300','cardTypeCode':'2','activityId':0},'imageUrl':'images/logo/citic_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-citic" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-spdb"
										onclick="bankSelect(this)">
										<input id="bank_SPDB" type="radio" class="jdradio"
											value="{'channelNo':'017|018','channelCode':'SPDB','channelName':'浦东发展银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/spdb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-spdb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-bob"
										onclick="bankSelect(this)">
										<input id="bank_BOB" type="radio" class="jdradio"
											value="{'channelNo':'029|000','channelCode':'BOB','channelName':'北京银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'050','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'imageUrl':'images/logo/bob_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-bob" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-pab"
										onclick="bankSelect(this)">
										<input id="bank_PAB" type="radio" class="jdradio"
											value="{'channelNo':'025|026','channelCode':'PAB','channelName':'平安银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'050','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'050','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'300','cardTypeCode':'2','activityId':0},'imageUrl':'images/logo/pab_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-pab" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-njcb"
										onclick="bankSelect(this)">
										<input id="bank_NJCB" type="radio" class="jdradio"
											value="{'channelNo':'037|000','channelCode':'NJCB','channelName':'南京银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'050','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'050','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'imageUrl':'images/logo/njcb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-njcb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-hzb"
										onclick="bankSelect(this)">
										<input id="bank_HZB" type="radio" class="jdradio"
											value="{'channelNo':'040|041','channelCode':'HZB','channelName':'杭州银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/hzb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-hzb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-shb"
										onclick="bankSelect(this)">
										<input id="bank_SHB" type="radio" class="jdradio"
											value="{'channelNo':'032|033','channelCode':'SHB','channelName':'上海银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'152','cardTypeCode':'2','activityId':0},'quickDebit':{'agencyCode':'131','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/shb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-shb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-srcb"
										onclick="bankSelect(this)">
										<input id="bank_SRCB" type="radio" class="jdradio"
											value="{'channelNo':'036|037','channelCode':'SRCB','channelName':'上海农商行','channelType':'20','isRoute':true,'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'quickCredit':{'agencyCode':'300','cardTypeCode':'2','activityId':0},'imageUrl':'images/logo/srcb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-srcb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-bocd"
										onclick="bankSelect(this)">
										<input id="bank_BOCD" type="radio" class="jdradio"
											value="{'channelNo':'042|000','channelCode':'BOCD','channelName':'成都银行','channelType':'10','isRoute':true,'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/bocd_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-bocd" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-cqrcb"
										onclick="bankSelect(this)">
										<input id="bank_CQRCB" type="radio" class="jdradio"
											value="{'channelNo':'035|000','channelCode':'CQRCB','channelName':'重庆农村商业银行','channelType':'10','isRoute':true,'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/cqrcb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-cqrcb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-qdccb"
										onclick="bankSelect(this)">
										<input id="bank_QDCCB" type="radio" class="jdradio"
											value="{'channelNo':'043|044','channelCode':'QDCCB','channelName':'青岛银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/qdccb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-qdccb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-nbcb"
										onclick="bankSelect(this)">
										<input id="bank_NBCB" type="radio" class="jdradio"
											value="{'channelNo':'038|039','channelCode':'NBCB','channelName':'宁波银行','channelType':'10','isRoute':true,'commonCredit':{'agencyCode':'147','cardTypeCode':'2','activityId':0},'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/nbcb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-nbcb" class="bank-logo"></span>
										</label>
									</li>
									<li clstag="payment|keycount|bank|c-bjrcb"
										onclick="bankSelect(this)">
										<input id="bank_BJRCB" type="radio" class="jdradio"
											value="{'channelNo':'034|000','channelCode':'BJRCB','channelName':'北京农村商业银行','channelType':'10','isRoute':true,'commonDebit':{'agencyCode':'147','cardTypeCode':'1','activityId':0},'imageUrl':'images/logo/bjrcb_1301.png'}"
											name="bankRadio">
										<label>
											<span id="bank-bjrcb" class="bank-logo"></span>
										</label>
									</li>
								</ul>
								<div class="pay-more" id="up" style="display: none">
									<a class="link-more" href="#" onclick="changBankShow('up')">
										<strong>收起</strong> <b class="icon-up01"></b> </a>
								</div>
								<div class="pay-more" id="down">
									<a class="link-more" href="#" onclick=changBankShow('down');
>
										<strong>更多银行</strong> <b class="icon-down01"></b> </a>
								</div>

								<div class="btns">
									<a class="btn-next" onclick=checkBankPay();>下一步</a>
								</div>
							</div>
							<div id="tab02" data-widget="tab-content" class="tabcon hide">
							<h5 class="subtit">支持网银与其他平台支付方式</h5>
							<ul class="list-bank">
								<li onclick="bankSelect(this)"><input type="radio" class="jdradio" value="1"
									name="platformRedio"> <label> <img width="125" height="28"
											alt="收银台" src="images/logo.png"></label></li>
							</ul>
							<div class="btns">
								<a class="btn-next" onclick="submitPay()">下一步</a>
							</div>
						</div>
						</div>
					</div>
				</div>
				<!-- 订单查询 -->
				<div class="tab_2">
					<div style="width:800px; height:50px; margin:0 auto;">
						订单号
						<input class="ipt" type="text" id="serachPrdordno" value="2014090400000003GN5I011056"/>
						商户号
						<input class="ipt" type="text" id="serachMerno" value="00000000000003"/>

						<!-- 商户自己的私钥（申请商户时，会分配 测试账户00000000000003的私钥为Dw7ZqwrLC4kC） -->
						<input type="hidden" id="SignType" value="M"/>
						<!-- 加密方式默M 代表MD5 -->
						<input type="hidden" id="MD5Key" value="Dw7ZqwrLC4kC"/>
						<input class="ser" type="button" name="Merno" value="搜索" onclick="BankOrderQuery();"/>
					</div>
					<div style="width:800px; height:130px;  margin:0 auto;">
						<ul>
							<li class="li_1">
								<div class="span_1">商户号</div><div class="span_2" id="MERNO"></div>
							</li>
							<li class="li_1">
								<div class="span_1">商品名称</div><div class="span_2" id="PRDNAME"></div>
							</li>
							<li>
								<div class="span_1">订单金额</div><div class="span_2" id="ORDAMT"></div>
							</li>
							<li>
								<div class="span_1">下单日期</div><div class="span_2" id="PAYDATE"></div>
							</li>
							<li class="li_1">
								<div class="span_1">交易类型</div><div class="span_2" id="TRANTYPE"></div>
							</li>
							<li class="li_1">
								<div class="span_1">商户订单号</div><div class="span_2" id="PRDORDNO"></div>
							</li>
							<li>
								<div class="span_1">商户业务类型</div><div class="span_2" id="BIZTYPE"></div>
							</li>
							<li>
								<div class="span_1">支付方式</div><div class="span_2" id="PAYTYPE"></div>
							</li>
							<li class="li_1">
								<div class="span_1">商户加密方式</div><div class="span_2" id="SIGNTYPE"></div>
							</li>

							<li class="li_1">
								<div class="span_1"></div><div class="span_2" id="Prdordno"></div>
							</li>
						</ul>
					</div>
				</div>
				<!-- 订单查询结束 -->
				<!-- 退款 -->
				<div class="tab_3" style="display: none;">
					<div class="all">
						<div align="center" class="title_font">
							申请退款
						</div>
						<br />
						<form class="form_1" role="form" method="post" id="formRefund" target="_blank" action="http://www.isilverpay.com/SilverPaymentTest/RefundMentServlet">
							<div class="form-group ">
								<label class=" control-label">
									金额/元
								</label>
								<div class="col-xs-10">
									<input class="form-control" type="text" placeholder="1.00" name="rfAmt">
								</div>
							</div>
							<div class="form-group ">
								<label class=" control-label">
									商户号&nbsp;
								</label>
								<div class="col-xs-10">
									<input class="form-control" type="text" value="00000000000003" name="merNo">
								</div>
							</div>

							<div class=" form-group ">
								<label class="control-label">
									订单号&nbsp;
								</label>
								<div class="col-xs-10">
									<input class="form-control" type="text" name="PRDORDNO"
										placeholder="20140903000000033527042301">
								</div>
							</div>

							<div class=" form-group">
								<label class=" control-label" for="formGroupInputSmall">
									原因&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</label>
								<div class="col-xs-10">
									<input class="form-control" type="text"
										name="rfSake" id="rfSake" placeholder="原因">
								</div>
							</div>

							<button type="submit" class="sub">
								提 交
							</button>

						</form>
					</div>

				</div>
				<!-- 退款结束 -->
			</div>
		</div>
	</div>
	<div style="display: none" id="payMethods">
		<div class="thickdiv" id=""></div>
		<div style="left: 284.5px; top: 17.5px; width: 772px; height: 488px;"
			class="thickbox" id="">
			<div style="width: 770px;">
				<div class="thicktitle" id="" style="width: 750">
					<span>请选择支付方式</span>
				</div>
				<div class="thickcon thickloading" id=""
					style="width: 750px; height: 535px; padding-left: 10px; padding-right: 10px;">
					<div id="mflex01" class="mflex">
						<div class="banklogo">
							<img src="" alt="工商银行" height="28" width="125" />
						</div>
						<div name="netpay" id="netpay" class="m-sele m-sele01" style="">
							<div class="mt-sele">
								网银支付：
							</div>
							<ul class="list-bank">
							</ul>
							<div class="msg-text">
								付款时需跳转至银行支付
							</div>
						</div>
						<div class="btns">
							<a onclick="submitChoosePayToBank();" class="btn-next" href="#"
								clstag="payment|keycount|paymentbutton|next-step-03"> 下一步 </a>
							<a class="link-more" href="#" onclick=jdThickBoxclose();
								clstag="payment|keycount|paymentlink|other-bank-02">
								使用其它银行卡支付</a>
						</div>
					</div>
				</div>
				<a href="#" class="thickclose" id="" onclick=jdThickBoxclose();>×</a>
			</div>
		</div>
	</div>
</body>
</html>

