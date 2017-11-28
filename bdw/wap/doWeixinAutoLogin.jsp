<%@ page import="com.iloosen.imall.commons.global.Global" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.ObjectEngineTypeCodeEnum" %>
<%@ page import="com.iloosen.imall.module.vmall.vo.WeixinConfig" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    try{
        System.out.println("--------------------------------进入doWeixinAutoLogin.jsp");
        StringBuffer url = request.getRequestURL();
        String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
        request.setAttribute("tempContextUrl", tempContextUrl);

        WeixinConfig settingConfig = ServiceManager.objectEnginService.getObject(ObjectEngineTypeCodeEnum.VMALL_BASE_CONFIG, Global.OBJECT_ENGIN_WEIXIN_BASE_INFO_ID, WeixinConfig.class);
        String reqUrl = "https://open.weixin.qq.com/connect/oauth2/authorize";
        String weixinRequestUrl = (String)request.getAttribute("weixinRequestUrl");
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(reqUrl)
                .append("?appid=").append(settingConfig.getAppId())
                .append("&redirect_uri=").append(java.net.URLEncoder.encode(tempContextUrl+"wap/codeToLogin.ac","GB2312"))
                .append("&response_type=code&scope=snsapi_base&state=").append(weixinRequestUrl).append("#wechat_redirect");

        System.out.println("请求code地址="+stringBuilder.toString());
        System.out.println();
        response.sendRedirect(stringBuilder.toString());
    }catch (Throwable e){
        e.printStackTrace();
    }

%>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
</head>
<body>

</body>
</html>
