<%--
  Created by IntelliJ IDEA.
  User: lzp
  Date: 12-6-18
  Time: 上午10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-套装购买-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/productSet.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/productSet.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};

        var productDatas=[];
        <c:if test="${productProxy.isEnableMultiSpec eq 'Y'}">
            productDatas.push({productId:${productProxy.productId},skuJons:eval('${productProxy.skuJsonData}'),userSpecData:eval('${productProxy.userSpecJsonData}')});
        </c:if>
        <c:forEach items="${productProxy.referProductList}"  var="prd">
        <c:if test="${prd.isEnableMultiSpec eq 'Y'}">
                productDatas.push(data={productId:${prd.productId},skuJons:eval('${prd.skuJsonData}'),userSpecData:eval('${prd.userSpecJsonData}')});
        </c:if>
        </c:forEach>
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=panic"/>
<%--页头结束--%>
<div class="pcWarp">

<!--pcNavMain end-->
<div class="pcProCon">
<h2 name="78409c93-00fd-469a-91b4-a22022b907c7" class="pcProTitle">
    ${productProxy.name}</h2>
<div class="productLeft">
    <div class="GoodsView">
        <div class="DanpinLeft">
            <div class="bigImg" id="vertical">
                <img alt="" src="${productProxy.defaultImage['320X320']}" id="midimg">
            </div>
        </div>
    </div>
    <!--GoodsView end-->
</div>
<!--productLeft end-->
<div class="pcDetailRight">
<div class="pcStepCon">

    <div class="pcStep02">
        <em class="pcStepLeft"></em>
        <p>
            <i>1.</i><span>选择规格</span></p>
        <em class="pcStepRig"></em>
    </div>
    <div class="pcStep03">
        <em class="pcStepLeft"></em>
        <p>
            <i>2.</i><span>点击<br>
                                “添加到套装”</span></p>
        <em class="pcStepRig"></em>
    </div>
    <div class="pcStep04">
        <em class="pcStepLeft"></em>
        <p>
            <i>3.</i><span>重复以上步<br>
                                骤完成添加</span></p>
        <em class="pcStepRig"></em>
    </div>
    <div class="pcStep05">
        <em class="pcStepLeft"></em>
        <p>
            <i>4.</i><span>点击放入<br>
                                购物车</span></p>
    </div>
</div>
<div class="pcSelAreaBox">
<div class="blank10">
</div>
<div class="pcSelArea productSet_${productProxy.productId}">
    <div class="pcSelTop">

        <div name="false" class="pcSelImg">
            <a rel="item_suits_78409c9300fd469a91b4a22022b907c7" target="_blank" href="${webRoot}/product-${productProxy.productId}.html" title="${productProxy.name}">
                <img title="${productProxy.name}" alt="${productProxy.name}" src="${productProxy.defaultImage['130X130']}"></a></div>
        <div class="pcMetaBox">
            <ul class="pcMeta">
                <li>
                    <h3 title="" class="pcMetaName">
                        ${productProxy.name}</h3>
                </li>
                <li>
                    ${productProxy.price.amountNm}：￥<b class="priceValue_${productProxy.productId}">${productProxy.priceListStr}</b></li>
                <li class="pcMetaMarket">市场价：￥<del><fmt:formatNumber value="${productProxy.marketPrice}" type="number" pattern="#0.00#" /></del></li>


                <li><a rel="item_suits_78409c9300fd469a91b4a22022b907c7" href="${webRoot}/product-${productProxy.productId}.html" target="_blank" class="pcLinkde">
                    商品详情&gt;&gt;</a></li>
            </ul>
        </div>
        <div class="blank0">
        </div>

    </div>
    <div class="blank12">
    </div>

    <c:if test="${productProxy.isEnableMultiSpec=='Y'}">
        <c:forEach items="${productProxy.productUserSpecProxyList}" var="spec">
            <div class="fixBox specSelect" >
                <label class="selSize">${spec.name}：</label>

                <div class="${spec.specType eq '0'?'sizeSel':'coloSel'}">
                    <ul>
                        <c:forEach items="${spec.specValueProxyList}" var="specValue">
                            <li>
                                <a href="javascript:" data-value="${spec.specId}:${specValue.specValueId}:${productProxy.productId}" >
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
    <div class="pcSizeNumBox">
        <p class="pcCoL01">
            数量：</p>
        <div class="pcSizeNum">
            <a href="javascript:" num="1" specNm="" productId="${productProxy.productId}" price="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.price.unitPrice}" productNm="${productProxy.name}" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}" class="buyNow" id="buyNow_${productProxy.productId}" >添加到套装&gt;&gt;</a>
            <select id="buyNum_${productProxy.productId}">

                <option selected="selected">
                    1</option>

                <option>
                    2</option>

                <option>
                    3</option>

                <option>
                    4</option>

                <option>
                    5</option>

                <option>
                    6</option>

                <option>
                    7</option>

                <option>
                    8</option>

                <option>
                    9</option>

                <option>
                    10</option>

            </select>
        </div>
        <div style="display: none" class="pcTip">
            套装最多可购买<span></span>件商品<br>
            您可调整已选商品选购套装</div>
        <div class="blank0">
        </div>

    </div>
