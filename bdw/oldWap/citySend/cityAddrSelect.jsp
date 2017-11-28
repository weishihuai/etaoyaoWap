<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<%--同城送收货地址--%>
<c:set value="${bdw:findCitySendAddr(loginUser.userId,param.orgId,true)}" var="citySendAddrList"/>
<%--购物车类型--%>
<c:set var="carttype" value="store"/>

<!DOCTYPE html>
<html>
<head>
    <title>收货地址</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/wap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/wap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/member.css" rel="stylesheet">
    <style type="text/css">
        /*弹出提示框*/
        .layer-tip {position: fixed; bottom: 6rem; left: 50%; z-index: 9999; width: 50%; min-height: 3rem; margin-left: -25%; padding: 0 1rem; font-size: 1.2rem; text-align: center; line-height: 3rem; color: #fff; background-color: rgba(0,0,0,.5);}

        /*弹出确认框*/
        .msg-box {position: fixed;bottom: 10rem; left: 50%; width: 80%; height: auto; margin-left: -40%; padding: 1rem; background-color: rgba(0,0,0,.7);z-index: 9999;}
        .msg-box p { margin-bottom: 1.5rem; font-size: 1.7rem; color: #fff;text-align: justify;}
        .msg-box .btn {display: inline-block; width: 48%;height: 3rem;line-height: 3rem;text-align: center;font-size: 1.3rem; border-radius: .4rem;}
        .msg-box .btn-l {color: #666; background-color: #fff;float: left;padding: 0;font-size: 1.7rem;}
        .msg-box .btn-r {color: #fff; background-color: #2fbdc8;float: right;padding: 0;font-size: 1.7rem;}
    </style>

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            orgId:"${param.orgId}",
            cartType:"${carttype}",
            isCod:"${param.isCod}"
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/citySend/statics/js/cityAddrSelect.js" type="text/javascript"></script>
</head>
<body>

<header class="row header">
    <div class="col-xs-8 col-xs-offset-2" style="font-weight: bolder;">选择收货地址</div>
</header>

<c:set var="isEmptyAddrList" value="true"/>
<c:forEach items="${citySendAddrList}" var="address">
    <c:if test="${address.citySendSupport}">
        <c:set var="isEmptyAddrList" value="false"/>
        <div class="row addrRow" receiveAddrId="${address.receiveAddrId}">
            <div class="col-xs-12 adr_rows" style="cursor: pointer;border-bottom: 1px solid #DCDDDD;border-top: none;">
                <div class="row">
                    <div class="col-xs-12 adr_name">${address.name}&nbsp;&nbsp;${address.mobile}</div>
                </div>
                <div class="row">
                    <div class="col-xs-11 adr_text">
                        ${address.addressPath}
                    </div>
                    <div class="col-xs-1"><span class="glyphicon  ${'Y' == address.isDefault ? ' glyphicon-ok ' : ' '} glyphicon-ok5 slectItem"></span></div>
                </div>
                <div class="row" style="padding-right: 10rem;">
                    <div class="col-xs-12 adr_text">
                        <span style="word-break: break-all;">${address.addressStr}</span>
                        <a style="position: absolute;right: -4rem;padding-left: 20px;background: url('${webRoot}/template/bdw/wap/module/member/statics/images/add-icon.png') no-repeat left 0 / auto 18px;" href="javascript:" receiveAddrId="${address.receiveAddrId}" class="editBtn">编辑</a>
                        <a style="position: absolute;right: -10rem;padding-left: 20px;background: url('${webRoot}/template/bdw/wap/module/member/statics/images/del-icon.png') no-repeat left 1px / 18px auto;" href="javascript:" receiveAddrId="${address.receiveAddrId}" class="delBtn">删除</a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</c:forEach>

<c:if test="${isEmptyAddrList == 'true'}">
    <div class="row addrRow">
        <div class="col-xs-12 adr_rows" style="cursor: pointer;border-bottom: 1px solid #DCDDDD;border-top: none;">
            <div class="row">
                <div class="col-xs-11 adr_text" style="text-align: center;">
                    查询不到可配送的地址
                </div>
            </div>
        </div>
    </div>
</c:if>

<div class="row" style=" margin-top: 8px;">
    <div class="col-xs-10 col-xs-offset-1" >
        <button onclick="window.location.href='${webRoot}/wap/module/member/addressOperate.ac?fromPath=cityAddrSelect&orgId=${param.orgId}&isCod=${isCod}&time='+(new Date()).getTime()"
                class="btn btn-default btn-default_adr btn-block" style="border: 1px solid #CC3333;background: none repeat scroll 0 0 #CC3333; color: #fff; font-weight: bold;" type="button">
            添加收货地址
        </button>
    </div>
</div>

</body>
</html>