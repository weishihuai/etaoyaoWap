
var page = 1;
$(document).ready(function(){

    /*var agent = navigator.userAgent.toLowerCase();
    res = agent.match(/windows/);
    if(res == "windows"){
        $("body").css({
            "width":"320px",
            "margin-left":"auto",
            "margin-right":"auto"
        });
    }*/

    $("#put").focus(function(){
        window.location.href = webPath.webRoot + "/wap/search.ac";
    });

    /*搜索*/
    $("#search_btn").click(function(){
        if($("#put").val()==""||$("#put").val()==null||$("#put").val()=="请输入关键字搜索"){
            return false;
        }
        var searchForm=document.getElementById("searchForm");
        setTimeout(function() {
            searchForm.submit();
        },1);
        return true;
    });

    $(".star").click(function(){
        var obj = $(this);
        var productId = obj.attr("productId");
        if (productId == '' || productId == undefined) {
            return;
        }
        if(obj.attr("isCollect") == 'false'){
            $.get(webPath.webRoot + "/member/collectionProduct.json?productId=" + productId, function (data) {
                if (data.success == "false") {
                    if (data.errorCode == "errors.login.noexist") {
                        window.location.href = webPath.webRoot + "/wap/login.ac";
                    }
                    if (data.errorCode == "errors.collection.has") {
                        breadDialog("您已收藏此商品","ok",1000,false);
                    }
                } else if (data.success == true) {
                    $(obj).addClass("cur");
                    obj.attr("isCollect","true");
                    breadDialog("商品收藏成功","ok",1000,false);
                }
            });
        }
        else{
            $.ajax({
                type:"POST",url:webPath.webRoot+"/member/delUserProductCollect.json",
                data:{items:productId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        breadDialog("成功取消收藏","ok",1000,false);
                        obj.removeClass("cur");
                        obj.attr("isCollect","false");
                    }else{
                        breadDialog("系统错误,请刷新重新操作","alert",1000,false);
                    }
                }
            });
        }
    });

    $(".more").click(function(){
        page++;
        var url = "/wap/indexRecommendProduct.ac?page=" + page;
        $.ajax({
            url : url,
            success: function(data){
                if(!(data.trim().endWith("</script>"))){
                    $(".floor04-list").append(data);
                } else{
                    breadDialog("没有更多商品了!","alert",1000,false);
                    $(".more").css("display","none");
                }
            },
            error: function(){
                console.log("请求有误");
            }
        })
    });


    /*$("#search_btn").bind('click',function(){
        if($("#put").val()==""||$("#put").val()==null||$("#put").val()=="请输入关键字搜索"){
            return false;
        }
        var searchForm=document.getElementById("searchForm");
        setTimeout(function() {
            searchForm.submit();
        },1);
        return true;
    });*/

   /* $(".main_visual").hover(function(){
        $("#btn_prev,#btn_next").fadeIn()
    },function(){
        $("#btn_prev,#btn_next").fadeOut()
    })
    $dragBln = false;
    $(".main_image").touchSlider({
        flexible : true,
        speed : 400,
        btn_prev : $("#btn_prev"),
        btn_next : $("#btn_next"),
        paging : $(".flicking_con a"),
        counter : function (e) {
            $(".flicking_con a").removeClass("on").eq(e.current-1).addClass("on");
        }
    });
    $(".main_image").bind("mousedown", function() {
        $dragBln = false;
    })
    $(".main_image").bind("dragstart", function() {
        $dragBln = true;
    })
    $(".main_image a").click(function() {
        if($dragBln) {
            return false;
        }
    })
    timer = setInterval(function() { $("#btn_next").click();}, 5000);
    $(".main_visual").hover(function() {
        clearInterval(timer);
    }, function() {
        timer = setInterval(function() { $("#btn_next").click();}, 5000);
    })
    $(".main_image").bind("touchstart", function() {
        clearInterval(timer);
    }).bind("touchend", function() {
            timer = setInterval(function() { $("#btn_next").click();}, 5000);
        })*/

});

function deleteSingCollection(object){
    var obj = $(object);
    var productId = $(obj).attr("productId");
    alert(productId);
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",url:webPath.webRoot+"/member/delUserProductCollect.json",
        data:{items:$Arr.join(",")},
        dataType:"json",
        success:function(data){
            if (data.success == "true") {
                alert("成功取消收藏!");
                //$(this).removeClass("cur");+
                //$(this).addClass("noCollect");
                //$(this).removeClass("collect");
            }else{
                alert("系统错误,请刷新重新操作!");
            }
        }
    });
}
//这里是判断某字符串是否以特定字符串结尾的函数(比如判断hello是否以lo结尾)
String.prototype.endWith=function(endStr){
    var d=this.length-endStr.length;
    return (d>=0&&this.lastIndexOf(endStr)==d)
};

