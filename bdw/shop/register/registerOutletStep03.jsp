<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="renderer" content="webkit">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>提交审核-${webName}</title>
	<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
	<link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
	<link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
		var webPath = {webRoot:"${webRoot}" };
        var imgRootUrl = "${webRoot}/upload/";
	</script>
	<link href="${webRoot}/template/bdw/shop/register/statics/css/registered.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/plupload/plupload.full.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/My97DatePicker/WdatePicker.js"></script>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/main.js"></script>
	<script type="text/javascript" src="${webRoot}/commons/js/localStorage.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/shop/register/statics/js/tip.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/shop/register/statics/js/registerOutletStep03.js"></script>
</head>

<body>
<%--页头开始--%>
<%@ include file="/template/bdw/shop/register/registerOutletHeader.jsp" %>
<%--页头结束--%>
<!--主体-->
<div class="main-bg">
	<div class="main">
		<div class="mt step03"><!-- step01就是第一步，step02就是第二步 -->
			<div class="mt-item m1">
				1.账号注册
				<span class="after"></span>
			</div>
			<div class="mt-item m2">
				2.填写门店信息
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
		<div class="step03-mc">
			<div class="mc-cont">
				<div class="cb-mt">
					<label>请认真核对以下信息，并提交相关资质文件</label>
					<span>请核实信息并准备相关资质文件进行提交, <a href="${webRoot}/shop/register/registerOutletStep02.ac">返回修改</a></span>
				</div>

				<div class="line"></div>
				<div class="cb-mt">
					<label>登录账户信息</label>
				</div>
				<div class="mc-box">
					<div class="box-item">
						<label>登录账号:</label>
						<div class="mrt">
							<span  id="loginId" > </span>
						</div>
					</div>
					<div class="box-item">
						<label>联系手机:</label>
						<div class="mrt">
							<span id="userMobile"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>电子邮箱:</label>
						<div class="mrt">
							<span id="userEmail"></span>
						</div>
					</div>
				</div>

				<div class="line"></div>
				<div class="cb-mt">
					<label>门店信息</label>
				</div>
				<div class="mc-box">
					<div class="box-item">
						<label>门店类型:</label>
						<div class="mrt">
							<span id="storeType"></span>
						</div>
					</div>
					<div class="box-item">
						<label>所属连锁:</label>
						<div class="mrt">
							<span id="outletCompanyNm"></span>
						</div>
					</div>
					<div class="box-item">
						<label>门店全称:</label>
						<div class="mrt">
							<span id="shopNm"></span>
						</div>
					</div>
					<div class="box-item">
						<label>法定代表人:</label>
						<div class="mrt">
							<span id="legalPerson"></span>
						</div>
					</div>
					<div class="box-item">
						<label>注册资金:</label>
						<div class="mrt">
							<span  id="regCapital"></span><span>万元</span>
						</div>
					</div>
					<div class="box-item">
						<label>门店经营地址:</label>
						<div class="mrt">
							<span id="outletAddrAll"> </span><br>
						</div>
					</div>
					<div class="box-item">
						<label>门店联系电话:</label>
						<div class="mrt">
							<span id="tel"> </span><br>
						</div>
					</div>
					<div class="box-item">
						<label>门店手机:</label>
						<div class="mrt">
							<span id="mobile"> </span><br>
						</div>
					</div>
					<div class="box-item">
						<label>入驻${webName}经营范围:</label>
						<div class="mrt">
							<c:forEach items="${sdk:listAllBusinessRange()}" var="businessRange">
								<span id="businessRange_${businessRange.businessRangeId}" style="display: none">${businessRange.name}、</span>
							</c:forEach>
						</div>
					</div>
				</div>


				<div class="line"></div>
				<div class="cb-mt">
					<label>联系人信息</label>
				</div>
				<div class="mc-box">
					<div class="box-item">
						<label>运营负责人:</label>
						<div class="mrt">
							<span id="companyContactCeo"></span>
						</div>
					</div>
					<div class="box-item">
						<label>手机号码:</label>
						<div class="mrt">
							<span id="companyContactPhone"></span>
						</div>
					</div>
					<div class="box-item">
						<label>电子邮箱:</label>
						<div class="mrt">
							<span id="companyContactEmail" > </span>
						</div>
					</div>
					<div class="box-item">
						<label>微信:</label>
						<div class="mrt">
							<span id="companyContactWeChat"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>QQ:</label>
						<div class="mrt">
							<span id="companyContactQQ"> </span>
						</div>
					</div>
					<br>
					<div class="box-item">
						<label>店长:</label>
						<div class="mrt">
							<span id="companyCeo"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>手机号码:</label>
						<div class="mrt">
							<span  id="ceoMobile" > </span>
						</div>
					</div>
					<br>
					<div class="box-item">
						<label>执业药师:</label>
						<div class="mrt">
							<span  id="qualityManagement"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>手机号码:</label>
						<div class="mrt">
							<span  id="qualityManagementMobile" > </span>
						</div>
					</div>
				</div>

				<div class="line"></div>
				<div class="cb-mt">
					<label>结算银行信息</label>
				</div>
				<div class="mc-box">
					<div class="box-item">
						<label>开户银行:</label>
						<div class="mrt">
							<span  id="clearingBank"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>支行名称:</label>
						<div class="mrt">
							<span id="branchName"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>银行账户:</label>
						<div class="mrt">
							<span id="clearingBankAccountName"></span>
						</div>
					</div>
					<div class="box-item">
						<label>银行账号:</label>
						<div class="mrt">
							<span id="clearingBankAccount"></span>
						</div>
					</div>
				</div>

				<div class="line"></div>
				<div class="cb-mt">
					<label>发票信息</label>
				</div>
				<div class="mc-box">
					<div class="box-item">
						<label>类型:</label>
						<div class="mrt">
							<span id="invoiceType"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>抬头:</label>
						<div class="mrt">
							<span id="invoiceTitle"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>税号:</label>
						<div class="mrt">
							<span  id="invoiceNumber"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>地址:</label>
						<div class="mrt">
							<span id="invoiceAddress"> </span>
						</div>
					</div>
					<div class="box-item">
						<label>电话:</label>
						<div class="mrt">
							<span id="invoicePhone"> </span>
						</div>
					</div>
					<div class="box-item" id="invoiceBankItem" style="display: none;">
						<label>开户银行:</label>
						<div class="mrt">
							<span id="invoiceBank"> </span>
						</div>
					</div>
					<div class="box-item" id="invoiceBankCodeItem" style="display: none;">
						<label>银行账号:</label>
						<div class="mrt">
							<span id="invoiceBankCode"> </span>
						</div>
					</div>
				</div>

				<div class="line"></div>
				<div class="cb-mt">
					<label>资质文件</label>
				</div>
				<div class="mc-box"  id="licenses">
                    <div class="box-item">
                        <label>证件类型:</label>
                        <div class="mrt">
                            <span id="isThreeInOne"> </span>
                        </div>
                    </div>
					<br>
				</div>
			</div>
			<div class="mc-bot">
				<a href="javascript:;" class="next-btn" onclick="saveShopInf();">提交审核</a>
			</div>
		</div>
	</div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>

