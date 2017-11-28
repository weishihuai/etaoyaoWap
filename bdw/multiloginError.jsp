<%--
  Created by IntelliJ IDEA.
  User: xws
  Date: 12-8-8
  Time: 上午10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-完善账户信息-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <style type="text/css">
        #member .rBox{width:980px;}
        #member .rBox .myInformation{width:980px;}
        #member .rBox .myInformation .box{width: 978px;}
        #model-login {background: none repeat scroll 0 0 #FFFDEE;border: 1px solid #EDD28B;line-height: 30px;margin: 20px 40px 20px;padding: 10px 15px;}
        #member .rBox .myInformation .box .btn{float: left;}
    </style>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript">
        <%--初始化参数，供myInformation.js调用 start--%>
        var dataValue={
            webRoot:"${webRoot}",  //当前地址
            email:"${loginUser.email}"  //用户email
        };
        <%--初始化参数，供myInformation.js调用 end--%>
    </script>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--个人资料设置 start--%>
<div id="member">
    <div class="rBox">
        <%--填写信息 start--%>
        <div class="myInformation">
            <h2 class="rightbox_h2_border">登陆方式尚未开通</h2>
            <div class="box right_box_border">
                <div id="myInfo">
                    <div class="model-prompt" id="model-login">
                        <dl>
                            <dt>${webName}欢迎您！ </dt>
                            <dd>该登陆方式尚未开通或者您的账号信息错误，请联系客服</dd>
                        </dl>

                    </div>

                        <a style="float: left;padding:0 0 0 50px;color: #005EA7;" href="${webRoot}/index.ac">以后再说，立即去购物！</a>
                    </form>
                </div>
            </div>
        </div>
        <%--填写信息 end--%>
    </div>
    <div class="clear"></div>
</div>
<%--个人资料设置 end--%>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
