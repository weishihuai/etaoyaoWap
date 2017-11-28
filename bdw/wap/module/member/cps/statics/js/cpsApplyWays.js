

$(function(){
    $(".pay-item").click(function(){

        if($(".pay-item .toggle").size()>0 && $(this).attr("url") != undefined){
            var $href= $(this).attr("url");
            window.location.href =$href;
        }
        if($(".pay-item .toggle").size()==0){
            $(".pay-item").removeClass("active");
            $(this).addClass("active");
            webParams.withdrawalWayCode=$(this).attr("withdrawalWayCode");
        }

    });

    $("#btnTrue").click(function(){
        window.location.href = webParams.webRoot+"/wap/module/member/cps/cpsApplying.ac?withdrawalWayCode="+webParams.withdrawalWayCode;
    });




});