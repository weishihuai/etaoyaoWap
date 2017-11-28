var category = 1;

$(document).ready(function(){
    loadFilterBrand(paramData.category);

    var page = 1;

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
        var categoryName = "";
        $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".class-item-box").children().each(function () {
            if ($(this).attr("data-active") == "true") {
                categoryId = $(this).attr("categoryid");
                categoryName = $(this).text();
            }
        });
        $(this).parent().parent().parent().parent().hide();
        $("#categoryName").text(categoryName);
        category = categoryId;
        loadFilterBrand(categoryId);
        loadFilterForm(categoryId);
    });

    /*分类返回*/
    $(".sp-sort-sx").find(".sx-class .li-dd-title").find(".btn-return").click(function () {
        $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".all-class").attr("data-active","true");
        $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".class-item-box").children().each(function () {
            cleanSelectedInfo($(this));
        });
    });

    /*确定品牌*/
    $("#confirmBrand").click(function () {
        getSelectedBrand();
    });

    /*品牌返回*/
    $(".sp-sort-sx").find(".sx-brand .li-dd-title").find(".btn-return").click(function () {
        $(".sp-sort-sx").find(".sx-brand .li-dd-inner").find(".brand-item-box").children().each(function () {
            cleanSelectedInfo($(this));
        });
    });

    /*剂型返回*/
    $(".sp-sort-sx").find(".sx-jx .li-dd-title").find(".btn-return").click(function () {
        $(".sp-sort-sx").find(".sx-jx .li-dd-inner").children().each(function () {
            cleanSelectedInfo($(this));
        });
    });

    /*确定剂型*/
    $("#confirmDosage").click(function () {
        getSelectedForm();
    });

    //重置搜索参数
    $(".btn-reset").live("touchstart", function(){
        $("#isInStore").removeClass("cur");
        $("#minSearchPrice").val("");
        $("#maxSearchPrice").val("");
        $("#categoryName").text("全部");
        $("#brandName").text("全部");
        $("#formName").text("全部");

        category = 1;

        /*清除选中分类信息*/
        $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".all-class").attr("data-active","true");
        $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".class-item-box").children().each(function () {
            cleanSelectedInfo($(this));
        });

        /*清除选中品牌信息*/
        $(".sp-sort-sx").find(".sx-brand .li-dd-inner").find(".brand-item-box").children().each(function () {
            cleanSelectedInfo($(this));
        });

        /*清除选中剂型信息*/
        $(".sp-sort-sx").find(".sx-jx .li-dd-inner").children().each(function () {
            cleanSelectedInfo($(this));
        });
        loadFilterBrand(1);
        loadFilterForm(1);
    });

    /*统计查询条件*/
    $("#selectResult").live("touchstart", function(){
        /*是否仅显示有货*/
        var isInStore = 'N';
        if ($("#isInStore").hasClass("cur")) {
            isInStore = 'Y';
        }

        /*价格区间*/
        var reg = /^[0-9]*$/;
        var minPrice = $("#minSearchPrice").val();
        var maxPrice = $("#maxSearchPrice").val();

        if(!reg.test(minPrice) || !reg.test(maxPrice)){
            alert("请输入大于等于0的整数！");
        }

        var min = parseInt(minPrice);
        var max = parseInt(maxPrice);
        if (max < min) {
            var temp = max;
            max = min;
            min =temp;
        }

        /* q查询参数  */
        var  queryParam1 = getSelectedBrand();
        var  queryParam2 = getSelectedForm();

        var queryParam = '';
        if (":" == queryParam1 && ":" == queryParam2) {
            queryParam = '';
        } else if("" != queryParam1 && ":" == queryParam2) {
            queryParam = queryParam1;
        } else if(":" == queryParam1 && !"" != queryParam2) {
            queryParam = queryParam2;
        } else {
            queryParam = queryParam1 + ";" + queryParam2;
        }

        if (isNaN(min) && isNaN(max)) {
            window.location.href = paramData.webRoot + "/wap/productList.ac?category=" + category + "&isInStore=" + isInStore + "&q=" + queryParam + "&keyword=" + paramData.keyword + "&order=" + paramData.order + "&page=" + paramData.page;
        } else if (!isNaN(min) && isNaN(max)) {
            window.location.href = paramData.webRoot + "/wap/productList.ac?category=" + category + "&isInStore=" + isInStore + "&q=" + queryParam + "&keyword=" + paramData.keyword + "&order=" + paramData.order + "&page=" + paramData.page + "&startPrice=" + min;
        } else if (isNaN(min) && !isNaN(max)) {
            window.location.href = paramData.webRoot + "/wap/productList.ac?category=" + category + "&isInStore=" + isInStore + "&q=" + queryParam + "&keyword=" + paramData.keyword + "&order=" + paramData.order + "&page=" + paramData.page + "&endPrice=" + max;
        } else {
            window.location.href = paramData.webRoot + "/wap/productList.ac?category=" + category + "&isInStore=" + isInStore + "&q=" + queryParam + "&keyword=" + paramData.keyword + "&order=" + paramData.order + "&page=" + paramData.page + "&startPrice=" + min + "&endPrice=" + max;
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
        window.location.href =paramData.webRoot+"/wap/productList.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order=lastOnSaleDate,asc"+"&page="+paramData.page;
    } else {
        window.location.href =paramData.webRoot+"/wap/productList.ac?category="+paramData.category+"&q="+paramData.q+  "&isInStore="+ paramData.isInStore +"&keyword="+paramData.keyword+"&order=lastOnSaleDate,desc"+"&page="+paramData.page;
    }
}

/**
 * 滚动动态隐藏显示搜索框
 */
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

/**
 * 根据分类ID动态加载品牌信息
 * @param categoryId 分类ID
 */
function loadFilterBrand(categoryId) {
    $.get(paramData.webRoot + "/wap/loadBrand.ac", {category: categoryId}, function (data) {
        $("#brandDiv").html('').append(data);
        $("#brandMenu").css("display", $("#brandBox:has(li)").length == 0 ? "none" : "block");
    });
}

/**
 * 根据分类ID动态加载剂型信息
 * @param categoryId 分类ID
 */
function loadFilterForm(categoryId) {
    $.get(paramData.webRoot + "/wap/loadForm.ac", {category: categoryId}, function (data) {
        $("#formDiv").html('').append(data);
        $("#formMenu").css("display", $("#innerDiv:has(p)").length == 0 ? "none" : "block");
    });
}

/**
 * 动态添加的品牌/剂型 点击事件处理
 * @param obj 当前对象
 */
function selectBrandOrForm(obj) {
    $(obj).attr("data-active", $(obj).attr("data-active") == "true" ? "false" : "true");
}

/**
 * 清除选中的分类/品牌/剂型信息
 * @param obj 当前对象
 */
function cleanSelectedInfo(obj) {
    if ($(obj).attr("data-active") == "true") {
        $(obj).attr("data-active", "false");
    }
}

function getSelectedBrand() {
    var str = "";
    var field = "";
    $(".sp-sort-sx").find(".dd-inner .li-dt").siblings(".li-dd").hide();

    var arr = [];
    $(".sp-sort-sx").find(".sx-brand .li-dd-inner").find(".brand-item-box").children().each(function () {
        if ($(this).attr("data-active") == "true") {
            field = ($(this).attr("field"));
            str += $(this).attr("fieldValue")+",";
            arr.push($(this).text());
        }
    });

    /*回显当前选中的品牌信息*/
    showSelectedBrandOrFormName("#brandName",arr);

    if (str.length > 0) {
        str = str.substring(0, str.length - 1);
    }
    var q = '';
    if (q != "") {
        var isAdd = false;
        var obj = q.split(";");
        for (var i = 0; i < obj.length; i++) {
            var subObj = obj[i].split(":");
            if(field==subObj[0]){
                isAdd = true;
            }
        }
        if(!isAdd){
            q = q+";"+field+":"+str;
        }
    }else{
        q = field+":"+str;
    }
    return q;
}

function getSelectedForm() {
    var str = "";
    var field = "";
    $(".sp-sort-sx").find(".dd-inner .li-dt").siblings(".li-dd").hide();

    var arr = [];
    $(".sp-sort-sx").find(".sx-jx .li-dd-inner").children().each(function () {
        if ($(this).attr("data-active") == "true") {
            field = ($(this).attr("field"));
            str += $(this).attr("fieldValue")+",";
            arr.push($(this).text());
        }
    });

    /*回显当前选中的剂型信息*/
    showSelectedBrandOrFormName("#formName",arr);

    if (str.length > 0) {
        str = str.substring(0, str.length - 1);
    }
    var q = '';
    if (q != "") {
        var isAdd = false;
        var obj = q.split(";");
        for (var i = 0; i < obj.length; i++) {
            var subObj = obj[i].split(":");
            if(field==subObj[0]){
                isAdd = true;
            }
        }
        if(!isAdd){
            q = q+";"+field+":"+str;
        }
    }else{
        q = field+":"+str;
    }
    return q;
}


/**
 * 解析url中的参数Q为一个Map类型
 * @param q url参数
 * @returns {Map}
 */
function parsingQ(q) {
    q = $.trim(q);
    var qMap = new Map();
    if (q == "" || q == ";") {
        return qMap;
    } else {
        var q1 = q.split(";");
        for (var i = 0; i < q1.length; i++) {
            var qi = q1[i];
            if ($.trim(qi) != "") {
                var q2 = qi.split(":");
                qMap.put(q2[0], q2[1]);
            }
        }
    }
    return qMap;
}

/*
 * MAP对象，实现MAP功能
 *
 * 接口：
 * size()     获取MAP元素个数
 * put(key, value)   向MAP中增加元素（key, value)
 * remove(key)    删除指定KEY的元素，成功返回True，失败返回False
 * get(key)    获取指定KEY的元素值VALUE，失败返回NULL
 * containsKey(key)  判断MAP中是否含有指定KEY的元素
 * 例子：
 * var map = new Map();
 *
 * map.put("key", "value");
 * var val = map.get("key")
 * ……
 *
 */
function Map() {
    this.elements = new Array();

    //获取MAP元素个数
    this.size = function () {
        return this.elements.length;
    };

    //向MAP中增加元素（key, value)
    this.put = function (_key, _value) {
        this.elements.push({
            key: _key,
            value: _value
        });
    };

    //删除指定KEY的元素，成功返回True，失败返回False
    this.removeByKey = function (_key) {
        var bln = false;
        try {
            for (i = 0; i < this.elements.length; i++) {
                if (this.elements[i].key == _key) {
                    this.elements.splice(i, 1);
                    return true;
                }
            }
        } catch (e) {
            bln = false;
        }
        return bln;
    };


    //获取指定KEY的元素值VALUE，失败返回NULL
    this.get = function (_key) {
        try {
            for (i = 0; i < this.elements.length; i++) {
                if (this.elements[i].key == _key) {
                    return this.elements[i].value;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    };

    //获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL
    this.element = function (_index) {
        if (_index < 0 || _index >= this.elements.length) {
            return null;
        }
        return this.elements[_index];
    };

    //判断MAP中是否含有指定KEY的元素
    this.containsKey = function (_key) {
        var bln = false;
        try {
            for (i = 0; i < this.elements.length; i++) {
                if (this.elements[i].key == _key) {
                    bln = true;
                }
            }
        } catch (e) {
            bln = false;
        }
        return bln;
    };

    //获取value通过key
    this.valueByKey = function (_key) {
        for (i = 0; i < this.elements.length; i++) {
            if (_key == this.elements[i].key) {
                return this.elements[i].value;
            }
        }
    };
}

/**
 * 回显用户选中的品牌剂型信息
 * @param id 选择器
 * @param arr 值(数组类型)
 */
function showSelectedBrandOrFormName(id, arr) {
    var name = "";
    $(arr).each(function(i,n){
        name = name.concat( n + " 、");
    });
    name = name.substring(0,name.length - 1);

    if(name.length > 15) {
        name = name.substring(0,15);
        name += "...";
    }
    $(id).text(name);
}