</div>
<div class="blank18">
</div>
<div class="pcLine01">
</div>
<c:forEach items="${productProxy.referProductList}"  var="prd">
    <div class="pcSelArea productSet_${prd.productId}">
        <div class="pcSelTop">

            <div name="false" class="pcSelImg">
                <a rel="item_suits_78409c9300fd469a91b4a22022b907c7" target="_blank" href="${webRoot}/product-${prd.productId}.html" title="${prd.name}">
                    <img title="${prd.name}" alt="${prd.name}" src="${prd.defaultImage['130X130']}"></a></div>
            <div class="pcMetaBox">
                <ul class="pcMeta">
                    <li>
                        <h3 title="${prd.name}" class="pcMetaName">
                                <a target="_blank" href="${webRoot}/product-${prd.productId}.html" title="${prd.name}">${prd.name}</a></h3>
                    </li>
                    <li>
                            ${prd.price.amountNm}：￥<b class="priceValue_${prd.productId}">${prd.priceListStr}</b></li>
                    <li class="pcMetaMarket">市场价：￥<del><fmt:formatNumber value="${prd.marketPrice}" type="number" pattern="#0.00#" /></del></li>


                    <li><a rel="item_suits_78409c9300fd469a91b4a22022b907c7" href="${webRoot}/product-${prd.productId}.html" target="_blank" class="pcLinkde">
                        商品详情&gt;&gt;</a></li>
                </ul>
            </div>
            <div class="blank0">
            </div>

        </div>
        <div class="blank12">
        </div>

        <c:if test="${prd.isEnableMultiSpec=='Y'}">
            <c:forEach items="${prd.productUserSpecProxyList}" var="spec">
                <div class="fixBox specSelect">
                    <label class="selSize">${spec.name}：</label>

                    <div class="${spec.specType eq '0'?'sizeSel':'coloSel'}">
                        <ul>
                            <c:forEach items="${spec.specValueProxyList}" var="specValue">
                                <li>
                                    <a href="javascript:" data-value="${spec.specId}:${specValue.specValueId}:${prd.productId}">
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
        <div class="pcSizeNumBox">
            <p class="pcCoL01">
                数量：</p>
            <div class="pcSizeNum">
                <a href="javascript:" num="1" specNm="" productId="${prd.productId}" price="${prd.isEnableMultiSpec=='Y' ?  '': prd.price.unitPrice}" productNm="${prd.name}" skuid="${prd.isEnableMultiSpec=='Y' ?  '': prd.skus[0].skuId}" class="buyNow" id="buyNow_${prd.productId}" >添加到套装&gt;&gt;</a>
             <select id="buyNum_${prd.productId}">


                    <option selected="selected">
                        1</option>

                    <option>
                        2</option>

                    <option>
                        3</option>

                    <option>
                        4</option>

                    <option>
                        5</option>

                    <option>
                        6</option>

                    <option>
                        7</option>

                    <option>
                        8</option>

                    <option>
                        9</option>

                    <option>
                        10</option>

                </select>
            </div>
            <div style="display: none" class="pcTip">
                套装最多可购买<span></span>件商品<br>
                您可调整已选商品选购套装</div>
            <div class="blank0">
            </div>

        </div>
    </div>
    <div class="blank18">
    </div>
    <div class="pcLine01">
    </div>
</c:forEach>


</div>
<div class="pcSelected">
    <h3>
        已选套装商品</h3>

    <div style="display: block;" class="yesSelected">
        <ul class="yesSelectedList">
        </ul>
        <div class="yesTotal">
            <p>
                合计：￥<span>0.00</span></p>
            <div class="yesBuyNow">
                <a name="dp_suit|qzjj4_20120613" href="javascript:" carttype="normal" handler="sku" class="batch_addcart">添加到购物车</a></div>
        </div>
    </div>
</div>
</div>
<!--pcDetailRight end-->
<div class="blank0">
</div>
</div>

</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
