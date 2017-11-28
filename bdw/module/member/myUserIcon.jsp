<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-修改头像-${sdk:getSysParamValue('index_title')}</title> <%--SEO title优化--%>
    <link href="${webRoot}/${templateCatalog}/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/member.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/module/member/statics/css/jcrop.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.Jcrop.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/uploadUserIcon.js"></script>
    <script type="text/javascript">
        /*初始化参数，uploadUserIcon.js调用 start*/
        var dataValue={
            webRoot:"${webRoot}" //当前路径
        };
        /*初始化参数，uploadUserIcon.js调用 end*/
    </script>
</head>
<body>

<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>

<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html">首页</a> >  <a href="${webRoot}/module/member/index.ac">会员中心</a> > 修改头像 </div></div>
<%--面包屑导航 end--%>

<div id="member">
    <%--左边菜单栏 start--%>
     <c:import url="/template/bdw/module/member/include/leftMenu.jsp"/>
    <%--左边菜单栏 end--%>
    <div class="rBox">
        <div class="myInformation">
            <h2 class="rightbox_h2_border">个人资料</h2>
            <%--图片上传 start--%>
            <div class="box right_box_border">
                <%--tab标题 start--%>
                <div class="myTAB">
                    <a title="个人信息" class="" href="${webRoot}/module/member/myInformation.ac">个人信息</a>   |
                    <a title="修改头像" class="cur" href="${webRoot}/module/member/myUserIcon.ac">修改头像</a>   |
                    <a title="帐号与密码" class="" href="${webRoot}/module/member/myPswModify.ac">帐号与密码</a>
                </div>
                <%--tab标题 end--%>
                <%--选择上传图片 start--%>
                <div class="userPic_upload">
                    <div class="l">
                        <div class="upLoad"><a href="javascript:void(0)" onclick="showDialog()">上传照片</a></div>
                        <div style="display:none;" id="tip" class="box" title="上传图片" >
                            <div align="center" id="tiptext" style="font-size: 14px;font-weight: bold;padding: 15px">
                                <form id="upload" action="${webRoot}/member/uploadUserImage.bin" method="post" enctype="multipart/form-data">
                                    <input type="file" id="tmpFile" name="imageFile" />
                                </form>
                            </div>
                        </div>
                        <div class="tips">
                            <c:choose>
                                <c:when test="${empty url}">
                                    <p class="tit">请选择你要上传的图片</p>
                                    <p class="clo">仅支持JPG图片文件，且文件小于1M</p>
                                    <p>选择一张本地的图片编辑后上传为头像</p>
                                </c:when>
                                <c:otherwise>
                                    <div id="drop"><img alt="" id="target" src="${url}"/></div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="r">
                        <c:set value="${loginUser.icon['80X80']}" var="bigUserIcon"/>
                        <c:set value="${loginUser.icon['40X40']}" var="smallUserIcon"/>
                        <c:choose>
                            <c:when test="${empty bigUserIcon || empty smallUserIcon}">
                                <div class="pic1"><img alt="头像80*80" src="${webRoot}/template/bdw/module/member/statics/images/member_userPic_80_80.gif" /><br />80*80</div>
                                <div class="pic2"><img alt="头像40*40" src="${webRoot}/template/bdw/module/member/statics/images/member_userPic_40_40.gif" /><br />40*40</div>
                            </c:when>
                            <c:otherwise>
                                <div class="pic1"><img alt="头像80*80" id="fileId80" src="${bigUserIcon}" /><br />80*80</div>
                                <div class="pic2"><img alt="头像40*40" id="fileId40" src="${smallUserIcon}" /><br />40*40</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="tips">您上传的头像自动生成的效果,请注意头像是否清晰。</div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <%--选择上传图片 end--%>
                <div class="btn padd"><a id="saveIcon" href="javascript:void(0);" >保存设置</a></div>
            </div>
            <%--图片上传 end--%>
        </div>
    </div>
    <div class="clear"></div>
</div>

<%--底部 start--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--底部 end--%>
</body>
</html>
