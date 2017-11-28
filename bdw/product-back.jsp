<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
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
<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.id,10)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>
<%--商品咨询--%>
<c:set var="buyConsultProxys" value="${sdk:findBuyConsultByProductId(param.id,10)}"/>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="specList" value="${productProxy.productUserSpecProxyList}"/>
<%--店铺信息--%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>
<c:set value="${sdk:getShopUser(productProxy.shopInfId)}" var="shopUser"/>
<%--保存商品到cookie--%>
<c:set value="${sdk:saveProductToCookie(productProxy.productId,pageContext.request,pageContext.response)}" var="saveProductToCookie"/>
<jsp:useBean id="systemTime" class="java.util.Date" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${webName}-${empty productProxy.metaTitle ? productProxy.name : productProxy.metaTitle}</title>
    <meta name="keywords" content="${productProxy.metaKeywords}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${productProxy.metaDescr}-${webName}" /> <%--SEO description优化--%>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/newdetail.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/jquery.jqzoom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jqzoom-core.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/scrollTop.js"></script>
    <script type="text/javascript">
        var skuData = eval('${productProxy.skuJsonData}');
        var userSpecData = eval('${productProxy.userSpecJsonData}');
        var isCanBuy = eval('${productProxy.isCanBuy}');
        var isShowProductInf ="${shopInf.isFreeze}";
        var supportZoneIds=new Array();
        <c:forEach items="${productProxy.supportZoneIds}" var="zoneId" varStatus="s">
        supportZoneIds[${s.index}]=${zoneId};
        </c:forEach>
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}",productCollectCount:"${loginUser.productCollectCount}",goBox:"${param.goBox}",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"};

        $(document).ready(function(){
            //加载联动地址栏
            $(".addressSelect").ld(
                    {ajaxOptions : {"url" : webPath.webRoot+"/member/addressBook.json"},
                        defaultParentId:9,
                        style:{"width": 70}
                    });
            $(".hoverT2").hover(function(){
                $(this).css("border","1px solid #DF9A07");
            },function(){
                $(this).css("border","1px solid #e3e3e3");
            })
        });

        function selectZoneChange (){
            var zoneId = $("#city").val();
            var isSupport = false;
            for(var i=0;i<supportZoneIds.length;i++){
                if(supportZoneIds[i]==zoneId){
                    var isSupport = true;
                }
            }

            if(!isSupport){
                $(".addcart").hide();
                $("#support").show();
            }else{
                $(".addcart").show();
                $("#support").hide();
            }
        }
        $(function(){
            $(".simple").scrollTop1();
            var simple = $("#goTopBtn22");
//            window.onscroll=function(){
////                document.documentElement.scrollTop>0?$("#goTopBtn").css("display",""):$("#goTopBtn").css("display","none");
//                if(document.documentElement.scrollTop>0){
//                    $("#goTopBtn22").css("display","");
//                }else{
//                    $("#goTopBtn22").css("display","none");
//                }
//            }
            var $backToTopFun = function() {
                var st = $(document).scrollTop(), winh = document.documentElement.clientHeight;
                //IE6下的定位
                if (!window.XMLHttpRequest) {
                    simple.css("top", st + winh - 400);
                }
//            $(".backToTop").css("top", (document.documentElement.clientHeight - $backToTopEle.css("height").split("px")[0])/2);
                if(st == 0){
                    simple.hide();
                }else{
                    simple.show();
                }
            };
            $(window).bind("scroll", $backToTopFun);
        });
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/comment.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/product.js"></script>
</head>


<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=detail"/>
<%--页头结束--%>

<div id="position"><a href="${webRoot}/index.html">首页</a> >
    <c:forEach items="${categoryProxy.categoryTree}" var="category" varStatus="stats" begin="1">
        <c:choose>
            <c:when test="${stats.last}">
                ${category.name}
            </c:when>
            <c:otherwise>
                <a href="${webRoot}/productlist-${category.categoryId}.html" title="${category.name}">${category.name}</a> >
            </c:otherwise>
        </c:choose>
    </c:forEach>
</div>


<div id="detail">
<div class="toolabsolute">
    <div class="float: left;margin-right: 10px;width: 200px;"></div>
    <div id="floatMenu"></div>
