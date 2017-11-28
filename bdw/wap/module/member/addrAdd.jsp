<html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${param.id}" var="id"/>
<head lang="en">
    <meta charset="utf-8">
    <title>${empty id ? '新增收货地址' : '编辑收货地址'}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/add-site.css" type="text/css" rel="stylesheet" />
</head>
<c:set value="${sdk:getZoneChildrenByParentId(9)}" var="provinces"/>
<c:set value="${sdk:getReceiverAddrById(id)}" var="receiverAddr"/>
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1);"></a>
    <span>${empty id ? '新增收货地址' : '编辑收货地址'}</span>
</div>

<div class="add-site-main">
    <div class="item"><span>收货人:</span><input value="${receiverAddr.name}" maxlength="48" id="name" name="name" type="text"/></div>
    <div class="item"><span>手机号码:</span><input value="${receiverAddr.mobile}" maxlength="11" id="mobile" name="mobile" type="text"/></div>
    <div class="item"><span>所在地区:</span><input value="${receiverAddr.addressPath}" readonly="readonly" id="addrPath" name="addrPath" type="text"/></div>
    <div class="item"><span>详细地址:</span><input value="${receiverAddr.addr}" maxlength="128" id="addr" name="addr" placeholder="街道、楼层" onfocus="goToBottom()"  type="text"/></div>
    <input type="hidden" value="${receiverAddr.zoneId}" id="zoneId" name="zoneId"/>
    <input type="hidden" value="${id}" id="id" name="id"/>
    <input type="hidden" value="${receiverAddr.addressStr}" id="geocoderLocation"/>
    <div class="m-sub"><a href="javascript:;" <c:if test="${empty id}">class="disable"</c:if>><span>保存</span></a></div>
</div>
<div style="display: none;" class="site-select-layer">
    <div class="site-select-box">
        <div class="dt">所在地区<a class="close-btn" href="javascript:;"></a></div>
        <div class="dd">
            <div class="dd-toggle"><p data-type="province" class="cur">选择省</p></div>
            <ul data-type="province" id="province" class="dd-list">
                <c:forEach items="${provinces}" var="p">
                    <li data-sys-tree-node-id="${p.sysTreeNodeId}">${p.sysTreeNodeNm}</li>
                </c:forEach>
            </ul>
            <ul style="display: none;" data-type="city" id="city" class="dd-list">

            </ul>
            <ul style="display: none;" data-type="area" id="area" class="dd-list">

            </ul>
        </div>
    </div>
</div>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
<script src="${webRoot}/template/bdw/wap/module/member/statics/js/addAddr.js"></script>
<script type="text/javascript">
    var webPath = {
        webRoot: "${webRoot}",
        redirectUrl: '${param.redirectUrl}'
    }
</script>
</body>
</html>
