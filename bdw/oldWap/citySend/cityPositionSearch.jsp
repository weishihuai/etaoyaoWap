<%--
  Created by IntelliJ IDEA.
  User: zxh
  Date: 2016/12/30
  Time: 9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<%--腾讯mapKey --%>
<c:set value="${sdk:getSysParamValue('qqMapKey')}" var="qqMapKey"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>选择收货地址-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link href="${webRoot}/template/bdw/wap/citySend/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/citySend/statics/css/city.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .search.active:before {left:0rem;top:0;background:none;}
        .search .btnBack{ display: block;content: ''; position: absolute; left: -0.5rem; top: 50%; width: 2.5rem; height: 2.5rem; font-size: 0; -webkit-transform: translateY(-50%); transform: translateY(-50%); background: url(${webRoot}/template/bdw/wap/statics/images/icon-back-outline.png) no-repeat center center / 100% auto;}
        .m-position-search .current-addr .reset:before { content: ''; position: absolute; top: 50%; left: 0; width: 2.1rem; height: 2.1rem; margin-top: -0.2rem; background: url(${webRoot}/template/bdw/wap/citySend/statics/images/city-icons.png) no-repeat -5.0rem -2.5rem / 10.0rem 7.5rem; -webkit-transform: translateY(-50%);transform: translateY(-50%);}
        .m-position-search .search-box .clear { position: absolute; right: 7.5rem; top: 50%; width: 2.2rem; height: 2.5rem;z-index: 11; font-size: 0; -webkit-transform: translateY(-50%); transform: translateY(-50%); background: url(${webRoot}/template/bdw/wap/citySend/statics/images/clear-enter.png) no-repeat center center / 1.45rem auto;}
    </style>

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/main.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script src="https://3gimg.qq.com/lightmap/components/geolocation/geolocation.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}", //当前路径
            lastPageNumber: "${productProxys.lastPageNumber}",
            orgIds: "${param.orgIds}",
            keyword: "${param.keyword}",
            limit: "${limit}",
            qqMapKey:"${qqMapKey}"
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/citySend/statics/js/cityPositionSearch.js" type="text/javascript"></script>
</head>
<body>
<div class="main m-position-search">
    <div class="search-box" style="padding-right: 9.8rem;">
        <a class="new-addr" href="${webRoot}/wap/module/member/addressOperate.ac?fromPath=cityPositionSearch">新增地址</a>
        <a class="clear" href="javascript:" title="清除">清除</a>
        <div class="search active">
            <a class="btnBack" href="javascript:" onclick="history.go(-1);" title="返回">返回</a>
            <input class="search-inp" id="searchTxt" style="margin-left: 2.5rem;padding-right: 3.2rem;padding-left: 2.5rem;" type="text" placeholder="请输入地址">
            <%--<a class="search-action" href="javascript:;"><i class="icon-search"></i>请输入地址</a>--%>
        </div>
    </div>

    <dl class="current-addr">
        <dt>当前地址</dt>
        <dd>
            <a class="reset" href="javascript:" id="resetPosition">重新定位</a>
            <a href="javascript:" id="currentAddress"><p class="stress" style="margin-right: 10rem;max-width: 100%;white-space:normal;min-height: 2.1rem;" title="" lat="" lng=""></p></a>
        </dd>
    </dl>

    <dl>
        <dt>收货地址</dt>
        <c:choose>
            <c:when test="${empty loginUser}">
                <dd style="text-align: center;"><a href="${webRoot}/wap/login.ac" style="font-size: 1.2rem;color: #F44336;">请先登录</a></dd>
            </c:when>
            <c:otherwise>
                <c:forEach items="${loginUser.receiverAddress}" var="addrValue" varStatus="s" end="10">
                    <dd>
                        <a href="javascript:" class="receiverAddr" lat="${addrValue.lat}" lng="${addrValue.lng}" receiveAddrId="${addrValue.receiveAddrId}">
                            <p class="stress">${addrValue.name}&emsp;${addrValue.mobile}</p>
                            <p>${addrValue.displayAddr}</p>
                        </a>
                    </dd>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </dl>

    <div class="modal" style="display: none;" id="result">
        <div class="modal-content" id="cont">
            <ul id="search-result" class="aaa">
            </ul>
        </div>
    </div>

</div>
<script src="${webRoot}/template/bdw/wap/citySend/statics/js/base.js"></script>
</body>
</html>
