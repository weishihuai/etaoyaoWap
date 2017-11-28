<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findGroupBuyProxy(param.id)}" var="groupBuy"/>
<c:set value="${groupBuy.groupBuySpec}" var="specList"/>
<c:set value="${groupBuy.groupBuySpecJson}" var="specJsonData"/>
<c:set value="${groupBuy.groupBuySkuProxyListJson}" var="skuIds"/>
<c:set value="${sdk:findTodayGroupBuy(null)}" var="groupBuyList"/>
<c:if test="${groupBuy ==null}">
    <c:redirect url="/wap/tuanlist.ac"></c:redirect>
</c:if>
<c:set var="productProxy" value="${sdk:getProductById(groupBuy.productId)}"/>
<c:set var="attrGroupProxyList" value="${groupBuy.attrGroupProxyList}"/>
<jsp:useBean id="systemTime" class="java.util.Date" />
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>团购活动详细</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-${groupBuy.title}-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/teamBuy.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/grouplist.css" rel="stylesheet">
    <%--<script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/statics/js/layer-v1.8.4/layer/layer.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/imall-countdown.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/tuan.js"></script>

    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />",
            endDates:'${groupBuy.endTimeString}',
            startDates:'${groupBuy.startTimeString}'
        };

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

        var skuData = eval('${skuIds}');
        $(function () {

            $("#countdownTime").imallCountdown('${groupBuy.endTimeString}','none',webPath.systemTime);

            var endtimeStr = webPath.endDates.replace(/-/g,"/");
            var starttimeStr = webPath.startDates.replace(/-/g,"/");
            var endTime=new Date(endtimeStr);
            var startTime=new Date(starttimeStr);
            var nowtime = new Date();
            var leftsecond=parseInt((endTime.getTime()-nowtime.getTime())/1000);
            var leftsecond2=parseInt((nowtime.getTime()-startTime.getTime())/1000);
            if(leftsecond <= 0 || leftsecond2 <= 0){
                $(".addcart").hide();
            }else{
                $(".addcart").show();
            }

            if(skuData.length==1){
                //单规格
                $(".addcart").attr("objectid",skuData[0].groupBuySkuId);
                $("#groupBuyPrice").html(skuData[0].groupBuyPrice);
                $("#selectSpec").html("");
                $("#selecSpecAll").html("");
                //单规格库存
                $("#stock").html("(库存"+skuData[0].groupBuyStockQuantity+"件)");
                $("#stockNum").val(skuData[0].groupBuyStockQuantity);
            }

            $("#num").blur(function () {
                if(parseInt($.trim($(this).val()))<=0){
                    alert("请输入正确的购买数量");
                    $(this).val(1);

                }
            });

            //多规格
            $(".specSelect").find("a").click(function () {

                if ($(this).hasClass("lock")) {
                    return;
                }

                if ($(this).hasClass("spec_cur")) {
                    $(this).removeClass("spec_cur");
                    $(this).removeClass("text-danger");
                } else {
                    $(this).parent().parent().find("a").removeClass("spec_cur");
                    $(this).addClass("spec_cur");
                    $(this).trigger("blur");
//                    $(this).addClass("text-danger");
//
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

                var filterSpecValueIds = [];
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

            });

            //多规格默认选中
            $(".specSelect").each(function(){
                $(this).find("a:first").each(function(){
                    this.click();
                });
            });

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

        //显示已选择的规格值
        function displaySelectSpecValue(nameArray){
            if(nameArray.length==0){
                $("#selecSpec").html("未选择");
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
            $("#stock").html("(库存"+sku.groupBuyStockQuantity+"件)");
            $("#stockNum").val(sku.groupBuyStockQuantity);
            //显示价格
            $("#groupBuyPrice").html(price);
            $(".addcart").attr("objectid",sku.groupBuySkuId);
        }

    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=团购详细"/>
<%--页头结束--%>
<div class="row tg_rows">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12"><a href="javascript:void(0);" title="${groupBuy.title}"><img src="${groupBuy.pic['420X420']}" style="width:100%; height: 100%;" alt="${groupBuy.title}"></a></div>
        </div>
        <div class="row tg_rows2">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-xs-12 tg_title"><a href="javascript:void(0);">${productProxy.name}</a></div>
                </div>
                <div class="row">
                    <div class="col-xs-6 list_rice">团购价:¥<fmt:formatNumber value="${groupBuy.price.unitPrice}" type="number" pattern="#0.00#" /></div>
                    <div class="col-xs-6 list_rice">￥<fmt:formatNumber value="${groupBuy.orgPrice}" type="number" pattern="#0.00#" />(<fmt:formatNumber  value="${groupBuy.discount/10}"  pattern="#,###,###,###"/>折)</div>
                </div>
                <div class="row">
                    <div class="col-xs-12 tg_time" id="countdownTime"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 box_bottom"></div>
        </div>
    </div>
</div>
<div class="row tg_rows">
    <div class="col-xs-12">
        <div class="row tg_rows2">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-xs-6 list_rice">团购价:<em>¥<fmt:formatNumber value="${groupBuy.price.unitPrice}" type="number" pattern="#0.00#" /></em></div>
                    <%--<div class="col-xs-6 list_rice"><button class="btn btn-danger btn-danger2 addcart" objectid="" num="1" carttype="groupBuy" handler="groupBuy" type="button" data-toggle="modal"
                                                            data-target="#numModel">参团</button></div>--%>

                    <div class="col-xs-6 list_rice"><button class="btn btn-danger btn-danger2" type="button" data-toggle="modal" id="cantuan">参团</button></div>

                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 box_bottom"></div>
        </div>
    </div>
</div>
<div class="row tg_rows">
    <div class="col-xs-12">
        <div class="row tg_spxq">
            <%--<div class="col-xs-12"><center>商品详情</center></div>--%>
            <div id="detail">
                <c:if test="${not empty attrGroupProxyList}">
                    <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                        <%--2015-02-04 zch,客户要求不显示通用属性组--%>
                        <%--<c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组' && attrGroupProxy.attrGroupNm != '图书扩展信息'}">

                                <p>${attrGroupProxy.attrGroupNm}</p>
                                <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict">
                                    <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">

                                                ${attrDict.name}：
                                            <c:if test="${!empty attrGroupProxy.dicValueMap}">
                                                ${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}
                                            </c:if>

                                    </c:if>
                                </c:forEach>
                                <div class="clear"></div>

                        </c:if>--%>
                        <c:if test="${not empty attrGroupProxy.dicValues}">
                            <table class="table size" style="margin-top: 0px;margin-bottom: 0px;">
                                    <%--<thead>
                                    <tr>
                                    <td colspan="2" class="size-title" >${attrGroupProxy.attrGroupNm}</td>
                                    </tr>
                                    </thead>--%>
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
                        </c:if>
                        <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm == '图书扩展信息'}">
                            <div>
                                <h5>${attrGroupProxy.attrGroupNm}</h5>
                                <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict" varStatus="s">

                                    <c:if test="${!empty attrGroupProxy.dicValueMap}">
                                        <c:set value="${attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}" var="attrDictValue"/>
                                        <c:set value="${fn:replace(attrDictValue,'<br>' ,'')}" var="valueTrim"/>
                                        <c:if test="${valueTrim != ''}">
                                            <div>
                                                <div>${attrDict.name}</div>
                                                <div>
                                                    <div id="tskzCont-${s.index}">
                                                            ${attrDictValue}
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if>
                <%--2016-4-6 lhw,依亚中要求，显示如果没有新的团购详情，则使用普通商品的详情--%>
                <div>${not empty groupBuy.description ? (groupBuy.description) : productProxy.description}</div>
            </div>
        </div>
        <div class="row tg_rows2">
            <div class="col-xs-12">
                ${groupBuy.description}
            </div>
        </div>
    </div>
</div>

<%--购买数量填写模态框 start--%>
<div class="modal fade myModel" id="numModel" tabindex="-1" role="dialog" aria-labelledby="myNumModelLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-size-12 text-primary" id="myNumModelLabel">请填写您需要团购的商品数量</h4>
            </div>
            <div class="modal-body">
                <p class="text-size-12 text-primary" id="selectSpec">请选择购买的规格：</p>
                <c:forEach items="${specList}" var="spec">
                    <div class="row specSelect">
                        <div class="col-xs-2 text-size-12 text-primary ele_margin_top" style="padding-top: 2px;">${spec.name}：</div>
                        <div class="col-xs-10">
                            <div class="row" style="margin-top: 5px;overflow-x: auto;">
                                <ul class="nav-pills list-unstyled" style="width: 1000px;">
                                    <c:forEach items="${spec.specValueProxyList}" var="specValue">
                                        <li class="pull-left" style="padding: 5px 0px;">
                                                <c:if test="${spec.specType eq '0'}">
                                                    <a title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}" class="def" style="text-decoration: none;">
                                                        ${specValue.value}
                                                    </a>
                                                </c:if>
                                                <c:if test="${spec.specType eq '1'}">
                                                    <a title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}" class="def" style="text-decoration: none;padding: 1px;width: 35px;height: 34px;">
                                                        <img width='30' height='30' src="${specValue.relPictId}" />
                                                    </a>
                                                </c:if>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <p class="ele_margin_top" id="selecSpecAll"><span class="text-primary text-size-12">你选择了：</span><span id="selecSpec" style=" color:#ed1f23; font-size:12px;">您未选择任何规格！</span></p>
                <p class="ele_margin_top text-primary"><span class="text-size-12">团购价：</span> <strong style=" color:#ed1f23; font-size:12px;"><i>￥</i><em id="groupBuyPrice"></em></strong></p>
                <%--输入购买的数量--%>
                <div class="row">
                    <div class="col-xs-2">
                        <label for="num" class="control-label text-right text-size-12 text-primary" style="margin-top:6px;padding-top: 2px;">数量:</label>
                    </div>
                    <div class="col-xs-10">
                        <div class="row">
                            <div class="col-xs-12">
                                <a href="javascript:" class="groupPrd_subNum" style="float:left;margin-left:0px;line-height:28px"><img width="25px" height="25px" src="${webRoot}/template/bdw/oldWap/statics/images/detail_toE.gif" /></a>
                                <input id="num" type="num" value="1" class="form-control put text-center" maxlength="4" style="float:left;margin-left:0px;height: 26px; width: 60px; margin: 2px 2px; border: #dfdfdf 1px solid;">
                                <a href="javascript:" class="groupPrd_addNum" style="float:left;margin-left:0;line-height:28px"><img width="25px" height="25px" src="${webRoot}/template/bdw/oldWap/statics/images/detail_toAdd.gif"/></a>
                                <%--<input type="number" class="form-control" id="num" placeholder="请输入" min="1">--%>
                                <div id="stock" style="padding: 7px;" class="text-size-12"></div>
                                <div id="stockNum"></div>
                            </div>
                            <div class="col-xs-12 msg text-size-12" style="margin-top: 20px; margin-left: 20px; color: red; }"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary btn-sm addcart" objectid="" carttype="groupBuy" handler="groupBuy">确定</button>
            </div>
        </div>
    </div>
</div>
<%--购买数量填写模态框 end--%>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>