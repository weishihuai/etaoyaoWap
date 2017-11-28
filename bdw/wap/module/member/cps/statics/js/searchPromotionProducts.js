
$(document).ready(function() {
    //搜索按钮
    $(".hr-btn").click(function(){
        var searchFields = $.trim($("#searchFields").val());
        if(searchFields==""){
            alert("请输入搜索关键字");
            $("#searchFields").val(searchFields);
            return false;
        }
        $("#searchFields").val(searchFields);
        $("form").submit();
    });
    //监听回车事件
    $("#searchFields").keypress(function (e) { //这里给function一个事件参数命名为e，叫event也行，随意的，e就是IE窗口发生的事件。
        var key = e.which; //e.which是按键的值
        if (key == 13) {
            $("form").submit();
        }
    });
    $(".search-input .del").click(function () {
        $(this).prev().val("");
    });


});