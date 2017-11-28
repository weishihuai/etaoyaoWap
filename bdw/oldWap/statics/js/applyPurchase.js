
$(document).ready(function(){
    var itemNum=webPath.itemNums.split(",");
    for(var i=0;i<itemNum.length;i++){
        $(".good-amount").each(function(index){
            $(this).html("数量：x"+itemNum[index].split(":")[0]);
            $(this).attr("num",itemNum[index].split(":")[0]);
        });
    }
       $(".btn-block").click(function(){
               var descr=$("#descr").val();
           if(descr.trim()==null||descr.trim()==""){
               alert("请填写相关信息！");
               return;
           }

           var value=getValue();
           $.ajaxSettings['contentType'] = "application/json; charset=utf-8;";
           $.ajax({
               type: "POST",
               url: webPath.webRoot + "/afterSale/add.json",
               data: _ObjectToJSON("post", value),
               async: false,
               success: function (data) {
                   if (data.errorCode === "errors.comment.notOrder") {
                       alert("您的订单尚未完成，请完成后再申请！");
                       return;
                   }
                   if (data.success === 'true') {
                       alert("申请成功");
                       //goToUrl(webPath.webRoot + "/module/member/exchangePurchase.ac");
                       window.location.href=webPath.webRoot+"/wap/module/afterSaleService/saleServiceApply.ac";
                   }
               }
           });
       });



    $(".addr-box").click(function(){
        window.location.href=webPath.webRoot+"/wap/shoppingcart/exchangeAddrSelect.ac?numStr="+webPath.itemNums+"&orderId="+webPath.orderId+"&isReturn="+webPath.isReturn+"&orderItems="+webPath.orderItems+"&time="+(new Date()).getTime();
    });

    var getValue = function () {
        var items = [];
        var i = 0;
        $(".good-amount").each(function (i) {
            items[i] = {
                orderItemId: $(this).attr("orderItemId"),
                quantity: $(this).attr("num")
            };
            i++;
        });

        var typeCode = webPath.isReturn;
        if (typeCode == 'false') {
            return {
                orderId: webPath.orderId,
                tel: $("#mobile").html(),
                descr: $("#descr").val(),
                typeCode: "0",
                receiverAddr: $("#receiver").html()+$("#address").html(),
                photoFileId: $("#hh_photoFileId").val(),
                orderItems: items
            }
        } else {
            return {
                orderId: webPath.orderId, tel:$("#mobile").html(), descr: $("#descr").val(),
                typeCode: "1",
                photoFileId: $("#hh_photoFileId").val(),
                orderItems: items
            }
        }
    };

    $(".add").click(function(){
        $("#tip").css("display","");
    });
    $(".close").click(function(){
        $("#tip").css("display","none")
    });

    var options = {
        dataType: 'html',
        success: function (responseText, statusText, xhr, $form) {
            try {
                var result = eval("(" + responseText + ")");
                if (result.success == "false") {
                    alert("您提交的图片格式不正确");
                } else if (result.success == "true") {
                    $("#hh_photoFileId").attr("value", $.trim(result.fileId));
                    //console.log($("#hh_upload_pic"));
                    $("#hh_upload_pic").attr("src", $.trim(result.url));
                    $("#tip").css("display","none");
                }
            } catch (err) {
                alert("您上传的图片不符合规格,请上传.jpg格式文件");
            }
        }
    };
    $('#upload').submit(function () {
        $(this).ajaxSubmit(options);
        return false;
    });
    $("#sm").click(function () {
            $("#upload").submit();
    });



});