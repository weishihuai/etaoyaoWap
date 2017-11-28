/**
 * Created by admin on 2016/11/23.
 */
$(document).ready(function(){
    //报告详情显示
    $(".report").click(function(){
        var repTitle = $(this).attr("repTitle");
        var repTime = $(this).attr("repTime");
        var repCont = $(this).attr("repCont");
        var repPict = $(this).attr("repPict");
        var cont = repCont + "<br/>";
        var pictArrs = repPict.split(",");
        for(var pic in pictArrs){
            if($.trim(pictArrs[pic]) != ""){
                cont += "<img src='" + pictArrs[pic] + "'/><br/>";
            }
        }
        $("#repTitle").html(repTitle);
        $("#repTime").html(repTime);
        $("#repCont").html(cont);
        $("#report_lay").show();

    });

    //报告详情隐藏
    $(".closeReport").click(function(){
        $("#report_lay").hide();
    });

    //图片选择隐藏
    $(".closePic").click(function(){
        $("#pic_lay").hide();
    });

    //显示填写报告
    $(".wriReport").click(function(){
        $("#freeTrialApplyId").val($(this).attr("freeTrialApplyId"));
        $("#freeTrialId").val($(this).attr("freeTrialId"));
        $("#wri_lay").show();
    });

    //填写报告隐藏
    $(".closeWri").click(function(){
        $("#wri_lay").hide();
    });

    //显示物流信息
    $(".showLog").click(function(){
        var log = $(this).attr("log");
        if( $("#showLog"+log).is(":hidden")){
            $("#showLog"+log).show();
        }else {
            $("#showLog"+log).hide();
        }
    });

    //实例化一个plupload上传对象
    var uploader = new plupload.Uploader({
        browse_button: 'btnUpload',                          //触发文件选择对话框的按钮，为那个元素id
        url: webPath.webRoot + '/member/uploadPhotoImg.json',   //服务器端的上传页面地址
        flash_swf_url: webPath.webRoot + '/template/frb/statics/js/plupload/Moxie.swf',       //swf文件，当需要使用swf方式进行上传时需要配置该参数
        silverlight_xap_url: webPath.webRoot + '/template/frb/statics/js/plupload/plupload/Moxie.xap',// silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
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
            var html ='<div class="pic"><img width="100" height="100" alt="" src="'+res.url+'"><a title="删除图片" onclick="del(this)" href="javascript:;" style="text-align: center; display: inline-block; width: 100px; color: #999">删除图片</a></div>';
            $(".pic-cont").prepend(html);
            $("#repPict").val( $("#repPict").val()+","+res.url);
        }
    });
});

//删除上传图片
function del(target){
    var url = $(target).prev().attr("src");
    var arr=$("#repPict").val().split(",");
    arr.splice(jQuery.inArray(url,arr),1);
    $("#repPict").val(arr.join(","));
    $(target).parent().remove();
}


/**
 * 提交报告
 * @returns {boolean}
 */
function updateFreeTrialApply(){
    var repTitle = $("#wriRepTitle").val();
    var repCont  =  $('#wriRepCont').val();
    var repPict = $('#repPict').val();
    if( jQuery.trim(repTitle) == "" || jQuery.trim(repTitle) == null){
        showNormalDialog("请填写报告标题");
        return false;
    }
    if( jQuery.trim(repCont) == "" || jQuery.trim(repCont) == null){
        showNormalDialog("请填写报告内容");
        return false;
    }
    if( jQuery.trim(repCont).length < 100){
        showNormalDialog("报告的内容不能少于100字");
        return false;
    }
    if(jQuery.trim(repCont).length > 1000) {
        showNormalDialog("报告的内容不能超过1000字");
        return false;
    }
    if(jQuery.trim(repPict) == "" || jQuery.trim(repPict) == null){
        showNormalDialog("请上传产品图片");
        return false;
    }
    var data = $('#addFrom').serializeObject();
    data.repCont = repCont;
    data.repTitle = repTitle;
    $.ajaxPost(webPath.webRoot+"/freeTrial/updateFreeTrialApplyRepCont.json",_ObjectToJSON("post",data),
        function(result){
            if(handleResult(result)){
                showAfterClickBtnToReload("报告提交成功!");
                //alert("报告提交成功");
                //window.location.reload();
            }
        })
}



//最普通最常用的alert对话框，默认携带一个确认按钮,确定后会刷新页面
function showAfterClickBtnToReload(dialogTxt){
    jDialog.alert(dialogTxt,{
        type : 'highlight',
        text : '确定',
        handler : function(button,callbackDialog) {
            callbackDialog.close();
            window.location.reload();
        }
    });
}


//最普通最常用的alert对话框，默认携带一个确认按钮
var showNormalDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};
