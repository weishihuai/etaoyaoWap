$(function(){
    $(".systemMsgTab").click(function(){
        $('.imallNoticeTab').removeClass('cur');
        $('.systemMsgTab').addClass('cur');
        $("#imallNotice").hide();
        $("#systemMsg").show();
    });
    $(".imallNoticeTab").click(function(){
        $('.systemMsgTab').removeClass('cur');
        $('.imallNoticeTab').addClass('cur');
        $("#imallNotice").show();
        $("#systemMsg").hide();
    });
});
/*系统消息 展开关闭*/
var closeSystemTip = function(systemMsgID){
    $("#"+systemMsgID).hide();
};
var showSystemTip = function(systemMsgID){
    $("#"+systemMsgID).show();
};
/*商城公告 展开关闭*/
var closeNoticeTip = function(NoticeId){
    $("#"+NoticeId).hide();
};
var showNoticeTip = function(NoticeId){
    $("#"+NoticeId).show();
};