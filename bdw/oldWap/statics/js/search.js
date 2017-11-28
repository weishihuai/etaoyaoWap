$(document).ready(function(){
    $("#search_btn").click(function(){
        $(".search-list").hide();
        var searchFields=document.getElementById("put");
        if(searchFields.value==null || searchFields.value==""||searchFields.value=="内置关键字搜索"){
            $("#alert").removeClass("sr-only");
            $("#alert").text("请输入搜索关键字!");
            return false;

        }
        var searchForm=document.getElementById("searchForm");
        setTimeout(function() {
            searchForm.submit();
        },1);
        return true;
    });

    //保存搜索记录cookie
    $(".btn-danger").click(function(){
        var put =$("#put").val();
        $.ajax({
            type:"POST",
            url:Top_Path.webRoot+"/member/addCookie.json",
            data:{"put":put},
            dataType: "json",
            async: false,//同步
            success:function(data) {
                if (data.success == "true") {

                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    })
    $("body").bind('keyup',function(event) {
        var put =$("#put").val();
        if(put==""){
            $(".search-list").show();
        }else {
            $(".search-list").hide();
        }
        if(event.keyCode==13){
            $(".search-list").hide();
            $.ajax({
                type:"POST",
                url:Top_Path.webRoot+"/member/addCookie.json",
                data:{"put":put},
                dataType: "json",
                async: false,//同步
                success:function(data) {
                    if (data.success == "true") {

                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        };
    });

    //显示搜索记录
    $("#put").click(function(){
        $(".search-list").show();
    })

    //选择搜索记录，在搜索框显示
    $("#search-list").find("li").each(function(){
        $(this).click(function(){
            $("#put").val($(this).find("a").html());
            $(".search-list").hide();
        })
    })

    $("#put").blur(function(){
        $("#no-search-list").hide();
    })
})