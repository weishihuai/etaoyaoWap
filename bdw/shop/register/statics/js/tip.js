/**
 * Created by chencheng on 2017/9/18.
 */


var showTip = function (tipId, errorText) {
    hideSuccess(tipId);
    $(tipId).addClass("wrong");
    $(tipId+"Error").addClass("appear");
    $(tipId+"Error").html("<i></i>"+errorText);
    var el = tipId.substr(0, tipId.indexOf('Tip'));
    // $(el).focus();
    if (isUnVisible($(el))) {
        $('html,body').animate({scrollTop: ($(el).offset().top)}, 500);//滚动到错误提示处
    }
    $(el).css("border",'1px solid #ff2a00');

};
//判断元素是否在可视范围内
function isUnVisible($item) {
    return ($(window).scrollTop() > ($item.offset().top+$item.outerHeight())) || (($(window).scrollTop()+$(window).height()) < $item.offset().top);
}
var hideTip = function (tipId) {
    $(tipId).removeClass("wrong");
    $(tipId+"Error").removeClass("appear");
    $(tipId+"Error").html("");
    var el = tipId.substr(0, tipId.indexOf('Tip'));$(el).css("border",'1px solid #dddddd');
};

var showSuccess = function (tipId) {
    hideTip(tipId)
    $(tipId).show();
    $(tipId).addClass("right");
};
var hideSuccess = function (tipId) {
    $(tipId).hide();
    $(tipId).removeClass("right");
};