<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>推广联盟主页-${webName}</title>
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width">

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">

    <c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
</head>
<body>
<!--判断用户是否登录-->
<c:choose>
    <c:when test="${empty loginUser}">
        <c:redirect url="${webUrl}/cps/cpsPromote.ac?unid=${param.unid}&target=${webUrl}?1=1" />
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${loginUser.isPopularizeMan eq 'Y'}">
                <c:set value="${sdk:getPromoteMemberByLoginUserId()}" var="memberInfo" /><!--会员信息，通过登录用户的id获得推广员对象-->
                <c:set value="${empty param.page ? 1 : param.page}" var="page"/>
                <c:set value="${sdk:findOfflineMember(page,10)}" var="myOfflinePage"/>
                <div class="main m-my-member" id="main">
                    <div class="amount">
                        <dl>
                            <c:set value="${sdk:getTheRebateAccountNum()}" var="myMoney"/>
                            <dt>账户余额（元）</dt>
                            <dd>${myMoney}</dd>
                        </dl>
                        <dl>
                            <dt>线下会员数量</dt>
                            <dd>${sdk:getOfflineAmount(memberInfo.id)}</dd>
                        </dl>
                    </div>

                    <ul class="member-list">
                        <c:forEach items="${myOfflinePage.result}" var="offLine" varStatus="s">
                            <li class="${offLine.isExpiration eq "Y" ? "disabled" : "new"}">
                                <div class="entry-block" onclick="window.location.href='${webRoot}/wap/module/member/cps/cpsMyMemberDrawal.ac?sysUserId=${offLine.sysUserId}'">
                                    <a href="javascript:void (0)">
                                        <i class="icon icon-angle-right"></i>
                                        <span class="img">
                                            <img src="${offLine.icon["100X100"]}" alt=""><%--原设计是60X60，暂时150X150，待调整--%>
                                        </span>
                                        <span class="lab">${offLine.userNm}</span>
                                        <span class="val">
                                            <c:choose>
                                                <c:when test="${offLine.isExpiration == 'Y'}">
                                                    已过期
                                                </c:when>
                                            </c:choose>
                                        </span>
                                    </a>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <nav id="page-nav">
                        <a href="${webRoot}/wap/module/member/cps/loadCpsMyMember.ac?page=2"></a>
                    </nav>
                </div>

            </c:when>
            <c:otherwise>
                <!--不是推广员，跳回首页-->
                <c:redirect url="${webUrl}/cps/cpsPromote.ac?unid=${param.unid}&target=${webUrl}?1=1" />
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
</body>
</html>

<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/base.js" type="text/javascript"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
<script type="text/javascript">
    var webPath = {
        lastPageNumber:${myOfflinePage.lastPageNumber},
        webRoot:"${webRoot}"
    };
    var readedpage = 1;//当前滚动到的页数
    var lastPageNumber = webPath.lastPageNumber;
    $(document).ready(function(){
        $("#main").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".member-list" ,
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function(newElements) {
            readedpage++;
            if(readedpage > lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#main").infinitescroll({state:{isDone:true},extraScrollPx: 50});
            }else{
                $("#page-nav a").attr("href",webPath.webRoot + "/wap/module/member/cps/loadCpsMyMember.ac?page="+readedpage);
            }
        });
    });
</script>
