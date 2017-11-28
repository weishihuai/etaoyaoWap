<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/14
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:searchZones()}" var="zones"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${sdk:getSysParamValue('key_tengxunMap')}" var="mapKey"/>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title>淘药店-${webName}</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="${webRoot}/template/bdw/citySend/statics/css/allStoreCarts.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/citySend/statics/css/tcs-index.css">

  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/jquery.ld.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/external/jquery.cookie.js"></script>
  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/ui/jquery.ui.core.js"></script>
  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/ui/jquery.ui.position.js"></script>
  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/ui/jquery.ui.widget.js"></script>
  <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/ui/jquery.ui.autocomplete.js"></script>
  <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
  <script type="text/javascript">
    var webParams = {
      webRoot: '${webRoot}',
      orgId: '${param.orgId}',
      lat: '${param.lat}',
      lng: '${param.lng}',
      mapkey:'${mapKey}'
    };
    var zoneData = [];
    <c:forEach items="${zones}" var="zone">
      <c:forEach items="${zone.value}" var="city">
        zoneData.push({value: "${city.spell}${city.name}", name: "${city.name}", zoneId: ${city.zoneId}});
      </c:forEach>
    </c:forEach>
  </script>
  <script type="text/javascript" src="${webRoot}/template/bdw/citySend/statics/js/citywide.js"></script>
</head>
<body>

<%--同城送地图头部--%>
<c:import url="/template/bdw/citySend/common/citySendTop.jsp?p=index"/>

<!--主体-->
<div class="main">
  <div class="map-img" id="map"></div>
</div>

</body>
</html>