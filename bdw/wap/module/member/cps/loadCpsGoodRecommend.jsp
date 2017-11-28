<%@ page import="com.iloosen.imall.module.core.domain.code.ChannelCodeEnum" %>
<%--
  Created by IntelliJ IDEA.
  User: zcj
  Date: 2016/12/15
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
<c:set value="${empty param.page ? 1 : param.page}" var="page"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:findListByPage(5,wap,null)}" var="themesPage"/>        <!--  主题活动 -->

<c:if test="${themesPage.totalCount > 0}">
<ul class="good-list">
    <c:forEach items="${themesPage.result}" var="themes" varStatus="s">
        <li class="media">
            <a class="media-cont"
               href="${webRoot}/wap/module/member/cps/cpsGoodDetail.ac?themeActivitieId=${themes.cpsThemeActivitieId}">
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

            <p class="media-price">佣金金额&ensp;<span><small>&yen;</small><fmt:formatNumber value="${themes.rebateAmount}"
                                                                                         type="number" pattern="#"/><small>
                .${themes.rebateAmountDecimal}</small></span></p>
            <a class="action" href="${webRoot}/wap/module/member/cps/cpsGoodDetail.ac?themeActivitieId=${themes.cpsThemeActivitieId}" shareId="${themes.cpsThemeActivitieId}">分享赚钱</a>
        </li>
    </c:forEach>
</ul>
</c:if>