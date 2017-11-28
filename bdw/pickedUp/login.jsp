<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:getAdminPickedUp()}" var="adminPickedUp"/>
<c:if test="${not empty adminPickedUp}">
    <c:redirect url="/pickedUp/notReceiving.ac"></c:redirect>
</c:if>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>${webName}-登录页面</title>
    <link href="${webRoot}/template/bdw/pickedUp/style/l_header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/pickedUp/style/login.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.md5.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/pickedUp/js/login.js"></script>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/pickedUp/common/top.jsp"/>
<%--页头开始--%>


<!--l_index-->
<div class="l_index_bg">
    <div class="l_index">
        <div class="li_lt"></div>
        <div class="li_rt_bg">
            <div class="li_rt">
                <h4>自提点登录</h4>

                <div class="item fore1">
                    <input type="text" id="loginId"/>
                </div>
                <div class="item fore2 cur">
                    <div class="error" id="error">您输入的账户名和密码不匹配，请重新输入</div>
                    <input type="password" id="loginPsw"/>
                </div>
                <div class="login_btn"><a href="javascript:;">登&nbsp;&nbsp;录</a></div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>


<%--页尾开始--%>
<c:import url="/template/bdw/pickedUp/common/bottom.jsp"/>
<%--页尾开始--%>

</body>
</html>
