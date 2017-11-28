﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set var="loginUser" value="${sdk:getLoginUser()}" />                                                             <%--获取当前用户--%>
<c:set value="${sdk:findTodayGroupBuy(null)}" var="groupBuyList"/>
<c:set value="${sdk:findGroupBuyProxy(param.id)}" var="groupBuyProxy" />                                            <%--获取团购--%>
<c:if test="${empty groupBuyProxy}">
    <c:redirect url="${webRoot}/tuanlist.ac"/>
</c:if>
<c:set var="productProxy" value="${sdk:getProductById(groupBuyProxy.productId)}"/>                                  <%--获取商品--%>
<c:if test="${empty productProxy}">
    <c:redirect url="${webRoot}/tuanlist.ac"/>
</c:if>
<c:set var="commentStatistics" value="${productProxy.commentStatistics}"/>                                          <%--评论统计--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(groupBuyProxy.productId,10)}"/>                      <%--评论详情--%>
<c:set var="categoryGroup" value="${sdk:findTodayGroupBuy(groupBuyProxy.category.categoryId)}"/>                    <%--同类团购--%>
<c:set var="shopInf" value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" />                                  <%--店 铺 信 息--%>
<c:set var="groupBuySkuProxyList" value="${groupBuyProxy.groupBuySkuProxyList}" />                                  <%--skuid--%>
<c:set var="attrGroupProxyList" value="${productProxy.attrGroupProxyList}"/>

