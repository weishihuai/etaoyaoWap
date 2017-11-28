/*不支持匿名投票和登录ID为空时，则跳转至登录页面*/
$(document).ready(function(){
    if(pageData.isAnonymousVote=='否'&&pageData.userId==""){
        window.location.href=pageData.webRoot+"/login.ac";
    }
});

function questionnaireCommit(){
    var questionnaireId =$("#questionnaireId").val();
    if(pageData.userId==""&&jQuery.cookie("questionnaire-"+questionnaireId)!=null){
        alert("您已经填写过问卷，谢谢您的参与！");
        if(pageData.isAllowViewResult=='是'){
            showCalendarTip();//弹出层
	        window.location.href=pageData.webRoot+"/index.ac";
        }
    }else{
        var i=0;
        var items = [];
        $(".optionItem").each(function(){
            if($(this).attr("checked")){
                items[i]=$(this).val();
                i++;
            }
        });
        if(items.length==0){
            alert("您还没有做任何的选择！");
        }else{
            var value={questionnaireId:questionnaireId,items:items};
            save(value);
        }
    }
}

function save(obj){
    var questionnaireId =$("#questionnaireId").val();
    $.ajaxSettings['contentType'] = "application/json; charset=UTF-8";
    /* $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";*/
    $.ajax({
        type:"POST",
        url:pageData.webRoot+"/frontQuestionnaire/saveQuestionnaire.json",
        data:_ObjectToJSON('post',obj),
        dataType: "json",
        success:function(data) {
            if(data.success==false){
                alert("您已经填写过问卷，谢谢您的参与！");
                window.location.href=pageData.webRoot+"/index.ac";
                if(pageData.isAllowViewResult=='是'){
                    showCalendarTip();//弹出层
                }
            }else{
                if(pageData.userId==""){
                    jQuery.cookie("questionnaire-"+questionnaireId,"questionnaire="+questionnaireId);
                }
                if(pageData.isAllowViewResult=='是'){
                    alert("提交成功");
                    showCalendarTip();//弹出层
                    window.location.href=pageData.webRoot+"/index.ac";
                }else{
                    alert("提交成功");
                    window.location.href=pageData.webRoot+"/index.ac";
                }

            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}

var showCalendarTip = function (){
    $.openDOMWindow({
        loader:0,
        windowBGColor:"#FFFFFF",
        width:339,
        height:144,
        borderSize:0,
        windowSourceID:'#Layer',
        windowPadding:0,
        overlay:0,
        windowZIndex:1000
    });
    return false;
};

var closeShoppingCartTip = function(){
    $.closeDOMWindow();
};