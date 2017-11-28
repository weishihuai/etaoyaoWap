<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/xywyUserInfo.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/main.js"></script>

<!--对话框-->
<div id="addUserInfo" class="modal-bg" style="display:none;">
    <!--填写资料框-->
    <div class="modal">
        <div class="modal-title">
            <h3>填写资料</h3>
            <%--<a href="javascript:;" onclick="closeWindow();" title="关闭">X</a>--%>
        </div>
        <form id="infoFrom" >
            <div class="item">
                <span class="label"><i>*</i>姓名</span>
                <input class="inp" name="userName" id="userName" value="${userName}" type="text">
            </div>
            <div class="item">
                <span class="label"><i>*</i>性别</span>
                <div class="down-menu oType"><!-- 鼠标点击加class:pull -->
                    <a class="down-switch" href="javascript:;">
                        <label class="oTypeSelected" orderType="${sex}">
                            <c:choose>
                                <c:when test="${sex == '男'}">男</c:when>
                                <c:when test="${sex == '女'}">女</c:when>
                                <c:otherwise>未选择</c:otherwise>
                            </c:choose>
                        </label>
                        <i class="arrow"></i>
                    </a>
                    <div class="down-data">
                        <ul class="data-list">
                            <li><a class="oTypeItem" href="javascript:;" orderType="男">男</a></li>
                            <li><a class="oTypeItem" href="javascript:;" orderType="女">女</a></li>
                            <li><a class="oTypeItem" href="javascript:;" orderType="">未选择</a></li>
                        </ul>
                    </div>
                </div>
                <input class="inp" type="hidden" id="sex" name="sex">
            </div>
            <div class="item">
                <span class="label"><i>*</i>年龄</span>
                <input class="inp" type="text" maxlength="2" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="age" name="age" value="${age}">
            </div>
            <div class="item">
                <span class="label"><i>*</i>手机</span>
                <input class="inp" maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" id="mobile" name="mobile" value="${mobile}" placeholder="">
            </div>
            <a class="btn btn-org mar-lft" href="javascript:;" onclick="sendInfo()" title="确定建立">确定建立</a>
        </form>
    </div>
</div>