<jsp:useBean id="systemTime" class="java.util.Date" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}-${webName}" /> <%--SEO description优化--%>
    <title>${webName}-团购详细</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/newtuan.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .m2  >div >p{text-align: center;}
        .m2  >div >p >img{width:750px; align: center; max-width: 100%;}
    </style>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/imall-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/tuanShoppingcart.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/DD_belatedPNG_0.0.8a-min.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/tuan.js"></script>

   <%-- <script>
        var webPath = {
            webRoot:"${webRoot}",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />"
        };
        var skuData = eval('${skuIds}');
        var userSpecData = eval('${specJsonData}');
        var selectSpecValues = [];
        var allSpecValueIds = [];
        var userSpecValueData = [];
        if(userSpecData!=null){
            buildData();
        }
        function buildData(){
            if(userSpecData == null){
                return;
            }
            for (var spd = 0; spd < userSpecData.length; spd++) {
                var productUserSpec =  userSpecData[spd].specValueProxyList;
                for(var usp=0;usp<productUserSpec.length;usp++){
                    var specValueId= productUserSpec[usp].specValueId;
                    var name= productUserSpec[usp].name;
                    var relPicId= productUserSpec[usp].relPictId;
                    var specId= userSpecData[spd].specId;

                    allSpecValueIds.push(specValueId);
                    userSpecValueData.push({
                        specId:specId,
                        specValueId:specValueId,
                        specValueNm:name,
                        relPicId:relPicId
                    });
                }
            }
        }

        $(function(){
            setTimeout(function(){
                DD_belatedPNG.fix('div,ul,li,a,h1,h2,h3,input,img,span,dl, background');
            },1);

            $("#countdownTime").imallCountdown('${groupBuy.isStart ? groupBuy.endTimeString : groupBuy.startTimeString}','tuanSpan',webPath.systemTime);
            if(skuData.length==1){
                $(".addGroupCart").attr("skuid",skuData[0].groupBuySkuId);
                $("#groupBuyPrice").html(skuData[0].groupBuyPrice);
                $("#countStr").html("请填写您需要团购的商品数量");
                $("#selecSpecAll").html("");
                $("#stock").html("<b style='margin-left: 10px;'>( 库存<span style='color:red;margin:1px 10px;'>"+skuData[0].groupBuyStockQuantity+"</span>件 )</b>");
                $("#stockNum").val(skuData[0].groupBuyStockQuantity);
            }
            $("#num").blur(function(){
                if($(this).val()==""){
                    alert("数量不能为空");
                    return;
                }
                $(".addGroupCart").attr("num",$(this).val());
            });

            /*$("#addGroup").click(function(){
                $("#num").val("");
            });*/

            $("#closeBox").click(function(){
                $(".box").hide();
            });

            $(".specSelect").find("a").click(function () {

                if ($(this).hasClass("lock")) {
                    return;
                }

                if ($(this).hasClass("cur")) {
                    $(this).removeClass("cur");
                } else {
                    $(this).parent().parent().find("a").removeClass("cur");
                    $(this).addClass("cur");
                }

                var data_values = $(this).attr("data-value");
                var data_value = data_values.split(":");
                var specObject = {specId:parseInt(data_value[0]), specValueId:parseInt(data_value[1])};

                //加入或移除
                pushSelected(specObject);


                var skuDatas = skuData;
                var selectSpecArray = [];
                for (var i = 0; i < selectSpecValues.length; i++) {
                    //过滤没有包含选择规格值ID的规格组合
                    skuDatas = filterSkuDatas(selectSpecValues[i].specValueId, skuDatas);
                    //记录选择规格
                    for (var spd = 0; spd < userSpecValueData.length; spd++) {
                        if (selectSpecValues[i].specValueId == userSpecValueData[spd].specValueId) {
                            selectSpecArray.push(userSpecValueData[spd].specValueNm);
                            break;
                        }
                    }
                }

                //展示选择的规格
                displaySelectSpecValue(selectSpecArray);

                $(".lock").removeClass("lock");
                var unSelectSpecValue = [];

        //        var filterSpecValueIds = [];
                var filterSkuData = skuData;

                for (var i = 0; i < selectSpecValues.length; i++) {
                    filterSkuData = filterSkuDatas(selectSpecValues[i].specValueId, filterSkuData);
                    var selectSpecIDs = [];
                    for(var spd=0;spd<=i;spd++){
                        selectSpecIDs[spd]=selectSpecValues[spd].specId;
                    }
                    filterUnSelectSpecValueIds(selectSpecIDs,unSelectSpecValue,filterSkuData,selectSpecValues[i].specValueId);
                }
                var selectSpecValues1 =  selectSpecValues.reverse();
                var filterSkuData1 = skuData;
                for (var i1 = 0; i1 < selectSpecValues1.length; i1++) {
                    filterSkuData1 = filterSkuDatas(selectSpecValues1[i1].specValueId, filterSkuData1);
                    var selectSpecIDs1 = [];
                    for(var spd1=0;spd1<=i1;spd1++){
                        selectSpecIDs1[spd1]=selectSpecValues1[spd1].specId;
                    }
                    filterUnSelectSpecValueIds(selectSpecIDs1,unSelectSpecValue,filterSkuData1,selectSpecValues1[i1].specValueId);
                }

                for (var s = 0; s < unSelectSpecValue.length; s++) {
                    $(".specSelect").find("a").each(function () {
                        var data_value = $(this).attr("data-value");
                        var specValueId = parseInt(data_value.split(":")[1]);
                        if (unSelectSpecValue[s] == specValueId) {
                            $(this).addClass("lock");
                        }
                    });
                }

                if (skuDatas.length == 1 && $(".specSelect").size() == selectSpecValues.length) {
                    selectSku(skuDatas[0]);
                }else{
                $("#selecSpec").html("没有选择规格商品");
                $("#stock").html("");
                $("#stockNum").val("");
            }

                /*else{
                    $("#selecSpec").html("没有选择规格商品");
                }*/

            });

            //增加或删除规格
            function pushSelected(specObject) {
                //不是增加 就是 删除
                var isAdd = true;
                var addIndex = -1;
                for (var i = 0; i < selectSpecValues.length; i++) {
                    var specValueId = selectSpecValues[i].specValueId;
                    var specId = selectSpecValues[i].specId;

                    if (specId == specObject.specId) {
                        addIndex = i;
                        if (specObject.specValueId == specValueId) {
                            isAdd = false;//删除
                            break;
                        }
                    }
                }
                //增加
                if (isAdd) {
                    if (addIndex < 0) {
                        selectSpecValues.push(specObject);
                    } else {
                        selectSpecValues[addIndex] = specObject;
                    }
                    //显示规格相关图片
                    var useSpecValue = getUseSpecValue(specObject.specValueId);
                    if(useSpecValue.relPicId!=undefined&&$.trim(useSpecValue.relPicId).length>0){
                        displaySpecRefPic(useSpecValue.relPicId)
                    }
                }
                //删除
                else {
                    //
                    selectSpecValues.splice(addIndex, 1);
                }
            }

            //sku过滤器
            function filterSkuDatas(specValueId, skuDatas) {
                var result = [];
                for (var i = 0; i < skuDatas.length; i++) {
                    var specValueIds = eval(skuDatas[i].skuJsonData);
                    if ($.inArray(specValueId,specValueIds) >= 0) {
                        result.push(skuDatas[i]);
                    }
                }
                return result;
            }

            //选择过滤器
            function filterUnSelectSpecValueIds(selectSpecIds,unSelectSpecValue,filterDatas,selectSpecValueId) {
                var canSelects = [];
                var filterSpecValueIds = [];
                if (selectSpecValueId == undefined) {
                    return  unSelectSpecValue;
                }

                for(var us = 0; us < userSpecValueData.length; us++){
                    var isSelectSpecId=false;
                    for(var spId=0;spId<selectSpecIds.length;spId++){
                        if(selectSpecIds[spId]==userSpecValueData[us].specId){
                            isSelectSpecId =true;
                        }

                    }
                    if(!isSelectSpecId){
                        filterSpecValueIds.push(userSpecValueData[us].specValueId);
                    }
                }


                for (var i = 0; i < filterDatas.length; i++) {
                    var skuJsonData = eval(filterDatas[i].skuJsonData);
                    if ($.inArray(selectSpecValueId, skuJsonData) >= 0) {
                        for(var a=0;a<skuJsonData.length;a++){
                            canSelects.push(skuJsonData[a]);
                        }
                    }
                }

                for (var f = 0; f < filterSpecValueIds.length; f++) {
                    if ($.inArray(filterSpecValueIds[f], canSelects) < 0) {
                        unSelectSpecValue.push(filterSpecValueIds[f]);
                    }
                }

                return unSelectSpecValue;
            }

            //根据规格ID取出规格值
            function getUseSpecValue(specValueId){
                for(var i=0;i<userSpecValueData.length;i++){
                    if(userSpecValueData[i].specValueId==specValueId){
                        return userSpecValueData[i];
                    }
                }
            }

            //显示规格关联图片
            function displaySpecRefPic(pic){
                $("#mycarousel").find("a").each(function(){
                    var rel = eval("(" + $.trim($(this).attr('rel')) + ")");
                    if(pic==$(this).attr("picId")){
                        $("#bigsrc").attr("src",rel.smallimage);
                        $(".jqzoom").attr("href",rel.largeimage);
                    }
                });
            }

            //多规格默认选中
            $(".specSelect").each(function(){
                $(this).find("a:first").each(function(){
                    this.click();
                });
            });

            //显示已选择的规格值
            function displaySelectSpecValue(nameArray){
                if(nameArray.length==0){
                    $("#selecSpec").html("没有选择规格商品");
                } else{
                    $("#selecSpec").html("");
                }
                $("#specValue").html("");
                for(var i=0;i<nameArray.length;i++){

                    if (i != 0) {
                        $("#selecSpec").append("、");
                        $("#specValue").append("、");
                    }
                    $("#selecSpec").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
                    $("#specValue").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
                }
            }

            //选择多种规格后得到SKU
            function selectSku(skuData) {
                var sku = skuData;
                var price = sku.groupBuyPrice;
                if(sku.groupBuyStockQuantity==0){
                    alert("该商品缺货");
                    return;
                }
                //选择规格的时候显示库存
                $("#stock").html("<b style='margin-left: 10px;'>( 库存<span style='color:red;margin: 1px 4px;'>"+sku.groupBuyStockQuantity+"</span>件 )</b>");
                $("#stockNum").val(sku.groupBuyStockQuantity);
                //显示价格
                $("#groupBuyPrice").html(price);
                $(".addGroupCart").attr("skuid",sku.groupBuySkuId);
            }
        });

    </script>--%>
    <script type="text/javascript">
        var productId = eval('${productProxy.productId}');
        var webPath = {
            webRoot:"${webRoot}",
            page: "${param.page}",
            shopCollectCount: "${loginUser.shopCollectCount}",
            systemTime: "<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />",
            shopId:"${productProxy.shopInfId}",
            isStart: ${groupBuyProxy.isStart},
            endTime: "${groupBuyProxy.endTimeString}",
            startTime: "${groupBuyProxy.startTimeString}",
            productId: "${productProxy.productId}",
            groupBuyId: "${param.id}",
            isLoaded:"N"
        };
        var isLogin = ${not empty loginUser};
    </script>
