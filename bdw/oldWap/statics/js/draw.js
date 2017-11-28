$(document).ready(function(){
    if(luckyDrawActivity){
        easyDialog.open({
            container : {
                header : '系统提示',
                content : '<div>活动正在维护中，请稍等....</div>',
                isShowClose :false,
                yesFn : false,
                noFn : false
            }
        });
    }
});

function reload(){
    window.location.href = webRoot+"/wap/module/member/vScratchCard.ac?timeStamp="+new Date().getTime();
}