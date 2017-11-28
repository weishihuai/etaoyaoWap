/**
 * Created by chencheng on 2017/10/27.
 *
 */


/**
 * 取消退货申请
 */
function cancelReturn(returnedPurchaseOrderId) {
    var confirmResult = confirm('确定需要取消申请吗');
    if (!confirmResult){
        return;
    }
    var url = '/afterSale/returnOrder/cancel.json';
    $.ajax({
        type:'post',
        url:url,
        data: {returnedPurchaseOrderId: returnedPurchaseOrderId},
        success:function () {
            window.location.reload();
        },
        error:function (result) {
            handleError(result)
        }
    });
}

/**
 * 填写物流信息
 */
function showLogisticsWind(returnedPurchaseOrderId, logisticsOrderCode, logisticsCompany) {
    $('.logistics-layer').show();
    $("#returnedPurchaseOrderId").val(returnedPurchaseOrderId);
    $("#logisticsOrderCode").val(logisticsOrderCode);
    $("#logisticsCompany").val(logisticsCompany);
}

/**
 * 更新物流信息
 */
function updateLogistics() {
    var returnedPurchaseOrderId = $("#returnedPurchaseOrderId").val();
    var logisticsOrderCode = $("#logisticsOrderCode").val();
    var logisticsCompany = $("#logisticsCompany").val();
    var url = '/afterSale/returnOrder/updateLogistics.json';
    $.ajax({
        type:'post',
        url:url,
        data: {returnedPurchaseOrderId: returnedPurchaseOrderId, logisticsOrderCode:logisticsOrderCode, logisticsCompany:logisticsCompany},
        success:function () {
            window.location.reload();
        },
        error:function (result) {
            handleError(result)
        }
    });
}

function handleError(result) {
    var data = eval("("+result.responseText+")");
    var errorText = data.errorObject.errorText;
    alert(errorText);
}