</div>
<div class="pro-item-part1">
<div class="l">
    <div class="photo"><a href="${productProxy.defaultImage['600X600']}" class="jqzoom" rel='gal1'
                          title="${productProxy.name}"><img id="bigsrc" src="${productProxy.defaultImage['360X360']}" style="width:360px; height:360px;"/></a></div>
    <div class="b">
        <div class="trunL" id="mycarousel-prev"><a></a></div>
        <div class="sorllBox">
            <div class="sorll" id="mycarousel">
                <ul>
                    <c:forEach varStatus="s" items="${productProxy.images}" var="image">
                        <li>
                            <a rel="{gallery: 'gal1',smallimage: '${image['360X360']}',largeimage: '${image['600X600']}'}"
                               class="" href="javascript:;" picId="${image}" displayImage="${image['360X360']}" ><img src="${image['50X50']}"/></a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="trunR" id="mycarousel-next"><a class="empty"></a></div>
        <div class="clear"></div>
    </div>
    <div class="getTo">
        <div id="ckepop">
            <span class="jiathis_txt">分享到：</span>
            <a class="jiathis_button_qzone"></a>
            <a class="jiathis_button_tsina"></a>
            <a class="jiathis_button_tqq"></a>
            <a class="jiathis_button_renren"></a>
            <a class="jiathis_button_kaixin001"></a>
            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
            <a class="jiathis_counter_style"></a>
        </div>
        <span>0</span>
        <a href="javascript:;" id="AddTomyLikeBtn"><img src="${webRoot}/template/bdw/statics/images/detail_add_obj.gif"> 收藏该商品</a>
    </div>
