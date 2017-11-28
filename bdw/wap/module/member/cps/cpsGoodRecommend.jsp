<%@ page import="com.iloosen.imall.module.core.domain.code.ChannelCodeEnum" %><%--
  Created by IntelliJ IDEA.
  User: zcj
  Date: 2016/12/14
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<%
    request.setAttribute("pc", ChannelCodeEnum.PC.toCode());                         //pc端
    request.setAttribute("wap", ChannelCodeEnum.WAP.toCode());                   	  //wap端
%>
<c:set value="${empty param.page ? 1 : param.page}" var="pageNum"/>            <%--翻页数，默认为第一页--%>
<c:set value="${sdk:findListByPage(5,wap,null)}" var="themesPage"/>		<!--  主题活动 -->
<head>
    <meta charset="utf-8">
    <title>好货推列表-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-good-recommend.css">
</head>
<body>

<div class="main" id="main">
    <%--<header class="header">
        <a href="javascript:history.go(-1);" class="back"></a>
        <div class="header-title">好货推</div>
    </header>--%>
    <ul class="good-list">

    <c:forEach items="${themesPage.result}" var="themes" varStatus="s">
        <li class="media">
            <a class="media-cont" href="${webRoot}/wap/module/member/cps/cpsGoodDetail.ac?themeActivitieId=${themes.cpsThemeActivitieId}">
                <div class="media-img">
                    <img src="${themes.wapMainImg['']}" alt="">
                </div>
                <div class="wrap">
                    <p class="media-name">${themes.themeName}</p>
                    <p class="media-desc">
                        <c:if test="${not empty themes.explanation}">
                            ${themes.explanation}
                        </c:if>
                        <c:if test="${empty themes.explanation}">
                            ${fn:substring(sdk:cleanHTML(themes.wapThemeDescStr,""),0 , 120)  }
                        </c:if>
                    </p>
                </div>
            </a>
            <p class="media-price">佣金金额&ensp;<span><small>&yen;</small><fmt:formatNumber value="${themes.rebateAmount}" type="number" pattern="#" /><small>.${themes.rebateAmountDecimal}</small></span></p>
            <a class="action" href="${webRoot}/wap/module/member/cps/cpsGoodDetail.ac?themeActivitieId=${themes.cpsThemeActivitieId}"  shareId="${themes.cpsThemeActivitieId}">分享赚钱</a>
        </li>
    </c:forEach>

    </ul>
    <nav id="page-nav">
        <a href="${webRoot}/wap/module/member/cps/loadCpsGoodRecommend.ac?page=2"></a>
    </nav>
</div>
<div id="loadDiv" >  </div>
</body>

</html>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>

<script>
    var dataValue  = {
        lastPageNumber:${themesPage.lastPageNumber},
        webRoot:"${webRoot}"
    };
    var readedpage = 1;//当前滚动到的页数
    var lastPageNumber = dataValue.lastPageNumber;

    $("#main").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".good-list" ,
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
            $("#page-nav a").attr("href",dataValue.webRoot + "/wap/module/member/cps/loadCpsGoodRecommend.ac?page="+readedpage);
        }
    });
</script>
