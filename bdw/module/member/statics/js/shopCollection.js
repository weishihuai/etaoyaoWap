/**
 * Created by IntelliJ IDEA.
 * User: feng_lh
 * Date: 12-4-1
 * Time: 下午4:12
 * To change this template use File | Settings | File Templates.
 */
    //未实施
function gotoBuy(skuId){
    //未实施
//            var num =1;
//            var skuId=skuId ;
//            $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
//            $.ajax({url:dataValue.webRoot+"/cart/shoppingCart/productItemAdd.ac?_method=get&skuId="+skuId+"&num="+num+"&promotionTypeCode=0",
//                        success:function(){
//                            $("#shoppingCartTip").load(dataValue.webRoot+"/page/template/includeProduct/shoppingCartTip.jsp");
//                            showComment();
//                        }}
//            );
}
//未实施
//关闭购物车弹出层
function closeShoppingCartTip(){
    $("#shoppingCartTip").hide();
    $("#wrap_id").hide();
    $("#wrap_success").hide();
}
//关闭购物车弹出层

//删除收藏商品 start
function deleteSingCollection(skuId){
    var $Arr = [];
    $Arr[0] = skuId;
    reomveCollection($Arr);
}
function reomveCollection($Arr){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";

    var cancelShopCollection = jDialog.confirm('<span style="margin-left: 10px">确定取消收藏该店铺吗!</span>',{
        type : 'highlight',
        text : '确定',
        handler : function(button,cancelShopCollection) {
            cancelShopCollection.close();
            $.ajax({
                type:"POST",url:dataValue.webRoot+"/member/delUserShopCollect.json",
                data:{items:$Arr.join(",")},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        var callbackDialog = jDialog.alert('删除成功!',{
                            type : 'highlight',
                            text : '确定',
                            handler : function(button,callbackDialog) {
                                callbackDialog.close();
                                window.location.reload();
                            }
                        });
                    }else{
                        shopCollectionAlertDialog("系统错误,请刷新重新操作!");
                    }
                }
            });
        }
    },{
        type : 'normal',
        text : '取消',
        handler : function(button,cancelShopCollection) {
            cancelShopCollection.close();
        }
    });
}
//删除收藏商品 end

//显示评论 start
function showComment(){
    $.openDOMWindow({
                loader:0,
                windowBGColor:"#FFFFFF",
                width:438,
                height:207,
                borderSize:0,
                windowSourceID:'#innerWin',
                windowPadding:0,
                overlay:0
            });
    return false;
}
//显示评论 end

//关闭评论 start
function closeComment(){
    $.closeDOMWindow()
}
//关闭评论 end


//最普通最常用的alert对话框，默认携带一个确认按钮
var shopCollectionAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};