<%@ page import="com.iloosen.imall.commons.global.Global" %>
<%@ page import="com.iloosen.imall.commons.util.StringUtils" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="now" class="java.util.Date"/>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:if test="${not empty loginUser}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>

<%
    Map<String, String> codeMap = new HashMap<String, String>();
    GregorianCalendar cal = new GregorianCalendar();
    cal.setTime(new Date());
    String uuid = UUID.randomUUID().toString();
    StringBuilder builder = new StringBuilder();
    builder.append(uuid).append(cal.getTimeInMillis());
    codeMap.put(builder.toString(), "http://" + request.getHeader("host") + "/wap/doWeixinConfirmLogin.ac?uuid=" + uuid);
    WebContextFactory.getWebContext().setSessionAttr("qrcodeLongCode", codeMap);
    pageContext.setAttribute("qrcodelong1", builder.toString());
    request.setAttribute("uuid",uuid);
    if(request.getSession().getAttribute(Global.REDIRECT_URL) != null && StringUtils.isNotBlank(request.getSession().getAttribute(Global.REDIRECT_URL).toString())) {
        request.setAttribute("url",request.getSession().getAttribute(Global.REDIRECT_URL));
    }else{
        request.setAttribute("url",request.getParameter("webRoot") + "/index.ac");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:set value="${empty param.firstLogin ? 0 : 1}" var="newComer"/>
<head>
    <meta property="qc:admins" content="3553273717624751446375" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}"/>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}"/>
    <title>微信登录</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/base1019.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <%--<link href="${webRoot}/template/bdw/statics/css/header1019.css" rel="stylesheet" type="text/css"/>--%>
    <link href="${webRoot}/template/bdw/statics/css/index1019.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .status{
            text-align: center;
            margin-top:15px;
            background-color:#232323;
            border-radius:100px;
            -moz-border-radius:100px;
            -webkit-border-radius:100px;
            box-shadow:inset 0 5px 10px -5px #191919,0 1px 0 0 #444;
            -moz-box-shadow:inset 0 5px 10px -5px #191919,0 1px 0 0 #444;
            -webkit-box-shadow:inset 0 5px 10px -5px #191919,0 1px 0 0 #444;
            font-size: 16px;
            color: #fff;
        }
    </style>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.lazyload.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/index.js"></script>

    <script type="text/javascript">
        var newComer = ${newComer};
        $(function(){
            setInterval("scanCodeLogin()",2000);
        });

        function scanCodeLogin(){
            $.ajax({
                type:"post",
                url:Top_Path.webRoot + "/member/getWeiXinScanCodeLogin.json",
                data:{uuid:"${uuid}"},
                dataType:"json",
                async: false,
                success:function(data){
                    if(data.success == "true"){
                        location.href="${url}";
                    }
                }

            });
        }
    </script>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<!--页头结束-->


<div style="width:300px;height: 390px;margin: 25px auto;">
    <div style="width:305px;font-size: 19px;text-align: center;">微信登录</div>
    <img src="${webRoot}/QRCodeServlet?qrcodelong=${qrcodelong1}" width="300" height="300"/>
    <div class="status">
        <p style="padding: 5px 0px;">请使用微信扫描二维码登录</p>
        <p style="padding-bottom:5px;">“${webName}”</p>
    </div>
</div>
<!--底部-->
<c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
</html>
