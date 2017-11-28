<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:getAdminPickedUp()}" var="pickedUpUser"/>
<div class="l_header_bg">
 	<div class="l_header">
    	<div class="h-lt">
            <a href="${webRoot}/ziti">
                <img src="${webRoot}/template/bdw/pickedUp/images/l_logo.png" width="180" height="80" />
            </a>
        </div>
        <div class="h-md"><span>${pickedUpUser.pickedUpName}自提服务中心</span></div>
        <div class="h-rt">
            <c:set value="${sdk:getSysParamValue('webPhone')}" var="webPhone"/>
        	<i>${webPhone}</i>
        	<span>如需帮助，服务热线：</span>
        </div>
    </div>
</div>
