<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="method" value="${empty param.method ? '添加' : '编辑'}"/>
<c:set var="receiveAddrId" value="${empty param.receiveAddrId ? '' : param.receiveAddrId}"/>

<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no, email=no" />
    <title>${method}收货地址</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/addressOperate.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">

    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/shoppingcart/statics/js/addressOperate.js"></script>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}",handler:"${param.handler}",carttype:"${param.carttype}"
        };
        //var change = false;
    </script>

</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=${method}收货地址"/>
<%--页头结束--%>
<div class="main">
    <div class="msg-list">
        <div class="input-box">
            <input type="text" class="name" placeholder="请输入联系人" maxlength="20">
            <a href="javascript:void(0);" class="clearInput clearName"></a>
        </div>
        <div class="input-box">
            <input type="text" class="phone" placeholder="请输入联系号码" maxlength="11">
            <a href="javascript:void(0);" class="clearInput clearPhone"></a>
        </div>
        <div class="input-box addrPath">
            <a href="javascript:void(0);" class="address-chose">
                <span class="text addrPathText">请选择省，市，区</span>
            </a>
        </div>
        <div class="input-box">
            <input type="text" class="address-desc addr" placeholder="请输入详细地址" maxlength="125">
            <a href="javascript:void(0);" class="clearInput clearAddr"></a>
        </div>
        <div class="input-box">
            <input type="text" class="zipcode" placeholder="请输入邮政编码" maxlength="6">
            <a href="javascript:void(0);" class="clearInput clearZip"></a>
        </div>
    </div>

    <%-- 下面两个div不显示，只是为了保存变量用的 --%>
    <div class="zoneId" style="display:none"></div>
    <div class="receiveAddrId" style="display:none" value="${receiveAddrId}"></div>

    <a href="#" class="save-btn">确认并保存</a>

    <%-- 结算页这里设置地址的时候不要去设置默认地址，不然用户可能会有误会 --%>
    <%--<a href="javascript:void(0);" class="use-always" isDefault="N">设为默认</a>--%>
</div>

<%-- 选择省份 --%>
<div class="choose-area provinceArea" style="display:none">
    <div class="area-box">
        <div class="title">
            <a href="javascript:void(0);" class="back province"></a>
            选择省份
            <a class="del" href="javascript:void(0);">&times;</a>
        </div>
        <div class="area-list provinceList">
        </div>
        <div class="bottom-text">已选择 <span class="provinceSelected"></span></div>
    </div>
</div>

<%-- 选择城市 --%>
<div class="choose-area cityArea" style="display:none">
    <div class="area-box">
        <div class="title">
            <a href="javascript:void(0);" class="back city"></a>
            选择城市
            <a class="del" href="javascript:void(0);">&times;</a>
        </div>
        <div class="area-list cityList">
        </div>
        <div class="bottom-text">已选择 <span class="citySelected"></span></div>
    </div>
</div>

<%-- 选择地区 --%>
<div class="choose-area zoneArea" style="display:none">
    <div class="area-box">
        <div class="title">
            <a href="javascript:void(0);" class="back zone"></a>
            选择地区
            <a class="del" href="javascript:void(0);">&times;</a>
        </div>
        <div class="area-list zoneList">
        </div>
        <div class="bottom-text">已选择 <span class="zoneSelected"></span></div>
    </div>
</div>
<%--页脚开始--%>
<%--<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>--%>
<%--页脚结束--%>
</body>

</html>
