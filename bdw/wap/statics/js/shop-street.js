$(function(){
    initDiscountBoxHeight();

	// 头部搜索框 仿input:placeholder
	(function() {
		var search_box = $(".m-top .search-box");
		search_box.find("input").focus( function(){
			$(this).siblings(".search-p").hide();
		});
		search_box.find("input").blur( function(){
			if ($(this).val() == '') {
				$(this).siblings(".search-p").show();
			}	
		});
	})();
});


jQuery(function($) {
    $(document).ready(function () {
        var lastPageNumber = Top_Path.lastPageNumber;
        // 加载分页
        var readedpage = 1;//当前滚动到的页数
        $("#shopInfList").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".item",
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function (newElements) {
            if (readedpage > lastPageNumber) {//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#shopInfList").infinitescroll({state: {isDone: true}, extraScrollPx: 50});
            }
            readedpage++;
            initDiscountBoxHeight();
        });
    });
});

function search() {
    var searchValue = $('.search').val();
    var targetHref = Top_Path.webRoot+"shopStreet.ac?keyword="+searchValue+"&sortType="+Top_Path.sortType+"&time=" + new Date().getTime();
    window.location.href = targetHref;
}
// 按Enter键,执行事件
function enterSearch(){
    var event = window.event || arguments.callee.caller.arguments[0];
    if (event.keyCode == 13)
    {
        search();

    }
}

/**
 * 显示隐藏商品折扣信息
 * @param obj 当前对象
 */
function showOrHideDiscount(obj) {
    var txtBox = $(obj).parent().find(".txt-box");
    var p_height = txtBox.find("p").eq(0).height();
    var pLength = txtBox.find("p").length;
    var arr_height = pLength * p_height;
    var onOff = $(obj).attr("data-onoff");
    if (onOff == "true") {
        $(obj).attr("data-onoff","false");
        $(obj).css("transform", "rotate(180deg)");
        if (pLength > 1) {
            txtBox.stop().animate({
                "height": arr_height
            });
        }
    } else {
        $(obj).attr("data-onoff","true");
        $(obj).css("transform", "rotate(0)");
        if (pLength > 1) {
            txtBox.stop().animate({
                "height": p_height
            });
        }
    }
}

/**
 * 初始化商品折扣信息盒子的高度(默认只显示一条的高度)
 */
function initDiscountBoxHeight() {
    var txtBox = $(".discounts-box").find(".txt-box");
    var discountLength = txtBox.find("p").length;
    if (discountLength >= 1) {
        var p_height = txtBox.find("p").eq(0).height();
        txtBox.css("height", p_height);
    }
}