</div>
<div class="r">
    <h2>${productProxy.name}</h2>
    <h1>${productProxy.salePoint}</h1>
    <div class="t1">

        <div class="fixBox">
            <label>商品编码：</label>
            <div style="font-family: '微软雅黑';color: #333;line-height:18px;">${productProxy.productCode}</div>
            <div class="clear"></div>
        </div>
        <div class="fixBox">
            <label>市 场 价：</label>
            <div class="text"><b>${productProxy.marketPrice}</b></div>
            <div class="clear"></div>
        </div>
        <div class="fixBox">
            <label>销 售 价：</label>
            <div class="price" id="price"><b>${productProxy.priceListStr}</b> 元&nbsp;&nbsp;&nbsp;&nbsp;</div>
            <input type="hidden" id="priceListStr" priceNm="${productProxy.price.amountNm}" value="${productProxy.priceListStr}">
            <div class="clear"></div>
        </div>
        <%--<c:if test="${productProxy.isZoneLimit}">--%>
            <%--<div class="fixBox adr-rows">--%>
                <%--<label>送至：</label>--%>
                <%--<div class="info">--%>
                    <%--<div class="adr">请选择<span></span></div>--%>
                    <%--<div class="adr-text">下单即发货</div>--%>
                    <%--<div class="adr-box" style="display:none;">--%>
                        <%--<b class="adr-close">关闭</b>--%>
                        <%--<ul class="selectProvince">--%>
                            <%--<c:forEach items="${productProxy.supportZoneTree.children}" var="node">--%>
                                <%--<li><a href="javascript:void(0)" zoneId="${node.id}" class="${node.checked?'':'unSelect'}"  >${node.name}</a></li>--%>
                            <%--</c:forEach>--%>
                            <%--<div class="clear"></div>--%>
                        <%--</ul>--%>
                        <%--<ul class="selectCity">--%>
                            <%--<div style="border-top:1px solid #CCC; padding-top:5px;"></div>--%>
                        <%--</ul>--%>
                    <%--</div>--%>
                    <%--<div class="clear"></div>--%>
                <%--</div>--%>
                <%--<div class="clear"></div>--%>
            <%--</div>--%>
        <%--</c:if>--%>
        <div class="fixBox">
            <label>商品评分：</label>
            <div class="toTalk">
                <c:choose>
                    <c:when test="${productProxy.commentStatistics.average > 0}">
                        <c:forEach begin="1" end="${productProxy.commentStatistics.average}">
                            <img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" />
                        </c:forEach>
                        <a href="javascript:;" onclick="tabChance('.desc5','#commentBox');">(已有${productProxy.total}条评论)</a>
                    </c:when>
                    <c:otherwise>
                        <img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" /><img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" /><img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" /><img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" /><img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" />
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
        </div>
        <c:if test="${not empty productProxy.presentProductList}">
            <div class="fixBox">
                <label>单品赠品：</label>
                <div class="addThing">
                    <c:forEach items="${productProxy.presentProductList}" var="rule">
                        <a>${rule.productNm}</a>&nbsp;
                    </c:forEach>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
        <c:choose>
            <c:when test="${fn:length(productProxy.skus)==1 && productProxy.price.isSpecialPrice}">

                <div class="fixBox">
                    <label>特价时间：</label>

                    <div id="lesTime" class="lesTime">

                    </div>
                    <div class="clear"></div>
                </div>
                <script type="text/javascript">
                    $("#lesTime").imallCountdown("${productProxy.price.endTimeStr}","li",webPath.systemTime)
                </script>
            </c:when>
            <c:otherwise>
                <div class="fixBox" id="specialPrice" style="display: none">
                    <label>特价时间：</label>

                    <div id="lesTime" class="lesTime">

                    </div>
                    <div class="clear"></div>
                </div>
            </c:otherwise>
        </c:choose>
        <div class="fixBox">
            <label>服&nbsp;&nbsp;&nbsp;&nbsp;务：</label>
            <div class="text">此商品由
                <%--去二级域名--%>
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
                提供</div>
            <div class="clear"></div>
        </div>
        <%--<div class="fixBox">
            <label>温馨提示：</label>
            <div class="text"><em>本商品不能开具增值税发票（可开具普通发票）</em></div>
            <div class="clear"></div>
        </div>--%>
    </div>
    <div class="t2 hoverT2">
        <c:if test="${productProxy.isEnableMultiSpec=='Y'}">
            <c:forEach items="${specList}" var="spec">
                <div class="fixBox specSelect">
                    <label class="selSize">${spec.name}：</label>

                    <div class="${spec.specType eq '0'?'sizeSel':'coloSel'}">
                        <ul>
                            <c:forEach items="${spec.specValueProxyList}" var="specValue">
                                <li>
                                    <a title="${specValue.name}" href="javascript:;" data-value="${spec.specId}:${specValue.specValueId}">
                                        <c:if test="${spec.specType eq '0'}">${specValue.value}</c:if>
                                        <c:if test="${spec.specType eq '1'}"><img width='30' height='30' src="${specValue.value}" /></c:if>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:forEach>
        </c:if>
        <div class="fixBox">
            <label class="selSize2">购买数量：</label>
            <div class="muber">
                <div class="put"><input type="text" value="1" class="prd_num" maxlength="4"/></div>
                <div class="up"><a href="javascript:;" class="prd_addNum"><img src="${webRoot}/template/bdw/statics/images/detail_ico03.gif" /></a></div>
                <div class="down"><a href="javascript:;" class="prd_subNum"><img src="${webRoot}/template/bdw/statics/images/detail_ico04.gif" /></a></div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="sureBox">
            <c:choose>
                <c:when test="${productProxy.isCanBuy}">
                    <div class="AddTomyLike"><a class="addcart" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku" href="javascript:;"></a><c:if test="${productProxy.isZoneLimit}"><span id="support"  style="color: red;display: none;">很抱歉，该区域不支持配送！</span></c:if></div>
                </c:when>
                <c:otherwise>
                    <div class="quehuo"><a skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}" class="quehuobtn" href="javascript:;"><img src="${webRoot}/template/bdw/statics/images/quehuo.gif" alt=""></a></div>
                </c:otherwise>
            </c:choose>
            <div class="clear"></div>
        </div>

        <%--弹出层--%>
        <div class="addTobuyCarLayer" style="display:none; margin-top:-180px;">
            <div class="showTip">
                <div class="close"><a href="javascript:;" onclick="$('.addTobuyCarLayer').hide()"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
                <div class="succe">
                    <h3>商品已成功添加到购物车！</h3>

                    <div class="tips">购物车共有 <b class="cartnum"></b> 件商品，合计：<b class="cartprice"></b>元</div>
                    <div class="toBuy"><a href="${webRoot}/shoppingcart/cart.ac"><img src="${webRoot}/template/bdw/statics/images/detail_layerbTN.gif"/></a> <a href="javascript:;" onclick="$('.addTobuyCarLayer').hide()">再逛逛</a>
                    </div>
                </div>
            </div>
            <div class="rShaw"></div>
            <div class="clear"></div>
            <div class="bShaw"></div>
        </div>

        <div class="AddTomyLikeLayer" style="display:none; margin-top:-10px;">
            <div class="showTip">
                <div class="close"><a href="javascript:;" onclick="$('.AddTomyLikeLayer').hide()"><img src="${webRoot}/template/bdw/statics/images/detail_closeLayer.gif"/> 关闭</a></div>
                <div class="succe">
                    <h3>商品已成功收藏！</h3>
                    <div class="tips">已收藏 <b id="productCollectCount">${loginUser.productCollectCount}</b> 件商品。 <a href="${webRoot}/module/member/productCollection.ac?menuId=51553">查看收藏夹>></a></div>
                </div>
            </div>
            <div class="rShaw"></div>
            <div class="clear"></div>
            <div class="bShaw"></div>
        </div>
        <%--弹出层--%>
    </div>
