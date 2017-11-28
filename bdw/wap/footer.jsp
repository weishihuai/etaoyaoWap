
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<script type="text/javascript">
    var footerData = {
        pIndex:'${param.pIndex}',
        webRoot:'${webRoot}'
    };
</script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/footer.js"></script>
<footer class="footer">
    <a href="${webRoot}/wap/index.ac?pIndex=index" class="home" id="footer_index">
        <div class="pic"><img src="${webRoot}/template/bdw/wap/statics/images/shouye48x48.png" alt=""></div>
        <span>首页</span>
    </a>
    <a href="${webRoot}/wap/outlettemplate/default/nearByShopList.ac?pIndex=index" class="home" id="footer_shop">
        <div class="pic"><img src="${webRoot}/template/bdw/wap/statics/images/fujinmendian-1.png" alt=""></div>
        <span>附近</span>
    </a>
    <a href="${webRoot}/wap/shoppingcart/cart.ac?pIndex=cart" class="cart" id="footer_cart">
        <div class="pic"><img src="${webRoot}/template/bdw/wap/statics/images/gouwuche48x48.png" alt=""></div>
        <span>购物车</span>
    </a>
    <a href="${webRoot}/wap/module/member/index.ac?pIndex=member" class="my" id="footer_member">
        <div class="pic"><img src="${webRoot}/template/bdw/wap/statics/images/wode48x48.png" alt=""></div>
        <span>我的</span>
    </a>
</footer>
