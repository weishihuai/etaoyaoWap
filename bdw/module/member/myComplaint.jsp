<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy" />
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>留言投诉</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/border.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/member.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/module/member/statics/css/leave-wd.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <style type="text/css" rel="stylesheet">
        .member .memberbox .memberL .l-title h3 a{
            _background:none;
            filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${webRoot}/${templateCatalog}/module/member/statics/images/back.png', sizingMethod='crop');
        }
    </style>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/module/member/statics/js/myComplaint.js"></script>
    <script>
        _toPath = { webRoot : '${webRoot}'}
    </script>
</head>

<body>
<%--头部 start--%>
<c:import url="/template/bdw/module/common/top.jsp?p=member"/>
<%--头部 end--%>


<%--面包屑导航 start--%>
<div id="position" class="m1-bg"><div class="m1">您现在的位置：<a href="${webRoot}/index.html">首页</a> > <a href="${webRoot}/module/member/index.ac">会员中心</a> > 我的留言</div></div>
<%--面包屑导航 end--%>

<div id="member" class="member">

    <!--会员中心首页-->
    <div class="memberbox">
    	<!--会员中心左边-->
        <c:import url="/template/bdw/module/member/include/leftMenu.jsp?menuId=51555"/>
        <!--end 会员中心左边-->
     </div>
   <%-- <div class="rArea">
        <div class="medicine">
            <div class="title">我的留言</div>
            <div class="box" style="padding-left:14px;">
                <div class="lBox">
                    <div class="t_Menu">
                        <ul>
                            <c:choose>
                                <c:when test="${param.tabid==1}">
                                    <li><a class="cur" href="${webRoot}/module/member/myComplaint.ac?tabid=1">我的留言</a></li>
                                    <li><a href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=2">我的建议</a></li>
                                    <li><a href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=3">我的投诉</a></li>
                                </c:when>
                                <c:when test="${param.tabid==2}">
                                    <li><a  href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=1">我的留言</a></li>
                                    <li><a class="cur" href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=2">我的建议</a></li>
                                    <li><a href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=3">我的投诉</a></li>
                                </c:when>
                                <c:when test="${param.tabid==3}">
                                    <li><a href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=1">我的留言</a></li>
                                    <li><a href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=2">我的建议</a></li>
                                    <li><a  class="cur" href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=3">我的投诉</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a class="cur" href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=1">我的留言</a></li>
                                    <li><a href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=2">我的建议</a></li>
                                    <li><a href="${webRoot}/module/member/myComplaint.ac?pitchOnRow=8&tabid=3">我的投诉</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    &lt;%&ndash;引入区域&ndash;%&gt;
                    <c:choose>
                        <c:when test="${param.tabid==1}">
                            <c:import url="/template/bdw/module/member/includeComplaint/includeMessage.jsp"/>   &lt;%&ndash;留言&ndash;%&gt;
                        </c:when>
                        <c:when test="${param.tabid==2}">
                            <c:import url="/template/bdw/module/member/includeComplaint/includeSuggestion.jsp"/>   &lt;%&ndash;建议&ndash;%&gt;
                        </c:when>
                        <c:when test="${param.tabid==3}">
                            <c:import url="/template/bdw/module/member/includeComplaint/includeComplaint.jsp"/>  &lt;%&ndash;投诉&ndash;%&gt;
                        </c:when>
                        <c:otherwise>
                            <c:import url="/template/bdw/module/member/includeComplaint/includeMessage.jsp"/>
                        </c:otherwise>
                    </c:choose>
                    &lt;%&ndash;引入区域&ndash;%&gt;
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>--%>
    <div class="rt-box">
        <div class="rb-mt">我的留言</div>
        <div class="rb-mc">
            <div class="mc-nav">
                <a href="##" rel="1" class="cur">我的留言</a>
                <a href="##" rel="2">我的建议</a>
                <a href="##" rel="3">我的投诉</a>
            </div>
            <div class="mc-cont">
                <!--我的留言-->
                <div class="cont-box advice1" style="display: block;">
                    <textarea  id="commentCont" name="commentCont" placeholder="请输入您对网站的留言，我们会及时向您反馈！" class="cont"></textarea>
                    <div class="submit-box">
                        <span>请输入少于300字符的留言</span>
                        <a href="##" id="publish" onclick="sendComment(this)">发布</a>
                    </div>
                    <c:set var="_page" value="${empty param.page?1:param.page}"/>
                    <c:set value="${sdk:findCustMessageByUserId(userProxy.userId,10)}" var="remarkPage" />
                    <c:set value="${remarkPage.result}" var="remarks" />
                    <c:forEach items="${remarks}" var="remark" varStatus="s">
                        <div class=leave-box>
                            <div class="item">
                                <div class="mb-top">
                                    <span><i>${userProxy.userName}</i> 发表了留言：</span>
                                    <em>${remark.messageTimeStr}</em>
                                </div>
                                <div class="mb-cont">${remark.messageCont}</div>
                            </div>
                            <c:if test="${not empty remark.messageReplyCont}">
                                <div class="item">
                                    <div class="mb-top">
                                        <span><i>商家</i>回复了<i>${userProxy.userName}</i>：</span>
                                        <em>${remark.lastReplyTimeStr}</em>
                                    </div>
                                    <div class="mb-cont">${remark.messageReplyCont}</div>
                                </div>
                            </c:if>
                            <c:if test="${not empty remark.custMessage}">
                                <c:forEach items="${remark.custMessage}" var="custMessage" varStatus="t">
                                    <div class="item">
                                        <div class="mb-top">
                                            <span><i>${userProxy.userName}</i> 发表了留言：</span>
                                            <em>${custMessage.messageTimeStr}</em>
                                        </div>
                                        <div class="mb-cont">${custMessage.messageCont}</div>
                                    </div>
                                    <c:if test="${not empty custMessage.messageReplyCont}">
                                        <div class="item">
                                            <div class="mb-top">
                                                <span><i>商家</i>回复了<i>${userProxy.userName}</i>：</span>
                                                <em>${custMessage.lastReplyTimeStr}</em>
                                            </div>
                                            <div class="mb-cont">${custMessage.messageReplyCont}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${fn:length(remark.custMessage) < 2}">
                                    <div class="reply-box"><a href="#commentCont" onclick="addParentCustMessageId('${remark.custMessageId}')">回复</a></div>
                                </c:if>
                            </c:if>
                        </div>
                        <c:if test="${empty remark.custMessage && not empty remark.messageReplyCont}">
                            <div class="reply-box"><a href="#commentCont" onclick="addParentCustMessageId('${remark.custMessageId}')">回复</a></div>
                        </c:if>
                    </c:forEach>

                </div>
                <!--我的建议-->
                <div class="cont-box advice2" style="display: none;">
                    <%--<div class="form-box">
                        <input type="text" class="memberName cont memberNameSuggest" onblur="checkMemberNameSuggest()" placeholder="请输入您的姓名">
                        <span class="tipMsg"></span>
                    </div>
                    <div class="form-box">
                        <input type="text" class="memberTel cont memberTelSuggest" onblur="checkMemberTelSuggest()" placeholder="请输入您的电话">
                        <span class="tipMsg"></span>
                    </div>--%>
                    <textarea class="commentCont cont suggest" onclick="clearMsgCont()" placeholder="请输入您对网站的建议，我们会及时向您反馈！"></textarea>
                    <div class="submit-box">
                        <span>请输入少于300字符的建议内容</span>
                        <a href="##" onclick="sendSuggestComment()">发布</a>
                    </div>
                    <c:set var="_page" value="${empty param.page?1:param.page}"/>
                    <c:set value="${sdk:findComplainSuggestByTypeUserId(userProxy.userId,10 ,'建议')}" var="remarkPage" />
                    <c:set value="${remarkPage.result}" var="remarks" />
                    <c:forEach items="${remarks}" var="remark" varStatus="s">
                        <div class=leave-box>
                            <div class="item">
                                <div class="mb-top">
                                    <span><i>${userProxy.userName}</i> 发表了建议：</span>
                                    <em>${remark.createTimeStr}</em>
                                </div>
                                <div class="mb-cont">${remark.complainCont}</div>
                            </div>
                            <c:if test="${not empty remark.replyCont}">
                                <div class="item">
                                    <div class="mb-top">
                                        <span><i>商家</i> 回复了 <i>${userProxy.userName}</i>：</span>
                                        <em>${remark.lastProcessTimeStr}</em>
                                    </div>
                                    <div class="mb-cont">${remark.replyCont}</div>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
                <!--我的投诉-->
                <div class="cont-box advice3" style="display: none;">
                    <%--<div class="form-box">
                        <input type="text" class="memberName cont memberNameComplain" onblur="checkMemberNameComplain()" placeholder="请输入您的姓名">
                        <span class="tipMsg"></span>
                    </div>
                    <div class="form-box">
                        <input type="text" class="memberTel cont memberTelComplain" onblur="checkMemberTelComplain()" placeholder="请输入您的电话">
                        <span class="tipMsg"></span>
                    </div>--%>
                    <textarea class="commentCont cont complain" onclick="clearMsgCont()" placeholder="请输入您对网站的投诉，我们会及时向您反馈！"></textarea>
                    <div class="submit-box">
                        <span>请输入少于300字符的投诉内容</span>
                        <a href="##" onclick="sendComplainComment()">发布</a>
                    </div>
                    <c:set var="_page" value="${empty param.page?1:param.page}"/>
                    <c:set value="${sdk:findComplainSuggestByTypeUserId(userProxy.userId,10 ,'投诉')}" var="remarkPage" />
                    <c:set value="${remarkPage.result}" var="remarks" />
                    <c:forEach items="${remarks}" var="remark" varStatus="s">
                        <div class=leave-box>
                            <div class="item">
                                <div class="mb-top">
                                    <span><i>${userProxy.userName}</i> 发表了投诉：</span>
                                    <em>${remark.createTimeStr}</em>
                                </div>
                                <div class="mb-cont">${remark.complainCont}</div>
                            </div>
                            <c:if test="${not empty remark.replyCont}">
                                <div class="item">
                                    <div class="mb-top">
                                        <span><i>商家</i> 回复了 <i>${userProxy.userName}</i>：</span>
                                        <em>${remark.lastProcessTimeStr}</em>
                                    </div>
                                    <div class="mb-cont">${remark.replyCont}</div>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <div style="display:none;" id="tip" class="box" title="系统提示" >
        <div id="tiptext" align="center"></div>
    </div>
    <div class="clear"></div>
</div>

<div id="buttomLine"></div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
