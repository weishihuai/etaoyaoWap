$(function(){
    var options  = {
        dataType:'html',
        success:function(responseText, statusText, xhr, $form){
            easyDialog.close();//关闭弹出层
            try{
                var result = eval("("+responseText+")");
                if(result.success == "false"){
                    if (result.msg != '') {
                        $(".error").show();
                        $("#missMsg").html(result.msg);
                    }
                    return;
                }else if(result.success == 'true'){
                    $(".error").hide();
                    alert("上传成功");
                }
            }catch(err){
                    alert("上传失败,您上传的文件的内容有误，请检查后重新上传");
                    window.location.href = webPath.webRoot+"/importMember.ac";
            }
        }
    };

    $('#upload').submit(function() {
        $(this).ajaxSubmit(options);
        return false;
    });

    $("#upLoad_btn").click(function(){
        $("#tip").dialog({
            buttons:{
                '确定':function() {
                    if($("#excelFile").val() == ''){
                        alert("选择上传文件");
                        return;
                    }
                    $("#upload").submit();
                    $("#tip").dialog('close');
                    easyDialog.open({
                        container: 'submitDiv',//这个是要被弹出来的div标签的ID值
                        fixed: true
                    });
                },
                '取消':function() {
                    $("#tip").dialog('close');
                }
            }
        });
    });
});