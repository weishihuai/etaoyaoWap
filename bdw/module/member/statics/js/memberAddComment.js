var memberAddComment = function(productId){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
                type:"GET",url:webPath.webRoot+"/frontend/comment/isAllowComment.json",
                dataType:"json",data:{productId:productId},
                success:function(data){
                    if(data.success == false){
                        if(data.errorCode == "errors.login.noexist"){
                            if(confirm("您尚未登陆，请登陆!")){
                                window.location.href=webPath.webRoot+"/login.ac";
                            }
                            return;
                        }
                        if(data.errorCode == "errors.comment.notOrder"){
                            window.location.href=webPath.webRoot+"/comment/cannotComment.ac?id="+productId;
                        }
                    }else if(data.success == true){
                        window.location.href=webPath.webRoot+data.result;
                    }
                }
            });
};

var memberAddCommentWithOrderId = function(productId,orderId){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"GET",url:webPath.webRoot+"/frontend/comment/isAllowComment.json",
        dataType:"json",data:{productId:productId},
        success:function(data){
            if(data.success == false){
                if(data.errorCode == "errors.login.noexist"){
                    if(confirm("您尚未登陆，请登陆!")){
                        window.location.href=webPath.webRoot+"/login.ac";
                    }
                    return;
                }
                if(data.errorCode == "errors.comment.notOrder"){
                    window.location.href=webPath.webRoot+"/comment/cannotComment.ac?id="+productId;
                }
            }else if(data.success == true){
                window.location.href=webPath.webRoot+data.result + '&orderId='+orderId;
            }
        }
    });
};