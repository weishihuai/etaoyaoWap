(function($){
    $(document).ready(function(){
        if(Top_Path.topParam=="index"||Top_Path.topParam=="list"||Top_Path.topParam=="detail"){
            if(window.screen.width<1200){
                $("body").addClass("w");
                showScreen(".widthScreen",".commonScreen");
            }else{
                showScreen(".commonScreen",".widthScreen");
            }
        }else{
            $("body").addClass("q");
            showScreen(".widthScreen",".commonScreen");
            $(".widthScreen").find("img").css("width","980px");
        }
        $("body").css("display","block");
        $(".me_Layer").bgiframe();
        $(".layer_show").bgiframe();

        $(".icondt").find(".icon").each(function(){
            var src=$(this).find("img").attr("src");
            if(src.split("/upload/")[1] == ""){
                $(this).hide();
            }
        })

        $("#showAllCategory").hover(function(){
            $(this).hide();
            $(".itemBox").show();
            $(".itemBox").hover(function(){
                $(".itemBox").show();
                $("#showAllCategory").hide();
                $(".layer_show_more").hover(function(){
                    $(".itemBox").show();
                    $("#showAllCategory").hide();
                },function(){
                    $(".itemBox").hide();
                    $("#showAllCategory").show();
                })
            },function(){
                $(".itemBox").hide();
                $("#showAllCategory").show();
            })
        },function(){
        })

        $("#myAccount").hover(function(){
            $(this).find(".in").children("a").addClass("cur");
            $(this).find(".myCop").show();

        },function(){
            $(this).find(".in").children("a").removeClass("cur");
            $(this).find(".myCop").hide();
        })

        $("#myService").hover(function(){
            $(this).find(".in").children("a").addClass("cur");
            $(this).find(".myCop").show();

        },function(){
            $(this).find(".in").children("a").removeClass("cur");
            $(this).find(".myCop").hide();
        })
        $("#myCart").hover(function(){
            var showlist = $(this).find(".showlist");
            showlist.load(Top_Path.webRoot+"/template/bdw/module/common/cartlayer.jsp?time="+new Date().getTime(),function(){
                showlist.show();
            });

        },function(){
            $(this).find(".showlist").hide();
        })
        $(".putArea").find("a").click(function(){
            var searchFields=document.getElementById("searchFields");
            if(searchFields.value==null || searchFields.value==""||searchFields.value=="请输入关键字"){
                alert("请输入搜索关键字");
                return false;

            }
            var searchForm=document.getElementById("searchForm");
            setTimeout(function() {
                searchForm.submit();
            },1);
            return true;
        })

        $(".l_btn").hover(function(){
            $(this).find(".me_Layer").show();
            $(this).find(".me_Layer").find(".layer_father").hover(function(){
                $(this).children(".layer_item").addClass("hover").show();
                $(this).children(".layer_show").show();
/*                $(this).addClass("hover");
                var itemIndx = $('.layer_item').index($(this));
                $(".layer_show").eq(itemIndx).show();
                var thisLayerWidth=$(".layer_show").eq(itemIndx).css("height").split("p")[0];
                var thisItemWidth=34*itemIndx+22;
                if(thisLayerWidth <  thisItemWidth ){
                    $(".layer_show").eq(itemIndx).css("margin-top",(thisItemWidth-thisLayerWidth+20)+"px");
                }*/
            },function(){
                $(this).children(".layer_item").removeClass("hover");
                $(this).children(".layer_show").hide();
      /*          $(this).removeClass("hover");
                var itemIndx = $('.layer_item').index($(this));
                $(".layer_show").eq(itemIndx).hide();*/
            });
/*            $(".layer_show").hover(function(){
                $(this).show();
                var layerIndx = $('.layer_show').index($(this));
                $(".layer_item").eq(layerIndx).addClass("hover");
            },function(){
                $(this).hide();
                var layerIndx = $('.layer_show').index($(this));
                $(".layer_item").eq(layerIndx).removeClass("hover");
            })*/
        },function(){
            if($("#isIndex").val()=="Y"){
                return true;
            }else{
                $(this).find(".me_Layer").hide();
            }
        });

        $(".tal_Acunnt").hover(function(){
            $(".Acunnt_info").show();
            $(".Acunnt_info").hover(function(){
                $(this).show();
            },function(){
                $(this).hide();
            })
        },function(){
            $(".Acunnt_info").hide();
        })
        $(".tal_Car").hover(function(){
            $(".Car_info").show();
            $(".Car_info").hover(function(){
                $(this).show();
            },function(){
                $(this).hide();
            })
        },function(){
            $(".Car_info").hide();
        })
    });

})(jQuery);
//清空商品的cookie
var clearHistoryCookie = function(divId){
    $.get(Top_Path.webRoot+"/member/clearProductsCookie.json",function(data){
        $(divId).html("<ul>暂无浏览商品记录</ul>");
    });
};

function showScreen(showScreen,removeScreen){
    $(showScreen).show();
    $(removeScreen).hide();
}

function toSearchSubmit(){
//    if($("#searchFields").val()=="请输入搜索关键字"){
//        $("#searchFields").attr("value","");
//    }
    setTimeout(function(){
        $("#searchForm").submit();
    },1)
}
function toFocus(){
//    if($("#searchFields").val()=="请输入搜索关键字"){
//        $("#searchFields").attr("value","");
//    }
    $("#searchFields").attr("value","");
}

