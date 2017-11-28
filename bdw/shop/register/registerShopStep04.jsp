<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="renderer" content="webkit">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
	<title>开通商家-供应商入驻-${webName}</title>
	<meta name="keywords" content="${sdk:getSysParamValue('index_keywords')} ${webName},开通商家" />       <%--SEO keywords优化--%>
	<meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
	<link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
	<link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css" />
	<link href="${webRoot}/template/bdw/shop/register/statics/css/registered.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript">
		var webPath = {webRoot:"${webRoot}"};
	</script>
</head>


<body>
<%--页头开始--%>
<%@ include file="/template/bdw/shop/register/registerShopHeader.jsp" %>
<%--页头结束--%>
	<!--主体-->
	<div class="main-bg">
		<div class="main">
			<div class="mt step04"><!-- step01就是第一步，step02就是第二步 -->
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
			<div class="step04-mc">
				<h4>恭喜！您的电子资质文件已提交，请等待管理员审核！</h4>
				<h5>为了您能尽快成为${webName}的正式入驻商家，请您及时联系${webName}客服进行审核。
					</h5>
				<div class="info">
					<%--<div class="in-mt"><span>纸质资质寄送地址信息（提示：请完善后邮寄，以免材料不全）</span></div>--%>
					<div class="in-box">
						<p>联系人： ${sdk:getSysParamValue('reg_zz_contact')}</p>
						<p>手机号码：${sdk:getSysParamValue('reg_zz_tel')}</p>
						<%--<p>收件地址：${sdk:getSysParamValue('reg_zz_addr')}</p>--%>
					</div>
					<div class="in-mt"><span>商家快速审核通道,联系微信</span></div>
					<div class="pic"><img src="${webRoot}/template/bdw/shop/register/statics/images/pic160x160.jpg" alt=""></div>
				</div>
			</div>
		</div>
	</div>


<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>

