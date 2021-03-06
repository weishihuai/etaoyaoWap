<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
	<meta name="keywords" content="${sdk:getSysParamValue('index_keywords')},${webName},商家入驻"/>
	<%--SEO keywords优化--%>
	<meta name="description" content="${sdk:getSysParamValue('index_description')}"/>
	<%--SEO description优化--%>
	<title>填写入驻企业信息-供应商入驻-${webName}</title>
	<link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
	<link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css" />
	<link href="${webRoot}/template/bdw/shop/register/statics/css/registered.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
	</script>

	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/plupload/plupload.full.min.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/My97DatePicker/WdatePicker.js"></script>

	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/main.js"></script>
	<script type="text/javascript" src="${webRoot}/commons/js/localStorage.js"></script>
	<script type="text/javascript" src="${webRoot}/commons/js/common.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/shop/register/statics/js/tip.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/shop/register/statics/js/registerShopStep02.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/shop/register/statics/js/registerShopStep02_valid.js"></script>

</head>
<body>
	<%--页头开始--%>
	<%@ include file="/template/bdw/shop/register/registerShopHeader.jsp" %>
	<%--页头结束--%>

	<!--主体-->
	<div class="main-bg">
		<div class="main">

			<%--注册程序--%>
			<div class="mt step02"><!-- step01就是第一步，step02就是第二步 -->
				<div class="mt-item m1">
					1.账号注册
					<span class="after"></span>
				</div>
				<div class="mt-item m2">
					2.填写入驻企业信息
					<span class="after"></span>
					<span class="before"></span>
				</div>
				<div class="mt-item m3">
					3.提交审核
					<span class="after"></span>
					<span class="before"></span>
				</div>
				<div class="mt-item m4">
					4.开通商家
					<span class="before"></span>
				</div>
			</div>


			<div class="step02-mc">
				<div class="info-cont">

					<%--店铺名称--%>
					<div class="cont-box">
						<div class="cb-mt">
							<label>开通店铺</label>
							<span>入驻${webName}开通商家经营店铺全称</span>
						</div>
						<div class="cb-mc">
							<div class="mc-item">
								<label>店铺名称</label>
								<div class="mrt"><input type="text" id="shopNm"></div>
                                <%--<a id="shopNmTip"> </a>--%>
                                <div id="shopNmTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>

							<div class="mc-item">
								<label>企业类型</label>
								<select id="customerTypeId" h>
									<c:forEach var="customerType" items="${sdk:listAllCustomerType()}">
										<option value="${customerType.customerTypeId}">${customerType.customerTypeName}</option>
									</c:forEach>
								</select>
								<div id="customerTypeIdTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
						</div>
					</div>

					<%--企业资料--%>
					<div class="cont-box">
						<div class="cb-mt">
							<label>企业业务资料</label>
							<span></span>
						</div>
						<div class="cb-mc">
							<div class="mc-item">
								<label>企业全称</label>
								<div class="mrt">
									<input id="companyNm" name="companyNm" value="" type="text">
									<p>只支持中国大陆工商局或市场监督管理局登记的企业。请填写工商营业执照上的企业全称。</p>
								</div>
								<%--<a id="companyNmTip"> </a>--%>
								<div id="companyNmTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>法定代表人</label>
								<div class="mrt">
									<input type="text" id="legalPerson">
									<p>请填写工商营业执照上明确的负责人姓名</p>
								</div>
								<%--<a id="legalPersonTip"> </a>--%>
								<div id="legalPersonTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>注册资金</label>
								<div class="mrt">
									<input type="text" id="regCapital" placeholder="单位：万元">
									<p>请填写工商营业执照上明确的注册资金</p>
								</div>
								<%--<a id="regCapitalTip"> </a>--%>
								<div id="regCapitalTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>企业经营地址</label>
								<div class="mrt">
									<input type="text" id="regAddr">
									<p>请填写工商营业执照上明确的经营地址</p>
								</div>
								<%--<a id="regAddrTip"> </a>--%>
								<div id="regAddrTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>是否有实体店</label>
								<select id="isOffLineShop">
									<option value="Y">有</option>
									<option value="N">没有</option>
								</select>
								<div id="isOffLineShopTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>仓库发货地址</label>
								<div class="mrt">
									<select class="shipperAddrSelect">
										<option>选择省份</option>
									</select>
									<select class="shipperAddrSelect">
										<option>选择城市</option>
									</select>
									<select class="shipperAddrSelect" >
										<option>选择地区</option>
									</select>
									<input type="hidden" id="shipperAddrZoneId">
									<input type="text" id="shipperAddrDetail">
									<p>请完整填写仓库详细地址</p>
									<%--<a href="##" class="more">添加仓库</a>--%>
								</div>
								<%--<a id="shipperAddrZoneIdTip"> </a>--%>
								<div id="shipperAddrZoneIdTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
								<%--<a id="shipperAddrDetailTip" style="margin-left: -320px; margin-top: 45px;"> </a>--%>
								<div id="shipperAddrDetailTipError" class="message" style="margin: 0;height: 35px;line-height: 35px; margin-top: 15px"><i></i></div>
							</div>
						</div>
					</div>

					<%--经营范围--%>
					<div class="cont-box range-box" id="businessRange">
						<div class="cb-mt">
							<label>入驻${webName}经营范围</label>
							<span>选择您经营的范围并准备相关电子资质待上传</span>
							<%--<a id="businessRangeTip"> </a>--%>
							<div id="businessRangeTipError" class="message" ><i></i></div>
						</div>
						<div class="cb-mc">
							<c:forEach items="${sdk:getBusinessCategory()}" var="businessCategory">
								<div class="se-item">
									<label>${businessCategory.businessCategoryNm}</label>
									<div class="mrt">
										<c:forEach items="${sdk:listBusinessRangeByCategoryCode(businessCategory.businessCategoryCode)}" var="businessRange">
											<label><input type="checkbox" value="${businessRange.businessRangeId}" id="businessRange_${businessRange.businessRangeId}">${businessRange.name}</label>
										</c:forEach>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>


					<%--联系人信息--%>
					<div class="cont-box info-box">
						<div class="cb-mt">
							<label>联系人信息</label>
						</div>
						<div class="cb-mc">
							<div class="mc-item">
								<label>运营负责人</label>
								<div class="mrt">
									<input type="text" id="companyContactCeo">
									<p>经营${webName}第三方医药批发平台运营负责人</p>
								</div>
								<%--<a id="companyContactCeoTip"> </a>--%>
								<div id="companyContactCeoTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>手机号码</label>
								<div class="mrt">
									<input type="text" id="companyContactPhone" maxlength="11">
								</div>
								<a id="companyContactPhoneTip"> </a>
								<div id="companyContactPhoneTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>电子邮箱</label>
								<div class="mrt">
									<input type="text" id="companyContactEmail">
								</div>
								<a id="companyContactEmailTip"> </a>
								<div id="companyContactEmailTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>微信</label>
								<div class="mrt">
									<input type="text" id="companyContactWeChat">
								</div>
								<%--<a id="companyContactWeChatTip"> </a>--%>
								<div id="companyContactWeChatTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>QQ</label>
								<div class="mrt">
									<input type="text" id="companyContactQQ">
								</div>
								<%--<a id="companyContactQQTip"> </a>--%>
								<div id="companyContactQQTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>企业负责人</label>
								<div class="mrt">
									<input type="text" id="companyCeo">
									<p>入驻${webName}第三方医药批发平台企业负责人</p>
								</div>
								<%--<a id="companyCeoTip"> </a>--%>
								<div id="companyCeoTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>手机号码</label>
								<div class="mrt">
									<input type="text" id="ceoMobile" maxlength="11">
								</div>
								<a id="ceoMobileTip"> </a>
								<div id="ceoMobileTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>质量负责人</label>
								<div class="mrt">
									<input type="text" id="qualityManagement">
									<p>经营${webName}第三方医药批发平台质量负责人</p>
								</div>
								<%--<a id="qualityManagementTip"> </a>--%>
								<div id="qualityManagementTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>手机号码</label>
								<div class="mrt">
									<input type="text" id="qualityManagementMobile" maxlength="11">
								</div>
								<a id="qualityManagementMobileTip"> </a>
								<div id="qualityManagementMobileTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
						</div>
					</div>

					<%--银行账户信息--%>
					<div class="cont-box info-box">
						<div class="cb-mt">
							<label>结算银行信息</label>
						</div>
						<div class="cb-mc">
							<div class="mc-item">
								<label>开户银行</label>
								<div class="mrt">
									<input type="text" id="clearingBank">
								</div>
								<%--<a id="clearingBankTip"> </a>--%>
								<div id="clearingBankTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>支行名称</label>
								<div class="mrt">
									<input type="text" id="branchName">
								</div>
								<%--<a id="branchNameTip"> </a>--%>
								<div id="branchNameTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>银行账户</label>
								<div class="mrt">
									<input type="text" id="clearingBankAccountName">
								</div>
								<%--<a id="clearingBankAccountNameTip" > </a>--%>
								<div id="clearingBankAccountNameTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>银行账号</label>
								<div class="mrt">
									<input type="text" id="clearingBankAccount">
									<p>用于${webName}结算的银行账号</p>
								</div>
								<%--<a id="clearingBankAccountTip"> </a>--%>
								<div id="clearingBankAccountTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
						</div>
					</div>

					<%--发票信息--%>
					<div class="cont-box info-box">
						<div class="cb-mt">
							<label>发票信息</label>
						</div>
						<div class="cb-mc">
							<div class="mc-item">
								<label>发票类型</label>
								<div class="mrt">
									<div class="types"><label><input name="invoiceType" id="invoiceType_normal" type="radio" value="0" onclick="setInvoiceType(0)">普通增值税发票</label></div>
									<div class="types"><label><input name="invoiceType" id="invoiceType_vat" type="radio" value="1" onclick="setInvoiceType(1)">专用增值税发票</label></div>
								</div>
							</div>
							<div class="mc-item">
								<label>发票抬头</label>
								<div class="mrt">
									<input type="text" id="invoiceTitle">
								</div>
								<%--<a id="invoiceTitleTip"> </a>--%>
								<div id="invoiceTitleTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>发票税号</label>
								<div class="mrt">
									<input type="text" id="invoiceNumber">
								</div>
								<%--<a id="invoiceNumberTip"> </a>--%>
								<div id="invoiceNumberTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>发票地址</label>
								<div class="mrt">
									<input type="text" id="invoiceAddress">
								</div>
								<%--<a id="invoiceAddressTip"> </a>--%>
								<div id="invoiceAddressTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item">
								<label>发票电话</label>
								<div class="mrt">
									<input type="text" id="invoicePhone">
								</div>
								<%--<a id="invoicePhoneTip"> </a>--%>
								<div id="invoicePhoneTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item" id="invoiceBankItem" style="display: none">
								<label>开户银行</label>
								<div class="mrt">
									<input type="text" id="invoiceBank">
								</div>
								<%--<a id="invoiceBankTip" > </a>--%>
								<div id="invoiceBankTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
							<div class="mc-item" id="invoiceBankCodeItem" style="display: none">
								<label>银行账号</label>
								<div class="mrt">
									<input type="text" id="invoiceBankCode">
								</div>
								<%--<a id="invoiceBankCodeTip" > </a>--%>
								<div id="invoiceBankCodeTipError" class="message" style="margin: 0;height: 35px;line-height: 35px;"><i></i></div>
							</div>
						</div>
					</div>

					<%--资质信息--%>
					<jsp:include page="shopLicenseFile.jsp"/>
				</div>

				<div class="mc-bot">
					<a href="javascript:;" class="next-btn" id="btnNext">下一步</a>
				</div>

			</div>
		</div>
	</div>


	<%--页脚开始--%>
	<c:import url="/template/bdw/module/common/bottom.jsp"/>
	<%--页脚结束--%>

</body>
</html>

