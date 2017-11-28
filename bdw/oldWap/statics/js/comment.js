$(document).ready(function(){
    //查询是否可以评论
    $("#isAllowComment").click(function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
                    type:"GET",url:webPath.webRoot+"/frontend/comment/isAllowComment.json",
                    dataType:"json",data:{productId:webPath.productId},
                    success:function(data){
                        if(data.success == false){
                            if(data.errorCode == "errors.login.noexist"){
                                if(confirm("您尚未登陆，请登陆!")){
                                    window.location.href=webPath.webRoot+"/login.ac";
                                }
                                return;
                            }
                            if(data.errorCode == "errors.comment.notOrder"){
                                window.location.href=webPath.webRoot+"/comment/cannotComment.ac?id="+webPath.productId;
                            }
                        }else if(data.success == true){
                            window.location.href=webPath.webRoot+data.result;
                        }
                    }
                });
    });
    var gradeLevel = 5;
    //增加评论js
    $("#addComment").click(function(){
        if(!clearAreaText("#commentCont","欢迎您发表原创并对其它用户有参考价值的商品评价。",function(){alert("请输入内容");})){
            return;
        }
        var commentCont = $("#commentCont").val();
        if(commentCont.length < 4){
            alert("您输入的内容太短了，请说多几句。");
            return;
        }
        if(commentCont.length > 255 ){
            alert("请输入少于255个字符！");
            return;
        }
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
                    type:"POST",
                    url:webPath.webRoot+"/frontend/comment/addProductComment.json",
                    data:{objectId:webPath.productId,gradeLevel:gradeLevel,commentCont:commentCont,isAnonymousComment:'Y'},
                    dataType:"json",
                    success:function(data){
                        if(data.success == false){
                            if(data.errorCode == "errors.login.noexist"){
                                if(confirm("您尚未登陆，请登陆!")){
                                    window.location.href=webPath.webRoot+"/wap/login.ac";
                                }
                                return;
                            }
                            if(data.errorCode == "errors.comment.notOrder"){
                                window.location.href=webPath.webRoot+"/wap/cannotComment.ac?id="+webPath.productId;
                            }
                        }else if(data.success == true){
                            $("#commentForm").submit();
                        }
                    }
                });
    });
    //打星特效
    $("#stars a").each(function(i){
        $(this).mouseover(function(){
            $("#stars a:lt("+(i+1)+")").attr("class","cur");
            $("#stars a:gt("+i+")").attr("class","grayStar");
            gradeLevel = i+1;
            showStarConet(gradeLevel);
        });
        $(this).click(function(){
            gradeLevel = i+1;
            showStarConet(gradeLevel);
        });
        $(this).mouseout(function(){
            var cur_star = gradeLevel - 1;
            $("#stars a:lt("+(cur_star+1)+")").attr("class","cur");
            $("#stars a:gt("+cur_star+")").attr("class","grayStar");
            gradeLevel = i+1;
            showStarConet(gradeLevel);
        });
    });
    //评价框移除提示文字
    $("#commentCont").click(function(){
        clearAreaText("#commentCont","欢迎您发表原创并对其它用户有参考价值的商品评价。",function(){
            $("#commentCont").html("");
        });
    });
    //咨询框移除提示文字
    $("#consultCont").click(function(){
        clearAreaText("#consultCont","欢迎您发表咨询内容。",function(){
            $("#consultCont").html("");
        });
    });
    //增加咨询
    $("#addConsultCont").click(function(){
        if(!clearAreaText("#consultCont","欢迎您发表咨询内容。",function(){alert("请输入内容");})){
            return;
        }
        var consultCont = $("#consultCont").val();
        if(consultCont.length < 4){
            alert("您输入的咨询太短了，请说多几句。");
            return;
        }
        if(consultCont.length > 255){
            alert("请输入少于255个字符！");
            return;
        }
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
                    type:"POST",
                    url:webPath.webRoot+"/frontend/comment/addConsultCont.json",
                    data:{productId:webPath.productId,consultCont:consultCont},
                    dataType:"json",
                    success:function(data){
                        if(data.success == false){
                            if(data.errorCode == "errors.login.noexist"){
                                if(confirm("您尚未登陆，请登陆!")){
                                    window.location.href=webPath.webRoot+"/login.ac";
                                }
                                return;
                            }
                        }else if(data.success == true){
                            $("#consultCont").attr("value","欢迎您发表咨询内容。");
                            alert("提交咨询成功，请耐心等候回复。");
                        }
                    }
                });
    });
});
var showStarConet = function(starNum){
    $("#gradeLevel").val(starNum);
    if(starNum >= 4){
        $("#showStar").html(starNum+"分 非常满意");
    }
    else if(starNum == 3){
        $("#showStar").html(starNum+"分 较好");
    }
    else{
        $("#showStar").html(starNum+"分 一般");
    }
};
var clearAreaText = function(id,areaStr,do_fn){
    if($(id).val() == areaStr){
        do_fn();
        return false;
    }
    return true;
};
var reLoadPage = function(url){
    setTimeout(function(){
        window.location.href=url;
    },1);
};
//评论有用js
var enableComment = function(commentId,idStr){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
                type:"GET",url:webPath.webRoot+"/frontend/comment/enable.json",
                data:{commentId:commentId},
                dataType:"json",
                success:function(data){
                    if (data.success == true) {
                        var eanbleNum = parseInt(data.commentEnableCount);
                        var voteStr = "已投票("+eanbleNum+")";
                        $(idStr).html(voteStr);
                        $(idStr).attr('onclick','')
                    }else{
                        alert("对不起，你的操作无效，请刷新页面重试！");
                    }
                },
                error:function(msg){
                    alert("您已经投票了");
                }
            });
};
//评论无用js
var disableComment = function(commentId,idStr){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
                type:"GET",url:webPath.webRoot+"/frontend/comment/disable.json",
                data:{commentId:commentId},
                dataType:"json",
                success:function(data){
                    if (data.success == true) {
                        var disableNum = parseInt(data.commentDisableCount);
                        var voteStr = "已投票("+disableNum+")";
                        $(idStr).html(voteStr);
                        $(idStr).attr('onclick','')
                    }else{
                        alert("对不起，你的操作无效，请刷新页面重试！");
                    }
                }
                ,
                error:function(msg){
                    alert("您已经投票了");
                }
            });
};