</div>
<div class="r_info">
    <div class="title">E购物 · 正品保证</div>
    <div class="safText">
        <ul>
            <li><img src="${webRoot}/template/bdw/statics/images/detail_comp_ico01.gif" /><br />厂家直销<br />品质保证</li>
            <li><img src="${webRoot}/template/bdw/statics/images/detail_comp_ico02.gif" /><br />厂家保修<br />退换服务</li>
            <li><img src="${webRoot}/template/bdw/statics/images/detail_comp_ico03.gif" /><br />800城市<br />货到付款</li>
        </ul>
    </div>
    <div class="seEr">
        <p>卖    家：<a  href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank">${shopInf.shopNm}</a> </p>
        <%--
                    <p>服务评价：<img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG02.gif" /> 4.0分</p>
        --%>
        <p>描述相符：<span>
                <fmt:formatNumber value="${shopInf.shopRatingAvgVo.productDescrSame}" type="number" pattern="#0" var="productDescrSame" />
                <c:choose>
                    <c:when test="${productDescrSame!=0}">
                        <c:forEach begin="1" end ="${productDescrSame}">
                            <img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif" />
                        </c:forEach>
                    </c:when>
                    <c:otherwise><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG02.gif" /></c:otherwise>
                </c:choose>
            </span></p>
        <p>服务态度：<span>
                <fmt:formatNumber value="${shopInf.shopRatingAvgVo.sellerServiceAttitude}" type="number" pattern="#0" var="sellerServiceAttitude" />
                            <c:choose>
                                <c:when test="${sellerServiceAttitude!=0}">
                                    <c:forEach begin="1" end ="${sellerServiceAttitude}">
                                        <img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif" />
                                    </c:forEach>
                                </c:when>
                                <c:otherwise><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG02.gif" /></c:otherwise>
                            </c:choose>
            </span></p>
        <p>发货速度：<span>
                <fmt:formatNumber value="${shopInf.shopRatingAvgVo.sellerSendOutSpeed}" type="number" pattern="#0" var="sellerSendOutSpeed" />
                   <c:choose>
                       <c:when test="${sellerSendOutSpeed!=0}">
                           <c:forEach begin="1" end ="${sellerSendOutSpeed}">
                               <img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG01.gif" />
                           </c:forEach>
                       </c:when>
                       <c:otherwise><img src="${webRoot}/template/bdw/statics/images/detail_harld_IMG02.gif" /></c:otherwise>
                   </c:choose>
            </span></p>
    </div>
    <div class="contact">
        <c:forEach items="${shopInf.csadInfList}" var="csadInf">
            <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${csadInf}&amp;site=qq&amp;menu=yes" target="_blank"><img src="${webRoot}/template/bdw/statics/images/detail_contact_img01.gif" /></a>
        </c:forEach>
        <a class="inTo" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank"><img src="${webRoot}/template/bdw/statics/images/detail_contact_img02.gif" /></a></div>
</div>
<div class="clear"></div>
</div>
<div class="pro-item-part2">
<div class="l">
    <c:if test="${fn:length(categoryProxy.categoryTree) > 2}">
        <div class="m1">
            <div class="box">
                <c:forEach items="${categoryProxy.categoryTree[1].childrenOrSameLevel}" var="fatherCategory">
                    <h4>
                        <div class="tit"><a href="javascript:;">${fatherCategory.name}</a></div>
                        <div class="ico"><a href="javascript:;"><img rel="N"  src="${webRoot}/template/bdw/statics/images/list_mIco.gif" /></a></div>
                        <div class="clear"></div>
                    </h4>
                    <ul>
                        <c:forEach items="${fatherCategory.children}" var="childrenCategory">
                            <li><a href="${webRoot}/productlist-${childrenCategory.categoryId}.html" title="${childrenCategory.name}">${childrenCategory.name}</a></li>
                        </c:forEach>
                    </ul>
                </c:forEach>
            </div>
        </div>
    </c:if>
    <div class="m3" id="monthHotSales">
        <h1>销量排行榜</h1>
        <div class="box">
            <ul>
                <%--月排行--%>
                <c:set value="${sdk:findMonthTopProducts(1,9)}" var="hotsales"/>
                <c:forEach items="${hotsales}" var="phoneList" varStatus="s" end="10">
                    <li class="hover">
                        <div class="mB">${s.count}</div>
                        <div class="tit"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="">${phoneList.name}</a></div>
                        <div class="detaiF" style="display:none;">
                            <div class="pic"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="${phoneList.name}"><img src="${empty phoneList.images ? phoneList.defaultImage['52X52'] : phoneList.images[0]['52X52']}" alt="${phoneList.name}" /></a></div>
                            <div class="title"><a target="_blank" href="${webRoot}/product-${phoneList.productId}.html" title="">${phoneList.name}</a></div>
                            <div class="price">￥<fmt:formatNumber value="${phoneList.price.unitPrice}" type="number" pattern="#0.00#" /></div>
                            <div class="clear"></div>
                        </div>
                        <div class="clear"></div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <%--<div class="m4">
        <h3>
            <div class="tit">最近浏览过的商品</div>
            <div class="deleHistory"><a href="javascript:;" onclick="clearHistoryProductsCookie('#pro-history')">清空</a></div>
            <div class="clear"></div>
        </h3>
        <div class="box" id="pro-history">
            <c:set value="${sdk:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
            <c:choose>
                <c:when test="${not empty productFromCookies}">
                    <ul>
                        <c:forEach items="${productFromCookies}" var="proxy">
                            <li>
                                <div class="pic"><a href="${webRoot}/product-${proxy.productId}.html" title="${proxy.name}"><img src="${proxy.defaultImage["50X50"]}" alt="${proxy.name}"/></a></div>
                                <div class="title"><a href="${webRoot}/product-${proxy.productId}.html" title="${proxy.name}">${proxy.name}</a></div>
                                <div class="clear"></div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <ul><li style="text-align: center;">您还未浏览其它商品</li></ul>
                </c:otherwise>
            </c:choose>
        </div>
    </div>--%>
