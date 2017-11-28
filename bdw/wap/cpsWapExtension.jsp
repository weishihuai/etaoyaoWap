<%--cps分享弹层(适用wap商品详情)--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>

<link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/cpsWapExtension.css">
<c:set value="${param.shareId}" var="Id"/>
<c:set value="${sdk:getPromoteMemberByUserId()}" var="promoteMember"/>
<c:choose>
    <c:when test="${empty promoteMember}">
        <c:set value="${param.shareUrl}" var="shareUrl"/>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${param.from eq 'product'}">
                <c:set value="${wapUrl}/cps/cpsPromote.ac?unid=${promoteMember.id}&target=${param.shareUrl}" var="shareUrl"/>
            </c:when>
            <c:otherwise>
                <c:set value="${wapUrl}/cps/cpsPromote.ac?unid=${promoteMember.id}&target=${param.shareUrl}" var="shareUrl"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

<c:if test="${empty Id}">
    <c:redirect url="/index.jsp"/>
</c:if>
<c:choose>
    <c:when test="${param.type=='theme'}">
        <c:set value="${sdk:getCpsThemeDetailProxy(Id)}" var="frialProxy"/>
    </c:when>
    <c:otherwise>
        <c:set value="${sdk:getProductById(Id)}" var="productProxy"/>
    </c:otherwise>
</c:choose>
<!-- 分享 -->
<div class="share-sec" id="share-sec">
    <div class="dropback"></div>
    <ul class="good-list">
        <c:choose>
            <c:when test="${param.type=='theme'}">
                <c:set var="bdPic" value="${frialProxy.mainImg['']}" />
                <c:choose>
                    <c:when test="${empty frialProxy.explanation}">
                        <c:set var="temp" value="${fn:substring(sdk:cleanHTML(frialProxy.themeDescStr,''),0 , 120)}"/>
                        <c:set var="bdText" value="${fn:trim(temp)}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="temp" value="${frialProxy.explanation}"/>
                        <c:set var="bdText" value="${fn:trim(temp)}"/>
                    </c:otherwise>
                </c:choose>
                <li class="media">
                    <a class="media-img" href="javascript:;">
                        <img src="${frialProxy.mainImg[""]}" alt=""><%--原设计是180X180,但后台没有生成此规格图，所以暂用300X300待用--%>
                    </a>
                    <div class="media-cont-win">
                        <p class="media-name">${frialProxy.themeName}</p>
                        <p class="media-desc">商品单价 ￥${frialProxy.productPrice}</p>
                        <p class="media-desc">佣金比率 ${frialProxy.rebateRate}%</p>
                        <p class="media-price">赚&ensp;<span><small>¥</small>${fn:split(frialProxy.rebateAmount, '.')[0]}<small>.${frialProxy.rebateAmountDecimal}</small></span></p>
                    </div>
                </li>
            </c:when>
            <c:otherwise>
                <c:set var="bdPic" value="${productProxy.defaultImage['160X160']}" />
                <li class="media">
                    <a class="media-img" href="javascript:;">
                        <img src="${productProxy.defaultImage['160X160']}" alt=""><%--原设计是180X180,但后台没有生成此规格图，所以暂用300X300待用--%>
                    </a>
                    <div class="media-cont-win">
                        <c:set var="bdText" value="${productProxy.salePoint}"/>
                        <c:set var="dbDesc" value="${productProxy.name}"/>
                        <c:set value="${fn:length(fn:split(productProxy.priceListStr, ' --- '))}" var="priceSize"/>
                        <c:set value="${fn:split(productProxy.priceListStr, ' --- ')[0]}" var="minPrice"/>
                        <c:set value="${fn:split(productProxy.priceListStr, ' --- ')[priceSize - 1]}" var="maxPrice"/>
                        <c:set var="earnMin" value="${productProxy.rebateRate * minPrice / 100}"/>

                        <p class="media-name">${productProxy.name}</p>
                        <p class="media-desc">商品单价 ￥${productProxy.priceListStr}</p>
                        <p class="media-desc">佣金比率 ${productProxy.rebateRate}%</p>
                       <%-- <c:set var="earn" value="${productProxy.rebateRate*productProxy.priceListStr/100}"></c:set>--%>
                        <p class="media-price">赚&ensp;
                            <span>
                                <small>¥</small>${fn:split(earnMin, '.')[0]}
                                <c:choose>
                                    <c:when test="${empty fn:split(earnMin, '.')[1]}">
                                        <small>.00</small>
                                    </c:when>
                                    <c:otherwise>
                                        <small>.${fn:substring((fn:split(earnMin, '.')[1]), 0, 2)}</small>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${priceSize > 1}">
                                    <c:set var="earnMax" value="${productProxy.rebateRate * maxPrice / 100}"/>
                                     --- ${fn:split(earnMax, '.')[0]}
                                    <c:choose>
                                        <c:when test="${empty fn:split(earnMax, '.')[1]}">
                                            <small>.00</small>
                                        </c:when>
                                        <c:otherwise>
                                            <small>.${fn:substring((fn:split(earnMax, '.')[1]), 0, 2)}</small>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </span>
                        </p>
                    </div>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>

    <div class="list-wrap">
        <ol class="share-list bdsharebuttonbox">
            <li>
                <a href="javascript:void(0);">
                        <span class="img" >
                            <img class="bds_tsina" data-cmd="tsina" src="${webRoot}/${templateCatalog}/wap/module/member/cps/statics/images/share-weibo.png" alt="">
                        </span>新浪微博
                </a>
            </li>
            <li>
                <a href="javascript:void(0);">
                        <span class="img">
                            <img class="bds_sqq" data-cmd="sqq" src="${webRoot}/${templateCatalog}/wap/module/member/cps/statics/images/share-qq.png" alt="">
                        </span>QQ
                </a>
            </li>
            <li>
                <a href="javascript:void(0);" >
                        <span class="img">
                            <img class="bds_qzone" data-cmd="qzone" src="${webRoot}/${templateCatalog}/wap/module/member/cps/statics/images/share-qzone.png" alt="" >
                        </span>QQ空间
                </a>
            </li>
            <li>
                <a href="javascript:;" >
                        <span class="img">
                            <img src="${webRoot}/${templateCatalog}/wap/module/member/cps/statics/images/share-link.png" alt="" id="copyUrl">
                        </span>复制链接
                </a>
            </li>
        </ol>
    </div>
    <a class="btn-close" href="javascript:void(0);" onclick="closeSharePage()">关闭</a>
</div>
<script type="text/javascript">
    var webParams = {
        type: '${param.type}',
        webRoot: '${webRoot}',
        bdUrl:'${shareUrl}',
        bdPic:'${bdPic}',
        bdText:'${bdText}'
    };
</script>

<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsWapExtension.js" type="text/javascript"></script>
<script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/zepto.min.js" type="text/javascript"></script>
<script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/main.js" type="text/javascript"></script>