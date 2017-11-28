<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="expires" content="0">
    <title>O2O首页</title>

    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/otoo/statics/css/base.css" rel="stylesheet"  type="text/css" />
    <link href="${webRoot}/template/bdw/otoo/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/otoo/statics/css/index.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/otoo/statics/js/index.js"></script>
</head>
<body>

<%-- header start --%>
<c:import url="/template/bdw/otoo/common/top.jsp?p=index"/>
<%-- header end --%>

<div class="focus">
    <div class="w">
        <div class="top">
            <dl>
                <dt class="frameEdit" frameInfo="O2O_topCenter_linkTitle_1">
                    <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_linkTitle_1').links}" var="link" varStatus="s" end="0">
                        ${link.title}
                    </c:forEach>
                </dt>
                <dd class="frameEdit" frameInfo="O2O_topCenter_link_1">
                    <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_link_1').links}" var="link" varStatus="s">
                        <%--如果该链接的标题中包含#,说明该链接是热门的--%>
                        <c:choose>
                            <c:when test="${fn:contains(link.title,'#')}">
                                <a class="hot" href="${link.link}" title="${link.title}">${fn:replace(link.title,'#','')}</a>
                            </c:when>
                            <c:otherwise>
                                <a  href="${link.link}" title="${link.title}">${link.title}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </dd>
            </dl>
            <dl>
                <dt class="frameEdit" frameInfo="O2O_topCenter_linkTitle_2">
                    <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_linkTitle_2').links}" var="link" varStatus="s" end="0">
                        ${link.title}
                    </c:forEach>
                </dt>
                <dd class="frameEdit" frameInfo="O2O_topCenter_link_2">
                    <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_link_2').links}" var="link" varStatus="s">
                        <%--如果该链接的标题中包含#,说明该链接是热门的--%>
                        <c:choose>
                            <c:when test="${fn:contains(link.title,'#')}">
                                <a class="hot" href="${link.link}" title="${link.title}">${fn:replace(link.title,'#','')}</a>
                            </c:when>
                            <c:otherwise>
                                <a  href="${link.link}" title="${link.title}">${link.title}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </dd>
            </dl>
            <dl>
                <dt class="frameEdit" frameInfo="O2O_topCenter_linkTitle_3">
                    <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_linkTitle_3').links}" var="link" varStatus="s" end="0">
                        ${link.title}
                    </c:forEach>
                </dt>
                <dd class="frameEdit" frameInfo="O2O_topCenter_link_3">
                    <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_link_3').links}" var="link" varStatus="s">
                        <%--如果该链接的标题中包含#,说明该链接是热门的--%>
                        <c:choose>
                            <c:when test="${fn:contains(link.title,'#')}">
                                <a class="hot" href="${link.link}" title="${link.title}">${fn:replace(link.title,'#','')}</a>
                            </c:when>
                            <c:otherwise>
                                <a  href="${link.link}" title="${link.title}">${link.title}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </dd>
            </dl>
        </div>
        <!--top end-->
        <div class="banner-main frameEdit" frameInfo="O2O_topCenter_adv|760X210">
            <ul id="croImg">
                <c:forEach items="${sdk:findPageModuleProxy('O2O_topCenter_adv').advt.advtProxy}" var="advtProxys" varStatus="s">
                    <li id="${s.count}">
                        <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}"></a>
                    </li>
                </c:forEach>
            </ul>
            <div class="slide" id="croNum" style="z-index: 99"></div>

            <a class="pre" href="javascript:void(0)" title="" style="z-index: 99"></a>
            <a class="next" href="javascript:void(0)" title="" style="z-index: 99"></a>
        </div>
        <!--banner end-->
        <div class="banner-side frameEdit" frameInfo="O2O_topRightCenter_adv|240X185">
          <c:forEach items="${sdk:findPageModuleProxy('O2O_topRightCenter_adv').advt.advtProxy}" var="advtProxys" varStatus="s" end="2">
              <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" width="240px" height="180px"></a>
            </c:forEach>
        </div>
        <!--banner-side end-->
    </div>
</div>
<!--focus end-->

