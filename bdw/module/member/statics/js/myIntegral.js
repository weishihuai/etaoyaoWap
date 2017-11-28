$(function(){
    $("#mycarousel-integral").jcarousel({
        scroll:1,
//        wrap: 'circular',
        initCallback:initProducts,
        buttonNextHTML: null,
        buttonPrevHTML: null
    });

    function initProducts(carousel) {
        $('#mycarousel-next').bind('click', function() {
            carousel.next();
            return false;
        });
        $('#mycarousel-prev').bind('click', function() {
            carousel.prev();
            return false;
        });
    }
    $("#mycarousel-integral").find("ul").css("left","0");
});
var  buyIntegralProduct = function(productId,price,point){
        if( parseFloat(point) < parseFloat(price)){
            alert("您的积分暂时不够兑换此商品");
            return;
        }
        alert("无购物车跳转链接");
        return false;
        window.location.href=dataValue.webRoot+"/cart/shoppingCart/integralExchangeItemAdd.ac?integralProductId="+productId+"&num=1"
};