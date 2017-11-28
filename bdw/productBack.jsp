<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<jsp:useBean id="systemTime" class="java.util.Date"/>

<c:if test="${!productProxy.onSale}">
    <c:redirect url="/index.jsp"></c:redirect>
</c:if>
<%--取分类--%>
<c:set var="categoryProxy" value="${productProxy.category}"/>
<%--取品牌--%>
<c:set var="brandProxy" value="${productProxy.brand}"/>
<%--取出商品属性--%>
<c:set var="attrDicList" value="${productProxy.dicValues}"/>
<c:set var="attrDicMap" value="${productProxy.dicValueMap}"/>
<c:set var="attrGroupProxyList" value="${productProxy.attrGroupProxyList}"/>
<%--组合套餐--%>
<c:set var="comboList" value="${productProxy.combos}"/>
<%--商品评论统计--%>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,5)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>
<%--商品咨询--%>
<%--<c:set var="buyConsultProxys" value="${sdk:findBuyConsultByProductId(param.id,10)}"/>--%>
<c:set var="specList" value="${productProxy.productUserSpecProxyList}"/>
<%--店铺信息--%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>
<c:set value="${sdk:getShopUser(productProxy.shopInfId)}" var="shopUser"/>
<%--同类商品--%>
<c:set value="${sdk:getSimilarProducts(productProxy.productId,productProxy.categoryId,20)}" var="similarProducts"/>
<c:set value="${productProxy.checkIsGroupBuyProduct}" var="groupBuyId"> </c:set>
<%-- 取得商品溯源 --%>
<c:set value="${bdw:getSyProductSourceProxyById(param.id)}" var="productSourceProxy"> </c:set>

<%--取出在售的门店商品--%>
<c:set value="${bdw:getAllRelProductProxy(20,param.id)}" var="productProxyList"/>

<%--地图--%>
<c:set value="${bdw:searchZones()}" var="zones"/>
<c:set value="${sdk:getSysParamValue('key_tengxunMap')}" var="mapKey"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>${webName}-${empty productProxy.metaTitle ? productProxy.name : productProxy.metaTitle}</title>
    <meta name="keywords" content="${productProxy.metaKeywords}-${webName}"/>
        <%--SEO keywords优化--%>
    <meta name="description" content="${productProxy.metaDescr}-${webName}"/>
        <%--SEO description优化--%>
        <%-- <link href="http://v3.jiathis.com/code/css/jiathis_counter.css" rel="stylesheet" type="text/css">
         <script src="http://tajs.qq.com/jiathis.php?uid=1338866268911669&dm=imalls.imall.com.cn" charset="utf-8"></script>
         <link href="http://v3.jiathis.com/code/css/jiathis_share.css" rel="stylesheet" type="text/css">--%>
        <%--<link href="${webRoot}/template/bdw/statics/css/base.css" rel="stylesheet" type="text/css"/>--%>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/detail.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/cloud-zoom/css/cloud-zoom.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/css/jquery.jqzoom.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
        <%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>--%>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/external/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/ui/jquery.ui.core.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/ui/jquery.ui.position.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/ui/jquery.ui.widget.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/jquery-ui-1.8.13/development-bundle/ui/jquery.ui.autocomplete.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jqzoom-core.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/cloud-zoom/js/cloud-zoom.1.0.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jcarousel.min.js"></script>
        <%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>--%>
        <%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/scrollTop.js"></script>--%>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/scrollimage.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/hScrollPane.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imallSlidelf.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
    <script type="text/javascript">
        var rel = "${param.rel}";
        var skuData = eval('${productProxy.skuJsonData}');
        var userSpecData = eval('${productProxy.userSpecJsonData}');
        var isCanBuy = eval('${productProxy.isCanBuy}');
        var productId = eval('${productProxy.productId}');
        var isShowProductInf = "${shopInf.isFreeze}";
        var supportZoneIds = [];
        <c:forEach items="${productProxy.supportZoneIds}" var="zoneId" varStatus="s">
        supportZoneIds[${s.index}] =${zoneId};
        </c:forEach>
        var webPath = {
            webRoot: "${webRoot}", page: "${param.page}", productId: "${param.id}", productCollectCount: "${loginUser.productCollectCount}", shopCollectCount: "${loginUser.shopCollectCount}", goBox: "${param.goBox}",
            systemTime: "<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />",lat: '${param.lat}', lng: '${param.lng}', mapkey:'${mapKey}',userId:"${loginUser.userId}"
        };


        var COOKIE_NAME = 'ProductHistory' +${productProxy.productId};
        if (!$.cookie(COOKIE_NAME)) {
            $.cookie(COOKIE_NAME, ${productProxy.productId}, {path: '/', expires: (60 * 60 * 24 * 365 * 1)});
        }

        var zoneData = [];
        <c:forEach items="${zones}" var="zone">
        <c:forEach items="${zone.value}" var="city">
        zoneData.push({value: "${city.spell}${city.name}", name: "${city.name}", zoneId: ${city.zoneId}});
        </c:forEach>
        </c:forEach>
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/comment.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/product.js"></script>
</head>

<%
    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();
    request.setAttribute("tempContextUrl", tempContextUrl);
%>

<body>
    <%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=detail"/>
    <%--页头结束--%>

<ul class="position">
    <li class="tab"><a href="${webRoot}/index.ac">首页</a></li>
    <input type="hidden" id="productcookie" value="${param.id}"/>
    <c:forEach items="${categoryProxy.categoryTree}" var="category" varStatus="stats" begin="1">
        <c:choose>
            <c:when test="${stats.last}">
                <li class="yx" style="border:none;">${category.name}</li>
            </c:when>
            <c:otherwise>
                <li class="tab"><a href="${webRoot}/productlist-${category.categoryId}.html" title="${category.name}">${category.name}</a></li>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</ul>

