
 <%--<%@ include file="/template/bdw/wap/fastShow.jsp" %>--%>
 <%--<script src="${webRoot}/template/bdw/wap/statics/js/fastShow.js"></script>--%>
 <%--<link href="${webRoot}/template/bdw/wap/statics/css/fastShow.css" type="text/css" rel="stylesheet" />--%>
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div class="qk-nav">
        <div class="mask-layer nav-block" id="fastShow-layer" style="display: none;" ></div>
        <span id="navBtn">快速<br/>导航</span>
        <div class="qk-box nav-block" style="display: none;">
            <a href="${webRoot}/wap/index.ac" class="m-index"><img src="${webRoot}/template/bdw/wap/statics/images/shouye.png" alt=""></a>
            <a href="${webRoot}/wap/newSearch.ac" class="m-search"><img src="${webRoot}/template/bdw/wap/statics/images/sousuo2.png" alt=""></a>
            <a href="javascript:void(0);" class="m-my" onclick="window.location.href='${webRoot}/wap/module/member/index.ac?pIndex=member&time='+ new Date().getTime();"><img src="${webRoot}/template/bdw/wap/statics/images/wode.png" alt=""></a>
            <a href="javascript:void(0);" class="m-share" onclick="window.location.href='${webRoot}/wap/shoppingcart/cart.ac?pIndex=cart&time='+ new Date().getTime();"><img src="${webRoot}/template/bdw/wap/statics/images/018gouwuche@2x.png" alt=""></a>
        </div>
    </div>

