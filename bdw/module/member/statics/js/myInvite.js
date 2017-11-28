/**
 * Created by IntelliJ IDEA.
 * User: feng_lh
 * Date: 12-4-1
 * Time: 下午4:51
 * To change this template use File | Settings | File Templates.
 */
//复制地址 start
function copy(){
    if($.browser.msie){
        window.clipboardData.setData("Text",$("#yaoqingVal").val());

        showDialog("复制成功，请粘贴到你的QQ/MSN上推荐给你的好友",{
                    '确定':function(){
                        $("#tip").dialog("close")
                    }
                })

    }else{

        showDialog("您使用的浏览器不支持此复制功能，请使用Ctrl+C或鼠标右键。",{
                    '确定':function(){
                        $("#yaoqingVal").select()
                        $("#tip").dialog("close")
                    }
                })


    }
}
//复制地址 end

//发送信息验证 start
$(document).ready(function(){
    var opt={
        beforeSubmit:function(){
            var email=$("#email");
            if($.trim(email.val())==""){
                showDialog("请输入用户邮箱",{
                            '确定':function(){
                                $("#tip").dialog("close")
                            }
                        });
                return false;

            }
            //验证
            var reMail=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            var arry_emails = jQuery.trim(email.val()).split(",");
            for(var x in arry_emails){
                if(arry_emails[x] != null && arry_emails[x] != ''){
                    if(!reMail.test(arry_emails[x])){
                        showDialog("请输入合法的邮箱地址,肯包括中文字符或者不正确的邮箱地址",{
                            '确定':function(){
                                $("#tip").dialog("close")
                            }
                        });
                        return false;
                    }
                }
            }
        },
        success:function(){
            showDialog("发送成功",{
                        '确定':function(){

                            $("#tip").dialog("close")
                        }
                    })
        }

    }
    $("#sendEmail").ajaxForm(opt);
})
//发送信息验证 end

//显示层 start
function showDialog(text,buttons){
    $("#tiptext").html(text);
    $("#tip").dialog({
                buttons:buttons
            });

}
//显示层 end