<!--details_index-->
<div class="details_index">
    <!--details_m1-->
    <div class="details_m1">
        <div class="m1_l">
            <div class="l_top">
                <div class="picbox">
                    <div class="x_pic">
                        <a href='${productProxy.defaultImage['600X600']}' class='cloud-zoom' id='zoom1' rel="adjustX:10,adjustY:-4,softFocus:false,smoothMove:2,zoomWidth:490,zoomHeight:380,showTitle:false,minWidth:383,minHeight:383">
                            <img id="bigsrc" src="${productProxy.defaultImage['420X420']}" alt='' title="${productProxy.name}" border="0"/>
                            <span>京东</span>
                        </a>
                    </div>
                    <div class="list_pic">
                        <div class="turnL" id="mycarousel-prev"><a href="javascript:"></a></div>
                        <div class="sorll_box" id="mycarousel">
                            <ul>
                                <c:forEach varStatus="s" items="${productProxy.images}" var="image">
                                    <li>
                                        <a href='${image['']}' picId="${image}" sImg="${image['420X420']}" lImg="${image['']}"
                                           class='cloud-zoom-gallery ${s.first?'cur':''}' rel="useZoom:'zoom1',smallImage:'${image['420X420']}',largeimage: '${image['600X600']}'">
                                            <img class="zoom-tiny-image" src="${image['58X58']}" alt="Thumbnail 1"/>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="turnR" id="mycarousel-next"><a href="javascript:"></a></div>
                        <div class="clear"></div>
                    </div>
                    <div class="l_btm">
                        <div class="share" id="ckepop">
                            <span class="jiathis_txt" style="margin-right: 10px;">分享给好友</span>
                            <a class="jiathis_button_weixin"></a>
                            <a class="jiathis_button_cqq"></a>
                            <a class="jiathis_button_tsina"></a>
                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
                            <a class="jiathis_counter_style"></a>
                        </div>
                        <div class="collect"><a href="javascript:" id="AddTomyLikeBtn" class="f-save ${productProxy.collect ? "focus-sel" : "unfocus"}"> 收藏商品</a></div>
                    </div>
                </div>
                <div class="infobox">
                    <div class="infotitle">${productProxy.name}<br><i>${productProxy.salePoint}</i></div>
                    <div class="info_layer">
                        <div class="lable">销售价</div>
                        <div class="price01">
                            <em class="price" id="price"><span>￥</span>${productProxy.priceListStr}</em>
                            <input type="hidden" id="priceListStr" priceNm="${productProxy.price.amountNm}" value="${productProxy.priceListStr}">
                            <input type="hidden" id="remainStock" value="${(productProxy.skus[0].price.remainStock)}">
                            <c:choose>
                                <c:when test="${productProxy.price.discountType eq 'PLATFORM_DISCOUNT'}">
                                    (活动剩余库存${productProxy.price.remainStock}件)
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(productProxy.skus[0].price.remainStock)<=0}"><span id="stock" style="font-size: 13px;">(库存0件</span></c:when>
                                        <c:otherwise>
                                            <span id="stock" style="font-size: 13px;">(库存${(productProxy.skus[0].price.remainStock)}件</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${sdk:getIsPlatformDiscount(param.id)&&!productProxy.price.isSpecialPrice}">
                                        ,活动剩余库存0件
                                    </c:if>
                                    )
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="info_rows">
                        <div class="lable">市场价</div>
                        <div class="info">
                            <div class="price01" id="marketPrice">
                                ￥${productProxy.marketPrice}
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="info_rows">
                        <div class="lable" style="letter-spacing:0;">商品评价</div>
                        <div class="info">
                            <div class="start">
                                <c:choose>
                                    <c:when test="${productProxy.commentStatistics.average > 0}">
                                        <c:forEach begin="1" end="${productProxy.commentStatistics.average}">
                                            <span></span>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                                <%--<div class="assess"><a href="javascript:;" onclick="showCommentBox()">(共有${productProxy.total}条评论)</a></div>--%>
                            <div class="assess"><span>(共有${productProxy.total}条评论)</span></div>
                            <div class="clear"></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="info_rows">
                        <div class="lable">服&nbsp;&nbsp;务</div>
                        <div class="info">
                            <div class="info_service">
                                由
                                <c:choose>
                                    <c:when test="${productProxy.jdProductCode != null }">
                                        <a href="www.jd.com">京东</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}">${shopInf.shopNm}</a>
                                    </c:otherwise>
                                </c:choose>
                                负责发货，并提供售后服务
                                <%--由 <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}">${shopInf.shopNm}</a> 负责发货，并提供售后服务--%>
                            </div>
                                <%--<div class="price01" id="marketPrice">
                                    ￥${productProxy.marketPrice}
                                </div>--%>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <c:if test="${shopInf.shopType eq '0'}"><%--石药自营店--%>
                        <div class="info_rows">
                            <div class="lable" style="letter-spacing:0;">温馨提示</div>
                            <div class="info">
                                <div class="info_service">
                                    <a href="javascript:void(0);" id="selectStoreBtn" style="color: #333;font-weight: 800">附近总共有<em style="color: red;">&nbsp;${productProxy.storeSaleCount}&nbsp;</em>家门店在售</a>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:if>
                    <c:choose>
                        <c:when test="${fn:length(productProxy.skus)==1 && productProxy.price.isSpecialPrice}">
                            <div class="info_rows">
                                <div class="lable" style="letter-spacing:0;">特价时间</div>
                                <div class="info lesTime" id="lesTime" style="margin-top: 5px;"></div>
                                <div class="clear"></div>
                            </div>
                            <script type="text/javascript">
                                $("#lesTime").imallCountdown("${productProxy.price.endTimeStr}", "li", webPath.systemTime)
                            </script>
                        </c:when>
                        <c:otherwise>
                            <div class="info_rows" id="specialPrice" style="display: none">
                                <div class="lable" style="letter-spacing:0;">特价时间</div>
                                <div class="info lesTime" id="lesTime" style="margin-top: 5px;"></div>
                                <div class="clear"></div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:set value="${productProxy.availableBusinessRuleList}"  var="availableBusinessRuleList" />
                    <c:if test="${not empty availableBusinessRuleList}">
                        <div class="info_rows">
                            <div class="lable" style="letter-spacing:0;">正在促销</div>
                            <div class="info">
                                <c:choose>
                                    <c:when test="${fn:length(availableBusinessRuleList)>3}">
                                        <div class="i_layer" style="height: 75px;">
                                            <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="i">
                                                <p>
                                                    <i>
                                                        <c:choose>
                                                            <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">折扣</c:when>
                                                            <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">免运</c:when>
                                                            <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">赠品</c:when>
                                                            <c:when test="${rule.ruleTypeCode=='9'||rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'}">换购</c:when>
                                                            <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">送券</c:when>
                                                            <%-- <c:when test="${rule.ruleTypeCode=='16'||rule.ruleTypeCode=='17'||rule.ruleTypeCode=='18'}">用券</c:when>--%>
                                                            <c:when test="${rule.ruleTypeCode=='19'||rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'}">送积分</c:when>
                                                        </c:choose>
                                                    </i>
                                                        <%--<c:choose>
                                                            <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">
                                                                <c:forEach items="${productProxy.presentProductList}" var="rule2" varStatus="i">
                                                                    ${rule2.businessRuleNm}
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>${rule.businessRuleNm}</c:otherwise>
                                                        </c:choose>--%>
                                                        ${rule.businessRuleNm}&nbsp;
                                                </p>
                                            </c:forEach>
                                                <%--<c:if test="${not empty groupBuyId}" >
                                                  <p>
                                                    <i>
                                                      团购
                                                    </i>
                                                    <c:set value="${sdk:findGroupBuyProxy(groupBuyId)}"   var="groupBuy" />
                                                      ${groupBuy.title}<a href="${webRoot}/tuan.ac?id=${groupBuyId}" target="_blank">&nbsp;详情</a>
                                                  </p>
                                                </c:if>--%>
                                        </div>
                                        <div>
                                            <c:if test="${fn:length(availableBusinessRuleList)>3}">
                                                <p><a href="javascript:void(0);" class="more-rule">展开更多活动</a></p>
                                                <p><a href="javascript:void(0);" class="hidden-rule" style="display: none;">收起更多活动</a></p>
                                            </c:if>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="i_layer">
                                            <c:forEach items="${productProxy.availableBusinessRuleList}" var="rule" varStatus="i">
                                                <p>
                                                    <i>
                                                        <c:choose>
                                                            <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">折扣</c:when>
                                                            <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">免运</c:when>
                                                            <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">赠品</c:when>
                                                            <c:when test="${rule.ruleTypeCode=='9'||rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'}">换购</c:when>
                                                            <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">送券</c:when>
                                                            <%--<c:when test="${rule.ruleTypeCode=='16'||rule.ruleTypeCode=='17'||rule.ruleTypeCode=='18'}">用券</c:when>--%>
                                                            <c:when test="${rule.ruleTypeCode=='19'||rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'}">送积分</c:when>
                                                        </c:choose>
                                                    </i>
                                                        ${rule.businessRuleNm}&nbsp;
                                                </p>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:if>

                    <c:if test="${productProxy.isZoneLimit == true && fn:length(productProxy.supportZoneStringList)>0}">
                        <div class="info_rows" style="margin-left:9px;">
                            <div class="lable" style="letter-spacing:0;font-size:14px;">配送地区</div>
                            <div class="info">
                                <div style="padding-top: 4px;color: red;font-size: 14px;font-weight: bold;"><span id="deliveryAreaSpan">查看配送区域</span></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:if>


                    <div class="i_btm">
                            <%--多规格 start--%>
                        <c:if test="${productProxy.isEnableMultiSpec=='Y'}">
                            <c:forEach items="${specList}" var="spec">
                                <div class="b_rows specSelect">
                                    <c:if test="${fn:length(spec.specValueProxyList) > 0}"><div class="lable">${spec.name}：</div></c:if>
                                    <div class="rows_right ${spec.specType eq '0'?'sizeSel':'coloSel'}">
                                        <c:forEach items="${spec.specValueProxyList}" var="specValue">
                                            <c:if test="${spec.specType eq '0'}">
                                                <div class="size item">
                                                    <a href="javascript:" title="${specValue.name}" data-value="${spec.specId}:${specValue.specValueId}" remainStock="${specValue.remainStock}">
                                                        <i></i>${specValue.value}</a>
                                                </div>
                                            </c:if>
                                            <c:if test="${spec.specType eq '1'}">
                                                <div class="size item2">
                                                    <a title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}">
                                                        <i></i><img width='30' height='30' src="${specValue.value}"/>
                                                    </a>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <div class="clear"></div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </c:forEach>
                        </c:if>
                            <%--多规格 end--%>

                        <div class="b_rows">
                            <div class="lable">购买数量</div>
                            <div class="rows_right">
                                <div class="n_box">
                                    <a href="javascript:void(0);" class="and prd_subNum"></a>
                                    <input type="text" value="1" class="prd_num" style="height: 21px;line-height: 21px;width: 50px;"/>
                                    <a href="javascript:void(0);" class="minus prd_addNum"></a>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="b_rows">
                            <div class="lable"></div>
                            <div class="rows_right">
                                <div class="r_btn">
                                    <c:choose>
                                        <c:when test="${productProxy.isCanBuy}">
                                            <a class="addGoCar btn01" skuid="${productProxy.isEnableMultiSpec=='Y' ? '': productProxy.skus[0].skuId}"
                                               num="1" carttype="normal" handler="sku" href="javascript:"></a>
                                            <a class="addcart btn02" id="addProductCart" skuid="${productProxy.isEnableMultiSpec=='Y' ? '': productProxy.skus[0].skuId}" num="1" carttype="normal" handler="sku" href="javascript:"></a>
                                            <c:if test="${not empty groupBuyId}">
                                                <a href="${webRoot}/tuan.ac?id=${groupBuyId}" target="_blank" class="group-buy">该商品正在参加团购</a>
                                            </c:if>
                                            <%--<c:if test="${productProxy.isZoneLimit}"><span id="support" style="color: red;display: none;">很抱歉，该区域不支持配送！</span></c:if>--%>
                                        </c:when>
                                        <c:otherwise>
                                            <a skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}" class="quehuobtn" href="javascript:">
                                                <img src="${webRoot}/template/bdw/statics/images/quehuo.gif" alt="">
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>

                            <%--二维码--%>
                        <c:if test="${productProxy.isCanBuy}">
                            <c:if test="${productProxy.enableQRCodePay}">
                                <div class="rdata">
                                        <%--lhw 支持多规格的扫购--%>
                                    <c:set var="urlStr" value="${tempContextUrl}/wechat/result.ac?skuId="/>
                                    <c:if test="${not empty bdw:getQRCodeLongFormat4(productProxy.productId,urlStr,'')}">
                                        <c:forEach items="${bdw:getQRCodeLongFormat4(productProxy.productId,urlStr,'')}" var="vorderaddQrSkuId">
                                            <c:set var="vorderaddQr" value="${fn:substringBefore(vorderaddQrSkuId,'.')}"/>
                                            <c:set var="skuId" value="${fn:substringAfter(vorderaddQrSkuId, '.')}"/>
                                            <div class="t2 qr${skuId}" style="display:none;">
                                                <div class="weixinbox" style="position:relative;">
                                                    <div class="w_left"><img src="${webRoot}/QRCodeServlet?qrcodelong=${vorderaddQr}" width="100" height="100" onmouseover="showBigORCode('${skuId}')"/></div>
                                                    <div class="w_right">
                                                        <div class="r_title"><i><img src="${webRoot}/template/bdw/statics/images/weixin001.png" width="35" height="30"/></i><em>关注${webName}微信，进行扫购</em></div>
                                                        <div class="r_title"><em>扫一扫即可购买，方便快捷！</em></div>
                                                        <div class="r_title"><em>鼠标移入二维码，进行放大！</em></div>
                                                    </div>
                                                    <div id="orcodeBig" class="code${skuId}"><img src="${webRoot}/QRCodeServlet?qrcodelong=${vorderaddQr}" width="200" height="200" onmouseout="hideBigORCode('${skuId}')"/></div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                        <%--<c:set var="urlStr" value="${tempContextUrl}/wechat/result.ac?skuId=${productProxy.skus[0].skuId}"/>
                                        <c:set value="${weixinSdk:getQRCodeLongFormat2(urlStr,'')}" var="vorderaddQr"/>
                                        <div class="t2">
                                            <div class="weixinbox" style="position:relative;">
                                                <div class="w_left"><img src="${webRoot}/QRCodeServlet?qrcodelong=${vorderaddQr}" width="100" height="100" onmouseover="showBigORCode()"/></div>
                                                <div class="w_right">
                                                    <div class="r_title"><i><img src="${webRoot}/template/bdw/statics/images/weixin001.png" width="35" height="30"/></i><em>关注${webName}微信，进行扫购</em></div>
                                                    <div class="r_title"><em>扫一扫即可购买，方便快捷！</em></div>
                                                    <div class="r_title"><em>鼠标移入二维码，进行放大！</em></div>
                                                </div>
                                                <div id="orcodeBig"><img src="${webRoot}/QRCodeServlet?qrcodelong=${vorderaddQr}" width="200" height="200" onmouseout="hideBigORCode()"/></div>
                                            </div>
                                        </div>--%>
                                </div>
                            </c:if>
                        </c:if>

                            <%--弹出层--%>
                        <div class="addTobuyCarLayer" style="display:none;" id="addToBuyCarLayer">
                            <div class="showTip">
                                <div class="close"><a href="javascript:" id="closeBtn"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
                                <div class="succe">
                                    <h3>商品已成功添加到购物车！</h3>

                                    <div class="tips">购物车共有 <b class="cartnum"></b> 件商品，合计：<b class="cartprice"></b>元</div>
                                    <div class="toBuy"><a href="javascript:" id="goToAccounts"><img src="${webRoot}/template/bdw/statics/images/detail_layerbTN.gif"/></a> <a href="javascript:" id="continueGoShopping">再逛逛</a>
                                    </div>
                                </div>
                            </div>
                            <div class="rShaw"></div>
                            <div class="clear"></div>
                            <div class="bShaw"></div>
                        </div>

                        <div class="AddTomyLikeLayer" style="display:none; margin-top:-10px;">
                            <div class="showTip">
                                <div class="close"><a href="javascript:" onclick="$('.AddTomyLikeLayer').hide()"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
                                <div class="succe">
                                    <h3>商品已成功收藏！</h3>

                                    <div class="tips">已收藏 <b id="productCollectCount">${loginUser.productCollectCount}</b> 件商品。
                                        <a href="${webRoot}/module/member/productCollection.ac?menuId=51553">查看收藏夹>></a>
                                    </div>
                                </div>
                            </div>
                            <div class="rShaw"></div>
                            <div class="clear"></div>
                            <div class="bShaw"></div>
                        </div>

                        <div class="AddShopTomyLikeLayer" style="display:none; margin-top:-10px;">
                            <div class="showTip">
                                <div class="close"><a href="javascript:" onclick="$('.AddShopTomyLikeLayer').hide()"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
                                <div class="succe">
                                    <h3>店铺已成功收藏！</h3>

                                    <div class="tips">已收藏 <b id="shopCollectCount">${loginUser.shopCollectCount}</b> 件店铺。
                                        <a href="${webRoot}/module/member/shopCollection.ac">查看收藏夹>></a>
                                    </div>
                                </div>
                            </div>
                            <div class="rShaw"></div>
                            <div class="clear"></div>
                            <div class="bShaw"></div>
                        </div>
                    </div>
                        <%--<div class="ts">--%>
                        <%--<div class="ts_text">温馨提示</div>--%>
                        <%--<div class="ts_tab"><i>正</i><a href="javascript:;">正品保证</a></div>--%>
                        <%--<div class="ts_tab"><i>赔</i><a href="javascript:;">假一赔三</a></div>--%>
                        <%--<div class="ts_tab" style="width:130px;"><i style="background:#bbb;">退</i><a href="javascript:;">不支持无理由退换货</a></div>--%>
                        <%--</div>--%>

                    <c:set value="${sdk:getShopAttestations(productProxy.shopInfId)}" var="shopAttestations"/>
                    <c:if test="${not empty shopAttestations}">
                        <div class="ts">
                            <div class="ts_text">认证信息:</div>
                            <c:forEach items="${shopAttestations}" var="attestations" varStatus="status">
                                <c:choose>
                                    <c:when test="${status.last}">
                                        <div class="ts_tab" style="border:0px;"><img src="${attestations.logo["20X20"]}" width="20px" height="20px"/>${attestations.attestationName}</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="ts_tab"><img src="${attestations.logo["20X20"]}" width="20px" height="20px"/>${attestations.attestationName}</div>
                                    </c:otherwise>

                                </c:choose>
                            </c:forEach>
                                <%--发现拿到的图片路径是80的，显示不了，我本地是8080,煌哥说拿到服务器上就可以正常显示--%>
                                <%--<div class="ts_tab"> <img src="http://localhost:80/upload/1/2015/2/3/95aaff44-83b7-4368-84af-21b39e209ff8_20X20.jpg" width="20px" height="20px" />正品保证</div>--%>
                                <%--<div class="ts_tab"> <img src="http://localhost:80/upload/1/2015/2/3/95aaff44-83b7-4368-84af-21b39e209ff8_20X20.jpg" width="20px" height="20px" />假一赔十</div>--%>
                                <%--<div class="ts_tab"> <img src="http://localhost:80/upload/1/2015/2/3/95aaff44-83b7-4368-84af-21b39e209ff8_20X20.jpg" width="20px" height="20px" />正品保证</div>--%>
                                <%--<div class="ts_tab"> <img src="http://localhost:80/upload/1/2015/2/3/95aaff44-83b7-4368-84af-21b39e209ff8_20X20.jpg" width="20px" height="20px" />假一赔十</div>--%>
                        </div>
                    </c:if>
                </div>
                <div class="clear"></div>
            </div>


            <!--套装搭配 start-->
            <c:if test="${not empty productProxy.referProductList}">
                <div class="left_btm">
                    <div class="btm_layer"><i class="cur">套餐搭配</i></div>
                    <div class="btm_box">
                        <div class="box_l">
                            <div class="l_icom"></div>
                                <%--<div class="up"><a href="javascript:;" id="referProductList-r"></a></div>--%>
                                <%--<div class="down"><a href="javascript:;" id="referProductList-l"></a></div>--%>
                            <ul class="b_info">
                                <li class="i_pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["120X120"]}"/></a></li>
                                <li class="i_title"><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></li>
                                <li class="i_price"><i>￥</i>${productProxy.priceListStr}</li>
                            </ul>
                            <div class="plus"></div>
                                <%--<c:set value="${fn:length(productProxy.referProductList)}" var="width"></c:set>--%>
                            <div id="referProductList" class="container1" style="width:580px; height:250px; float:left;position: relative;overflow: hidden;">
                                <div class="bigbox1" style="position:absolute;left: 0;margin: 0;padding: 0;top: 0;width: 4000px;">
                                    <c:forEach items="${productProxy.referProductList}" var="prd" varStatus="num">
                                        <div class="nrbox1">
                                            <ul class="b_info tuijian">
                                                <li class="i_pic"><a href="${webRoot}plus/product-${prd.productId}.html"><img src="${prd.defaultImage["120X120"]}"/></a></li>
                                                <li class="i_title"><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></li>
                                                <li class="i_price"><i>￥</i>${prd.price.unitPrice}</li>
                                            </ul>
                                            <c:if test="${!num.last}">
                                                <div class="plus"></div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="box_r">
                            <div class="r_btn"><a href="${webRoot}/productSet.ac?id=${productProxy.productId}">购买组合</a></div>
                        </div>
                    </div>
                </div>
            </c:if>
                <%--套装搭配 end--%>

            <!--推荐搭配 start-->
            <c:if test="${not empty productProxy.referSkuList}">
                <div class="left_btm">
                    <input type="hidden" id="dapei_skuId" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.skus[0].skuId}</c:if>">
                    <input type="hidden" id="dapei_skuprice" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.price.unitPrice}</c:if>">

                    <div class="btm_layer"><i class="cur">推荐搭配</i></div>
                    <div class="btm_box" id="dapei">
                        <div class="box_l">
                            <div class="l_icom"></div>
                                <%--<div class="up"><a href="#"></a></div>--%>
                                <%--<div class="down"><a href="#"></a></div>--%>
                            <ul class="b_info">
                                <li class="i_pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["120X120"]}"/></a></li>
                                <li class="i_title"><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></li>
                                <li class="i_price"><i>￥</i>${productProxy.priceListStr}</li>
                            </ul>
                            <div class="plus"></div>
                                <%--<c:set value="${fn:length(productProxy.referSkuList)}" var="width"/>--%>
                            <div id="referProductList" class="tuiJianDaPei container2" style="width:580px; height:250px; float:left;position: relative;overflow: hidden;">
                                <div class="bigbox2" style="position:absolute;left: 0;margin: 0;padding: 0;top: 0;width: 4000px;">
                                    <c:forEach items="${productProxy.referSkuList}" var="prd" varStatus="num">
                                        <div class="nrbox2">
                                            <ul class="b_info tuijian">
                                                <li class="i_pic"><a href="${webRoot}/product-${prd.productId}.html"><img src="${prd.defaultImage["120X120"]}"/></a></li>
                                                <li class="i_title"><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></li>
                                                <li class="i_price">
                                                    <input class="ch" name="" skuid="${prd.skus[0].skuId}" type="checkbox" value="${prd.price.unitPrice}"/>
                                                    <i>￥</i>
                                                        ${prd.price.unitPrice}
                                                </li>
                                            </ul>
                                            <c:if test="${!num.last}">
                                                <div class="plus"></div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <script type="text/javascript">
                                var referProductListNoCheck = function () {
                                    $("#referProductList input[type='checkbox']").each(function () {
                                        $(this).attr("checked", false);
                                    });
                                }();
                            </script>
                            <div class="clear"></div>
                        </div>
                        <div class="box_r">
                            <div class="r_text">您已选择<i id="selectNum">0</i>个自由搭配组合</div>
                                <%--<div class="r_price">原价：<span><i>￥</i>88.00</span></div>--%>
                            <div class="r_price">搭配价：<span style=" color:#ed1f23; font-size:18px;"><i>￥</i><em id="dapeiprice">0.0</em></span></div>
                            <div class="r_btn"><a class="batch_addcart" carttype="normal" handler="sku" href="javascript:">购买搭配组合</a></div>
                        </div>
                    </div>
                </div>
            </c:if>
                <%--推荐搭配 end--%>


                <%--套餐组合--%>
            <c:set value="${productProxy.combos}" var="combos"/>
            <c:if test="${ not empty combos}">
                <div class="left_btm">
                    <div class="btm_layer zuhe_menu">
                        <c:forEach items="${combos}" var="combo" varStatus="s">
                            <i class="${s.count==1?'cur':''}" onclick="onTabSelect(${combo.comboId},this)" comboid="${combo.comboId}">${combo.title}</i>
                        </c:forEach>
                    </div>
                    <c:forEach items="${combos}" var="combo" varStatus="s">
                        <div class="btm_box zuhe_List combos${combo.comboId}" style="${!s.first?'display:none;':''}">
                            <div class="box_l">
                                <div class="l_icom"></div>
                                    <%--<div class="up"><a href="#"></a></div>--%>
                                    <%--<div class="down"><a href="#"></a></div>--%>
                                    <%-- 隐藏原商品
                                    <ul class="b_info">
                                         <li class="i_pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["120X120"]}"/></a></li>
                                         <li class="i_title"><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></li>
                                         <li class="i_price"><i>￥</i><fmt:formatNumber value="${productProxy.priceListStr}" pattern="#00.0#"/></li>
                                     </ul>--%>
                                    <%--<div class="plus"></div>--%>
                                <div id="referProductList" class="taocanZuHe container3" style="width:580px; height:250px; float:left;position: relative;overflow: hidden;">
                                    <div class="bigbox3" style="position:absolute;left: 0;margin: 0;padding: 0;top: 0;width: 4000px;">
                                        <c:forEach items="${combo.skus}" var="sku" varStatus="i">
                                            <div class="nrbox3">
                                                <ul class="b_info tcZuhe">
                                                    <li class="i_pic"><a href="${webRoot}/product-${sku.productProxy.productId}.html"><img src="${sku.productProxy.defaultImage["120X120"]}"/></a></li>
                                                    <li class="i_title"><a href="${webRoot}/product-${sku.productProxy.productId}.html">${sku.productProxy.name}</a></li>
                                                    <li class="i_price"><i>￥</i>${sku.price.unitPrice} × ${sku.amountNum}</li>
                                                    <p><c:forEach items="${sku.specs}" var="spec"><b>${spec.spec}</b> </c:forEach></p>
                                                </ul>
                                                <c:if test="${!i.last}">
                                                    <div class="plus"></div>
                                                </c:if>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="box_r zuhe_List combos${combo.comboId} zuhe_List" style="${!s.first?'display:none;':''}">
                                <div class="r_text">套餐价格：<span style=" color:#ed1f23; font-size:18px;"><i style="font-family:'微软雅黑'">￥</i>${combo.price}</span></div>
                                <div class="r_price">
                                    为您节省：<span style=" color:#ed1f23; font-size:18px;"><i>￥</i>${combo.saveMoney}</span>
                                </div>
                                <div class="r_btn"><a href="javascript:" class="combo_addcart" skuid="${combo.comboId}" handler="combo" carttype="normal" num="1">购买组合</a></div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
            <%--同类商品--%>
        <div class="m1_r">
            <div class="r_box proCarousel">
                <ul style="width: 160px;">
                    <c:forEach items="${similarProducts}" var="phoneList" varStatus="s" end="10">
                        <li class="b_info">
                            <div class="i_pic">
                                <a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="${phoneList.name}">
                                    <img src="${empty phoneList.images ? phoneList.defaultImage['160X160'] : phoneList.images[0]['160X160']}" alt="${phoneList.name}"/>
                                </a>
                            </div>
                            <div class="i_title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="">${phoneList.name}</a></div>
                            <div class="i_price"><i>￥</i><fmt:formatNumber value="${phoneList.price.unitPrice}" type="number" pattern="#0.00#"/></div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="up"><a href="javascript:" class="turnRCarousel"></a></div>
            <div class="down"><a href="javascript:" class="turnLCarousel"></a></div>
        </div>

    </div>
    <!--end details_m1-->

    <!--details_m2-->
    <div class="details_m2">
            <%--左边公共部分--%>
        <div class="m2_l">
            <div class="l_box01">
                <div class="b_layer">店铺信息</div>
                <div class="b_rows">
                    <div class="r_title">
                            <%--取二级域名--%>
                            <%--<c:choose>--%>
                            <%--<c:when test="${not empty shopInf.subDomain}">--%>
                            <%--<c:set var="shopUrl" value="http://${shopInf.subDomain}.bdwmall.com"></c:set>--%>
                            <%--<a href="${shopUrl}" title="${shopInf.shopNm}" target="_blank">--%>
                            <%--${fn:substring(shopInf.shopNm,0,16)}--%>
                            <%--</a>--%>
                            <%--</c:when>--%>
                            <%--<c:otherwise>--%>
                            <%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" title="${shopInf.shopNm}" target="_blank">--%>
                            <%--${fn:substring(shopInf.shopNm,0,16)}--%>
                            <%--</a>--%>
                            <%--</c:otherwise>--%>
                            <%--</c:choose>--%>
                        <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" title="${shopInf.shopNm}" target="_blank">
                                ${fn:substring(shopInf.shopNm,0,16)}
                        </a>
                    </div>
                    <div class="r_zs"><img src="${shopInf.shopLevel.levelIcon['']}" <%--width="15" height="15"--%>/></div>
                </div>
                <div class="b_rows">
                    <div class="r_text">开店日期：${shopInf.startDateString}</div>
                    <div class="r_text">商品数量：${shopInf.productTotalCount}款</div>
                </div>
                <div class="b_rows">
                    <div class="r_item">
                        <div class="item_lable">描述相符：</div>
                        <div class="item_xin">
                            <c:forEach begin="1" end="${shopInf.shopRatingAvgVo.productDescrSame}">
                                <i></i>
                            </c:forEach>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="r_item">
                        <div class="item_lable">服务态度：</div>
                        <div class="item_xin">
                            <c:forEach begin="1" end="${shopInf.shopRatingAvgVo.sellerServiceAttitude}">
                                <i></i>
                            </c:forEach>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="r_item" style=" margin-bottom:0;">
                        <div class="item_lable">发货速度：</div>
                        <div class="item_xin">
                            <c:forEach begin="1" end="${shopInf.shopRatingAvgVo.sellerSendOutSpeed}">
                                <i></i>
                            </c:forEach>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="b_rows">
                    <div class="r_item" style=" margin-bottom:5px;">
                        <div class="item_lable" style="margin-top:5px;">联系客服：</div>
                        <div class="item_btn">
                                <%--<c:forEach items="${shopInf.csadInfList}" var="csadInf" varStatus="i">--%>
                                <%--<a style="${i.first?'':'margin-left: 60px;margin-top: 5px;'}" class="qq" href="http://wpa.qq.com/msgrd?v=3&amp;uin=${csadInf}&amp;site=qq&amp;menu=yes" target="_blank">在线客服</a>--%>
                                <%--</c:forEach>--%>

                            <c:choose>
                                <c:when test="${not empty shopInf.companyQqUrl}">
                                    <a href="${shopInf.companyQqUrl}" target="_blank">
                                        <img src="${webRoot}/template/bdw/statics/images/qq.png"/>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${shopInf.csadInfList}" var="caadInf" end="0">
                                        <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${caadInf}&amp;site=qq&amp;menu=yes" target="_blank">
                                            <img src="${webRoot}/template/bdw/statics/images/qq.png"/>
                                        </a>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <div class="clear"></div>
                    </div>
                    <c:if test="${not empty shopInf.qRCodeFileId}">
                        <div class="r_item" style=" margin-bottom:5px;">
                            <div class="item_lable" style="margin-top:5px;">店家微信：</div>
                            <div class="item_btn">
                                <a href="javascript:" ><img src="${webRoot}/template/bdw/statics/images/weixin001.png" width="30px" id="qrCode" onmouseover="show()"/></a>
                                <div  id="bigQrCode" style="display:none;width: 200px;height: auto;" onmouseout="hide()" >
                                    <img src="${shopInf.qrDefaultImage}" width="200" height="200"/>
                                    <span id="qrTips">打开微信扫一扫，添加商家个人微信</span>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:if>
                    <c:choose>
                        <c:when test="${empty shopInf.tel}">
                            <div class="r_text" style="margin-bottom:5px;" title="${shopInf.mobile}">联系电话：${shopInf.mobile}</div>
                        </c:when>
                        <c:otherwise>
                            <div class="r_text" style="margin-bottom:5px;" title="${shopInf.tel}">联系电话：${shopInf.tel}</div>
                        </c:otherwise>
                    </c:choose>
                    <div class="r_text" style="margin-bottom:5px;" title="${shopInf.csadOnlineDescr}">工作时间：${shopInf.csadOnlineDescr}</div>
                    <div class="r_item">
                        <div class="item_lable">认证信息：</div>
                        <c:forEach items="${shopInf.shopAttesation}" var="shopAttesations">
                            <div class="item_rz" style="background: url('${shopAttesations.logo['20X20']}') no-repeat scroll 0 0;background-size:15px 15px;"></div>
                        </c:forEach>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="sc">
                    <c:set value="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" var="shopUrl"/>
                    <a id="shopCollect" <c:if test="${productProxy.shopCollect}">class="cur"</c:if> title="${sdk:getSysParamValue('webName')}-${shopInf.shopNm}" href="javascript:" onClick="CollectShop(${shopInf.shopInfId})" class="sc">收藏本店</a>
                </div>
            </div>
            <c:import url="/template/bdw/module/common/productLeft.jsp?p=detail"/>
        </div>
        <div class="m2_r">
            <ul class="minute_menu">
                <li><a class="desc cur" href="javascript:" rel="1">商品详情</a></li>
                <li><a class="desc" href="javascript:" rel="2">包装清单</a></li>
                <li><a class="desc" href="javascript:" rel="3">售后服务</a></li>
                <li style="width:120px;"><a class="desc desc4" rel="4" href="javascript:" style="width:120px;">客户评论（<i>${commentStatistics.total}</i>）</a></li>
                <li><a class="desc" href="javascript:" rel="5">售前咨询</a></li>
                    <%--判断商铺类型为门店时才显示商品溯源信息--%>
                <c:if test="${shopInf.shopType eq '0' && not empty productSourceProxy.sourceCont}"><li><a class="desc" href="javascript:" rel="6">商品溯源</a></li></c:if>
                <div class="clear"></div>
            </ul>

            <div class="r_infobox infobox1">
                <c:if test="${not empty attrGroupProxyList}">
                    <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                        <%--2016年9月8日 属性组的标题不显示--%>
                        <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                            <ul class="b_info">
                                    <%-- <p>${attrGroupProxy.attrGroupNm}</p>--%>
                                <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                                    <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                        <li>
                                                ${attrDict.name}：
                                            <c:if test="${!empty attrGroupProxy.dicValueMap}">
                                                ${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}
                                            </c:if>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <div class="clear"></div>
                            </ul>
                        </c:if>
                    </c:forEach>
                </c:if>
                <div class="b_adv">${not empty productProxy.description ? (productProxy.description) : ''}</div>
            </div>

            <div class="r_infobox infobox2" style="display: none;">
                <div class="textbox">
                    <pre>${not empty productProxy.packingList ? (productProxy.packingList) : ''}</pre>
                </div>
            </div>

            <div class="r_infobox infobox3" style="display: none;">
                <div class="textbox">
                    <pre>${not empty productProxy.afterSaleService ? (productProxy.afterSaleService) : ''}</pre>
                </div>
            </div>

            <div class="r_infobox infobox4" id="commentInfoBox" style="display: none;">
                <div class="grade">
                    <div class="grade-box">
                        <div class="g-b-l">
                            <h3>${commentStatistics.average}</h3>

                            <p>共${productProxy.commentQuantity}人评论</p>
                        </div>
                        <div class="g-b-m">
                            <div class="rows">
                                好评：<span class="bar">
                                <span style="width:${productProxy.goodRate}" class="in"></span>
                            </span>
                                <i>${productProxy.goodRate}</i>
                            </div>
                            <div class="rows">
                                中评：<span class="bar">
                                <span style="width:${productProxy.normalRate}" class="in"></span>
                            </span>
                                <i>${productProxy.normalRate}</i>
                            </div>
                            <div class="rows">
                                差评：<span class="bar">
                            <span style="width:${productProxy.badRate}" class="in"></span>
                         </span>
                                <i>${productProxy.badRate}</i>
                            </div>
                        </div>
                        <div class="g-b-r">
                                <%--<p>评论获积分</p>--%>

                                <%--<div class="r-text">已购买过本产品的会员发表商品评价，获得积分奖励。</div>--%>
                            <div class="mygrade">
                                <a style="float:left;" href="javascript:void(0);" id="isAllowComment" title="发表商品评论">发表评论</a>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div id="commentBox"></div>
                        <%--分页 start--%>
                        <%--<div class="num page">
                            <div style="float: right;">
                                <c:if test="${commentProxyPage.lastPageNumber>1}">
                                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${commentProxyPage.lastPageNumber}' currentPage='${_page}' totalRecords='${commentProxyPage.totalCount}' ajaxUrl='${webRoot}/product.ac' frontPath='${webRoot}' displayNum='6'/>
                                </c:if>
                            </div>
                        </div>--%>

                    <div class="clear"></div>
                </div>
            </div>

            <div class="r_infobox infobox5" style="display: none;">
                <div class="fault-bg">
                    <div class="fault">
                        <div class="l"></div>
                        <div class="r">声明：您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，我们有专人进行回复！因厂家随时会更改一些产品的包装、颜色、产地等参数，所以该回复仅在当时对提问者有效！咨询回复的工作时间为：${shopInf.csadOnlineDescr}，请耐心等待工作人员回复。</div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="advice-box">
                    <div id="buyConsultBox"></div>
                    <div class="fb_box">
                        <div class="fbzx">发表咨询：</div>
                        <textarea class="te" id="consultCont" name="consultCont" cols="112" rows="" onfocus="var v = $(this).val();if('请输入咨询内容'==v){$(this).val('')}">请输入咨询内容</textarea>

                        <div class="tj">
                            <c:choose>
                                <c:when test="${empty loginUser}">
                                    <div class="tj_r">
                                        <a href="${webRoot}/login.ac" title="登录" style="color: #FF6600;">请登陆</a>后提交咨询！
                                        <a href="${webRoot}/register.ac" title="注册新账户">注册新用户</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="tj_btn"><a href="javascript:void(0);" id="addConsultCont">提交咨询</a></div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
                <%--判断商铺类型为门店(0)并且查找出来的对象不为空--%>
            <c:if test="${shopInf.shopType eq '0' && not empty productSourceProxy}">
                <div class="r_infobox infobox6" style="display: none;">
                    <div class="b_adv">${productSourceProxy.sourceCont}</div>
                </div>
            </c:if>
        </div>
        <div class="clear"></div>
    </div>
    <!--end details_m2-->
