var commentLayer;
//删除订单
function deleteOrder(orderId){
    if (window.confirm("确认要删除？")) {
        $.ajax({
            type: "POST",
            url: webPath.webRoot+"/otoo/otooOrder/updateOrderStatus.json",
            data:{"orderId":orderId ,"delete":"Y"},
            async: false,//同步
            success: function (data) {
                if (data.success = "true") {
                    alert("删除成功!")
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
        window.location.reload();
    }
}

//取消订单
function cancelOrder(orderId){
    if (window.confirm("确认要取消？")) {
        $.ajax({
            type: "POST",
            url: webPath.webRoot+"/otoo/otooOrder/updateOrderStatus.json",
            data:{"orderId":orderId ,"cancel":"2"},
            async: false,//同步
            success: function (data) {
                if (data.success = "true") {
                    alert("取消成功!")
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
        window.location.reload();
    }
}

//商品评论弹出层
function showCommentLayer() {
    commentLayer = $.layer({
        type: 1,
        area: ['auto', 'auto'],
        title: false,
        //move: '.e-tit',
        move:false,
        border: [1],
        shadeClose: false,
        moveType:1,
        page: {dom: '#productComment'},
        bgcolor: "none"
    });
    return commentLayer;
}

//显示订单评论弹出框
function comment(orderId){
    $("#commentCont").val("");
    $("#orderId").val(orderId);
    $(".e-con .btn").attr("id","addComment");
    showCommentLayer();
}

var gradeLevel = 5;
$(function(){
    //打星特效
    $(".stars a").each(function(i){
        $(this).mouseover(function(){
            $(".stars a:lt("+(i+1)+")").attr("class","cur");
            $(".stars a:gt("+i+")").attr("class","grayStar");
            gradeLevel = i+1;
        });
        $(this).click(function(){
            gradeLevel = i+1;
        });
        $(this).mouseout(function(){
            var cur_star = gradeLevel - 1;
            $(".stars a:lt("+(cur_star+1)+")").attr("class","cur");
            $(".stars a:gt("+cur_star+")").attr("class","grayStar");
        });
    });
});

//发表评论
function addComment(){
    var commentCont = $("#commentCont").val();
    if(commentCont.length < 5){
        alert("您输入的内容太短了，请说多几句。");
        return;
    }
    if(commentCont.length > 200 ){
        alert("请输入少于255个字符！");
        return;
    }
    var orderId = $("#orderId").val();
    //是否匿名
    var isAnonymousComment = "";
    if($("#isAnonymousComment").attr("checked") == "checked"){
        isAnonymousComment = "Y";
    }else{
        isAnonymousComment = "N";
    }

    //评分转换
    if(gradeLevel == 1){
        gradeLevel = -2;
    }
    if(gradeLevel == 2){
        gradeLevel = -1;
    }
    if(gradeLevel == 3){
        gradeLevel = 0;
    }
    if(gradeLevel == 4){
        gradeLevel = 1;
    }
    if(gradeLevel == 5){
        gradeLevel = 2;
    }
    $("#addComment").attr("class", "submitted");;
    $("#addComment").attr("onclick", "javascript:;");
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/otoo/otooComment/addComment.json",
        data:{"orderId":orderId,"gradeLevel":gradeLevel,"commentCont":commentCont,"isAnonymousComment":isAnonymousComment},
        dataType:"json",
        success:function(data){
            if(data.success == "true"){
                alert("评论成功!");
                layer.close(commentLayer);
                window.location.href=webPath.webRoot+"/module/member/otoo/myOrderList.ac?pitchOnRow=47&isPayed=Y&used=Y";
            }else{
                if(data.errorCode == "errors.login.noexist"){
                    if(confirm("您尚未登陆，请登陆!")){
                        window.location.href=webPath.webRoot+"/login.ac";
                    }
                    return;
                }
            }
        },
        error:function(data){
            alert("对不起,提交评论失败");
        }
    });
}

//关闭所有层
function hideLayer() {
    layer.closeAll();
}

