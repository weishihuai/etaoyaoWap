/**
 * Created By wsh 2017/11/02
 * 控制三级商品分类的动态显示
 * @param index 索引值
 */
function changeHover(index) {
    $(".cate-tab li").removeClass("cur");
    $(".cate-tab li:eq(" + index + ")").addClass("cur");
    $(".cate-cont").attr("style", "display:none");
    $(".cate-cont:eq(" + index + ")").attr("style", "display:block");
}