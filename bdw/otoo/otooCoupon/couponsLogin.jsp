<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${bdw:CheckShopLogin()}" var="sysShopInf"></c:set>
<c:if test="${not empty sysShopInf}">
    <c:redirect url="/otoo/otooCoupon/couponsSearch.ac"></c:redirect>
</c:if>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title>登录页面</title>
    <link href="${webRoot}/template/bdw/otoo/otooCoupon/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/otoo/otooCoupon/css/couponsLogin.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.md5.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/otooCoupon/js/couponsLogin.js"></script>

</head>
<body>
<!--页头-->
<c:import url="/template/bdw/otoo/otooCoupon/common/top.jsp"/>
<!--l_index-->
<div class="l_index_bg">
    <div class="l_index">
        <div class="li_lt"></div>
        <div class="li_rt_bg">
            <div class="li_rt">
                <h4>查询入口登录</h4>
                <div class="item fore1 cur">
                    <div class="error" style="display: none;" id="error_login_id"></div>
                    <input type="text" id="loginId" />
                </div>
                <div class="item fore2 cur">
                    <div class="error" style="display: none;" id="error_login_pwd"></div>
                    <input type="password" id="loginPwd" />
                </div>
                <div class="yzm cur">
                    <div class="error" style="display: none;" id="code_error"></div>
                    <input type="text" id="code"/>

                    <a href="javascript:void(0)" onclick="changValidateCode();return false;"><img style="width:89px;height:38px" id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode'></a>
                </div>
                <div class="login_btn"><a href="javascript:void(0)" id="login_btn">登&nbsp;&nbsp;录</a></div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>
<c:import url="/template/bdw/otoo/otooCoupon/common/bottom.jsp?p=index"/>
</body>
</html>
