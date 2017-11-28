<%@ page import="com.iloosen.imall.commons.global.Global" %>
<%@ page import="com.iloosen.imall.commons.util.JsonBinder" %>
<%@ page import="com.iloosen.imall.commons.util.StringUtils" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysUser" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.ObjectEngineTypeCodeEnum" %>
<%@ page import="com.iloosen.imall.module.vmall.vo.WeixinConfig" %>
<%@ page import="org.apache.commons.httpclient.HttpClient" %>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%

    String code = request.getParameter("code");
    System.out.println("--------------------------------获得code，执行登录，code="+code);
    if(StringUtils.isBlank(code)){
        return;
    }
    WeixinConfig weixinConfig = ServiceManager.objectEnginService.getObject(ObjectEngineTypeCodeEnum.VMALL_BASE_CONFIG, Global.OBJECT_ENGIN_WEIXIN_BASE_INFO_ID, WeixinConfig.class);
    String urlStr = "https://api.weixin.qq.com/sns/oauth2/access_token";
    StringBuilder buf = new StringBuilder();
    buf.append(urlStr)
            .append("?appid=").append(weixinConfig.getAppId())
            .append("&secret=").append(weixinConfig.getAppSecret())
            .append("&code=").append(code)
            .append("&grant_type=authorization_code");

    HttpClient httpClient = new HttpClient();
    GetMethod method = new GetMethod(buf.toString());
    httpClient.executeMethod(method);
    String result = new String(method.getResponseBody(), "UTF-8");
    Map responseMap = JsonBinder.buildNormalBinder().toBean(result, HashMap.class);
    System.out.println();
    System.out.println("--------------------------------openID="+responseMap.get("openid"));
    System.out.println();
    if(responseMap.get("openid")==null){
        return;
    }
    String openId = (String)responseMap.get("openid");
    List<SysUser> sysUserList = ServiceManager.sysUserService.findByKey(SysUser.V_USER_ID,openId);
    System.out.println();
    System.out.println("--------------------------------通过openId找到="+sysUserList.size()+"个用户");
    System.out.println();

    /*如果没有关注，则自动创建帐号*/
    if(sysUserList.isEmpty()){
        System.out.println("进入codeToLogin.jsp，没有关注，则自动创建帐号");
        ServiceManager.sysUserService.checkAndCreateSysUserByOpenId(openId);
    }
    if(sysUserList.size()>=2){
        //若是合并了，则取合并后的账户
        for(SysUser sysUser : sysUserList){
            if(sysUser.getIsDelete().equals(BoolCodeEnum.NO.toCode())){
                System.out.println("--------------------------------合并登录，用户ID="+sysUser.getSysUserId());
                WebContextFactory.getWebContext().setFrontEndUser(sysUser);
                break;
            }
        }
    }else{
        //未合并则取微信账户，loginId就是openId
        SysUser sysUser = ServiceManager.sysUserService.getByLoginId(openId);
        System.out.println("--------------------------------微信帐号登录，用户ID=" + sysUser.getSysUserId());
        WebContextFactory.getWebContext().setFrontEndUser(sysUser);
    }
%>

<c:set value="${param.state}" var="id"/>
<c:if test="${empty id}">
    <c:redirect url="${webRoot}/wap/index.ac"></c:redirect>
</c:if>

<%-- 取得商品--%>
<c:set var="productProxy" value="${sdk:getProductById(id)}"/>

<%-- 取得商品溯源 --%>
<c:set value="${bdw:getSyProductSourceProxyById(id)}" var="productSourceProxy"> </c:set>
<c:if test="${empty productSourceProxy}">
    <c:redirect url="${webRoot}/wap/index.ac"></c:redirect>
</c:if>


<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>查看溯源<c:if test="${not empty productProxy}">-${productProxy.name}</c:if></title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <style>
        img{
            width: 100%;
            height: 100%;
        }
    </style>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/base.js" type="text/javascript"></script>

</head>

<body>
<div style="width: 94%;margin: 10px auto 20px;">
    ${productSourceProxy.sourceCont}
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>