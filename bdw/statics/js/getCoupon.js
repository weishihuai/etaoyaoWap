$(document).ready(function() {

    $('.getCoupon').click(function() {
        var $mythis = $(this);
        //var batchId = $mythis.attr('data-batchId');
        var ruleLinke = $mythis.attr('data-ruleLinke');

        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url: webParam.webRoot+"/member/getCoupon.json",
            data:{
                ruleLinke: ruleLinke
            },
            dataType: "json",
            success: function(data) {
                if (data.success == true) {
                    alertDialog("领取成功!","success");
                    $($mythis.attr('data-target-bindAmount')).each(function() {
                        var amount = parseInt($(this).text());
                        $(this).text(amount+1);
                    });
                    return;
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText,"error");
                    return;
                }
            }
        });
    });

});