</head>

<body>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=tuan"/>


<!--主体-->
<div class="main-bg">
    <div class="breadcrumb clearfix">
        <a class="breadcrumb-first fl"  href="javascript:;" title="">${webName}</a>
        <span class="breadcrumb-arr fl">&gt;</span>

        <span class="breadcrumb-last fl">${groupBuyProxy.title}</span>

    </div>
    <div class="m-top">
        <div class="fl">
            <div class="preview">
                <a href="javascript:;"><img src="${groupBuyProxy.pic[""]}" width="400" height="300"></a>
            </div>
            <div class="inner">
                <h3 class="elli">
                    <c:choose>
                        <c:when test="${productProxy.prescriptionTypeCode=='0'}"><img src="${webRoot}/template/default/statics/images/RX.png" height="22" alt=""></c:when>
                        <c:when test="${productProxy.prescriptionTypeCode=='1'}"><img src="${webRoot}/template/default/statics/images/OTC-J.png" height="22" alt=""></c:when>
                        <c:when test="${productProxy.prescriptionTypeCode=='2'}"><img src="${webRoot}/template/default/statics/images/OTC-Y.png" height="22" alt=""></c:when>
                    </c:choose>
                    ${groupBuyProxy.title}</h3>
               <%-- <p class="newpc">${groupBuyProxy.sellingPoint}</p>--%>
                <div class="price">
                    <div class="pri01">
                      <%--  <c:if test="${empty loginUser}">
                            <em>批发价采购商可见</em>
                        </c:if>--%>
                        <%--<c:if test="${not empty loginUser}">--%>
                            团购价<span>¥</span><i><fmt:formatNumber  value="${groupBuyProxy.price.unitPrice}" type="number"  pattern="#0.00#"/></i>
                     <%--   </c:if>--%>
                    </div>
                    <div class="pri02">
                        <div class="discount"><fmt:formatNumber  value="${groupBuyProxy.discount/10}" type="number"  pattern="#0.0#"/>折</div>
                        <br/>
                        <del>
                           <%-- <c:if test="${not empty loginUser}">--%>
                                <span>¥</span><fmt:formatNumber  value="${groupBuyProxy.orgPrice}" type="number"  pattern="#0.00#"/>
                          <%--  </c:if>--%>
                        </del>
                    </div>
                    <div class="pri03"><span>${groupBuyProxy.soldQuantity}</span>人已购买</div>
                </div>
                <div class="little-time">
                    <label class="timeLabel">距离团购${groupBuyProxy.isStart ? '结束' : '开始'}：</label>
                    <div class="time" >
                    </div>
                </div>
                <div class="choose-amount">
                    <span>购买数量：</span>
                    <div class="wrap-input">
                        <input id="num" type="text" value="1" >
                        <a href="javascript:;" class="add" onclick="productNumAdd()"></a>
                        <a href="javascript:;" class="sub disabled" onclick="productNumSub()"></a><!--这里可以去掉disabled-->
                    </div>
                </div>
                <div class="choose-btn">
                    <a href="javascript:;" class="btn1" id="addGroupCart" carttype="groupBuy" handler="groupBuy" skuid='${groupBuySkuProxyList[0].groupBuySkuId}' num=""><i></i>参团购买</a>
                </div>
            </div>
        </div>
      <%--  <div class="fr">
            <div class="mt">
                <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" class="title elli ">${shopInf.shopNm}</a>
                <span>信用等级：</span>
                <div class="gd-icon">
                    <img src="${shopInf.shopLevel.levelIcon['']}" height="16px"/>
                </div>
            </div>
            <div class="grade">
                <ul>
                    <li>描述相符：<span>${shopInf.shopRatingAvgVo.productDescrSame}</span>分</li>
                    <li>服务态度：<span>${shopInf.shopRatingAvgVo.sellerServiceAttitude}</span>分</li>
                    <li>物流速度：<span>${shopInf.shopRatingAvgVo.sellerSendOutSpeed}</span>分</li>
                </ul>
            </div>
            <div class="grade">
                <ul>
                    <li>商品数量：<span>${shopInf.shopProductTotal}</span></li>
                    <li>供应商认证：
                        <c:forEach var="attesation" items="${shopInf.shopAttesation}">
                            <div class="iden">
                                <img src="${attesation.logo['']}">
                                <div class="iden-cont">
                                    <h5>${attesation.attestationName}</h5>
                                    <p>${attesation.descr}</p>
                                    <i></i>
                                </div>
                            </div>
                        </c:forEach>
                    </li>
                </ul>
            </div>
            <div class="btns">
                <a href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${productProxy.shopInfId}">进入商家</a>

            </div>
        </div>--%>
        <div class="store">
            <h2>${shopInf.shopNm}</h2>
            <ul>
                <li>等级：<span class="grade"><img src="${shopInf.shopLevel.levelIcon['']}"/></span></li>
                <li>商品数量：<em>${shopInf.productTotalCount}</em></li>
            </ul>

            <ul>
                <li>描述相符：<strong>${shopInf.shopRatingAvgVo.productDescrSame}分</strong></li>
                <li>服务态度：<strong>${shopInf.shopRatingAvgVo.sellerServiceAttitude}分</strong></li>
                <li>物流速度：<strong>${shopInf.shopRatingAvgVo.sellerSendOutSpeed}分</strong></li>
            </ul>

            <ul class="store-service">
                <li style="position: relative">联系客服：
                    <c:choose>
                        <c:when test="${not empty shopInf.companyQqUrl}">
                            <a href="${shopInf.companyQqUrl}" target="_blank" class="qq-service">QQ客服</a>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${shopInf.csadInfList}" var="caadInf" end="0">
                                <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${caadInf}&amp;site=qq&amp;menu=yes" target="_blank" class="qq-service">QQ客服</a>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </li>
                <li>联系电话：
                    <c:choose>
                        <c:when test="${empty shopInf.tel}">
                            <strong>${shopInf.mobile}</strong>
                        </c:when>
                        <c:otherwise>
                            <strong>${shopInf.tel}</strong>
                        </c:otherwise>
                    </c:choose>
                </li>
                <li>工作时间：<strong>${shopInf.csadOnlineDescr}</strong></li>
                <li>认证信息：
                    <c:forEach items="${shopInf.shopAttesation}" var="shopAttesations">
                        <img src="${shopAttesations.logo['']}" style="max-height: 16px;"/>
                    </c:forEach>
                </li>
            </ul>
            <a class="btn btn-default bl" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank">进入店铺</a>
            <a class="btn btn-default br" id="collectState" href="javascript:;" <c:if test="${shopInf.collect == false}">onClick="CollectShop(${shopInf.shopInfId})"</c:if>>${shopInf.collect ? '已收藏' : '收藏本店'}</a>
        </div>
    </div>
