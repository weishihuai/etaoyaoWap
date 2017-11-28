<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
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
<%--&lt;%&ndash;相关商品&ndash;%&gt;--%>
<%--<c:set var="refProductList" value="${productProxy.refProducts}"/>--%>
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
<c:if test="${!productProxy.onSale}">
    <c:redirect url="/index.jsp"></c:redirect>
</c:if>

<%--<c:set var="haveWifi" value="${empty param.has ? 'N' :  param.has}"/>--%>
<%--保存商品到cookie--%>
<c:set value="${sdk:saveProductToCookie(productProxy.productId,pageContext.request,pageContext.response)}" var="saveProductToCookie"/>
<jsp:useBean id="systemTime" class="java.util.Date" />
<%
    //收藏
/*    String idStr = (String)request.getParameter("id");
    Integer collectSize= ServiceManager.userProductCollectService.getUserProductCollectSize(Integer.valueOf(idStr));
    request.setAttribute("collectSize",collectSize);*/
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>${webName}-${empty productProxy.metaTitle ? productProxy.name : productProxy.metaTitle}</title>
    <meta name="keywords" content="${productProxy.metaKeywords}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${productProxy.metaDescr}-${webName}" /> <%--SEO description优化--%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/details.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/jquery.jqzoom.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/productslider.css" rel="stylesheet" media="screen">
    <%--<script src="${webRoot}/template/jvan/wap/statics/js/jquery.js"></script>--%>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/stickUp.min.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.jqzoom-core.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/wap-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.event.drag-1.5.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.touchSlider.js"></script>
    <script type="text/javascript">
        var isCollect = '${productProxy.collect}';
        var skuData = eval('${productProxy.skuJsonData}');
        var userSpecData = eval('${productProxy.userSpecJsonData}');
        var isCanBuy = eval('${productProxy.isCanBuy}');
        var webPath = {webRoot:"${webRoot}",productId:"${param.id}",productCollectCount:"${loginUser.productCollectCount}",collectSize:"${collectSize}",page:"${page}",href:"${param.href}",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/shoppingcart.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/product.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/checkwifi.js"></script>
    <style>
        .btm_layer .cur {
            border-top: 2px solid #ed1f23;
            color: #ed1f23;
            cursor: default;
        }
        .btm_layer i{
            background: #fff none repeat scroll 0 0;
            border-left: 1px solid #eee;
            border-right: 1px solid #eee;
            border-top: 1px solid #eee;
            color: #666;
            cursor: pointer;
            display: block;
            float: left;
            font-family: "微软雅黑";
            font-size: 16px;
            height: 38px;
            line-height: 38px;
            margin-right: -1px;
            text-align: center;
            width: 100px;
        }
        .plus{
            background: rgba(0, 0, 0, 0) url("statics/images/de_icon14.png") no-repeat scroll 0 0;
        }
    </style>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=product"/>
<%--页头结束--%>
<div class="row sort" style="background:#FFF;">
    <div class="col-xs-12">
        <div class="navtabs">
            <ul id="myTab" class="nav nav-tabs">
                <li class="active"><a role="button" class="btn btn-default" href="#defaut" data-toggle="tab">商品简介</a></li>
                <li><a role="button" class="btn btn-default" href="#sell" data-toggle="tab">商品详情</a></li>
                <li><a role="button" class="btn btn-default" href="#sell2" data-toggle="tab">关键参数</a></li>
                <li><a role="button" class="btn btn-default" href="#priceM" data-toggle="tab">用户评价</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="tab-content">
    <div class="tab-pane active" id="defaut" >
        <div class="container" style="padding-left: 0px;padding-right: 0px;">

            <%--轮换广告START--%>
            <div class="main_visual">
                <div class="main_image" style="height: 320px;">
                    <ul>
                        <c:forEach varStatus="s" items="${productProxy.images}" var="image">
                            <li><img src="${image['420X420']}"  class="img-responsive col-xs-12" style="height:320px;"/></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div id="slider" class="col-xs-12 text-right" style="position: relative; bottom: 300px; right: 20px; z-index: 99; color: #333; font-weight: bold; font-size: 16px;"><i id="focusImg" style="font-style: normal;"></i></div>
            <%--轮换广告END--%>

            <div class="row" style="position: relative;">
                <%--<div class="carousel-caption " style="height: 60px; " >--%>
                <div class="carousel" style="height: 60px; background: #000 none repeat scroll 0 0; color:#fff;padding: 5px 0 5px 15px;opacity: 0.6;text-align: left;width: 100%;" >
                    <div class="col-xs-10">
                        <em style="height: 22px; overflow: hidden; font-style: normal; display: block; margin: 5px 0 2px;"> ${productProxy.name}</em>
                        <i style="height: 22px; overflow: hidden; font-style: normal; display: block; color:#ff6600"> ${productProxy.salePoint}</i>
                    </div>
                    <div class="col-xs-2  text-right" >
                        <span id="AddTomyLikeBtn" class="glyphicon glyphicon-star" style="font-size: 35px; line-height: 50px; margin-right: 10px;"></span>
                    </div>
                </div>
            </div>

            <div class="row" style="margin-top: 10px;">
                <div class="col-xs-6">
                    <div class="cx"  id="price" style="padding-left: 15px;">销售价：￥<em style="font-size: 20px;">${productProxy.priceListStr}</em></div>
                </div>
                <div class="col-xs-6">
                    <div class="price" style=" font-family: '微软雅黑';  color: #333;" >市场价：<em style="color: #999; font-family: '宋体';">￥${productProxy.marketPrice}</em></div>
                    <input type="hidden" id="priceListStr" priceNm="${productProxy.price.amountNm}" value="${productProxy.priceListStr}">
                </div>
            </div>

            <div class="row" style="padding-left: 15px;">
                <c:choose>
                    <c:when test="${fn:length(productProxy.skus)==1 && productProxy.price.isSpecialPrice}">
                        <div class="col-xs-12">
                            <div class="col-xs-12">
                                <div class="sysj">
                                </div>
                            </div>
                            <script type="text/javascript">
                                $(".sysj").imallCountdown("${productProxy.price.endTimeStr}","wap",webPath.systemTime);
                            </script>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-xs-12" id="specialPrice" style="display: none">
                            <div class="col-xs-12">
                                <div class="sysj">
                                </div>
                            </div>
                            <script type="text/javascript">
                                $(".sysj").imallCountdown("${productProxy.price.endTimeStr}","wap",webPath.systemTime);
                            </script>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="row" style="padding-left: 15px; margin-bottom: 10px;">
                <div class="col-xs-12" >
                    <c:if test="${not empty productProxy.presentProductList}"><div class="zp">赠品</div></c:if>
                    <c:if test="${'PANIC_BUY' ==productProxy.price.discountType}"><div class="xs">限时抢</div></c:if>
                    <c:if test="${'SPECIAL_PRICE' ==productProxy.price.discountType}"><div class="zj">直降</div></c:if>
                    <%--<div class="zj">直降</div>--%>
                </div>
            </div>


            <c:if test="${not empty productProxy.availableBusinessRuleList}">
                <div class="row cx_btn" style="margin-bottom: 0;">
                    <div class="col-xs-4 cx_btn2"> 参与活动：</div>
                    <div class="col-xs-8">
                        <c:forEach items="${productProxy.availableBusinessRuleList}" var="rule">
                            <div class="col-xs-12" title="${rule.descr}">
                                <span class="label label-default" style="width:100%; display:inline-block; background:#e7e7e8; overflow:hidden; border:#ddd 1px solid; margin-bottom: 5px; border-radius:0; color:#666; text-align:left; font-weight:normal; font-size: 14px; padding: 5px 10px;">${rule.businessRuleNm}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
        <div class="container wap_container" style="margin-top: 0;">
            <div class="row c1_rows" id="c1_rows">
                <c:if test="${productProxy.isEnableMultiSpec=='Y'}">
                    <c:forEach items="${specList}" var="spec">
                        <div class="specSelect" style="margin-top: 5px;height:40px">
                            <div class="col-xs-3">
                                <label class="control-label xzgg">${spec.name}：</label>
                            </div>
                            <div class="col-xs-9 ${spec.specType eq '0'?'sizeSel':'coloSel'}">
                                <c:forEach items="${spec.specValueProxyList}" var="specValue">
                                    <button<%-- <c:if test="${}">disabled="true"</c:if>--%> style="margin-top: 2px;margin-right: 2px"  title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}" class="gg_btn " type="submit">
                                        <c:if test="${spec.specType eq '0'}">${specValue.value}</c:if>
                                        <c:if test="${spec.specType eq '1'}"><img width='30' height='30' src="${specValue.value}" /></c:if>
                                        <i></i>
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
            <div class="row c1_rows2">
                <div class="col-xs-3">
                    <label class="control-label xzgg">数量：</label>
                </div>
                <div class="col-xs-9">
                    <a href="javascript:" class="prd_subNum" style="float:left;margin-left:0px;line-height:28px"><img src="${webRoot}/template/bdw/oldWap/statics/images/detail_toE.gif" /></a>
                    <input type="num" value="1" class="form-control put prd_num text-center" maxlength="4" style="float:left;margin-left:0px;height: 30px; width: 60px; margin-top: 1px; border: #dfdfdf 1px solid; border-left: none; border-right: none;">
                    <a href="javascript:" class="prd_addNum" style="float:left;margin-left:0;line-height:28px"><img src="${webRoot}/template/bdw/oldWap/statics/images/detail_toAdd.gif"/></a>
                </div>
            </div>
            <div class="row c1_rows3">
                <c:if test="${productProxy.isEnableMultiSpec=='Y'}">

                    <div class="col-xs-3">
                        <label class="control-label xzgg" id="selecSpec">选择规格：</label>
                    </div>
                    <div class="col-xs-9">
                        <div class="kxgg" id="specValue">可选规格</div>
                    </div>
                </c:if>
                <%--<div class="col-xs-3">--%>
                <%--<label class="control-label xzgg" for="inputEmail3">选择规格：</label>--%>
                <%--</div>--%>
                <%--<div class="col-xs-9">--%>
                <%--<div class="kxgg">可选规格</div>--%>
                <%--</div>--%>
            </div>
            <div class="row c1_rows4">
                <div class="col-xs-6 " style="${productProxy.isCanBuy ? '':"display:none"}" >
                    <button class="ligm_btn addcart2" id="addcart2" type="submit" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku">立即购买</button>
                </div>
                <div class="col-xs-6 quehuo" style="${productProxy.isCanBuy ? 'display:none':''}" >
                    <button class="ligm_btn quehuobtn" id="quehuobtn" type="submit" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}">到货通知</button>
                </div>
                <div class="col-xs-6 addTobuyCar" style="padding-left:10px;${productProxy.isCanBuy ? '':"display:none"}">
                    <button  class="ligm_btn2 addcart" id="addcartButton"  type="submit" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}"  num="1" carttype="normal" handler="sku">加入购物车</button>
                </div>
            </div>
        </div>

        <%--搭配组合--%>
        <c:set value="${productProxy.referSkuList}" var="referProductList"></c:set>
        <c:if test="${not empty referProductList}">
            <div class="container wap_container">
                <input type="hidden" id="dapei_skuId" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.skus[0].skuId}</c:if>">
                <input type="hidden" id="dapei_skuprice" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.price.unitPrice}</c:if>">

                <ul class="nav nav-tabs nav-justified">
                    <li class="active"><a href="#refer" data-toggle="tab"><strong class="text-danger">推荐搭配</strong></a></li>
                </ul>
                <div class="tab-content">
                    <div id="refer" class="tab-pane fade in active">
                        <div class="row" style="margin-top:30px;overflow-x: scroll;" id="dapei">
                            <ul class="list-inline" style="width:4000px;">
                                <li class="pull-left">
                                    <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="thumbnail"><img src="${productProxy.defaultImage["120X120"]}" width="100px" height="100px"/></a>
                                    <h5 class="format"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">${productProxy.name}</a></h5>
                                    <p><strong class="small text-danger">￥${productProxy.priceListStr}</strong></p>
                                </li>
                                <li class="pull-left">
                                    <a href="javascript:" class="thumbnail" style="margin-top: 50px;">
                                        <img src="${webRoot}/template/bdw/oldWap/statics/images/de_icon14.png" alt="+"/>
                                    </a>
                                </li>
                                <c:forEach items="${referProductList}" var="refPrd" varStatus="num">
                                    <li class="pull-left">
                                        <a href="${webRoot}/wap/product.ac?id=${refPrd.productId}" class="thumbnail"><img src="${refPrd.defaultImage["120X120"]}" width="100px" height="100px"/></a>
                                        <h5 class="format"><a href="${webRoot}/wap/product.ac?id=${refPrd.productId}">${refPrd.name}</a></h5>
                                        <p>
                                            <input class="ch" name="" skuid="${refPrd.skus[0].skuId}" type="checkbox" value="${refPrd.price.unitPrice}"/>
                                            <strong class="small text-danger">￥${refPrd.price.unitPrice}</strong>
                                        </p>
                                    </li>
                                    <c:if test="${!num.last}">
                                        <li class="pull-left">
                                            <a href="javascript:" class="thumbnail" style="margin-top: 50px;">
                                                <img src="${webRoot}/template/bdw/oldWap/statics/images/de_icon14.png" alt="+"/>
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                            <script type="text/javascript">
                                var referProductListNoCheck = function () {
                                    $("#refer input[type='checkbox']").each(function () {
                                        $(this).attr("checked", false);
                                    });
                                }();
                            </script>
                        </div>
                        <div class="row" style="border-top:1px solid #fff;padding-top:20px;">
                            <div class="col-xs-7 col-xs-offset-2">
                                <p>您已选择 <i id="selectNum">0</i> 个自由搭配组合</p>
                                <p>搭配价：<span style=" color:#ed1f23; font-size:18px;"><i>￥</i><em id="dapeiprice">0.0</em></span></p>
                            </div>
                            <div class="col-xs-2" style="margin-top:10px;">
                                <button class="btn btn-danger btn-sm batch_addcart" id="dapeiCart" carttype="normal" handler="sku" href="javascript:">购买搭配组合</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <%--组合套餐--%>
        <c:set value="${productProxy.combos}" var="combos"/>
        <c:if test="${not empty combos}">
            <div class="container wap_container">
                <ul class="nav nav-tabs nav-justified">
                        <%--组合套餐标题--%>
                    <c:forEach items="${combos}" var="combo" varStatus="s">
                        <li <c:if test="${s.index == 0}">class="active"</c:if>><a href="#${combo.comboId}" data-toggle="tab" class="text-danger" comboid="${combo.comboId}"><strong>${combo.title}</strong></a></li>
                    </c:forEach>
                </ul>

                <div class="tab-content">
                    <c:forEach items="${combos}" var="cont_combo" varStatus="cs">
                        <div id="${cont_combo.comboId}" class="tab-pane fade <c:if test="${cs.index eq 0}">in active</c:if>">
                            <div class="row" style="margin-top:30px;overflow-x: scroll">
                                <ul class="list-inline" style="width: 4000px;">
                                    <c:forEach items="${cont_combo.skus}" var="sku" varStatus="ss">
                                        <li class="pull-left">
                                            <a href="${webRoot}/wap/product.ac?id=${sku.productProxy.productId}" class="thumbnail"><img src="${sku.productProxy.defaultImage["120X120"]}" style="width: 100px;height: 100px;"/></a>
                                            <h5 class="format"><a href="${webRoot}/wap/product.ac?id=${sku.productProxy.productId}">${sku.productProxy.name}</a></h5>
                                            <p><strong class="small text-danger">￥<span>${sku.price.unitPrice} </span>× ${sku.amountNum}</strong></p>
                                        </li>
                                        <c:if test="${!ss.last}">
                                            <li class="pull-left">
                                                <a href="javascript:" class="thumbnail" style="margin-top: 50px;">
                                                    <img src="${webRoot}/template/bdw/oldWap/statics/images/de_icon14.png" alt="+"/>
                                                </a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                                <%--组合商品总价计算--%>
                            <div class="row" style="border-top:1px solid #fff;padding-top:20px;">
                                <div class="col-xs-6 col-xs-offset-2">
                                    <p><span>套餐价格：</span><strong style=" color:#ed1f23; font-size:18px;"><i>￥</i><em>${cont_combo.price}</em></strong></p>
                                    <p><span>为您节省：</span><strong style=" color:#ed1f23; font-size:18px;"><i>￥</i><em>${cont_combo.saveMoney}</em></strong></p>
                                </div>
                                <div class="col-xs-2" style="margin-top:10px;">
                                    <button class="btn btn-danger btn-sm combo_addcart" id="comboAddCart" skuid="${cont_combo.comboId}" handler="combo" carttype="normal" num="1">购买组合</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

    </div>
    <div class="tab-pane container" id="sell">
        <%--<c:if test="${haveWifi == 'N'}">--%>
        <div class="alert alert-danger fade in" style="margin-top: 20px" id="descriptionAlert">
            <h4>温馨提示!</h4>
            <p>浏览商品详情会产生较大的流量，建议您在Wifi网络中使用.</p>
            <p>
                <button type="button" class="btn btn-danger btn-lg" id="openDescription"><span class="glyphicon glyphicon-ok"/> 继续查看</button>
            </p>
        </div>
        <%--</c:if>--%>
        <%--<c:if test="${haveWifi == 'Y'}">--%>
        <div style="display: none; word-wrap: break-word;" id="productDescription"></div>
        <%--</c:if>--%>
    </div>
    <div class="tab-pane container" id="sell2">
        <c:if test="${not empty attrGroupProxyList}">
            <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy" >
                <table class="table size">
                    <thead>
                    <tr>
                        <td colspan="2" class="size-title" >${attrGroupProxy.attrGroupNm}</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                        <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                            <tr>
                                <td class="size_td" style="text-align:right; padding-right:13px; width:45%;" >${attrDict.name}</td>
                                <td style="width:55%;">
                                    <c:if test="${!empty attrGroupProxy.dicValueMap}">
                                        ${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}
                                    </c:if>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </c:forEach>
        </c:if>
    </div>



    <div class="tab-pane" id="priceM">
    </div>
</div>
<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>