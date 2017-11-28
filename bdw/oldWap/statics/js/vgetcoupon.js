/**
 * Created with IntelliJ IDEA.
 * User: lzg
 * Date: 14-4-9
 * Time: 下午4:25
 * To change this template use File | Settings | File Templates.
 */


var dataValue = {
    webRoot: "${webRoot}" //当前路径
};
var lingquan = function (activityId) {
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
    type: "GET",
    url: dataValue.webRoot + "/frontend/vmall/vcouponActivity/getCoupon.json",
    data: {activityId: activityId},
    dataType: "json",
success: function (data) {
    if (data.success == 'true') {
    $("#lqdiv").html("<a class='btn btn-default btn-block l_btn disabled' role='button'>您今天已经领取过</a>");
    alert("领取购物券成功");
    }
},
error: function (XMLHttpRequest, textStatus) {
    if (XMLHttpRequest.status == 500) {
    var result = eval("(" + XMLHttpRequest.responseText + ")");
    $("#lqdiv").html("<a class='btn btn-default btn-block l_btn disabled' role='button'>系统繁忙</a>");
    alert(result.errorObject.errorData);
    }
}
});
}