</div>
<div class="main">
    <div class="fr">
        <h4>正在进行的其他团购</h4>
        <ul>
            <c:forEach items="${categoryGroup}" var="categoryGroupBuy">
                <c:if test="${categoryGroupBuy.groupBuyId != groupBuyProxy.groupBuyId}">
                    <li>
                        <div class="pic"><a href="" title=""><img src="${categoryGroupBuy.pic["200X200"]}" alt=""></a></div>
                        <a href="" class="title elli"><span><fmt:formatNumber  value="${categoryGroupBuy.discount/10}" type="number"  pattern="#0.0#"/>折</span>${categoryGroupBuy.title}</a>
                      <%--  <div class="firm">${categoryGroupBuy.sellingPoint}</div>--%>
                        <div class="price">
                            <%--<c:if test="${empty loginUser}">
                                <em>批发价采购商可见</em>
                            </c:if>--%>
                           <%-- <c:if test="${not empty loginUser}">--%>
                                <em><fmt:formatNumber  value="${groupBuyProxy.orgPrice}" type="number"  pattern="#0.00#"/></em>
                          <%--  </c:if>--%>
                        </div>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
    <!-- 商品 -->
    <div class="body">
        <ul class="minute-menu">
            <li class="active cur" rel="1"><a href="javascript:;" >商品详情</a></li>
            <li rel="2" id="relComment"><a href="javascript:;">商品评价(${commentStatistics.total})</a></li>
           <%-- <li rel="3"><a href="javascript:;">售前咨询</a></li>--%>
        </ul>

        <!-- 商品详情 -->
        <div class="minute-cont" style="display: block;">
            <c:choose>
                <c:when test="${productProxy.jdProductCode != null || !productProxy.jdProductCode  eq 'null'}">
                    <ul class="attributes">
                        <c:forEach items="${fn:split(productProxy.paramHtml, ',')}" var="data">
                            <li>${data}</li>
                        </c:forEach>
                        <div class="clear"></div>
                    </ul>
                </c:when>
                <c:otherwise>
                    <c:if test="${not empty attrGroupProxyList}">
                        <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                            <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                                <ul class="attributes">
                                    <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                                        <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                            <li class="elli" title="${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
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
                </c:otherwise>
            </c:choose>
            <div class="detail-img">
                ${not empty groupBuyProxy.description ? (groupBuyProxy.description) : ''}
            </div>
        </div>

        <!-- 商品评价 -->
        <div class="minute-cont">
            <div class="comment">
                <div class="g-b-l">
                    <h3>${productProxy.commentStatistics.average}</h3>
                    <p>用户满意度</p>
                </div>
                <div class="g-b-m">
                    <ul>
                        <li>
                            <span class="txt">好评</span>
                            <span class="bar"><i style="width: ${productProxy.goodRate};"></i></span>
                            <span class="txt">${productProxy.goodRate}</span>
                        </li>
                        <li>
                            <span class="txt">中评</span>
                            <span class="bar"><i style="width: ${productProxy.normalRate};"></i></span>
                            <span class="txt">${productProxy.normalRate}</span>
                        </li>
                        <li>
                            <span class="txt">差评</span>
                            <span class="bar"><i style="width: ${productProxy.badRate};"></i></span>
                            <span class="txt">${productProxy.badRate}</span>
                        </li>
                    </ul>
                </div>
                <div class="g-b-r">
                    <a class="btn" href="javascript:;" id="isAllowComment">发表评论</a>
                    <p>写评价，赚积分！已购买过本产品的会员可对商品进行评价，获得积分奖励。</p>
                </div>
            </div>
            <div class="comment-list">
            </div>
        </div>
      <%--  <!-- 售前咨询 -->
        <div class="minute-cont">
            <div class="pre-sale">
                <div class="form">
                    <div>我要咨询</div>
                    <div class="text-box">
                        <textarea name="" id="consultCont" placeholder="您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，300字以内。" maxlength="300"></textarea>
                    </div>

                    <c:choose>
                        <c:when test="${empty loginUser}">
                            <div>
                                <a href="${webRoot}/login.ac" title="登录" style="color: #FF6600;">请登陆</a>后提交咨询！
                                <a href="${webRoot}/register.ac" title="注册新账户">注册新用户</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <button class="btn" type="button" id="addConsultCont">提交</button>
                            <span class="words" id="consultContLength">0/300</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <ul class="ask-list">
                    <c:forEach items="${buyConsultProxys.result}" var="buyConsultProxy" varStatus="result">
                        <li>
                            <c:set value="${fn:substring(buyConsultProxy.userName, 0,3)}" var="mobileHeader"/>&lt;%&ndash; 用户名前3位 &ndash;%&gt;
                            <c:set value="${fn:substring(buyConsultProxy.userName, 7,fn:length(buyConsultProxy.userName))}" var="mobileStern"/>&lt;%&ndash; 用户名后4位 &ndash;%&gt;
                            <p class="from">${mobileHeader}****${mobileStern}</p>
                            <div class="cont">
                                <p class="ask">${buyConsultProxy.consultCont}</p>
                                <p class="time"><c:if test="${not empty buyConsultProxy.lastReplyTimeString}">${buyConsultProxy.lastReplyTimeString}</c:if></p>
                                <c:if test="${not empty buyConsultProxy.consultReplyCont}">
                                    <p class="answer">${buyConsultProxy.consultReplyCont}</p>
                                </c:if>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>--%>
    </div>

</div>
<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
