$(function(){
    $('#myRebateAccount').click(function(){
        location.href = webPath.webRoot + "/wap/module/member/cps/myRebateAccount.ac";
    });

    $('#myProfile').click(function(){
        location.href = webPath.webRoot + "/wap/module/member/cps/myProfile.ac";
    });

    $('#cpsMyMember').click(function(){
        location.href = webPath.webRoot + "/wap/module/member/cps/cpsMyMember.ac?unid=" + webPath.memberId;
    });
    
    $('#myQrCode').click(function(){
        $('#qr-share-div').show();
    });

    $("#qr-share-div").click(function()　{
        $(this).hide();
    });
});