var s_item_height;
$(document).ready(function(){
    $(function(){
        if($.browser.msie&&($.browser.version === "6.0")){
            $('.showList ul li').each(function(){
                if($(this).find('.title').height()>40){
                    $(this).find('.title').css({height:40});
                }
            });
        }
    });
    /*上一页和下一页*/
    checkPage();
    $("#pageUp").click(function(){
        if(dataValue.page==1){
            alert("当前已是第一页");
            return;
        }
        var page=parseInt(dataValue.page)-1;
        toUrl(page);
    })

    $("#pageDown").click(function(){
        if(dataValue.page==dataValue.totalPage){
            alert("当前已是最后一页");
            return;
        }
        var page=parseInt(dataValue.page)+1;
        toUrl(page);
    })

    /*热门城市*/
    if(dataValue.selectId==null||dataValue.selectId==""){
        $("#C_"+dataValue.nodeId).addClass("cur");
    }

    /*地区div高度控制*/
    s_item_height=$(".zoneNm").height();
    $("#areaLabel").css("height",$(".screen").height());
    if(dataValue.lastNodeId==null||dataValue.lastNodeId==""){
        if(s_item_height>26){
            $(".s_more").show();
            $(".zoneNm").css("height","31px");
            $("#areaLabel").css("height",$(".screen").height());
            $(".screen").css("height","32px");
        }else{
            $(".s_more").hide();
        }
    }else{
        $(".s_more").hide();
    }
    /*积分范围样式控制*/
    if(dataValue.lastNodeId!=""){
        $("#"+dataValue.lastNodeId).addClass("cur");
    }
    $(".paymentWay").find("a").removeClass("cur");
    if(dataValue.isIntegral=='Y'){
        $(".integral").addClass("cur");
    } else if(dataValue.isIntegral=='N'){
        $(".integralAndCash").addClass("cur");
    }else{
        $(".integralAll").addClass("cur");
    }
    /*支付方式样式控制*/
    $(".range").find("a").removeClass("cur");
    if(dataValue.min==""||dataValue.max==""){
        $(".rangeAll").addClass("cur");
    }else if(dataValue.min=="0"&&dataValue.max=="1000"){
        $(".rangeF").addClass("cur");
    } else if(dataValue.min=="1100"&&dataValue.max=="20000"){
        $(".rangeS").addClass("cur");
    }else{
        $("#min").attr("value",dataValue.min);
        $("#max").attr("value",dataValue.max);
    }
});

/*排序*/
function order(order){
    if(order=='integralOrder'){
        if(dataValue.order==""||dataValue.order=="integralPrice,desc"){
            urlForOrder("integralPrice,asc");
        }else{
            urlForOrder("integralPrice,desc");
        }
    }
    if(order=='timeOrder'){
        if(dataValue.order==""||dataValue.order=="integralProductId,asc"){
            urlForOrder("integralProductId,desc");
        }else{
            urlForOrder("integralProductId,asc");
        }
    }
}

function urlForOrder(order){
    if(dataValue.type==null||dataValue.type==""){
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "nodeId="+dataValue.nodeId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+dataValue.min+
            "&max="+dataValue.max+
            "&order="+order +
            "&categoryId="+dataValue.categoryId ;
    }else{
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "type="+dataValue.type+
            "&selectId="+dataValue.selectId+
            "&lastNodeId="+dataValue.lastNodeId+
            "&nodeId="+dataValue.nodeId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+dataValue.min+
            "&max="+dataValue.max+
            "&order="+order +
            "&categoryId="+dataValue.categoryId ;
    }
}

function toUrl(page){
    if(dataValue.type==null||dataValue.type==""){
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "nodeId="+dataValue.nodeId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+dataValue.min+
            "&max="+dataValue.max+
            "&page="+page +
            "&categoryId="+dataValue.categoryId ;
    }else{
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "type="+dataValue.type+
            "&selectId="+dataValue.selectId+
            "&lastNodeId="+dataValue.lastNodeId+
            "&nodeId="+dataValue.nodeId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+dataValue.min+
            "&max="+dataValue.max+
            "&page="+page+
            "&categoryId="+dataValue.categoryId ;
    }
}

