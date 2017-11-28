/**
 * Created by chencheng on 2017/10/27.
 *
 */


/**
 * 取消换货申请
 * @param exchangeOrderId
 */
function cancelExchange(exchangeOrderId) {
    var confirmResult = confirm('确定需要取消申请吗');
    if (!confirmResult){
        return;
    }
    var url = '/afterSale/exchangeOrder/cancel.json';
    $.ajax({
        type:'post',
        url:url,
        data: {exchangeOrderId: exchangeOrderId},
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
function showLogisticsWind(exchangeOrderId, logisticsOrderCode, logisticsCompany) {
    $('.logistics-layer').show();
    $("#exchangeOrderId").val(exchangeOrderId);
    $("#logisticsOrderCode").val(logisticsOrderCode);
    $("#logisticsCompany").val(logisticsCompany);
}

/**
 * 更新物流信息
 */
function updateLogistics() {
    var exchangeOrderId = $("#exchangeOrderId").val();
    var logisticsOrderCode = $("#logisticsOrderCode").val();
    var logisticsCompany = $("#logisticsCompany").val();
    var url = '/afterSale/exchangeOrder/updateLogistics.json';
    $.ajax({
        type:'post',
        url:url,
        data: {exchangeOrderId: exchangeOrderId, logisticsOrderCode:logisticsOrderCode, logisticsCompany:logisticsCompany},
        success:function () {
            window.location.reload();
        },
        error:function (result) {
            handleError(result)
        }
    });
}

/**
 * 确认收货
 */
function confirmPackage(exchangeOrderId) {
    var confirmResult = confirm('确定已收到换货商品了吗');
    if (!confirmResult){
        return;
    }
    var url = '/afterSale/exchangeOrder/finish.json';
    $.ajax({
        type:'post',
        url:url,
        data: {exchangeOrderId: exchangeOrderId},
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
