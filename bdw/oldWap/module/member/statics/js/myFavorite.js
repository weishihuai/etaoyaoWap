function delCollect(productId){
    xyPop({
        id: "pop_msg",
        title: "删除商品",
        content: "您确认要删除此收藏商品吗！",
        type: "confirm",
        padding: 15,
        btn: ["确定","取消"],
        btn2: function(){
        },
        btn1: function(){
            $.ajax({
                type:"POST",
                url:dataValue.webRoot+"/member/delUserProductCollect.json",
                data:{items:productId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        xyPop({content:'删除成功!',type:'success',btn:['确定'],
                        onClose:function(){
                            window.location.reload();
                        },
                        btn1:function(){
                            window.location.reload();
                        }});
                    }else{
                        xyPop({content:'系统错误,请刷新重新操作!',type:'error'});
                    }
                }
            });
        },
        fixed: true
    });
}


function doShopCollectDelete(shopId){
    xyPop({
        id: "pop_msg",
        title: "删除店铺收藏",
        content: "您确认要删除此收藏店铺吗！",
        type: "confirm",
        padding: 15,
        btn: ["确定","取消"],
        btn2: function(){
        },
        btn1: function(){
            $.ajax({
                type:"POST",
                url:dataValue.webRoot+"/member/delUserShopCollect.json",
                data:{items:shopId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        xyPop({content:'删除成功!',type:'success',btn:['确定'],
                            onClose:function(){
                                window.location.reload();
                            },
                            btn1:function(){
                                window.location.reload();
                            }});
                    }else{
                        xyPop({content:'系统错误,请刷新重新操作!',type:'error'});
                    }
                }
            });
        },
        fixed: true
    });
}

// 跳转到店铺
function gotoStore(obj){
    var orgId = $(obj).attr("orgId");
    var isSupportBuy = $(obj).attr("isSupportBuy");
    if (isEmpty(orgId)) {
        return;
    }
    if (isEmpty(isSupportBuy) || 'Y' != isSupportBuy) {
        showError("该店铺不支持购买");
        return;
    }
    window.location.href = dataValue.webRoot + "/wap/citySend/storeIndex.ac?orgId=" + orgId;
}
function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}