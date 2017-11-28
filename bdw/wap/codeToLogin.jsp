<%@ page import="com.iloosen.imall.commons.global.Global" %>
<%@ page import="com.iloosen.imall.commons.util.JsonBinder" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysUser" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.ObjectEngineTypeCodeEnum" %>
<%@ page import="com.iloosen.imall.module.vmall.vo.WeixinConfig" %>
<%@ page import="org.apache.commons.httpclient.HttpClient" %>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    String code = request.getParameter("code");
    System.out.println();
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
    List<SysUser> userList = ServiceManager.sysUserService.findUserByVuserId(openId);
    System.out.println("--------------------------------通过openId找到="+userList.size()+"个用户");
    List<SysUser> sysUserList = new ArrayList<SysUser>();
    for(SysUser sysUser : userList){
        if(StringUtils.isBlank(sysUser.getBytUserId())){
            sysUserList.add(sysUser);
        }
    }

    /*如果没有关注，则自动创建帐号*/
    if(null == sysUserList || sysUserList.isEmpty()){
/*        System.out.println("进入codeToLogin.jsp，没有关注，则自动创建帐号");
        System.out.println("openId================================"+(openId==null?"":openId));
        ServiceManager.sysUserService.checkAndCreateSysUserByOpenId(openId);
        SysUser sysUser = ServiceManager.sysUserService.getByLoginId(openId);
        System.out.println("=========1=========="+sysUser==null?"SysUser为空":sysUser.getLoginId());*/
        session.setAttribute("openId", openId);
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
    }else if (sysUserList.size()==1){
        //未合
        // .并则取微信账户，loginId就是openId
        System.out.println("=========2==========");
        SysUser sysUser = sysUserList.get(0);
        System.out.println(sysUser==null?"SysUser为空":sysUser.getLoginId());
        System.out.println("--------------------------------微信帐号登录，用户ID=" + sysUser.getSysUserId());
        WebContextFactory.getWebContext().setFrontEndUser(sysUser);

    }
    System.out.println("--------------------------------返回原路径=" + request.getParameter("state"));
    String url = request.getParameter("state");
    if (request.getParameter("state")!=null && request.getParameter("state").contains("/wap/weixin/")) { //首页
        url = url.replace("/weixin","");
        url = url +"?type=weixin";
        System.out.println("url发生改变，此时的URL：" + url);
    }
    request.getRequestDispatcher(url).forward(request,response);
%>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
</head>
<body>

</body>
</html>