</div>
<div class="r">
<%--推荐搭配--%>
<c:if test="${not empty productProxy.referSkuList}">
    <div class="Combination">
        <input type="hidden" id="dapei_skuId" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.skus[0].skuId}</c:if>">
        <input type="hidden" id="dapei_skuprice" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.price.unitPrice}</c:if>">
        <div class="t_menu"><span>推荐搭配</span></div>
        <div class="lList" id="dapei">
            <div class="keyPortant">
                <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["120X120"]}" /></a></div>
                <div class="title"><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></div>
                <div class="price">销售价: <b>${productProxy.priceListStr}</b> 元</div>
                <p><a>请勾选配套商品>></a></p>
            </div>
            <div class="ico"><img src="${webRoot}/template/bdw/statics/images/detail_toAdd01.gif" /></div>
            <div class="addListSel">
                <ul id="referProductList" class="tuiJianDaPei">    <!-- ul.width= 134 * li(4)    -->
                    <c:forEach items="${productProxy.referSkuList}" var="prd">
                        <li class="tuijian">
                            <div class="pic"><a href="${webRoot}/product-${prd.productId}.html"><img src="${prd.defaultImage["120X120"]}" /></a></div>
                            <div class="title"><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></div>
                            <div class="price">销售价: <b>${prd.price.unitPrice}</b> 元</div>
                            <p><input name="" skuid="${prd.skus[0].skuId}"  type="checkbox" value="${prd.price.unitPrice}" /> 加入组合</p>
                        </li>
                    </c:forEach>
                </ul>
                <script type="text/javascript">
                    var referProductListNoCheck = function(){
                        $("#referProductList input[type='checkbox']").each(function(){
                            $(this).attr("checked",false);
                        });
                    }();
                </script>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="sub_all">搭配组合结算：主商品 <span>1</span> 件 | 组合 <span id="selectNum">0</span> 件&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总价：<b id="dapeiprice">￥0.0</b> <a class="batch_addcart" carttype="normal" handler="sku" href="javascript:;"><img src="${webRoot}/template/bdw/statics/images/detail_add_btn_sel.gif" /></a></div>
</c:if>

<%--套装搭配--%>
<c:if test="${not empty productProxy.referProductList}">
    <div class="Combination">
        <div class="t_menu"><span>套装搭配</span></div>
        <div class="lList">
            <div class="keyPortant">
                <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["120X120"]}" /></a></div>
                <div class="title"><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></div>
                <div class="price">销售价: <b>${productProxy.priceListStr}</b> 元</div>
                <p><a href="javascript:;">请配套商品>></a></p>
            </div>
            <div class="ico"><img src="${webRoot}/template/bdw/statics/images/detail_toAdd01.gif" /></div>
            <div class="addListSel">
                <ul id="referProductList" class="taoCanDabei">    <!-- ul.width= 134 * li(4)    -->
                    <c:forEach items="${productProxy.referProductList}" var="prd">
                        <li class="taocan">
                            <div class="pic"><a href="${webRoot}/product-${prd.productId}.html"><img src="${prd.defaultImage["120X120"]}" /></a></div>
                            <div class="title"><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></div>
                            <div class="price">销售价: <b>${prd.price.unitPrice}</b> 元</div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="sub_all"><a target="_blank" href="${webRoot}/productSet.ac?id=${productProxy.productId}"><img src="${webRoot}/template/bdw/statics/images/detail_add_btn_sel.gif" /></a></div>
</c:if>