<div class="main">
    <div class="left">
        <!--item item01 end-->
        <div class="item item01">
            <div class="tit frameEdit" frameInfo="O2O_center_recommend_title_1">
                <c:forEach items="${sdk:findPageModuleProxy('O2O_center_recommend_title_1').links}" var="recommend_title" varStatus="s" end="0">
                    <h3>${recommend_title.title}</h3>
                    <i class="m-tit">${recommend_title.description}</i>
                    <b></b>
                    <a class="more" href="${recommend_title.link}" title="">查看更多&gt;</a>

                    <div class="clearfix"></div>
                </c:forEach>
            </div>
            <!--tit end-->
            <div class="con frameEdit" frameInfo="O2O_center_recommend_1">
                <ul>
                <c:forEach items="${bdw:otooFindPageModuleProxy('O2O_center_recommend_1').otooRecommendProducts}" var="otooRecommend" varStatus="s" end="2">
                    <li>
                        <a class="p-img" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title=""><img src="${otooRecommend.images[0]['300X200']}"></a>
                        <a class="p-name" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title="">${otooRecommend.otooProductNm}</a>
                        <span class="c-price"><i>&yen;</i>${otooRecommend.otooDiscountPrice}</span>
                       <%-- <span class="o-price">价值&yen;${otooRecommend.otooMarketPrice}</span>--%>
                        <span class="o-price"><del>&yen;${otooRecommend.otooMarketPrice}</del></span>
                    </li>
                </c:forEach>
                </ul>
            </div>
        </div>
        <!--item item02 end-->
        <div class="item item02">
            <div class="tit frameEdit" frameInfo="O2O_center_recommend_title_2">
                <c:forEach items="${sdk:findPageModuleProxy('O2O_center_recommend_title_2').links}" var="recommend_title" varStatus="s" end="0">

                <h3>${recommend_title.title}</h3>
                    <i class="m-tit">${recommend_title.description}</i>
                <b></b>
                <a class="more" href="${recommend_title.link}" title="">查看更多&gt;</a>

                <div class="clearfix"></div>
                </c:forEach>
            </div>
            <!--tit end-->
            <div class="con frameEdit" frameInfo="O2O_center_recommend_2">
                <ul>
                    <c:forEach items="${bdw:otooFindPageModuleProxy('O2O_center_recommend_2').otooRecommendProducts}" var="otooRecommend" varStatus="s" end="2">
                        <li>
                            <a class="p-img" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title=""><img src="${otooRecommend.images[0]['300X200']}"></a>
                            <a class="p-name" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title="">${otooRecommend.otooProductNm}</a>
                            <span class="c-price"><i>&yen;</i>${otooRecommend.otooDiscountPrice}</span>
                            <%--<span class="o-price">价值&yen;${otooRecommend.otooMarketPrice}</span>--%>
                            <span class="o-price"><del>&yen;${otooRecommend.otooMarketPrice}</del></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--item item03 end-->
        <div class="item item03">
            <div class="tit frameEdit" frameInfo="O2O_center_recommend_title_3">
                <c:forEach items="${sdk:findPageModuleProxy('O2O_center_recommend_title_3').links}" var="recommend_title" varStatus="s" end="0">

                <h3>${recommend_title.title}</h3>
                    <i class="m-tit">${recommend_title.description}</i>
                <b></b>
                    <a class="more" href="${recommend_title.link}" title="">查看更多&gt;</a>

                    <div class="clearfix"></div>
                </c:forEach>
            </div>
            <!--tit end-->
            <div class="con frameEdit" frameInfo="O2O_center_recommend_3">
                <ul>
                    <c:forEach items="${bdw:otooFindPageModuleProxy('O2O_center_recommend_3').otooRecommendProducts}" var="otooRecommend" varStatus="s" end="2">
                        <li>
                            <a class="p-img" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title=""><img src="${otooRecommend.images[0]['300X200']}"></a>
                            <a class="p-name" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title="">${otooRecommend.otooProductNm}</a>
                            <span class="c-price"><i>&yen;</i>${otooRecommend.otooDiscountPrice}</span>
                            <%--<span class="o-price">价值&yen;${otooRecommend.otooMarketPrice}</span>--%>
                            <span class="o-price"><del>&yen;${otooRecommend.otooMarketPrice}</del></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--item item04 end-->
        <div class="item item04">
            <div class="tit frameEdit" frameInfo="O2O_center_recommend_title_4">
                <c:forEach items="${sdk:findPageModuleProxy('O2O_center_recommend_title_4').links}" var="recommend_title" varStatus="s" end="0">

                <h3>${recommend_title.title}</h3>
                    <i class="m-tit">${recommend_title.description}</i>
                <b></b>
                <a class="more" href="${recommend_title.link}" title="">查看更多&gt;</a>

                <div class="clearfix"></div>
                </c:forEach>
            </div>

            <!--tit end-->
            <div class="con frameEdit" frameInfo="O2O_center_recommend_4">
                <ul>
                    <c:forEach items="${bdw:otooFindPageModuleProxy('O2O_center_recommend_4').otooRecommendProducts}" var="otooRecommend" varStatus="s" end="2">
                        <li>
                            <a class="p-img" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title=""><img src="${otooRecommend.images[0]['300X200']}"></a>
                            <a class="p-name" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title="">${otooRecommend.otooProductNm}</a>
                            <span class="c-price"><i>&yen;</i>${otooRecommend.otooDiscountPrice}</span>
                           <%-- <span class="o-price">价值&yen;${otooRecommend.otooMarketPrice}</span>--%>
                            <span class="o-price"><del>&yen;${otooRecommend.otooMarketPrice}</del></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--item item05 end-->
        <div class="item item05">
            <div class="tit frameEdit" frameInfo="O2O_center_recommend_title_5">
                <c:forEach items="${sdk:findPageModuleProxy('O2O_center_recommend_title_5').links}" var="recommend_title" varStatus="s" end="0">

                <h3>${recommend_title.title}</h3>
                    <i class="m-tit">${recommend_title.description}</i>
                <b></b>
                <a class="more" href="${recommend_title.link}" title="">查看更多&gt;</a>

                <div class="clearfix"></div>
                </c:forEach>
            </div>
            <!--tit end-->
            <div class="con frameEdit" frameInfo="O2O_center_recommend_5">
                <ul>
                    <c:forEach items="${bdw:otooFindPageModuleProxy('O2O_center_recommend_5').otooRecommendProducts}" var="otooRecommend" varStatus="s" end="2">
                        <li>
                            <a class="p-img" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title=""><img src="${otooRecommend.images[0]['300X200']}"></a>
                            <a class="p-name" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title="">${otooRecommend.otooProductNm}</a>
                            <span class="c-price"><i>&yen;</i>${otooRecommend.otooDiscountPrice}</span>
                           <%-- <span class="o-price">价值&yen;${otooRecommend.otooMarketPrice}</span>--%>
                            <span class="o-price"><del>&yen;${otooRecommend.otooMarketPrice}</del></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--item item06 end-->
        <div class="item item06">
            <div class="tit frameEdit" frameInfo="O2O_center_recommend_title_6">
                <c:forEach items="${sdk:findPageModuleProxy('O2O_center_recommend_title_6').links}" var="recommend_title" varStatus="s" end="0">

                <h3>${recommend_title.title}</h3>
                    <i class="m-tit">${recommend_title.description}</i>
                <b></b>
                <a class="more" href="${recommend_title.link}" title="">查看更多&gt;</a>

                <div class="clearfix"></div>
                </c:forEach>

            </div>
            <!--tit end-->
            <div class="con frameEdit" frameInfo="O2O_center_recommend_6">
                <ul>
                    <c:forEach items="${bdw:otooFindPageModuleProxy('O2O_center_recommend_6').otooRecommendProducts}" var="otooRecommend" varStatus="s" end="2">
                        <li>
                            <a class="p-img" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title=""><img src="${otooRecommend.images[0]['300X200']}"></a>
                            <a class="p-name" href="${webRoot}/otoo/product.ac?id=${otooRecommend.otooProductId}" title="">${otooRecommend.otooProductNm}</a>
                            <span class="c-price"><i>&yen;</i>${otooRecommend.otooDiscountPrice}</span>
                            <%--<span class="o-price">价值&yen;${otooRecommend.otooMarketPrice}</span>--%>
                            <span class="o-price"><del>&yen;${otooRecommend.otooMarketPrice}</del></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--item item01 end-->
    </div>
    <!--left end-->
    <div class="right" id="topMenu" style="z-index: 1">
        <h3>最近浏览<a href="javascript:" class="fr" style="font-size: 12px;color:red;margin-right: 4px;" onclick="clearHistoryProductsCookie();"><img src="${webRoot}/template/bdw/otoo/statics/images/rubbish.png" title="清空" style="margin-top: 20px; margin-right: 20px;"/></a></h3>
        <c:set value="${bdw:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
        <c:choose>
            <c:when test="${not empty productFromCookies}">
                <ul>
                    <c:forEach items="${productFromCookies}" var="product" end="5">
                        <li>
                            <a class="p-img" href="${webRoot}/otoo/product.ac?id=${product.otooProductId}" target="_blank" title="${product.otooProductNm}"><img src="${product.defaultImage['120X80']}" alt="${product.otooProductNm}"></a>
                            <div class="p-info">
                                <a class="p-name" href="${webRoot}/otoo/product.ac?id=${product.otooProductId}" target="_blank" title="">${product.otooProductNm}</a>
                                <p>${product.otooSellingPoint}</p>
                                <span class="c-price">&yen;${product.otooDiscountPrice}</span>
                                <span class="o-price"><del>&yen;${product.otooMarketPrice}</del></span>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div style="margin-top: 16px; margin-bottom: 16px;text-align: center;color:red">你还未浏览其他商品</div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="clear"></div>
    <!--right end-->
</div>
<!--main end-->
<c:import url="/template/bdw/otoo/common/bottom.jsp?p=index"/>
<!-- footer end-->
</body>
</html>
