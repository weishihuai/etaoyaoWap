$(function () {

    $(".subBtn").click(function () {
        var seq = $(this).attr("seq");
        var quantity = $(".quantity"+seq);
        var value = quantity.val();
        var num = parseInt(value) - 1;
        if (num == 0) {
            return;
        }
        quantity.val(num);
    });

    $(".addBtn").click(function () {
        var seq = $(this).attr("seq");
        var quantity = $(".quantity"+seq);
        var value = quantity.val();
        var num = parseInt(value) + 1;
        quantity.val(num);
    });

    $(".quantity").change(function () {
        var seq = $(this).attr("seq");
        var quantity = $(".quantity"+seq);
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);

        }
    });

    $(".buyBtn").click(function(){
        //判断是否登录
        if(undefined == paramData.userId || null ==paramData.userId || "" == paramData.userId ) {
            showCardListUserLogin();
            return;
        }
        var seq = $(this).attr("seq");
        var cardBatchId = $(this).attr("cardBatchId");
        var quantity = $(".quantity"+seq).val();
        var cardRemainQuantity = $(this).attr("cardRemainQuantity");
        if(parseInt(cardRemainQuantity)<parseInt(quantity)){
            breadCardJDialog("您最多可以购买"+cardRemainQuantity+"件！",1200,"10px",true);
            return;
        }
        window.location.href = paramData.webRoot + "/card/cardBalance.ac?cardBatchId=" + cardBatchId + "&quantity=" + quantity;
    });

});

//登录提示框
function showCardListUserLogin(){
    var dialog = jDialog.confirm('您还没有登录',{
        type : 'highlight',
        text : '登录',
        handler : function(button,dialog) {
            dialog.close();
            window.location.href = paramData.webRoot + "/login.ac";
        }
    },{
        type : 'normal',
        text : '取消',
        handler : function(button,dialog) {
            dialog.close();
        }
    });
    return dialog;
}

//没有标题和按钮的提示框
function breadCardJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}