<%--套餐组合--%>
<c:set value="${productProxy.combos}" var="combos"/>
<c:if test="${ not empty combos}">
    <div class="Combination">
        <div class="t_menu zuhe_menu">
            <c:forEach items="${combos}" var="combo" varStatus="s">
                <span class="<c:if test="${s.count==1}">cur</c:if>" style="float: left;margin-right: 2px;"><a href="javascript:void(0)" onclick="onTabSelect(${combo.comboId},this)" comboid="${combo.comboId}">${combo.title}</a> </span>
            </c:forEach>
        </div>
        <c:forEach items="${combos}" var="combo" varStatus="s">
            <div class="lList zuhe_List combos${combo.comboId}" id="combos${combo.comboId}"  style="<c:choose><c:when test="${s.first}">display: block</c:when><c:otherwise>display:none</c:otherwise></c:choose>">
                <div class="keyPortant">
                    <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["120X120"]}" /></a></div>
                    <div class="title"><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></div>
                    <div class="price">销售价: <b>${productProxy.priceListStr}</b> 元</div>
                    <p><a href="javascript:;">请配套商品>>></a></p>
                </div>


                <div class="ico" <c:if test="${!(fn:length(combo.skus)>1)}">style="display:none;"</c:if>><img src="${webRoot}/template/bdw/statics/images/detail_toAdd01.gif" /></div>

                <div class="addListSel">
                    <ul class="taocanZuHe" style="width: ${(fn:length(combo.skus) - 1)*170}px;">    <!-- ul.width= 134 * li(4)    -->
                        <c:forEach items="${combo.skus}" var="sku">
                            <c:if test="${productProxy.skus[0].skuId != sku.skuId}">
                                <li class="tcZuhe">
                                    <div class="pic"><a href="${webRoot}/product-${sku.productProxy.productId}.html"><img src="${sku.productProxy.defaultImage["120X120"]}" /></a></div>
                                    <div class="title"><a href="${webRoot}/product-${sku.productProxy.productId}.html">${sku.productProxy.name}</a></div>
                                    <div class="price">销售价: <b>${sku.price.unitPrice} × ${sku.amountNum}</b></div>
                                    <p><c:forEach items="${sku.specs}" var="spec"><b>${spec.spec}</b> </c:forEach></p>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
            <div class="sub_all combos${combo.comboId} zuhe_List" style="<c:choose><c:when test="${s.first}">display: block</c:when><c:otherwise>display:none</c:otherwise></c:choose>">
                <a href="javascript:;" class="combo_addcart" skuid="${combo.comboId}" handler="combo" carttype="normal" num="1">
                    <img src="${webRoot}/template/bdw/statics/images/detail_add_btn_sel.gif" />
                </a>
                <span style="font-size: 16px;">套餐价格：${combo.price}元，为您节省：${combo.saveMoney}元</span>
            </div>
        </c:forEach>
    </div>
</c:if>

