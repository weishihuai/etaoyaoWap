$.fn.extend({
    "slidelf1":function (value) {
        value = $.extend({
            "prev":"",
            "next":"",
            "speed":"",
            "vertical":false
        }, value)
        var dom_this = $(this).get(0);	//将jquery对象转换成DOM对象;以便其它函数中调用；
        if(value.vertical){
            var marginl = parseInt($("ul li:first", this).css("margin-top")); //每个图片margin的数值
            var movew = $("ul li:first", this).outerHeight() + marginl;	//需要滑动的数值
        }else{
            var marginl = parseInt($("ul li:first", this).css("margin-left")); //每个图片margin的数值
            var movew = $("ul li:first", this).outerWidth() + marginl;	//需要滑动的数值
        }
        //左边的动画
        function leftani() {
            if(value.vertical){
                $("ul li:first", dom_this).animate({"margin-top":-movew}, value.speed, function () {
                    $(this).css("margin-top", marginl).appendTo($("ul", dom_this));
                });
            }else{
                $("ul li:first", dom_this).animate({"margin-left":-movew}, value.speed, function () {
                    $(this).css("margin-left", marginl).appendTo($("ul", dom_this));
                });
            }
        }
        //右边的动画
        function rightani() {
            $("ul li:last", dom_this).prependTo($("ul", dom_this));
            if(value.vertical){
                $("ul li:first", dom_this).css("margin-top", -movew).animate({"margin-top":marginl}, value.speed);
            }else{
                $("ul li:first", dom_this).css("margin-left", -movew).animate({"margin-left":marginl}, value.speed);
            }
        }
        //点击左边
        $("." + value.prev).click(function () {
            if (!$("ul li:first", dom_this).is(":animated")) {
                leftani();
            }
        });
        //点击左边
        $("." + value.next).click(function () {
            if (!$("ul li:first", dom_this).is(":animated")) {
                rightani();
            }
        })
    }
});