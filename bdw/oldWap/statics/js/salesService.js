$(function(){

    $(".log-btn").click(function(){
        $(".overlay").css("display","block");
    });

    $(".close").click(function(){
        $(".overlay").css("display","none");
        $(".mc input").val("");
    });
    // 售后滚动
    var currentPage = 1;//当前滚动到的页数
    $("#saleServiceApply").infinitescroll({
        navSelector: '.ser-content-nav-bar',
        nextSelector: '.ser-content-nav-bar a',
        animate: true,
        itemSelector :  '.cont-box1',
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50,
    },function(){
        currentPage ++;
        if(currentPage <= webParam.lastPageNumber){
            $(".ser-content-nav-bar a").attr("href", webParam.webRoot + "/wap/module/afterSaleService/loadSaleServiceApply.ac?userId="+ webParam.userId + "&pageNum=" + currentPage + "&pageSize=8");
        } else{
            $("#saleServiceApply").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }
    });

    // 退换滚动
    var currentPage = 1;//当前滚动到的页数
    $("#returnProcess").infinitescroll({
        navSelector: '.ser-content-nav-bar',
        nextSelector: '.ser-content-nav-bar a',
        animate: true,
        itemSelector:  '.cont-box2',
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50,
    },function(){
        currentPage ++;
        if(currentPage <= webParam.lastPageNumber){
            $(".ser-content-nav-bar a").attr("href", webParam.webRoot + "/wap/module/afterSaleService/loadReturnProcess.ac?"+ webParam.userId + "&pageNum=" + currentPage + "&pageSize=8");
        } else{
            $("#returnProcess").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }
    });

    // 换货滚动
    var currentPage = 1;//当前滚动到的页数
    $("#exchangeProcess").infinitescroll({
        navSelector: '.ser-content-nav-bar',
        nextSelector: '.ser-content-nav-bar a',
        animate: true,
        itemSelector:  '.cont-box2',
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50,
    },function(){
        currentPage ++;
        if(currentPage <= webParam.lastPageNumber){
            $(".ser-content-nav-bar a").attr("href", webParam.webRoot + "/wap/module/afterSaleService/loadExchangeProcess.ac?"+ webParam.userId + "&pageNum=" + currentPage + "&pageSize=8");
        } else{
            $("#exchangeProcess").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }
    });
});
function submitLogisticOrder(obj){
    var returnId = $(obj).attr("returnId");
    var logisticsNum = $("#logisticsNum").val().trim();
    var logisticsCompanyNm = $("#logisticsCompanyNm").val().trim();
    var type = $("#type").val();
    if(!checkLogisticsCompanyNm(logisticsCompanyNm)){
        return;
    }
    if(!checkLogisticsNum(logisticsNum)){
        return;
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    if (isReturn === 'N') {
        $.post(webParam.webRoot + "/afterSale/exchangeOrder/updateLogistics.json", {
            exchangeOrderId: returnId,
            logisticsOrderCode: logisticsNum,
            logisticsCompany: logisticsCompanyNm
        }, function () {
            $(".overlay").css("display","none");
            setTimeout(function(){window.location.reload()},1)
        })
    }else {
        $.post(webParam.webRoot + "/afterSale/returnOrder/updateLogistics.json", {
            returnedPurchaseOrderId: returnId,
            logisticsOrderCode: logisticsNum,
            logisticsCompany: logisticsCompanyNm
        }, function () {
            $(".overlay").css("display","none");
            setTimeout(function(){window.location.reload()},1)
        })
    }
}

function fillLogisticsOrder(id){
    $(".confirm").attr("returnId", id);
}

function confirmDelivery(id){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.post(webParam.webRoot + '/afterSale/exchangeOrder/finish.json',{exchangeOrderId:id},function(){
        $(".overlay").css("display","none");
        setTimeout(function(){window.location.reload()},1);
    })
}

function checkLogisticsCompanyNm(logisticsCompanyNm){
    if(logisticsCompanyNm == undefined || logisticsCompanyNm == ''){
        alert("请填写物流公司名称");
        return false;
    } else if(!/^[0-9a-zA-Z\u4e00-\u9fa5]*$/.test(logisticsCompanyNm)){
        alert("物流公司只能输入数字,字母，中文");
        return false;
    }
    return true;
}
function checkLogisticsNum(logisticsNum){
    if(logisticsNum == undefined || logisticsNum == ''){
        alert("请填写物流单号");
        return false;
    }else if(!/^[0-9a-zA-Z]*$/.test(logisticsNum)){
        alert("物流单号只能输入数字,字母");
        return false;
    }
    return true;
}

//检查服务时间
function checkAfterSale(type,id){
    $.ajax({
        type:"post" ,url:webParam.webRoot + "/member/checkAfterSaleTime.json",
        data:{id:id,serviceType:type},
        dataType:"json",
        success:function(data) {
            if(data.result){
                if(type == 1){
                    location.href = webParam.webRoot + "/wap/module/afterSaleService/returnOrder.ac?orderId=" +id;
                }else{
                    location.href = webParam.webRoot +"/wap/module/afterSaleService/exchangeOrder.ac?orderId=" +id;
                }
            }else{
                alert("抱歉，该订单已超出该服务时间范围");
            }
        }
    });
}
