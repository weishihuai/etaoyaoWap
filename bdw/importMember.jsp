<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:getAdminLoginOrgId()}" var="adminOrgId"/> <%--获取后台登陆机构Id--%>
<c:if test="${adminOrgId !=1}">
    <c:redirect url="/index.jsp"></c:redirect>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}" /> <%--SEO description优化--%>
    <title>${webName}-会员导入-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/uploadFile.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jquery-powerFloat/css/powerFloat.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jquery-powerFloat/css/common.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript">
        var webPath={webRoot:"${webRoot}"}
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/importMember.js"></script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="upload-main">
    <form id="uploadForm">
        <div class="box">
            <div class="info">
                <div class="info-l info-l2">
                    <div class="login login3">导入线下会员：</div>
                    <div class="btn" id="upLoad_btn"><a style="cursor: pointer">选择上传文件</a></div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="messageTip">
                请上传<span style="color: red;padding: 0px 4px;">.xls</span>格式的文件，文件上传时可能需要较长的时间，上传时请不要进行其他操作，请耐心等待！<br/>
            </div>
            <div class="messageTip">
                <span>模板文件下载：</span>
                <a href="${webRoot}/xlsoutput/userImportExcelTemplate.xls" style="text-decoration: underline;color: #0033cc">点击下载</a>
            </div>
            <div class="error" style="padding-top: 20px;display: none">
                <span style="font-size: 14px;font-weight: bolder;">
                    部分用户缺少括号内的信息，为避免其他完整的信息被更新，请先修改或删除错误信息后再导入：
                </span><br/>
                <span style="color: red;" id="missMsg"></span>
            </div>
        </div>
    </form>
</div>

<%--上传进度条--%>
<div style="display:none;" id="submitDiv">
    <img src="${webRoot}/template/bdw/statics/images/loading.gif" alt="正在上传"/>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>

<div style="display:none;" id="tip" class="box" title="导入线下会员">
    <div align="center" id="tiptext" style="font-size: 14px;font-weight: bold;padding: 15px">
        <form id="upload" action="${webRoot}/member/uploadExcel.ac" method="post" enctype="multipart/form-data">
            <input type="file" id="excelFile" name="excelFile"/>
        </form>
    </div>
</div>
</body>
</html>
