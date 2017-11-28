<%--
  Created by IntelliJ IDEA.
  User: zcj
  Date: 2016/12/14
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>
<!DOCTYPE html>
<html>

<c:set value="${param.themeActivitieId}" var="themeActivitieId"/>
<c:if test="${empty themeActivitieId}">
    <c:redirect url="/index.jsp"/>
</c:if>
<c:set value="${sdk:getCpsThemeDetailProxy(themeActivitieId)}" var="frialProxy"/>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(frialProxy.productId)}"/>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<c:set value="${wapUrl}/wap/module/member/cps/cpsGoodDetail.ac?themeActivitieId=${param.themeActivitieId}" var="signUrl"/>

<c:choose>
    <c:when test="${not empty loginUser}">
        <c:set value="${sdk:getPromoteMemberByUserId()}" var="promoteMember"/>
        <c:choose>
            <c:when test="${not empty promoteMember}">
                <c:set value="${wapUrl}/cps/cpsPromote.ac?unid=${promoteMember.id}&target=${signUrl}" var="shareUrl"/>
            </c:when>
            <c:otherwise>
                <c:set value="${signUrl}" var="shareUrl"/>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <c:set value="${signUrl}" var="shareUrl"/>
    </c:otherwise>
</c:choose>

<head>
    <meta charset="utf-8">
    <title>好货推详情</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-good-recommend.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cpsGoodDetail.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/guide.css">

    <c:choose>
        <c:when test="${empty frialProxy.effectDisplayId}">
            <c:set var="imgUrl" value="${webUrl}/template/bdw/statics/images/noPic_160X160.jpg"/>
        </c:when>
        <c:otherwise>
            <c:set var="imgUrl" value="${webUrl}/upload/${frialProxy.effectDisplayId}"/>
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${empty frialProxy.wapThemeDescStr}">
            <c:set var="wapThemeDescStr" value=""/>
        </c:when>
        <c:otherwise>
            <c:set var="temp" value="${fn:substring(sdk:cleanHTML(frialProxy.wapThemeDescStr,''),0 , 120)}"/>
            <c:set var="wapThemeDescStr" value="${fn:trim(temp)}"/>
        </c:otherwise>
    </c:choose>

    <script type="text/javascript">
        var webPath = {
            webRoot: '${webRoot}',
            shareUrl:'${shareUrl}',
            title:'${frialProxy.themeName}',
            imgUrl:'${imgUrl}',
            desc:'${productProxy.salePoint}',
            isWeixin:'${isWeixin}',
            cps:'${empty promoteMember ? 0:1}',
            weixinJsConfig: {
                jsApiList: [
                    'onMenuShareTimeline',      //分享到朋友圈
                    'onMenuShareAppMessage',    //发送给朋友
                    'onMenuShareQQ',            //分享到QQ
                    'onMenuShareQZone'          //分享到 QQ 空间
                ]
            }
        };
    </script>
</head>
<body>

<div class="main">
    <div class="main m-good-detail">
        <div class="hd">
            <div class="img">
                <c:if test="${empty frialProxy.wapEffectDisplayId}">
                    <c:set var="imgPictUrl" value="${webRoot}/template/bdw/statics/images/noPic_160X160.jpg"/>
                </c:if>
                <c:if test="${not empty frialProxy.wapEffectDisplayId && frialProxy.wapEffectDisplayId !=''}">
                    <c:set var="imgPictUrl" value="${frialProxy.wapAdvImg['']}"/>
                </c:if>
                <img src="${imgPictUrl}" alt="">
            </div>
            <h2 class="name elli">${frialProxy.themeName}</h2>
            <p class="desc elli">
                <c:if test="${not empty frialProxy.explanation}">
                    ${frialProxy.explanation}
                </c:if>
                <c:if test="${empty frialProxy.explanation}">
                    ${fn:substring(sdk:cleanHTML(frialProxy.wapThemeDescStr,""),0 , 50)  }
                </c:if>
            </p>
        </div>

        <div class="bd">
            <dl>
                <dt>好货介绍</dt>
                <dd>${frialProxy.wapThemeDescStr}</dd>
            </dl>
        </div>
        <%--CPS会员功能--%>
        <div class="ft" style="display:${loginUser.isPopularizeMan == "Y"?"block":"none"}">
            <a class="btn" id="cpsShare" href="javascript:;" shareId="${frialProxy.cpsThemeActivitieId}">分享赚钱</a>
            <div class="cont">
                <p>
                    <span class="fl">佣金比率&ensp;${frialProxy.rebateRate}%</span>
                    <span class="price fr"><small>&yen;</small><fmt:formatNumber value="${frialProxy.rebateAmount}" type="number" pattern="#"/>.<small>${frialProxy.rebateAmountDecimal}</small></span>
                </p>
                <p>
                    <span class="fl">商品单价&ensp;￥${frialProxy.productPrice}</span>
                    <span class="fr">佣金金额</span>
                </p>
            </div>
        </div>
        <%--普通会员功能--%>
        <div class="ft"  style="display:${loginUser.isPopularizeMan != "Y"?"block":"none"}">
            <span>会员价&ensp;</span>
            <span class="price"><small>&yen;</small>${frialProxy.productPrice}</span>
            &emsp;
            <del>&yen;${frialProxy.productPrice}</del>
            <a class="btn" href="${webRoot}/wap/product-${frialProxy.productId}.html">去购买</a>
        </div>
    </div>
</div>

<!-- 引导层 -->
<div class="guide" style="display: none;" id="guide" >
    <span class="direction"></span>
    <div class="desc">
        <p>点击右上角</p>
        <p>选择【发送给好友】或【分享给好友】 </p>
    </div>
</div>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/base.js" type="text/javascript"></script>
<c:if test="${isWeixin=='Y'}">
    <script src="${webRoot}/template/bdw/wap/statics/js/jweixin-1.2.0.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/weixinJsConfigInit.js"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/wxShare.js" type="text/javascript"></script>
</c:if>
<script>
    var shareHtml = '';
    $(document).ready(function(){
        //关注公众号top的样式
       $(document).scroll(function(){
           var y =  $(document).scrollTop();
           if(y < 5){
               $(".focus").css("top","54px");
           }else{
               $(".focus").css("top","0px");
           }
       });

        if(webPath.isWeixin=='Y' && webPath.cps==1) {//微信端显示引导层
            $('.header').css('position', 'inherit');
            $('#guide').show();
        }

       $("#cpsShare").click(function(){
           if(webPath.isWeixin=='Y'){//微信端显示引导层
               $('.header').css('position', 'inherit');
               $('#guide').show();
           }else{
               if($("#loadDiv").html().trim()==''){
                   var $shareId = $(this).attr("shareId");
                   var $shareUrl = encodeURIComponent(webPath.shareUrl.split('target=')[1]);
                   $("#loadDiv").load("${wapUrl}/wap/module/member/cps/cpsWapExtension.ac?type=theme&shareId="+$shareId+"&shareUrl="+$shareUrl);
               }else {
                   $('body').append(shareHtml);
                   $("#loadDiv").show();
               }
           }
       });

        $('#guide').click(function(){
            $('.header').css('position', 'relative');
            $('#guide').hide();
        });
    });
</script>
</body>

<div id="loadDiv" >  </div>
</html>
