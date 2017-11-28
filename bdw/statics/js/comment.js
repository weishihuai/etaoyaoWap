//var addrs;//加载地区
//function loadAddr() {
//    return  $(".addressSelect").ld({ajaxOptions : {"url" : webPath.webRoot+"/member/addressBook.json"},
//        defaultParentId:34693,
//    });
//}

function getZone(){
    var zone = $("#zone").val();
    $("#zoneId").val(zone);
}

$(document).ready(function(){
    //查询是否可以评论
    $("#isAllowComment").click(function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"GET",url:webPath.webRoot+"/frontend/comment/isAllowComment.json",
            dataType:"json",data:{productId:webPath.productId},
            async: false,//同步
            success:function(data){
                if(data.success == false){
                    if(data.errorCode == "errors.login.noexist"){
                        showPrdCommentUserLogin();
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
    //addrs = loadAddr();

    var gradeLevel = 5;
    //增加评论js(不可重复点击)
    $("#addComment").click(function(){
        if(!clearAreaText("#commentCont","欢迎您发表原创并对其它用户有参考价值的商品评价。",function(){alert("请输入内容");})){
            return;
        }
        var commentCont = $.trim($("#commentCont").val());
        if(commentCont.length < 4){
            prdCommentLAlertDialog("您输入的内容太短了，请说多几句。");
            return;
        }
        if(commentCont.length > 255 ){
            prdCommentLAlertDialog("请输入少于255个字符");
            return;
        }
        if(!jQuery.trim($('#repPict').val()) == "" || !jQuery.trim($('#repPict').val()) == null){
            var repPict = $('#repPict').val();
        }
        $("#addComment").unbind("click");
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/frontend/comment/addProductComment.json",
            data:{objectId:webPath.productId,gradeLevel:gradeLevel,commentCont:commentCont,orderId: webPath.orderId,isAnonymousComment:'Y',commentPictList:repPict},
            dataType:"json",
            async: false,//同步
            success:function(data){
                if(data.success == false){
                    if(data.errorCode == "errors.login.noexist"){
                        showPrdCommentUserLogin();
                        return;
                    }
                    if(data.errorCode == "errors.comment.notOrder"){
                        window.location.href=webPath.webRoot+"/comment/cannotComment.ac?id="+webPath.productId;
                    }
                }else if(data.success == true){
                    $("#addComment").html("正在提交");
                    $("#commentForm").submit();
                }
            },
            error:function(data){
                prdCommentLAlertDialog("对不起,提交评论失败");
            }
        });
    });
    //打星特效
    $("#stars a").each(function(i){
        $(this).click(function(){
            $("#stars a:lt("+(i+1)+")").attr("class","cur");
            $("#stars a:gt("+i+")").attr("class","grayStar");
            gradeLevel = i+1;
            showStarConet(gradeLevel);
        });
        $(this).click(function(){
            gradeLevel = i+1;
            showStarConet(gradeLevel);
        });
        $(this).click(function(){
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
        var consultCont = $.trim($("#consultCont").val());
        if(undefined == consultCont || null == consultCont || "" == consultCont || consultCont == '请输入咨询内容'){
            prdCommentLAlertDialog("请输入咨询内容");
            return;
        }

        if(consultCont.length < 4){
            prdCommentLAlertDialog("您输入的咨询太短了，请说多几句。");
            return;
        }
        if(consultCont.length > 255){
            prdCommentLAlertDialog("请输入少于255个字符！");
            return;
        }
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/frontend/comment/addConsultCont.json",
            data:{productId:webPath.productId,consultCont:consultCont},
            dataType:"json",
            async: false,//同步
            success:function(data){
                if(data.success == false){
                    if(data.errorCode == "errors.login.noexist"){
                        showPrdCommentUserLogin();
                    }
                }else if(data.success == true){
                    $("#consultCont").attr("value","欢迎您发表咨询内容。");
                    prdCommentLAlertDialog("提交咨询成功，请耐心等候回复。");
                    location.reload();
                }
            }
        });
    });


    var uploader = new plupload.Uploader({                          //实例化一个plupload上传对象
        browse_button: 'upload',                                //触发文件选择对话框的按钮，为那个元素id
        url: webPath.webRoot + '/member/uploadPhotoImg.ac',   //服务器端的上传页面地址
        flash_swf_url: webPath.webRoot + '/template/bdw/module/member/statics/js/plupload/Moxie.swf',       //swf文件，当需要使用swf方式进行上传时需要配置该参数
        silverlight_xap_url: webPath.webRoot + '/template/bdw/module/member/statics/js/plupload/Moxie.xap',// silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
        filters: [
            {title: "image", extensions: "jpg,jpeg,gif,png"}
        ]
    });
    uploader.init();                                            //在实例对象上调用init()方法进行初始化
    uploader.bind('FilesAdded', function (loader, files) {   //绑定各种事件，并在事件监听函数中做你想做的事
        loader.start();                                        //调用实例对象的start()方法开始上传文件，当然你也可以在其他地方调用该方法
    });
    uploader.bind('FileUploaded', function (up, file, res) {//上传完成后执行
        var res = $.parseJSON(res.response);
        if (res.success) {
            var html = "<div class='up-img'><img fileid='"+res.fileId+"' src='"+res.url+"' height='100' width='100' alt=''><a href='javascript:;' title='删除图片'>删除图片</a></div>";
            $(".pic-cont").prepend(html);
            if($("#repPict").val() != null && $("#repPict").val() != ""){
                $("#repPict").val($("#repPict").val()+","+res.url);
            } else{
                $("#repPict").val(res.url);
            }
        }
    });

    $(" .up-img a").live("click", function(){
        var url = $(this).prev().attr("src");
        var arr=$("#repPict").val().split(",");
        arr.splice(jQuery.inArray(url,arr),1);
        $("#repPict").val(arr.join(","));
        $(this).parent(".up-img").remove();
    })
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
        async: false,//同步
        success:function(data){
            if (data.success == true) {
                var eanbleNum = parseInt(data.commentEnableCount);
                var voteStr = "已投票("+eanbleNum+")";
                $(idStr).html(voteStr);
                $(idStr).attr('onclick','')
            }else{
                prdCommentLAlertDialog("对不起，你的操作无效，请刷新页面重试！");
            }
        },
        error:function(msg){
            prdCommentLAlertDialog("您已经投票了");
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
        async: false,//同步
        success:function(data){
            if (data.success == true) {
                var disableNum = parseInt(data.commentDisableCount);
                var voteStr = "已投票("+disableNum+")";
                $(idStr).html(voteStr);
                $(idStr).attr('onclick','')
            }else{
                prdCommentLAlertDialog("对不起，你的操作无效，请刷新页面重试！");
            }
        }
        ,
        error:function(msg){
            prdCommentLAlertDialog("您已经投票了");
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
        prdCommentLAlertDialog("回复内容不能为空以及不能少于4个字符");
        return;
    }
    commentSession=commentSession.replace(/<(script|link|style|iframe)(.|\n)*\/\1>\s*/ig,"");
    commentSession=commentSession.replace(/<.*?>/g,"");
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",url:webPath.webRoot+"/frontend/comment/addProductCommentSeesion.json",
        data:{commentId:commentId,replyCont:commentSession},
        dataType:"json",
        async: false,//同步
        success:function(data){
            if(data.success == false){
                if(data.errorCode == "errors.login.noexist"){
                    showPrdCommentUserLogin();
                    return;
                }
                if(data.errorCode == "errors.comment.notOrder"){
                    window.location.href=webPath.webRoot+"/comment/cannotComment.ac?id="+webPath.productId;
                }
            }else if(data.success == true){
                prdCommentLAlertDialog("提交回复成功，管理员审批通过后即可显示");
                $("#"+areaId).val("请填写回复内容，长度在5-300位字符之间");
            }

        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                prdCommentLAlertDialog(result.errorObject.errorText);
            }
        }
    });
};
var openUrl = function( url ){
    var f=document.createElement("form");
    f.setAttribute("action" , url );
    f.setAttribute("method" , 'get' );
    f.setAttribute("target" , '_black' );
    document.body.appendChild(f);
    f.submit();
};



//登录提示框
function showPrdCommentUserLogin(){
    var dialog = jDialog.confirm('您还没有登录',{
        type : 'highlight',
        text : '登录',
        handler : function(button,dialog) {
            dialog.close();
            window.location.href = webPath.webRoot + "/login.ac";
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


//最普通最常用的alert对话框，默认携带一个确认按钮
var prdCommentLAlertDialog = function(dialogTxt){
    var commentAlertDialog = jDialog.alert(dialogTxt);
};


function slideShow(obj){
    var imageIndex = $(obj).attr("imageIndex");//选择的小图的下标
    var $shareOrder = $(obj).parent().parent().parent().next().find(".shareOrder");

    //把选中的小图对应的大图的前面几个大图移到大图列表的最后,让对应的大图排到第一位
    $("ul li",$shareOrder).each(function(){
        var $firstImage = $("ul li" , $shareOrder).first();
        if($firstImage.attr("index") == imageIndex){//如果对应的大图排在第一位了，就不用移动了
            return;
        }
        //否则将第一个大图移到大图列表最后
        var $lastImage = $firstImage.remove();
        $lastImage.appendTo($("ul",$shareOrder));
    });

    $(obj).parent().parent().parent().next().slideDown(500);//默认展开
    if($(obj).parent().parent().parent().next().attr("imageIndex") == imageIndex){//如果点击的是当前展开的大图对应的小图，把大图收起来
        $(obj).parent().parent().parent().next().slideUp(300);
        $(obj).parent().parent().parent().next().attr("imageIndex",-1);
        return;
    }
    $(obj).parent().parent().parent().next().attr("imageIndex",imageIndex);
}