function checkPage(){
    if(dataValue.page==dataValue.totalPage||dataValue.page+1==dataValue.totalPage){
        $("#pageDown").find("img").attr("src",dataValue.webRoot+"/template/lihui/statics/images/list_turnP_inB01.gif");
    }else{
        $("#pageDown").find("img").attr("src",dataValue.webRoot+"/template/lihui/statics/images/list_turnP_inB02.gif");
    }
    if(dataValue.page==1){
        $("#pageUp").find("img").attr("src",dataValue.webRoot+"/template/lihui/statics/images/list_turnP_inF01.gif");
    }else{
        $("#pageUp").find("img").attr("src",dataValue.webRoot+"/template/lihui/statics/images/list_turnP_inF02.gif");
    }
}

function findArea(obj){
    var selectId=$(obj).find("a").attr("id");
    var type=$(obj).find('.type').val();
    if(type!="D"){
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "type="+type+
            "&selectId="+selectId+
            "&nodeId="+selectId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+dataValue.min+
            "&max="+dataValue.max+
            "&categoryId="+dataValue.categoryId ;
    }
    if(type=="D"){
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "type="+dataValue.type+
            "&selectId="+dataValue.selectId+
            "&lastNodeId="+selectId+
            "&nodeId="+selectId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+dataValue.min+
            "&max="+dataValue.max+
            "&categoryId="+dataValue.categoryId ;
    }
}

function payment(obj){
    var  isHotCity;
    if(dataValue.type==null||dataValue.type==""){
        isHotCity="Y";
    }else{
        isHotCity="N";
    }
    if(obj=='integral'){
        paymentExecute(isHotCity,"Y");
    }else  if(obj=='integralAndCash'){
        paymentExecute(isHotCity,"N");
    }else{
        paymentExecute(isHotCity,"");
    }
}

function paymentExecute(isHotCity,isIntegral){
    if(isHotCity=="Y"){
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "nodeId="+dataValue.nodeId+
            "&isIntegral="+isIntegral+
            "&min="+dataValue.min+
            "&max="+dataValue.max+
            "&categoryId="+dataValue.categoryId ;
    }else{
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "type="+dataValue.type+
            "&selectId="+dataValue.selectId+
            "&lastNodeId="+dataValue.lastNodeId+
            "&nodeId="+dataValue.nodeId+
            "&isIntegral="+isIntegral+
            "&min="+dataValue.min+
            "&max="+dataValue.max+
            "&categoryId="+dataValue.categoryId ;
    }
}

function range(obj1,obj2){
    if(dataValue.type==null||dataValue.type==""){
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "nodeId="+dataValue.nodeId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+obj1+
            "&max="+obj2+
            "&categoryId="+dataValue.categoryId ;
    }else{
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "type="+dataValue.type+
            "&selectId="+dataValue.selectId+
            "&lastNodeId="+dataValue.lastNodeId+
            "&nodeId="+dataValue.nodeId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+obj1+
            "&max="+obj2+
            "&categoryId="+dataValue.categoryId ;
    }
}

function range2(){
    var obj1=$("#min").val();
    var obj2=$("#max").val();
    if(dataValue.type==null||dataValue.type==""){
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "nodeId="+dataValue.nodeId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+obj1+
            "&max="+obj2+
            "&categoryId="+dataValue.categoryId ;
    }else{
        /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
        window.location.href=dataValue.webRoot+"/jfhg.ac?" +
            "type="+dataValue.type+
            "&selectId="+dataValue.selectId+
            "&lastNodeId="+dataValue.lastNodeId+
            "&nodeId="+dataValue.nodeId+
            "&isIntegral="+dataValue.isIntegral+
            "&min="+obj1+
            "&max="+obj2+
            "&categoryId="+dataValue.categoryId ;
    }
}

function hotCity(selectId){
    /*window.location.href=dataValue.webRoot+"/integral/integralList.ac?" +*/
    window.location.href=dataValue.webRoot+"/jfhg.ac?" +
        "nodeId="+selectId+
        "&isIntegral="+dataValue.isIntegral+
        "&min="+dataValue.min+
        "&max="+dataValue.max+
        "&categoryId="+dataValue.categoryId ;
}

function showUnSel(){
    $("#showUnSel").hide();
    $("#hideUnSel").show();
    $(".s_more").css("bottom","6px");
    $(".screen").css("height",s_item_height);
    $(".zoneNm").css("height",s_item_height);
    $("#areaLabel").css("height",$(".screen").height());
}

function hideUnSel(){
    $("#showUnSel").show();
    $("#hideUnSel").hide();
    $(".s_more").css("bottom","10px");
    $(".zoneNm").css("height","31px");
    $(".screen").css("height","32px");
    $("#areaLabel").css("height",$(".screen").height());
}