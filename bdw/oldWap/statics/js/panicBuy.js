/**
 * Created with IntelliJ IDEA.
 * User: ljt
 * Date: 13-11-28
 * Time: 下午1:50
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){
    if(pageData.tabSelect=='N'){
        $('#myTab a[value="pan2"]').tab('show');
    }

    $("input[name=time]").each(function() {
        $(this).next("[name=endTime]").imallCountdown($(this).val(),'span',pageData.nowTime);
    });
});

var gotoUrl=function(type){
    window.location.href=pageData.webRoot+"/wap/panicBuy.ac?tabSelect="+type;
}
