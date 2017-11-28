(function($){
    $(document).ready(function(){

        //左边的店内搜索
        $("#shopLeftMenuSearch").click(function () {
            var reg = new RegExp("\d{1,9}(\.\d{0,2}|)");
            var minPrice = $("#left_minPrice").val();
            var maxPrice = $("#left_maxPrice").val();
            if (reg.test(minPrice)||reg.test(maxPrice)) {
                alertShopPrdListDialog("请输入正确的价格!");
                return;
            }
            if ( parseFloat(minPrice)>parseFloat(maxPrice)) {
                alertShopPrdListDialog("价格区间应从小到大!");
                return;
            }
            $("#searchShopFormLeft").submit();
        });

        //显示商品价格筛选框
        $("#selectPrice").hover(function () {
            $("#xz_btn").show();
        }, function () {
            $("#xz_btn").hide();
        });
        //显示商品价格筛选框

        $(".searchBox").focus(function () {
            $(".xz_btn").show();
        });
        $(".searchBoxQk").click(function () {
            $(".searchBox").val("");
            $("#left_minPrice").val("");
            $("#left_maxPrice").val("");
            $(".xz_btn").hide();
        });
        $(".searchBoxQd").click(function () {
            var reg = new RegExp("\d{1,9}(\.\d{0,2}|)");
            var minPrice = $("#s-minPrice").val();
            var maxPrice = $("#s-maxPrice").val();
            if (minPrice == null || maxPrice == null || minPrice == "" || maxPrice == "") {
                alertShopPrdListDialog("请完善搜索条件!");
                return;
            }
            if (reg.test(minPrice)||reg.test(maxPrice)) {
                alertShopPrdListDialog("请输入正确的价格!");
                return;
            }
            if ( parseFloat(minPrice)>parseFloat(maxPrice)) {
                alertShopPrdListDialog("价格区间应从小到大!");
                return;
            }
            var url = "/shopTemplate/default/shopProductList.ac?" +
                "shopId=" + paramData.shopId +
                "&shopCategoryId=" + paramData.shopCategoryId +
                "&q=" + paramData.q +
                "&keyword=" + paramData.keyword +
                "&minPrice=" + minPrice +
                "&maxPrice=" + maxPrice +
                "&order=" + paramData.order;

            $(".xz_btn").hide();
            setTimeout(function () {
                window.location.href = paramData.webRoot + url;
            }, 1);
        });
        /*上一页和下一页事件 start*/
        $("#pageUp").click(function () {
            //checkPage();
            if (paramData.page == 1) {
                alertShopPrdListDialog("当前已是第一页!");
                return;
            }
            var page = parseInt(paramData.page) - 1;
            window.location.href=paramData.webRoot+"/shopTemplate/default/shopProductList.ac?shopCategoryId="+paramData.shopCategoryId+"&shopId="+paramData.shopId+"&page="+page;
        });

        $("#pageDown").click(function () {
            //checkPage();
            if (paramData.page == paramData.totalCount) {
                alertShopPrdListDialog("当前已是最后一页!");
                return;
            }
            var page = parseInt(paramData.page) + 1;
            window.location.href=paramData.webRoot+"/shopTemplate/default/shopProductList.ac?shopCategoryId="+paramData.shopCategoryId+"&shopId="+paramData.shopId+"&page="+page;
        });
        /*上一页和下一页事件 end*/
    });

})(jQuery);

function Collect(webName, webUrl) {
    if (document.all) {
        window.external.addFavorite(webUrl, webName);
    }
    else if (window.sidebar) {
        try {
            window.sidebar.addPanel(webName, webUrl, "");
        } catch (e) {

        }
    }
    else {
        alertShopPrdListDialog("收藏失败！请使用Ctrl+D进行收藏");
    }
}



//最普通最常用的alert对话框，默认携带一个确认按钮
var alertShopPrdListDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};
