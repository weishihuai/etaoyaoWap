<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:set value="${sdk:getShopCategoryProxy(param.shopId)}" var="shopCategory"/>
<script type="application/javascript">
    $(document).ready(function () {
        $(".shopRow").click(function () {
            var rel = $(this).attr("rel");
            var m = $(this).parent();
            $(".b_itembox").find(".item").removeClass("cur");
            if ("N" == rel) {
                m.addClass("cur");
                $(this).attr("rel", "Y");
            } else {
                m.removeClass("cur");
                $(this).attr("rel", "N");
            }
        });
    });
</script>

<div class="m2_l">
    <div class="l_box01">
        <div class="b_layer">商家信息</div>
        <div class="b_rows">
            <div class="r_title"><%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shop.shopInfId}" target="_blank">${shop.shopNm}</a>--%>
                <%--<c:choose>--%>
                    <%--<c:when test="${not empty shop.subDomain}">--%>
                        <%--<c:set var="shopUrl" value="http://${shop.subDomain}.bdwmall.com"></c:set>--%>
                        <%--<a href="${shopUrl}" title="${shopInf.shopNm}" target="_blank">--%>
                                <%--${shop.shopNm}--%>
                        <%--</a>--%>
                    <%--</c:when>--%>
                    <%--<c:otherwise>--%>
                        <%--<a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shop.shopInfId}" title="${shopInf.shopNm}" target="_blank">--%>
                                <%--${shop.shopNm}--%>
                        <%--</a>--%>
                    <%--</c:otherwise>--%>
                <%--</c:choose>--%>
                <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shop.shopInfId}" title="${shop.shopNm}" target="_blank">
                    ${shop.shopNm}
                </a>
            </div>
            <div class="r_zs"><a href="javascript:void(0);"><img src="${shop.shopLevel.levelIcon['']}" height="16px"/></a></div>
        </div>
        <div class="b_rows">
            <div class="r_text"><a>开店日期：${shop.startDateString}</a></div>
            <div class="r_text"><a>商品数量：${shop.shopProductTotal}款</a></div>
            <c:if test="${not empty shop.shopAddr}">
                <div class="r_text1">
                    <a>商家店址：${shop.shopAddr}</a>
                </div>
            </c:if>
        </div>
        <div class="b_rows">
            <div class="r_item">
                <div class="item_lable" style="width: 175px;">描述相符：
                    <fmt:formatNumber value="${shop.shopRatingAvgVo.productDescrSame}" type="number" pattern="#0" var="productDescrSame"/>
                    <c:choose>
                        <c:when test="${productDescrSame!=0}">
                            <c:forEach begin="1" end="${productDescrSame}">
                                <img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif"/>
                            </c:forEach>
                        </c:when>
                        <%--<c:otherwise><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG02.gif"/></c:otherwise>--%>
                    </c:choose>
                </div>
            </div>
            <div class="r_item">
                <div class="item_lable" style="width: 175px;">服务态度：
                    <fmt:formatNumber value="${shop.shopRatingAvgVo.sellerServiceAttitude}" type="number" pattern="#0" var="sellerServiceAttitude"/>
                    <c:choose>
                        <c:when test="${sellerServiceAttitude!=0}">
                            <c:forEach begin="1" end="${sellerServiceAttitude}">
                                <img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif"/>
                            </c:forEach>
                        </c:when>
                        <%--<c:otherwise><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG02.gif"/></c:otherwise>--%>
                    </c:choose>
                </div>
            </div>
            <div style=" margin-bottom:0;" class="r_item">
                <div class="item_lable" style="width: 175px;">发货速度：
                    <fmt:formatNumber value="${shop.shopRatingAvgVo.sellerSendOutSpeed}" type="number" pattern="#0" var="sellerSendOutSpeed"/>
                    <c:choose>
                        <c:when test="${sellerSendOutSpeed!=0}">
                            <c:forEach begin="1" end="${sellerSendOutSpeed}">
                                <img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif"/>
                            </c:forEach>
                        </c:when>
                        <%--<c:otherwise><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG02.gif"/></c:otherwise>--%>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="b_rows">
            <div style=" margin-bottom:5px;" class="r_item">
                <div style="margin-top:5px;" class="item_lable">联系客服：</div>
                <!--联系客服没内容-->
                <div class="item_btn">
                    <%--<c:set value="${sdk:getShopInfProxyById(shop.shopInfId).csadInfList}" var="csadInfList"/>--%>
                    <c:choose>
                        <c:when test="${not empty shop.companyQqUrl}">
                            <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${shop.companyQqUrl}&amp;site=qq&amp;menu=yes" target="_blank">
                                <img src="${webRoot}/template/bdw/statics/images/qq.png"/>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${shop.csadInfList}" var="caadInf" end="0">
                                <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${caadInf}&amp;site=qq&amp;menu=yes" target="_blank">
                                    <img src="${webRoot}/template/bdw/statics/images/qq.png"/>
                                </a>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="clear"></div>
            </div>
            <c:if test="${not empty shop.qRCodeFileId}">
                <div class="r_item" style=" margin-bottom:5px;">
                    <div class="item_lable" style="margin-top:5px;">店家微信：</div>
                    <div class="item_btn">
                        <a href="javascript:" ><img src="${webRoot}/template/bdw/statics/images/weixin001.png" width="30px" id="qrCode" onmouseover="show()"/></a>
                        <div  id="bigQrCode" style="display:none;width: 200px;height: auto;" onmouseout="hide()" >
                            <img src="${shop.qrDefaultImage}" width="200" height="200"/>
                            <span id="qrTips">打开微信扫一扫，添加商家个人微信</span>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
            <c:choose>
                <c:when test="${not empty shop.tel}">
                    <div class="r_text" style="margin-bottom:5px;" title="${shop.tel}">联系电话：${shop.tel}</div>
                </c:when>
                <c:when test="${not empty shop.mobile}">
                    <div class="r_text" style="margin-bottom:5px;" title="${shop.mobile}">联系电话：${shop.mobile}</div>
                </c:when>
                <c:when test="${not empty shop.ceoMobile}">
                    <div class="r_text" style="margin-bottom:5px;" title="${shop.ceoMobile}">联系电话：${shop.ceoMobile}</div>
                </c:when>
            </c:choose>
            <div style=" margin-bottom:5px;" class="r_text">工作时间：${shop.csadOnlineDescr}</div>
            <div class="r_item">
                <div class="item_lable">认证信息：</div>
                <div class="item_rz" style="width: 120px">
                    <c:set value="${sdk:getShopAttestations(shop.shopInfId)}" var="shopAttestations"/>
                    <c:if test="${not empty shopAttestations}">
                        <c:forEach items="${shopAttestations}" var="attestations">
                            <a style="width: 20px;height: 20px;" href="javascript:void(0);" title="${attestations.attestationName}"><img src="${attestations.logo[""]}"/></a>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <div class="sc">
            <c:set value="${requestAddr}/shopTemplate/default/shopIndex.ac?shopId=${shop.shopInfId}" var="shopUrl"/>
            <a id="shopCollect" <c:if test="${shop.shopCollect}">class="cur"</c:if> href="javascript:" onclick="CollectShop(${shop.shopInfId})">收藏此店</a>
        </div>
    </div>

    <!--end 商品信息-->
    <!--店内搜索-->
    <div class="l_box01">
        <div class="b_layer">店内搜索</div>
        <div class="b_rows" style="border-bottom:none;">
            <form id="searchShopFormLeft" action="${webRoot}/shopTemplate/default/shopProductList.ac" method="get">
                <div class="r_item" style=" margin-bottom:5px;">
                    <div class="item_lable" style="margin-top:5px; width:48px;">关键字：</div>
                    <input type="text" class="put" name="keyword" id="left_keyword" value="${param.keyword}"/>
                    <input type="hidden" name="shopId" value="${shop.shopInfId}"/>

                    <div class="clear"></div>
                </div>
                <div class="r_item" style=" margin-bottom:5px;">
                    <div class="item_lable" style="margin-top:5px; width:48px;letter-spacing:2px;">价格：</div>
                    <input type="text" class="put" style="width:48px;" id="left_minPrice" name="minPrice" value="${param.minPrice}"/>

                    <div class="item_lable" style="margin-top:5px; width:25px; text-align:center;">到</div>
                    <input type="text" class="put" style="width:48px;" id="left_maxPrice" name="maxPrice" value="${param.maxPrice}"/>

                    <div class="clear"></div>
                </div>
                <div class="dp_search"><a href="javascript:" id="shopLeftMenuSearch">搜索</a></div>
                <div class="clear"></div>
            </form>
        </div>
    </div>
    <!--end 店内搜索-->
    <!--店内分类-->
    <div class="l_box01" style="border-bottom:none;">
        <div class="b_layer">店铺分类</div>
        <div class="b_itembox">
            <c:forEach items="${shopCategory.children}" var="children" varStatus="s">
                <div class="item">
                    <a href="javascript:" class="it-icon shopRow" rel="N"></a>
                    <a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopCategoryId=${children.categoryId}&shopId=${param.shopId}">${children.name}</a>
                    <ul>
                        <c:forEach items="${children.children}" var="childrenC">
                            <li>
                                <a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopCategoryId=${childrenC.categoryId}&shopId=${param.shopId}">${childrenC.name}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--end 店铺分类-->

    <!--热卖推荐-->
    <c:if test="${param.p=='shopIndex'}">
        <div class="l_box01">
            <div class="b_layer shopEdit" shopInfo="shop_last_ZuoXia_Title">
                <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_last_ZuoXia_Title').links}" var="pageLinks" end="0" varStatus="s">
                    <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                </c:forEach>
            </div>

            <div class="b_list  shopEdit" shopInfo="shop_last_ZuoXia_recommend" style="width:198px;height: 547px;">
                <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_last_ZuoXia_recommend').recommendProducts}" var="prd" end="1">
                    <ul class="l_info">
                        <li class="i_pic"><a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X160'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a></li>
                        <li class="i_title"><a href="${webRoot}/product-${prd.productId}.html" target="_blank" title="${prd.name}"> ${fn:substring(prd.name,0,40)}<span>${prd.salePoint}</span></a></li>
                        <li class="i_price">
                            <i>￥</i><fmt:formatNumber value="${prd.price.unitPrice}" type="number" pattern="#0.00#"/>
                        </li>

                    </ul>
                </c:forEach>
            </div>

        </div>
    </c:if>
    <!--end 热卖推荐-->

    <%--<div class="l_adv shopEdit" shopInfo="shop_last_ZuoXia_recommend" style="width:200px;height: 300px;">
        <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_last_ZuoXia_recommend').recommendProducts}" var="prd" end="0">
            <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank">
                <img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['200X300'] : prd.images[0]['200X300']}" width="200px" height="300px"/>
            </a>
        </c:forEach>
    </div>--%>
</div>
