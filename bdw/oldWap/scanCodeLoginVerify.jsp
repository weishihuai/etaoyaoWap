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
    String uuid = request.getParameter("uuid");
    System.out.println();
    System.out.println("--------------------------------获得code，执行扫码登录，code="+code+",uuid=" + uuid);
    if(StringUtils.isBlank(code) && StringUtils.isBlank(uuid)){
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

    request.setAttribute("openId",openId);
    request.setAttribute("uuid",uuid);

%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>确认登录</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/headerForIndex.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/index.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/unslider.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/css/zepto.alert.css" rel="stylesheet" type="text/css" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/scanCodeLoginVerify.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",openId:"${openId}",uuid:"${uuid}"};
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/base.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.alert.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/tinyAlertDialog.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.lazyload.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/index.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#message").load(webPath.webRoot+"/template/bdw/oldWap/ajaxload/indexMessage.jsp",{},function(){});
        });
    </script>

</head>

<body>
<!--头部-->
<header class="header">
    <div class="index-top">
        <div class="logo frameEdit" frameInfo="weixin_logo_new|65X25">
            <c:forEach items="${sdk:findPageModuleProxy('weixin_logo_new').advt.advtProxy}" var="logo" end="0">
                <i style="display:block;background: url(${logo.advUrl}) no-repeat 0 0 / 65px 25px;" onclick="window.location.href='${logo.link}'"></i>
            </c:forEach>
        </div>

        <div id="message"></div>

    </div>
</header>
<!--中间内容-->
<div class="main">
    <div class="cont">
        <div class="pic"><img src="${webRoot}/template/bdw/oldWap/statics/images/footer-logo2.png" alt=""></div>
        <a href="javascript:void(0);" id="scanAffirmLogin" class="confirm-btn">确认登录</a>
        <a href="javascript:void(0);" id="cancel" class="cancel-btn">取消</a>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
<script>
    $(function(){
        $("#scanAffirmLogin").click(function(){
                    $.ajax({
                        type : "GET",
                        dataType : "json",
                        url : webPath.webRoot + "/member/scanCodeToLogin.json",
                        data : {openId:webPath.openId,uuid:webPath.uuid},
                        async : false,
                        success : function(data) {
                            if (data.success == "true") {
                                WeixinJSBridge.call('closeWindow');
                            } else {
                                alert("登录失败，请重新登录");
                                WeixinJSBridge.call('closeWindow');
                            }
                        }
                    });
        });

        //点击取消，关闭浏览器
        $("#cancel").click(function(){
            WeixinJSBridge.call('closeWindow');
        });
    });

</script>
</html>





