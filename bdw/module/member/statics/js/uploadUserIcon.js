/**
 * User: jlmak
 * Date: 12-4-1
 * Time: 下午4:34
 * 用户上传头像用.
 */
$(document).ready(function() {
    var jcrop;
    var height = 80;
    var width = 80;
    var x = 0;
    var y = 0;
    $('#target').Jcrop({
//      maxSize:[80,80],
        minSize:[80,80],
        aspectRatio:1,
        onRelease:function() {
           // jcrop.setOptions({allowSelect:true})
        },
        onChange:function(c) {},
        onSelect:function(c) {
            if (c.w < 80 || c.h < 80) {
                userIconAlertDialog("图片像素不能低于80X80");
                jcrop_api.animateTo([0,0,80,80]);
            }
            height = c.h;
            width = c.w;
            x = c.x;
            y = c.y;
        }
    }, function() {
        jcrop_api = this;
        jcrop_api.animateTo([0,0,80,80]);
        // Setup and dipslay the interface for "enabled"
    });
    $("#saveIcon").click(function() {
        // alert("高"+height+"宽"+width);
        if($("#drop").val()==undefined){
            userIconAlertDialog('请选择图片!');
            return;
        }
        $.ajax({
            url:dataValue.webRoot+"/member/cutUserIcon.json",
            data:{x:x,y:y,height:height,width:width},
            type:"post",
            success:function(data) {
                if (data.success == true) {
                    $("#fileId80").attr("src", data.fileId80);
                    $("#fileId40").attr("src", data.fileId40);
                    userIconAlertDialog("头像修改完成");
                }
            }
            ,error:function(data){
                userIconAlertDialog("头像修改只支持jpg格式文件");
            }
        })
    });
});
function showDialog() {
    $("#tip").dialog({
        buttons:{
            '确定':function() {
                var uploadFile = document.getElementById("tmpFile").value;
                var fileName = uploadFile.substring(uploadFile.lastIndexOf(".")+1).toLowerCase();
                if(uploadFile == ""){
                    userIconAlertDialog('请上传图片!');
                }
                else if(fileName != "jpg"){
                    userIconAlertDialog('图片格式不正确，请上传jpg图片!');
                }
                else{
                    /*var a = $("#tmpFile").value;
                    alert(a);*/
                    $("#upload").submit();
                    $("#tip").dialog('close');
                }
            },
            '取消':function() {
                $("#tip").dialog('close');
            }
        }
    });
}


//最普通最常用的alert对话框，默认携带一个确认按钮
var userIconAlertDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};
