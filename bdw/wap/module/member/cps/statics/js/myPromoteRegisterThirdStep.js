$(function(){
    setInterval(countDown, 1000);
});

function countDown(){
    var second = parseInt($('#countDown').text().trim());
    if(second==0){
        location.href = webPath.webRoot + "/wap/module/member/index.ac?type=member";
    }else{
        $('#countDown').text(second - 1);
    }
}