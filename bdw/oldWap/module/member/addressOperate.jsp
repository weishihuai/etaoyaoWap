<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="method" value="${empty param.method ? '添加' : '编辑'}"/>
<c:set var="receiveAddrId" value="${empty param.receiveAddrId ? '' : param.receiveAddrId}"/>

<%--腾讯mapKey --%>
<c:set value="${sdk:getSysParamValue('qqMapKey')}" var="qqMapKey"/> <%--获取当前用户--%>

<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no, email=no" />
    <title>${method}收货地址</title>
    <%--<link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">--%>
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/addressOperate.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/common.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/css/zepto.alert.css" rel="stylesheet" type="text/css">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/mapAddress.css" rel="stylesheet"  type="text/css">

    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/otoo/statics/js/layer-v1.8.4/layer/layer.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/module/member/statics/js/base.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/main.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="https://3gimg.qq.com/lightmap/components/geolocation/geolocation.min.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&libraries=place"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js" type="text/javascript"></script>
    <script type="text/javascript">
        var dataValue={
            webRoot:"${webRoot}", //当前路径
            qqMapKey:"${qqMapKey}",
            /*同城送选择地址跳转参数 START */
            fromPath:"${param.fromPath}",
            orgId:"${param.orgId}",
            isCod:"${isCod}",
            /*同城送选择地址跳转参数 END */
            handler:"${param.handler}",
            carttype:"${param.carttype}",
            /*积分订单跳转参数 START */
            integralProductId:"${param.integralProductId}",
            num:"${param.num}",
            integralExchangeType:"${param.integralExchangeType}",
            /*积分订单跳转参数 END */
            /*换货参数START*/
            orderItems :'${param.orderItems}',
            orderId:'${param.orderId}',
            isReturn: '${param.isReturn}',
            itemNums: '${param.numStr}'
            /*换货参数END*/

        };
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/module/member/statics/js/addressOperate.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.alert.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/tinyAlertDialog.js" type="text/javascript"></script>
</head>

<body>
    <div id="userAddr">
        <%--页头开始--%>
        <%--<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=${method}收货地址"/>--%>
        <div class="row" id="d_row1">
            <div class="col-xs-2"><a onclick="history.go(-1);" href="javascript:void(0);" style="color:#FFF"><span class="glyphicon glyphicon-arrow-left"></span></a></div>
            <div class="col-xs-8">${method}收货地址</div>
        </div>
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
                <div class="input-box">
                    <a href="javascript:void(0);" class="address-chose addrPath" isMapLocated="false">
                        <span class="text addrPathText">请选择省，市，区</span>
                    </a>
                    <%--<a href="javascript:void(0);" class="map_located" id="locatedM"></a>--%>
                </div>
                <div class="input-box">
                    <input type="text" class="address-desc addr" placeholder="请输入详细地址" maxlength="125" id="detailAddr">
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

            <a href="javascript:void(0);" class="save-btn">确认并保存</a>

            <a href="javascript:void(0);" class="use-always" isDefault="N">设为默认</a>
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

        <div class="choose-area townArea" style="display:none">
            <div class="area-box">
                <div class="title">
                    <a href="javascript:void(0);" class="back town"></a>
                    选择地区
                    <a class="del" href="javascript:void(0);">&times;</a>
                </div>
                <div class="area-list townList">
                </div>
                <div class="bottom-text">已选择 <span class="townSelected"></span></div>
            </div>
        </div>


    </div>
    <div id="locatedAddr" style="display: none;">
        <!-- 搜索入口 -->
        <div class="search-sec">
            <a class="action action-back" href="javascript:">返回</a>
            <a class="action action-cancel" href="javascript:">取消</a>
            <a class="action action-clear" href="javascript:">清除</a>
            <div class="inp-wrap">
                <input class="inp" type="text" placeholder="小区｜写字楼｜学校" id="keywords"/>
            </div>
        </div>

        <!-- 地图 -->
        <div class="map-sec" id="locationMap"></div>

        <!-- 地址列表 -->
        <div class="area-sec">
            <ul id="nearPanel">
            </ul>
        </div>

        <!-- 搜索结果 -->
        <div id="searchMap"></div>
        <div class="modal" style="display: none;" id="result">
            <div class="modal-content" style="display: none;" id="cont">
                <ul id="search-result" class="aaa">

                </ul>
            </div>
        </div>
    </div>
</body>

</html>