</div>

    <%--配送区域弹出层--%>
<div class="zoneLimit" id="zoneLimit" style="display: none;">
    <div class="e-tit">
        <h3>可配送区域</h3>
    </div>
    <div class="e-con">
        <ul>
            <c:forEach items="${productProxy.supportZoneStringList}" var="zoneValueString">
                <li>${zoneValueString}</li>
            </c:forEach>
        </ul>
    </div>
</div>


<!--请选择配送地址-->
<div class="overlay" style="display: none;" id="selectMap">
    <div class="store-box">
        <div class="box-top">
            <div class="search">
                <div class="form">
                    <div class="search-sel">
                        <span><a class="city-toggle" id="city-toggle" href="javascript:void(0);" style="color: #E5151F;"></a></span>
                        <div style="display: none;" class="city-box city-dropdown">
                            <div class="box-mod">
                                <label>请选择您所在的城市</label>
                                <em><a href="javascript:void(0);">选城市</a> > 定位置 > 购买商品</em>
                            </div>
                            <div class="box-bot">
                                <div class="bot-sc">
                                    <i>猜你在</i>
                                    <div class="ct g-city"></div>
                                    <div class="sc-cont">
                                        <input type="text" id="cityToggle" autocomplete="off" value="" placeholder="请输入城市或城市首字母">
                                        <a href="javascript:void(0);" id="se" class="sc-btn"></a>
                                    </div>
                                </div>
                                <div class="bot-ct">
                                    <c:forEach items="${zones}" var="zone">
                                        <div class="ct-item">
                                            <div class="rank">${zone.key}</div>
                                            <ul>
                                                <c:forEach items="${zone.value}" var="city">
                                                    <li> <a class="city city-item" cm="${city.name}" zoneId="${city.zoneId}" spell="${city.spell}" href="javascript:">${city.name}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="text" autocomplete="off" id="keyword" placeholder="请输入您要配送的地址" style="padding-left: 10px;">
                    <a href="javascript:void(0);" id="search" class="search-btn">搜索</a>
                </div>
                    <%--根据输入地址筛选出的地址列表--%>
                <div class="search-box" id="cityBox">
                    <ul id="search-result"></ul>
                </div>
            </div>
            <div class="sel-addr"><a href="javascript:void(0);" id="selectAddr">选择配送地址</a></div>
            <a href="javascript:void(0);" class="close-btn" id="closeMap">&times;</a>
        </div>
        <div class="box-cont">
            <div class="bot-lt" id="storeList">
                <c:set var="total" value="${fn:length(productProxyList)}"/>
                <div class="lt-th">
                    共<span>&nbsp;${total}&nbsp;</span>家门店
                </div>
                <div class="lt-td">
                    <div class="lt-td">
                        <c:forEach items="${productProxyList}" var="productProxy" varStatus="s">
                            <div class="td-item">
                                <a href="${webRoot}/citySend/storeDetail.ac?orgId=${productProxy.sysOrgId}" class="title">${productProxy.shopName}</a>
                                <p>${productProxy.storeAddress}</p>
                                <div class="num">
                                    <span>库存</span>
                                    <em>${productProxy.totalStockNum}</em>
                                    <span>配送费</span>
                                    <em>${productProxy.minFee}</em>
                                </div>
                                <div class="rank">${s.count}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="bot-rt">
                <div id="productDetailMap" style="width:1160px;height: 700px;"></div>
            </div>
        </div>
    </div>
</div>


<!--请选择配送地址-->
<div class="addressOverlay" style="display: none;" id="addressLayer">
    <div class="add-box">
        <div class="mt">
            <span>请选择配送地址</span>
            <a href="javascript:void(0);" class="close" id="closeAddrLayer">&times;</a>
        </div>
        <div class="mc">
            <c:if test="${not empty loginUser.addr}">
                <div class="mc-top">
                    <ul id="addressList">
                        <c:forEach items="${loginUser.addr}" var="userAddr">
                            <li class="cur">
                                <span class="elli"><em>${userAddr.addressPath}</em>${userAddr.addressStr}</span>
                                <a addr="${userAddr.addressPath}${userAddr.addressStr}" lat="${userAddr.lat}" lng="${userAddr.lng}" class="btn btn-org" href="javascript:" title="选择">选择</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
        </div>
    </div>
</div>


<!--end details_index-->
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1338866268911669" charset="utf-8"></script>
    <%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
    <%--页脚结束--%>
</body>
</html>

