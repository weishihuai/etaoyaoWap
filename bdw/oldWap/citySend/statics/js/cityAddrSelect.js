/**
 * Created by lhw on 2016/12/29.
 */
jQuery(function($) {
    var isEditOrDel = false; // 是否点击了编辑或删除按钮，因为点击了会触发选择地址事件
    $(document).ready(function () {
        // 删除
        $(".delBtn").click(function(){
            isEditOrDel = true;
            var receiveAddrId = $(this).attr("receiveAddrId");
            if (isEmpty(receiveAddrId)) {
                return;
            }
            showConfirm("你确定要删除此收货地址吗?",function() {
                $.ajax({
                    type:"post" ,
                    url:webPath.webRoot+"/member/deleteUserAddress.json?id=" + receiveAddrId ,
                    dataType: "json",
                    success:function(data) {
                        if (data.success == true) {
                            showSuccess("删除成功", function(){
                                window.location.reload();
                            })
                        }else{
                            showError("删除失败!");
                        }
                    },
                    error:function() {
                        showError("系统繁忙，请稍后重试!");
                    }
                });
            });
        });

        // 修改
        $(".editBtn").click(function(){
            isEditOrDel = true;
            var receiveAddrId = $(this).attr("receiveAddrId");
            if (isEmpty(receiveAddrId)) {
                return;
            }
            window.location.href = webPath.webRoot + "/wap/module/member/addressOperate.ac?fromPath=cityAddrSelect&orgId=" + webPath.orgId + "&receiveAddrId=" + receiveAddrId + "&isCod=" + webPath.isCod + "&method=edit";
        });

        // 选择收货地址
        $(".addrRow").click(function(){
            if (isEditOrDel) {
                isEditOrDel = false;
                return;
            }
            var receiveAddrId = $(this).attr("receiveAddrId");
            if (isEmpty(receiveAddrId) || isEmpty(webPath.orgId)) {
                return;
            }
            setDefaultAddress(receiveAddrId);
        });

    });
});

// 判断符不符合配送
function setDefaultAddress(receiverAddrId){
    $.ajax({
        type:"get",
        url:webPath.webRoot+"/member/setDefaultCitySendReceiveAddr.json",
        data:{receiveAddrId:receiverAddrId,sysOrgId:webPath.orgId},
        success:function(data) {
            if(data.success == 'true'){
                // 重新设置购物车收货地址
                selectAddressFun(receiverAddrId)
            }else{
                if (isEmpty(data.errorCode)) {
                    showError("该地址不在配送范围内!");
                } else if (data.errorCode == 'login') {
                    showLoginLayer();
                }
            }
        }
    });
}

// 重新设置购物车收货地址
var selectAddressFun = function(receiveAddrId){
    var isCod = false;
    if ('Y' == webPath.isCod) {
        isCod = true;
    }
    $.ajax({
        url:webPath.webRoot+"/cart/updateReceiver.json",
        data:({type:webPath.cartType,receiveAddrId:receiveAddrId,isCod:isCod}),
        success:function(data){
            if(data.success == "true"){
                window.location.href = webPath.webRoot + "/wap/citySend/cityCheckout.ac?orgId=" + webPath.orgId;
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
        }
    });
};

// 弹出登录提示框
function showLoginLayer(){
    showConfirm("请先登录", function(){
        window.location.href = webPath.webRoot + "/wap/login.ac";
    });
}

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}