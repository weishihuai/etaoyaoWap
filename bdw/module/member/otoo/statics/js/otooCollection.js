//删除收藏O2O商品 start
function deleteSingCollection(otooProductId) {
    var result = window.confirm("确定删除吗?");
    if(result == false){
        return;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type: "POST",
        url: webPath.webRoot + "/member/delUserOtooProductCollect.json",
        data: {otooProductId: otooProductId},
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                alert("删除成功!");
                window.location.reload();
            } else {
                alert("系统错误,请刷新重新操作!");
            }
        }
    });
}
//删除收藏O2O商品 end
