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
            alert("留言内容不能为空字符！");
            return false;
        }

        if(commentCont == "您对网站的留言?我们会及时向您反馈!"){
            return false;
        }
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",url:"${webRoot}/frontend/comment/addMessage.json",
            data:{messageCont:commentCont},
            dataType:"json",
            success:function(data){
                if (data.success == "true") {
                    $("#commentCont").attr("value","您对网站的留言?我们会及时向您反馈!");
                    alert("您的留言已发送，我们会及时反馈!");
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
    function clearMsgCont(){
        var cont = $("#commentCont");
        if(cont.val() == '您对网站的留言?我们会及时向您反馈!'){
            cont.attr("value", "");
        }
        return false;
    }
</script>
<div class="myMedi_ly">
    <div class="box2" style="border: 0px;">
        <div class="area1">
            <div class="userPic">
                <img src="${userProxy.icon['80X80']}" width="80" height="80" />
            </div>
            <div class="put_Box">
                <div class="put"><textarea id="commentCont" onclick="clearMsgCont()" name="" cols="" rows="" placeholder="您对网站的留言?我们会及时向您反馈!"></textarea></div>
                <div class="btn"><a href="javascript:;" onclick="sendComment()">发布</a></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="area2">
            <c:set var="_page" value="${empty param.page?1:param.page}"/>
            <c:set value="${sdk:findCustMessageByUserId(userProxy.userId,10)}" var="remarkPage" />
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
                            <div class="stars"><span>${userProxy.userName}</span> 发表了留言： </div>
                            <div class="times">${remark.messageTimeStr}</div>
                            <div class="clear"></div>
                        </div>
                        <div class="qustion">${remark.messageCont}</div>
                        <c:if test="${not empty remark.messageReplyCont}">
                            <div class="tiText">
                                <div class="stars"><span>${remark.lastReplyUserNm}</span> 发表了回复：${remark.messageReplyCont}</div>
                                <div class="times">${remark.lastReplyTimeStr}</div>
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
