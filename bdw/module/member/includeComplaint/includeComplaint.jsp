<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy" />
<script>
    function sendComment(){
        var commentCont = $("#commentCont").val();
        commentCont=commentCont.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig,"");
        commentCont=commentCont.replace(/<.*?>/g,"");
        if(commentCont.length > 255 || commentCont.length < 5){
            alert("长度在5-255位字符之间！");
            return false;
        }
        if (commentCont.replace(/(^\s*)|(\s*$)/g, "")==""){
            alert("投诉内容不能为空字符！");
            return false;
        }
        if(!checkMemberName() || !checkMemberTel()){
            alert("请完善提交信息！");
            return;
        }
        if(commentCont == "您对网站有不满之处?我们会及时向您反馈!"){
            alert("请输入投诉内容！");
            return false;
        }
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",url:"${webRoot}/frontend/comment/addComplaintSuggest.json",
            data:{complainCont:commentCont,complainType:'投诉',memberName:$("#memberName").val(), memberTel:$("#memberTel").val()},
            dataType:"json",
            success:function(data){
                if (data.success == "true") {
                    $("#commentCont").attr("value","您对网站有不满之处?我们会及时向您反馈!");
                    alert("您的投诉已发送，我们会及时反馈!");
                    window.location.reload();
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    }
    function sendSessionReply(areaId){
        var idStr= "#answer_" + areaId;
        var sessionCont = $(idStr).val();
        sessionCont=sessionCont.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig,"");
        sessionCont=sessionCont.replace(/<.*?>/g,"");
        if(sessionCont.length > 255 || sessionCont.length < 5){
            alert("长度在5-255位字符之间！");
        }

        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",url:"${webRoot}/frontend/session/sessionIsApproveReply.json",
            data:{commentId:areaId,sessionCont:sessionCont},
            dataType:"json",
            success:function(data){
                if (data.success == "true") {
                    $(idStr).attr("value","请填写回复内容，长度在5-255位字符之间！");
                    alert("提交成功!");

                }else{
                    alert("系统错误,请重新输入!");
                }
            }
        });
    }
    function clearMsgCont(){
        var cont = $("#commentCont");
        if(cont.val() == '您对网站的留言?我们会及时向您反馈!'){
            cont.attr("value", "");
        }
        return false;
    }
    function showPutAnswer(idStr){
        $("#btn_"+idStr).hide();
        $("#putAnswer_"+idStr).fadeIn(500);
        return false;
    }
    function clearPutAnswer(userMsgId){
        var cont = $("#" + userMsgId);
        if(cont.val() == '请填写回复内容，长度在5-255位字符之间！'){
            cont.attr("value", "");
        }
        return false;
    }
    function alertMessage(message,buttons){
        $("#tiptext").html(message);
        $("#tip").dialog({
            buttons:buttons
        });
        return false;
    }
    function checkMemberName(){
        var memberName = $("#memberName").val();
        if(memberName == ""){
            $("#memberName").next().html("请输入姓名");
            return false;
        }
        if(memberName.replace(/(^\s*)|(\s*$)/g, "")=="")
        {
            $("#memberName").next().html("输入的名字不能为空格");
            return false;
        }
        $("#memberName").next().html("");
        return true;
    }
    function checkMemberTel(){
        var memberTel = $("#memberTel").val();
        var regxt = /^13[0-9]{9}|15[0-99][0-9]{8}|18[0-9][0-9]{8}|147[0-9]{8}|177[0-9]{8}|170[0-9]{8}|176[0-9]{8}$/;
        if(memberTel == ""){
            $("#memberTel").next().html("请输入您的电话号码");
            return false;
        }
        if(!regxt.test(memberTel)){
            $("#memberTel").next().html("请输入正确的电话号码");
            return false;
        }
        $("#memberTel").next().html("");
        return true;
    }
</script>
<div class="myMedi_ly">
    <div class="box2" style="border: 0px;">
        <div class="area1">
            <div class="userPic">
                <img src="${userProxy.icon['80X80']}" width="80px" height="80px" />
            </div>
            <div class="put_Box put_Box2">
                <div class="put">
                    <div class="label"><div style="float: left">姓名：</div><input type="text" class="memberName" onblur="checkMemberName()" maxlength="16" id="memberName"/><span style="margin-left: 5px;color: #CC0000;font-family: '微软雅黑'"></span></div>
                </div>
                <div class="put">
                    <div class="label"><div style="float: left">电话：</div><input type="text" class="memberTel" onblur="checkMemberTel()" maxlength="24" id="memberTel"/><span style="margin-left: 5px;color: #CC0000;font-family: '微软雅黑'"></span></div>
                </div>
                <div class="put">
                    <div class="label"><div style="float: left">投诉：</div>
                        <textarea id="commentCont" onclick="clearMsgCont()" name="" cols="" rows="" placeholder="您对网站的留言?我们会及时向您反馈!"></textarea>
                    </div>
                </div>
                <div class="btn"><a href="javascript:;" onclick="sendComment()">发布</a></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="area2">
            <c:set var="_page" value="${empty param.page?1:param.page}"/>
            <c:set value="${sdk:findComplainSuggestByTypeUserId(userProxy.userId,10 ,'投诉')}" var="remarkPage" />
            <c:set value="${remarkPage.result}" var="remarks" />
            <c:forEach items="${remarks}" var="remark" varStatus="s">
                <div class="each">
                    <div class="l">
                        <div class="picUser">
                            <img src="${userProxy.icon['40X40']}" width="40px" height="40px" />
                        </div>
                    </div>
                    <div class="r">
                        <div class="tiText">
                            <div class="stars"><span>${userProxy.userName}</span> 发表了投诉： </div>
                            <div class="times">${remark.createTimeStr}</div>
                            <div class="clear"></div>
                        </div>
                        <div class="qustion">${remark.complainCont}</div>
                        <c:if test="${not empty remark.replyCont}">
                            <div class="tiText">
                                <div class="stars"><span>${remark.lastProcessManLoginId}</span> 发表了回复：${remark.replyCont}</div>
                                <div class="times">${remark.lastProcessTimeStr}</div>
                                <div class="clear"></div>
                            </div>
                        </c:if>
                        <div class="buttomLine"></div>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:forEach>
        </div>
        <div class="page">
            <div align="center" style="padding-left:250px ">
                <c:if test="${remarkPage.lastPageNumber > 1}">
                    <p:PageTag isDisplaySelect="false" ajaxUrl="${webRoot}/member/myComplaint.ac" totalPages='${remarkPage.lastPageNumber}' currentPage='${_page}'  totalRecords='${remarkPage.totalCount}' frontPath='${webRoot}' displayNum='6'/>
                </c:if>
            </div>
        </div>
    </div>
</div>
