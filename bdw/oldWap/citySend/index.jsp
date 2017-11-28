<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--腾讯mapKey --%>
<c:set value="${sdk:getSysParamValue('qqMapKey')}" var="qqMapKey"/>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <title>首页-同城送</title>
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/base.css" />
    <link href="${webRoot}/template/bdw/wap/citySend/statics/css/city.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .m-index .banner .addr:before { content: ''; position: absolute; top: 0.8rem; left: 0; width: 2.5rem; height: 2.5rem; -webkit-transform: translateY(-50%); transform: translateY(-50%); background: url(${webRoot}/template/bdw/wap/citySend/statics/images/city-icons.png) no-repeat 0 0 / 10.0rem 7.5rem; }
        .m-index .banner .addr:after { content: ''; position: absolute; top: 0.8rem; right: 4rem; width: 2.5rem; height: 2.5rem; -webkit-transform: translateY(-50%); transform: translateY(-50%); background: url(${webRoot}/template/bdw/wap/citySend/statics/images/city-icons.png) no-repeat -5.0rem 0 / 10.0rem 7.5rem; }
    </style>

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/otoo/statics/js/layer-v1.8.4/layer/layer.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/main.js" type="text/javascript"></script>
    <script src="https://3gimg.qq.com/lightmap/components/geolocation/geolocation.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    var dataValue={
        webRoot:"${webRoot}", //当前路径
        loadLat:"${param.lat}",
        loadLng:"${param.lng}",
        receiveAddrId:"${param.receiveAddrId}",
        qqMapKey:"${qqMapKey}"
    };
    </script>
    <script src="${webRoot}/template/bdw/wap/citySend/statics/js/index.js" type="text/javascript"></script>

</head>

<body>
<div class="main m-index">
  <div class="banner">
      <div class="position">
          <a class="addr" href="${webRoot}/wap/citySend/cityPositionSearch.ac" style="white-space: normal;padding-right: 5.8rem;max-width: 100%;max-height: 6rem;line-height: 2rem;word-break: break-all;" lat="" lng="" id="location" title="正在获取位置信息..">正在获取位置信息..</a>
          <a class="reset" href="${webRoot}/wap/citySend/cityPositionSearch.ac">定位</a>
      </div>

      <div class="search search-trans-dark">
          <input class="search-inp" type="text" placeholder="">
          <a class="search-action" href="javascript:"><i class="icon-search"></i>搜索商家或商品</a>
      </div>
  </div>

  <div class="topToolBar">
      <div class="search-box" style="display:none;">
          <div class="search">
              <input class="search-inp" type="text" placeholder="">
              <a class="search-action" href="javascript:"><i class="icon-search"></i>搜索商家或商品</a>
          </div>
      </div>

      <div class="segmented-control">
          <a class="control-item active" href="javascript:" order="distinct">距离最近</a>
          <a class="control-item" href="javascript:" order="comment">评价最高</a>
          <a class="control-item" href="javascript:" order="speed">配送最快</a>
      </div>
  </div>

  <div class="segmented-content">
      <div class="control-content" id="shopListDiv">
      </div>
  </div>
</div>

<script src="${webRoot}/template/bdw/wap/citySend/statics/js/base.js"></script>
</body>
</html>
