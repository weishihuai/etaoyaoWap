/**
 * Created by chencheng on 2017/10/25.
 * 底部导航
 */
$(function () {
    /*底部导航切换*/
    var shouYeUnselectedImageUrl = footerData.webRoot+"/template/bdw/wap/module/member/statics/images/shouye48x48.png";
    var shouYeSelectedImageUrl = footerData.webRoot+"/template/bdw/wap/module/member/statics/images/shouye48x48-2.png";
    var cartUnselectedImageUrl = footerData.webRoot+"/template/bdw/wap/module/member/statics/images/gouwuche48x48.png";
    var cartSelectedImageUrl = footerData.webRoot+"/template/bdw/wap/module/member/statics/images/gouwuche48x48-2.png";
    var myUnselectedImageUrl = footerData.webRoot+"/template/bdw/wap/module/member/statics/images/wode48x48.png";
    var mySelectedImageUrl = footerData.webRoot+"/template/bdw/wap/module/member/statics/images/wode48x48-2.png";

    var $footerIndex = $("#footer_index");
    var $footerCart = $("#footer_cart");
    var $footerMember = $("#footer_member");
    if (footerData.pIndex === 'index') {
        $footerIndex.addClass("cur").siblings().removeClass("cur");
        $footerIndex.find(".pic").find("img").attr("src",shouYeSelectedImageUrl);
        $footerCart.find(".pic").find("img").attr("src",cartUnselectedImageUrl);
        $footerMember.find(".pic").find("img").attr("src",myUnselectedImageUrl);
    }else if (footerData.pIndex === 'cart') {
        $footerCart.addClass("cur").siblings().removeClass("cur");
        $footerCart.find(".pic").find("img").attr("src",cartSelectedImageUrl);
        $footerIndex.find(".pic").find("img").attr("src",shouYeUnselectedImageUrl);
        $footerMember.find(".pic").find("img").attr("src",myUnselectedImageUrl);
    }else if(footerData.pIndex === 'member') {
        $footerMember.addClass("cur").siblings().removeClass("cur");
        $footerMember.find(".pic").find("img").attr("src",mySelectedImageUrl);
        $footerCart.find(".pic").find("img").attr("src",cartUnselectedImageUrl);
        $footerIndex.find(".pic").find("img").attr("src",shouYeUnselectedImageUrl);
    }
});