<div class="m3">
    <div id="productMenu">
        <div id="detail_btn_addBuyCar">
            <div class="addBuyCar"><a class="addcart" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku" href="javascript:;"><img src="${webRoot}/template/bdw/statics/images/detail_btn_addBuyCar.gif" /></a></div>
            <div class="layout_BuyCar" style="display:none;">
                <div class="pic"><img src="${productProxy.defaultImage["120X120"]}" /></div>
                <div class="title">${productProxy.name}</br>${productProxy.salePoint}</div>
                <div class="price">销售价：<b>${productProxy.priceListStr}</b> 元</div>
                <div class="clear"></div>
            </div>
        </div>
        <div class="t_Menu">
            <ul>
                <li><a class="cur desc1" onclick="tabChance('.desc1','#description');" href="javascript:;">商品介绍</a></li>
                <li><a class="desc2" onclick="tabChance('.desc2','#attrGroupProxyList');" href="javascript:;">规格参数</a></li>
                <li><a class="desc3" onclick="tabChance('.desc3','#packingList');" href="javascript:;">包装清单</a></li>
                <li><a class="desc4" onclick="tabChance('.desc4','#afterSaleService');" href="javascript:;">售后保障</a></li>
                <li><a class="desc5" onclick="tabChance('.desc5','#description');" href="javascript:;">商品评价<span>(${commentStatistics.total})</span></a></li>
                <li><a class="desc6" onclick="tabChance('.desc6','#buyConsultBox');" href="javascript:;">售前咨询</a></li>
            </ul>
        </div>
    </div>
    <div class="menuBox box1" id="description" style="display: block;">
        ${not empty productProxy.description ? (productProxy.description) : ''}
    </div>
    <div class="menuBox box2" id="attrGroupProxyList" style="display: none;">
        <c:if test="${not empty attrGroupProxyList}">
            <table width="100%" border="0" cellspacing="0">
                <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy" >
                    <tr>
                        <td class="tit" colspan="2"><%--商品属性--%>${attrGroupProxy.attrGroupNm}</td>
                    </tr>
                    <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                        <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                            <tr>
                                <td class="labl">${attrDict.name}</td>
                                <td>
                                    <c:if test="${!empty attrGroupProxy.dicValueMap}">
                                        ${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}
                                    </c:if>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </table>
        </c:if>
    </div>
    <div class="menuBox box1" id="packingList" style="display: none;">
        <pre>${not empty productProxy.packingList ? (productProxy.packingList) : ''}</pre>
    </div>
    <div class="menuBox box1" id="afterSaleService" style="display: none;">
        <pre>${not empty productProxy.afterSaleService ? (productProxy.afterSaleService) : ''}</pre>
    </div>
    <div class="box_pl" id="commentBox">
        <c:choose>
            <c:when test="${commentStatistics.total == 0}">
                <div class="datShowBox">
                    <div class="shar">
                        <div class="hornot">
                            <div class="prod2">暂无评论</div>
                            <p><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></p>
                            <p>0人参与评分</p>
                        </div>
                        <div class="starShow">
                            <ul>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:0px;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">0</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:0px;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">0</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:0px;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">0</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:0px;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">0</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:0px;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">0</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                            </ul>
                        </div>
                        <div class="tips">
                            <p>我购买过该商品，我要评论此商品!</p>
                            <p>注：购买过此商品的用户才能进行评价。</p>
                            <div class="btn"><a href="javascript:void(0);" id="isAllowComment" title="发表商品评论"><img src="${webRoot}/template/bdw/statics/images/detail_sey_this_btn.gif" /></a>&nbsp;&nbsp;&nbsp;<a href="${webRoot}/comment/productComment.ac?id=${param.id}" title="查看全部商品评论" target="_blank">[查看所有评价]</a></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="datShowBox">
                    <div class="shar">
                        <div class="hornot">
                            <div class="prod2"><b>${commentStatistics.average}</b>分</div>
                            <p>
                                <c:choose>
                                    <c:when test="${commentStatistics.average le 2 && commentStatistics.average ge 1}">
                                        <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" />
                                    </c:when>
                                    <c:when test="${commentStatistics.average le 3 && commentStatistics.average ge 2}">
                                        <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" />
                                    </c:when>
                                    <c:when test="${commentStatistics.average le 4 && commentStatistics.average ge 3}">
                                        <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" />
                                    </c:when>
                                    <c:when test="${commentStatistics.average ge 4}">
                                        <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" />
                                    </c:when>
                                </c:choose>
                            </p>
                            <p>${commentStatistics.total}人参与评分</p>
                        </div>
                        <div class="starShow">
                            <ul>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:${commentStatistics.fiveStar}%;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">${commentStatistics.fiveStar}</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:${commentStatistics.fourStar}%;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">${commentStatistics.fourStar}</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:${commentStatistics.threeStar}%;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">${commentStatistics.threeStar}</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:${commentStatistics.twoStar}%;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">${commentStatistics.twoStar}</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <div class="star"><img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /><img src="${webRoot}/template/bdw/statics/images/detail_starIco02.gif" /></div>
                                    <div class="sorll"><div class="bg" style="display:block; width:${commentStatistics.oneStar}%;height: 100%;"></div>	<!-- 100%=200px 30%=60px  --></div>
                                    <div class="mub" style=" margin-left:0px;">${commentStatistics.oneStar}</div>	<!-- margin-left 30%=60px  -->
                                    <div class="clear"></div>
                                </li>
                            </ul>
                        </div>
                        <div class="tips">
                            <p>我购买过该商品，我要评论此商品!</p>
                            <p>注：购买过此商品的用户才能进行评价。</p>
                            <div class="btn"><a href="javascript:void(0);" id="isAllowComment" title="发表商品评论"><img src="${webRoot}/template/bdw/statics/images/detail_sey_this_btn.gif" /></a>&nbsp;&nbsp;&nbsp;<a href="${webRoot}/comment/productComment.ac?id=${param.id}" title="查看全部商品评论" target="_blank">[查看所有评价]</a></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="plList">
            <h2>客户评价</h2>
            <div class="box">
                <c:forEach items="${commentProxyResult}" var="commentProxy">
                    <div class="item">
                        <div class="messg">
                            <div class="t_are">
                            <span>${commentProxy.userName} &nbsp;&nbsp;评分
                                <c:forEach begin="1" end="${commentProxy.score}">
                                    <img src="${webRoot}/template/bdw/statics/images/detail_starIco.gif" />
                                </c:forEach>
                            </span>
                                <em>${commentProxy.createTimeString}</em>
                                <div class="clear"></div>
                            </div>
                            <div class="c_are">
                                <p>${commentProxy.content}</p>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<div class="menuBox" id="buyConsultBox" style="display: none;">
    <div class="box_zx">
        <div class="tip">声明：您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，我们有专人进行回复！因厂家随时会更改一些产品的包装、颜色、产地等参数，所以该回复仅在当时对提问者有效！咨询回复的工作时间为：周一至周五，9:00至18:00，请耐心等待工作人员回复。
            <br/>
            <a href="${webRoot}/comment/buyConsult.ac?id=${param.id}" title="查看全部商品咨询" target="_blank" style="color: #c00;">查看全部商品咨询>>></a>
        </div>
        <div class="askList">
            <c:forEach items="${buyConsultProxys.result}" var="buyConsultProxy">
                <div class="each">
                    <div class="fixBox">
                        <div class="question">${buyConsultProxy.userName}: ${buyConsultProxy.consultCont}</div>
                        <div class="time">${buyConsultProxy.consultTimeString}</div>
                        <div class="clear"></div>
                    </div>
                    <div class="fixBox">
                        <div class="answer">客服回复：${buyConsultProxy.consultReplyCont}</div>
                        <div class="time">${buyConsultProxy.lastReplyTimeString}</div>
                        <div class="clear"></div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="m6">
        <h2>发表咨询</h2>
        <div class="box">
            <div class="fixBox">
                <label>咨询内容<span>*</span>：</label>
                <div class="put2"><textarea id="consultCont" name="consultCont" cols="" rows="">欢迎您发表咨询内容。</textarea></div>
                <div class="clear"></div>
            </div>
            <div class="fixBox">
                <c:choose>
                    <c:when test="${empty loginUser}">
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <div class="text">请登录后提交咨询！ <a href="${webRoot}/login.ac" title="登录"><img src="${webRoot}/template/bdw/statics/images/detail_btn04.gif" /></a> <a href="${webRoot}/register.ac" title="注册新账户"><img src="${webRoot}/template/bdw/statics/images/detail_btn05.gif" /></a></div>
                    </c:when>
                    <c:otherwise>
                        <label>用户账号：</label>
                        <div class="text">${loginUser.loginId}</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:choose>
                <c:when test="${not empty loginUser}">
                    <div class="btn"><a href="javascript:void(0);" id="addConsultCont">提交咨询</a></div>
                </c:when>
                <c:otherwise></c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</div>
