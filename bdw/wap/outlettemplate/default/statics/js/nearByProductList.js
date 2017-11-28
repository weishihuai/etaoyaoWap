$(document).ready(function(){
    var page = 1;

    $("#searchInput").bind("keyup", function (e) {
        if(e.keyCode == 13){
            window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&q="+paramData.q+"&isInStore="+paramData.isInStore+"&keyword="+$(this).val()+"&order="+paramData.order;
        }
    });

    /*商品列表展示形式切换*/
    var list_inner = $("#list_inner");
    $(".list-head .toggle").click(function(){
        if ($(this).attr("data-list") == "true") {
            $(this).addClass("toggle-block").attr("data-list","false");
            list_inner.attr("class", "block-inner clearfix");
        }
        else {
            $(this).removeClass("toggle-block").attr("data-list","true");
            list_inner.attr("class", "list-inner clearfix");
        }
    });

    /*商品列表综合、价格排序*/
    var sp_sort_li = $(".sp-sort > li").eq(0);
    var zh_a = $(".sp-sort-zh").find("a");
    sp_sort_li.click(function(){
        $(this).parent().children().removeClass("cur");
        $(this).addClass("cur");
        $(this).find(".dd").toggle();
    });

    /*筛选*/
    var sp_sort_sx = $(".sp-sort-sx");
    var sx_dt = $(".sp-sort-sx > .dt");
    var sx_dd = $(".sp-sort-sx > .dd");
    var brand_inner = sp_sort_sx.find(".sx-brand .li-dd-inner");
    var initial_side = sp_sort_sx.find(".initial-side");
    var title_height = sp_sort_sx.find(".li-dd-title").height();
    var arr_top = [];
    var onOff = true;
    var initial_tips = sp_sort_sx.find(".initial-tips");

    sx_dt.on("click", function(){
        index = $(".sp-sort-zh").find("a").parent().index();
        zh_a.attr("data-active","false").eq(index).attr("data-active","true");
        $(".sp-sort-zh").removeClass("high-to-low").find(".dt").html("综合");

        if($(".sp-sort > li").eq(0).find(".dd").is(":visible")) {
            $(".sp-sort > li").eq(0).find(".dd").toggle();
        }
        $(this).siblings(".dd").show();
        $("html, body").scrollTop(0);
    });

    sx_dd.on("click", function(){
        $(this).hide();
    });

    sp_sort_sx.find(".dd-inner").on("click", function(event){
        event.stopPropagation();
    });

    /*仅显示有货*/
    $("#isInStore").click(function(){
        $(this).toggleClass("cur");
        var isInStore = "N";
        if ($(this).hasClass("cur")) {
            isInStore = "Y";
        }
        $(".sp-sort-sx > .dt").siblings(".dd").hide();
        window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&q="+paramData.q+"&isInStore="+isInStore+"&keyword="+paramData.keyword+"&order="+paramData.order;
    });

    sp_sort_sx.find(".dd-inner .li-dt").on("click", function(){
        $(this).siblings(".li-dd").show();
    });

    sp_sort_sx.find(".li-dd-title .btn-return").on("click", function(){
        $(this).parent().parent().hide();
    });

    sp_sort_sx.find(".sx-class .class-name").on("click", function(){
        $(this).siblings(".class-item-box").toggle();
    });

    sp_sort_sx.find(".sx-brand").on("click", function(){
        if (onOff == true) {
            arr_top = ["0"];
            for (var i = 1; i < brand_inner.find("li").length; i++) {
                arr_top.push(Math.round(brand_inner.find(".brand-name").eq(i).offset().top - title_height));
            }
            onOff = false;
        } else {
            return;
        }
    });

    initial_side.on("click", "span", function(){
        var index = $(this).index();
        brand_inner.parent().animate({scrollTop: arr_top[index] + "px"},0);
    });

    brand_inner.parent().on("scroll", function(){
        $("#list_inner").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        for (var i = 0; i < arr_top.length; i++) {
            if (arr_top[1] > $(this).scrollTop()) {
                initial_tips.html(initial_side.find("span").eq(0).html());
                return;
            } else if (arr_top[arr_top.length - i] <= $(this).scrollTop()) {
                initial_tips.html(initial_side.find("span").eq(arr_top.length - i).html());
                return;
            }
        }
    });

    /*选择分类*/
    $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".class-item-box").find("p").click(function () {
        $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".all-class").attr("data-active","false");
            $(this).attr("data-active","true");
            $(this).siblings().attr("data-active","false");
            $(this).parent().parent().siblings().find(".class-item-box").find("p").attr("data-active","false");
            var categoryId = "";
            $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".class-item-box").children().each(function () {
                if ($(this).attr("data-active") == "true") {
                    categoryId = $(this).attr("categoryid");
                }
            });
            $(this).parent().parent().parent().parent().hide();
            $(".sp-sort-sx > .dt").siblings(".dd").hide();
            window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+categoryId+"&isInStore="+paramData.isInStore+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&startPrice="+paramData.startPrice+"&endPrice="+paramData.endPrice;
    });

    /*分类返回*/
    $(".sp-sort-sx").find(".sx-class .li-dd-title").find(".btn-return").click(function () {
        $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".all-class").attr("data-active","true");
        $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".class-item-box").children().each(function () {
            if ($(this).attr("data-active") == "true") {
                $(this).attr("data-active","false");
            }
        });
    });

    /*选择品牌*/
    $(".sp-sort-sx").find(".sx-brand .li-dd-inner").find(".brand-item-box").find("p").click(function () {
        if ($(this).attr("data-active") == "true") {
            $(this).attr("data-active","false");
        } else {
            $(this).attr("data-active","true");
        }
    });

    /*确定品牌*/
    $("#confirmBrand").click(function () {
        $(".sp-sort-sx > .dt").siblings(".dd").hide();

        var str = "";
        var field = "";
        $(".sp-sort-sx").find(".dd-inner .li-dt").siblings(".li-dd").hide();
        $(".sp-sort-sx").find(".sx-brand .li-dd-inner").find(".brand-item-box").children().each(function () {
            if ($(this).attr("data-active") == "true") {
                field = ($(this).attr("field"));
                str += $(this).attr("fieldValue")+",";
            }
        });
        if (str.length > 0) {
            str = str.substring(0, str.length - 1);
        }
        var q = paramData.q;
        if (q != "") {
            var isAdd = false;
            var obj = q.split(";");
            for (var i = 0; i < obj.length; i++) {
                var subObj = obj[i].split(":");
                if(field==subObj[0]){
                    m.put(subObj[0], str);
                    isAdd = true;
                }
            }
            if(!isAdd){
                q = q+";"+field+":"+str;
            }
        }else{
            q = field+":"+str;
        }
        window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&isInStore="+paramData.isInStore+"&q="+q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page;
    });

    /*品牌返回*/
    $(".sp-sort-sx").find(".sx-brand .li-dd-title").find(".btn-return").click(function () {
        $(".sp-sort-sx").find(".sx-brand .li-dd-inner").find(".brand-item-box").children().each(function () {
            if ($(this).attr("data-active") == "true") {
                $(this).attr("data-active","false");
            }
        });
    });

    /*选择剂型*/
    $(".sp-sort-sx").find(".sx-jx .li-dd-inner").find("p").click(function () {
        if ($(this).attr("data-active") == "true") {
            $(this).attr("data-active","false");
        } else {
            $(this).attr("data-active","true");
        }
    });

    /*剂型返回*/
    $(".sp-sort-sx").find(".sx-jx .li-dd-title").find(".btn-return").click(function () {
        $(".sp-sort-sx").find(".sx-jx .li-dd-inner").children().each(function () {
            if ($(this).attr("data-active") == "true") {
                $(this).attr("data-active","false");
            }
        });
    });

    /*确定剂型*/
    $("#confirmDosage").click(function () {
        $(".sp-sort-sx > .dt").siblings(".dd").hide();
        var str = "";
        var field = "";
        $(".sp-sort-sx").find(".dd-inner .li-dt").siblings(".li-dd").hide();
        $(".sp-sort-sx").find(".sx-jx .li-dd-inner").children().each(function () {
            if ($(this).attr("data-active") == "true") {
                field = ($(this).attr("field"));
                str += $(this).attr("fieldValue")+",";
            }
        });
        if (str.length > 0) {
            str = str.substring(0, str.length - 1);
        }
        var q = paramData.q;
        if (q != "") {
            var isAdd = false;
            var obj = q.split(";");
            for (var i = 0; i < obj.length; i++) {
                var subObj = obj[i].split(":");
                if(field==subObj[0]){
                    m.put(subObj[0], str);
                    isAdd = true;
                }
            }
            if(!isAdd){
                q = q+";"+field+":"+str;
            }
        }else{
            q = field+":"+str;
        }
        window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&isInStore="+paramData.isInStore+"&q="+q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page;
    });

    /*价格区间查询*/
    $("#confirmBtn").click(function () {
        var reg = /^[0-9]*$/;
        var minPrice = $("#minSearchPrice").val();
        var maxPrice = $("#maxSearchPrice").val();

        if((minPrice == null || minPrice == "") && (maxPrice == null || maxPrice == "")){
            $(".sp-sort-sx > .dt").siblings(".dd").hide();
            window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&q="+paramData.q+"&isInStore="+paramData.isInStore+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page;
        }
        if(!reg.test(minPrice) || !reg.test(maxPrice)){
            alert("请输入大于等于0的整数！");
        }
        if((minPrice == null || minPrice == "") && (maxPrice != null && maxPrice != "")){
            $(".sp-sort-sx > .dt").siblings(".dd").hide();
            window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&q="+paramData.q+"&isInStore="+paramData.isInStore+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&startPrice="+"&endPrice="+maxPrice;
            $("#maxSearchPrice").val("");
        }
        if((minPrice != null && minPrice != "") && (maxPrice == null || maxPrice == "")){
            $(".sp-sort-sx > .dt").siblings(".dd").hide();
            window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&q="+paramData.q+"&isInStore="+paramData.isInStore+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&startPrice="+minPrice+"&endPrice=";
            $("#minSearchPrice").val("");
        }
        if((minPrice != null && minPrice != "") && (maxPrice != null && maxPrice != "")) {
            $(".sp-sort-sx > .dt").siblings(".dd").hide();
            window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&isInStore="+paramData.isInStore+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&startPrice="+minPrice+"&endPrice="+maxPrice;
            $("#maxSearchPrice").val("");
            $("#minSearchPrice").val("");
        }

        var min = parseInt(minPrice);
        var max = parseInt(maxPrice);
        if (max < min) {
            var temp = max;
            max = min;
            min =temp;
            $(".sp-sort-sx > .dt").siblings(".dd").hide();
            window.location.href=paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&isInStore="+paramData.isInStore+"&q="+paramData.q+"&keyword="+paramData.keyword+"&order="+paramData.order+"&page="+paramData.page+"&startPrice="+min+"&endPrice="+max;
            $("#maxSearchPrice").val("");
            $("#minSearchPrice").val("");
        }
    });

    //下拉加载更多数据
    var currentPage = 1;//当前滚动到的页数
    $("#list_inner").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".item" , //选择的是你要加载的那一个块（每次载入的数据放的地方）
        animate: true,
        loading: {
            finishedMsg: '无更多数据',
            finished: function() {
                $("#infscr-loading").remove();
            }
        },
        extraScrollPx: 50
    }, function(newElements) {
        if(currentPage > paramData.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
            $("#page-nav").remove();
            $("#list_inner").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }
        currentPage++;
    });

});

/**
 * 检查价格格式是否正确
 * @param obj 当前对象
 */
function checkPrice(obj) {
    var objValue = $(obj).val();
    var reg = /^[0-9]*$/;
    if (!reg.test(objValue)) {
        setTimeout(function () {
            $(obj).val("");
        },300);
    }
    if (objValue.length > 6) {
        $(obj).val(objValue.substring(0,6));
    }
}

/**
 * 改变新品排序方式
 * @param obj 当前对象
 */
function changeSortByOnSaleDate(obj) {
    var order = paramData.order;
    if ("lastOnSaleDate,desc" == order) {
        window.location.href =paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order=lastOnSaleDate,asc"+"&page="+paramData.page;
    } else {
        window.location.href =paramData.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order=lastOnSaleDate,desc"+"&page="+paramData.page;
    }
}

$(window).scroll(hideTopSearch);
function hideTopSearch(){
    var sTop = $(window).scrollTop();
    var scBox2 = $(".list-head-t");
    var scBox1 = $(".list-head-b");
    if(sTop < scBox1.height()){
        scBox2.slideDown("1000");
    } else {
        scBox2.slideUp("1000");
    }
}