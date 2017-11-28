<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telphone=no, email=no"/>
    <title>店铺资质</title>

    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/shop-info.css" type="text/css" rel="stylesheet" />

    <script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function showCertImages(){
            var url = "${webRoot}/wap/module/shop/shopCertImages.ac?shopId=${shop.shopInfId}";
            $("#descriptionAlert").css("display","none");
            $("#certImages").load(url);
            $("#certImages").css("display","block");
        }
        $(function(){
            if(${isWeixin=="Y"}){
                $(".alert").css("margin-top","0px");
            }
        });
    </script>
</head>

<body>
    <!--头部-->
    <c:if test="${isWeixin!='Y'}">
    <header class="header">
        <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
        <span class="title">店铺资质</span>
        <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
    </header>
    </c:if>
    <%--<div class="main">
        <c:if test="${!empty shop.certifiedImages}">
            <c:forEach items="${shop.certifiedImages}" var="certImages" varStatus="status">
                <img src="${certImages[""]}" style="height: 100%;width: 100%">
            </c:forEach>
        </c:if>
    </div>--%>
    <div class="alert alert-danger fade in" style="margin-top: 45px" id="descriptionAlert">
        <h4>温馨提示!</h4>
        <p>浏览店铺资质会产生较大的流量，建议您在Wifi网络中使用。</p>
        <p>
            <button type="button" class="btn btn-danger btn-lg" id="showCertImages" onclick="showCertImages();"><span class="glyphicon glyphicon-ok"/> 继续查看</button>
        </p>
    </div>
    <div style="display: none;" class="main" id="certImages"></div>
</body>

</html>