//移除回复提示文字
var clearReplyText = function(id){
    clearAreaText("#"+id,"请填写回复内容，长度在5-300位字符之间",function(){
        $("#"+id).val("");
    });
};
var showReplyArea = function(id){
    $("#"+id).parent().parent().show();
};
var addCommentSession = function(commentId,areaId){
    clearReplyText(areaId);
    var commentSession = $.trim($("#"+areaId).val());
    if(commentSession == '' || commentSession == null || commentSession.length < 4){
        alert("回复内容不能为空以及不能少于4个字符");
        return;
    }
    commentSession=commentSession.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig,"");
    commentSession=commentSession.replace(/<.*?>/g,"");
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
                type:"POST",url:webPath.webRoot+"/frontend/comment/addProductCommentSeesion.json",
                data:{commentId:commentId,replyCont:commentSession},
                dataType:"json",
                success:function(data){
                    if(data.success == false){
                        if(data.errorCode == "errors.login.noexist"){
                            if(confirm("您尚未登陆，请登陆!")){
                                window.location.href=webPath.webRoot+"/login.ac";
                            }
                            return;
                        }
                        if(data.errorCode == "errors.comment.notOrder"){
                            window.location.href=webPath.webRoot+"/comment/cannotComment.ac?id="+webPath.productId;
                        }
                    }else if(data.success == true){
                        alert("提交回复成功，管理员审批通过后即可显示。");
                        $("#"+areaId).val("请填写回复内容，长度在5-300位字符之间");
                    }

                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
};
var openUrl = function( url ){
    var f=document.createElement("form");
    f.setAttribute("action" , url );
    f.setAttribute("method" , 'get' );
    f.setAttribute("target" , '_black' );
    document.body.appendChild(f)
    f.submit();
};

