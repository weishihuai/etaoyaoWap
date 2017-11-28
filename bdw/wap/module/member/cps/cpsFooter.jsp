
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getPromoteMemberByLoginUserId()}" var="memberInfo" /><!--会员信息，通过登录用户的id获得推广员对象-->
<script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsFooter.js"></script>
<c:set value="${webUrl}/cps/cpsPromote.ac?unid=${memberInfo.id}&target=${wapUrl}?1=1" var="promoteHref"/>
<c:set value="${weixinSdk:getQRCodeLongFormat2(promoteHref,'')}" var="vorderaddQr"/>
<script type="text/javascript">
    var footer = {
        pIndex:'${param.pIndex}',
        webRoot:'${webRoot}'
    };
</script>

<div class="layer-bg" id="qr-code-share-div" style="display: none;;">
    <div class="share-code">
        <div class="cont">
            <div class="shop-info">
                <h2 class="shop-name elli">我的推广二维码</h2>
            </div>
            <div class="code">
                <img src="${webRoot}/QRCodeServlet?qrcodelong=${vorderaddQr}" alt="">
            </div>
            <p class="tip">扫一扫上面的二维码，注册成为会员</p>
        </div>
    </div>
</div>

<div class="bottom-bar">
    <ul>
        <li  id="foot_makeMoney">
            <a href="${webRoot}/wap/module/member/cps/cpsIndex.ac?pIndex=makeMoney" ><i class="icon icon-makeMoney"></i>我要赚钱</a>
        </li>
        <li  id="QrCode">
            <a href="javascript:;"><i class="icon icon-erweima"></i>二维码</a>
        </li>
        <li id="foot_cpsMe">
            <a href="${webRoot}/wap/module/member/cps/cpsMe.ac?pIndex=cpsMe"><i class="icon icon-tixian"></i>提现</a>
        </li>
        <li id="foot_member">
            <a href="${webRoot}/wap/module/member/index.ac?pIndex=member"><i class="icon icon-mine"></i>会员中心</a>
        </li>
    </ul>
</div>
