<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-注册成功-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .box_1{
            background: url("${webRoot}/template/bdw/statics/images/register_result_succe.gif") no-repeat scroll 203px 40px transparent;
            border: 1px solid #989898;
            overflow: hidden;
            padding-bottom: 88px;
            padding-left: 320px;
            padding-top: 40px;
            width: 610px;
        }
        .box_1 h1{
            font-size: 17px;
            font-weight: bold;
            padding-top: 20px;
        }
        .box_1 p{
            font-size: 14px;
            padding: 10px 0 0 70px;
        }
        .box_1 a{
            color: #3366CC;
        }
    </style>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
</head>

<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>
<div id="header">
  <div class="h_shopM">
      <div class="logo frameEdit" frameInfo="logo|239X82">
                  <c:forEach items="${sdk:findPageModuleProxy('logo').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                      <a id="${s.count}" target="_blank" href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt="${advtProxys.hint}" id="adv${s.count}" title="${advtProxys.title}" width="239" height="82" /></a>
                  </c:forEach>
              </div>
  </div>
</div>

<div id="register">
	<div class="resulr">
		<div class="box_1">
			<h1>您的申请已经收到，审核时间1-3个工作日，请随时保持手机畅通！</h1>
            <p>请<a href="${webRoot}/">点击这里</a>返回首页</p>
		</div>
	</div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</html>