<div class="clear"></div>
</div>
<div class="part2">
    <h2>
        <div class="tit">最近浏览</div>
        <div class="clearOut"><a href="javascript:clearHistoryProductsCookie();" >清空</a></div>
        <div class="clear"></div>
    </h2>
    <div class="box">
        <c:set value="${sdk:getProductFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
        <c:choose>
            <c:when test="${not empty productFromCookies}">
                <div class="sorll_Box">
                    <ul style="width:3000px;">
                        <c:forEach items="${productFromCookies}" var="proxy">
                            <li>
                                <div class="pic">
                                    <a class="cur" href="${webRoot}/product-${proxy.productId}.html" title="${proxy.name}" target="_blank">
                                        <img src="${proxy.defaultImage["150X150"]}" alt="${proxy.name}"/>
                                    </a>
                                </div>
                                <div class="title">
                                    <a href="${webRoot}/product-${proxy.productId}.html" title="${productProxy.name}" target="_blank">${proxy.name}<span>${proxy.salePoint}</span></a>
                                </div>
                                <p>
                                    <c:choose>
                                        <c:when test="${proxy.commentStatistics.average!=0}">
                                            <c:forEach begin="1" end="${proxy.commentStatistics.average}">
                                                <img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" />
                                            </c:forEach>
                                            <c:forEach begin="1" end="${5.0-proxy.commentStatistics.average}">
                                                <img src="${webRoot}/template/bdw/statics/images/list_starImg02.gif" />
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach begin="1" end="5">
                                                <img src="${webRoot}/template/bdw/statics/images/list_starImg01.gif" />
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p>
                                    已有${proxy.commentQuantity}条评论
                                </p>
                                <div class="price"><b>¥ <fmt:formatNumber value="${proxy.price.unitPrice}" type="number" pattern="#0.00#" /></b></div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <ul><li style="text-align: center;padding-top: 110px;font-size: 14px;">您还未浏览其它商品</li></ul>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</div>
<div id="goTopBtn22" style="display: none;">
    <div class="goTopBtn22">
        <a onmousemove="toPageTop()" onmouseout="toPageTopOut()" href="#top" class="simple">
            <img id="toTop" src="${webRoot}/template/bdw/statics/images/to_top.jpg" style="float: right;">
        </a>
    </div>
</div>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1338866268911669" charset="utf-8"></script>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
