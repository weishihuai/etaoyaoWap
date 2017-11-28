$(function(){
    //上拉加载数据
    var readedpage = 1;//当前滚动到的页数
    var lastPageNumber = webParams.lastPageNumber;
    $("#main").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".record" ,
        animate: true,
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50
    }, function(newElements) {
        readedpage++;
        if(readedpage > lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
            $("#page-nav").remove();
            $("#main").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }else{
            $("#page-nav a").attr("href", webParams.webRoot + "/wap/module/member/cps/myRebateAccount.ac?rebateAccountType="+webParams.rebateAccountType+"&page="+readedpage+"&indexYear="+webParams.indexYear+"&indexMonth="+webParams.indexMonth);
        }
    });
});

//判空
function isEmpty(obj){
    if(obj==undefined || obj==null || obj==''){
        return true;
    }else{
        return false;
    }
}