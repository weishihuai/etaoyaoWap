

$(function(){

    $("#disJoin").click(function () {
        tenderAlertDialog("仅供应商参与!");
    });

    //最新招标公告上下滚动
    $('.udbook').vTicker({
        showItems: 5,
        pause: 3000
    });


    $("#tender").click(function () {
        $(".overlay").show();
        reloadProduct(1,4,"");
    });

    $("#closeWin").click(function(){
        $(".overlay").hide();
        btnReset();
    });

    //搜索
    $("#searchProductBtn").live("click",function(){
        var keyword = $("#searchTxt").val();
        reloadProduct(1, 4, keyword);
    });

    //重置
    $("#resetBtn").click(function () {
        btnReset();
    });

    //提交
    $("#submitBtn").click(function () {
        //招标ID
        var forBidId = $.trim($("#forBidId").val());
        //联系人
        var contactName = $.trim($("#contactName").val());
        //联系电话
        var contactMobile = $.trim($("#contactMobile").val());
        //竞标商品
        var productId  = $.trim($("#proId").val());

        var checkContactTel = /^1(\d{10})$/;

        if(undefined == contactName || contactName == ''){
            breadJDialog("联系人不能为空!",2000,"30px",true);
            return;
        }else if($.trim($("#contactName").val()).length > 20){
            breadJDialog("联系人填写过长!",2000,"30px",true);
            return;
        }

        if(undefined == contactMobile || contactMobile == ''){
            breadJDialog("联系电话不能为空!",2000,"30px",true);
            return;
        }else if(!checkContactTel.test(contactMobile)){
            breadJDialog("请输入正确的手机电话!",2000,"30px",true);
            return;
        }

        if(undefined == productId || productId == ''){
            breadJDialog("请选择竞标商品!",2000,"30px",true);
            return;
        }

        var requestUrl =  valueData.webRoot+"/invitationForBid/responseItemFront/uploadInvitationFile.json";
        $("#uploadForm").ajaxSubmit({
            type: 'post',
            dataType : "json",
            url: requestUrl,
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function(data) {
                if(data.success){
                    breadJDialog(data.productName+"投标成功,等待审核!",2000,"30px",true);
                    $(".overlay").hide();
                    reloadResponseItemProduct(1,5,forBidId);
                }else{
                    if(data.userLogin == 'noLogin'){
                        var dialog = jDialog.confirm('您还没有登录',{
                            type : 'highlight',
                            text : '登录',
                            handler : function(button,dialog) {
                                dialog.close();
                                window.location.href = valueData.webRoot + "/login.ac";
                            }
                        },{
                            type : 'normal',
                            text : '取消',
                            handler : function(button,dialog) {
                                dialog.close();
                            }
                        });
                    }

                    if(data.contactName == 'emptyName'){
                        breadJDialog("请输入联系人!",2000,"30px",true);
                        return;
                    }
                    if(data.contactMobile == 'emptyMobile'){
                        breadJDialog("请输入联系电话!",2000,"30px",true);
                        return;
                    }
                    if(data.fileType == 'noFile'){
                        breadJDialog("请选择竞标文件!",2000,"30px",true);
                        return;
                    }

                    if(data.product == 'emptyProduct'){
                        breadJDialog("请选择竞标商品!",2000,"30px",true);
                        return;
                    }

                    if(data.alreadyBid == 'alreadyBid'){
                        breadJDialog("该商品已经投标过了,请重新选择!",2000,"30px",true);
                        return;
                    }

                    if(data.fileTooMax == 'fileTooMax'){
                        breadJDialog("竞标文件超过10M!",2000,"30px",true);
                        return;
                    }

                    breadJDialog("竞标文件格式错误或者大小超过10M,请检查!",2000,"30px",true);

                }
            }
        });
    });
});

//没有标题和按钮的提示框
function breadJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}


/*重置按钮onclick事件*/
function btnReset() {
    $("#contactName").val("");
    $("#contactMobile").val("");
    $("#proId").val("");
    reloadProduct(1,4,"");
}

/*复选框点击*/
function toggleCheckBox(productId){
    var objBox = $(".box" + productId);
    var prdItem = $("#prd" + productId);
    if(objBox.hasClass("selected")){
        objBox.removeClass("selected");
        prdItem.removeClass("bg-color");
    }else{
        //只选择一个
        $(".sel-btn").removeClass("selected");
        $(".item").removeClass("bg-color");
        objBox.addClass("selected");
        prdItem.addClass("bg-color");
        $("#proId").val(productId);
    }

}

/*商品异步分页*/
function syncProductPage(pageNum){
    $("#prdContent").load(valueData.webRoot + "/template/bdw/ajaxload/loadTenderDetailProduct.jsp", {
        page: pageNum
    }, function () {

    });
}

/*当前投标异步分页*/
function syncResponseItemPage(pageNum,forBidId){
    $("#responseResult").load(valueData.webRoot + "/template/bdw/ajaxload/loadTenderResponseItem.jsp", {
        page: pageNum,
        tnd:forBidId
    }, function () {

    });
}

//商品重新load
function reloadProduct(pageNum, limit, keyword){
    $("#prdContent").load(valueData.webRoot + "/template/bdw/ajaxload/loadTenderDetailProduct.jsp", {
        page: pageNum,
        limit:limit,
        keyword:keyword
    }, function () {

    });
}

//投标记录重新load
function reloadResponseItemProduct(pageNum, limit, forBidId){
    $("#responseResult").load(valueData.webRoot + "/template/bdw/ajaxload/loadTenderResponseItem.jsp", {
        page: pageNum,
        limit:limit,
        tnd:forBidId
    }, function () {

    });
}


//最普通最常用的alert对话框，默认携带一个确认按钮
var tenderAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};
