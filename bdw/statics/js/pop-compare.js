$(function(){
    $(".hide-me").click(function(){
        $(".pop-compare").slideUp();
    })
    /*初始化比价栏 start*/
    var date=new Date();
    date.setTime(date.getTime()-10000);
    var strCookie=document.cookie;
    var  arrCookie=strCookie.split(";");
//            alert(document.cookie);
    var height=0;
    var productNum=1;
    for(var i=0;i<arrCookie.length;i++){
        var arr=arrCookie[i].split("=");
        if(" "+arr[1]==arr[0]){
            var productId = arr[1];
            var productNm = ($.cookie('cookie'+arr[1]).toString()).split("*")[0];
            var unitPrice = ($.cookie('cookie'+arr[1]).toString()).split("*")[2];
            var picUrl = ($.cookie('cookie'+arr[1]).toString()).split("*")[1];
            $(".item-empty"+productNum).html(" <dt> <a href='"+paramData.webRoot+"/product-"+productId+".html' target='_blank'>"+
                "<img width='50'  height='50' src='"+picUrl+"'>"+
                "</a>"+
                "</dt>"+
                "<dd>"+
                "<a href='"+paramData.webRoot+"/product-" + productId +".html' class='diff-item-name' target='_blank'>" + productNm +"</a>"+
                "<span class='p-price'><b>"+ unitPrice +
                "</b><a productId='" + productId +"' class='del-comp-item' floatNum='"+productNum.toString()+"' onclick='deleteBox(this)'>删除</a>"+
                "</span></dd>");
            $(".item-empty"+productNum.toString()).addClass("hasItem");
            $(".item-empty"+productNum.toString()).removeClass("item-empty");
            productNum++;
            paramData.cookieNum++;
        }
    }
    if(productNum>2){
        $(".btn-compare-b").addClass("compare-active");
    }
    if($(".hasItem").length!=0){
        $(".pop-compare").slideDown();
    }
//    $(".num").html(paramData.cookieNum);
    /*初始化比价栏 end*/
})
/*添加对比项 start*/
function addBox(obj){
    $("#float").show();
    var num = parseInt(paramData.cookieNum)+1;
    if( $.cookie("cookie"+$(obj).attr("productId").toString())!=null){
        $(".pop-compare").slideDown();
        alert("该产品已在对比列表中，请查看");
        return;
    }else if(paramData.cookieNum>=4){
        $(".pop-compare").slideDown();
        alert("对比产品不得超过4项");
        return;
    }else{
        var date=new Date();
        date.setTime(date.getTime()+1000*60*30);
        $.cookie("cookie"+$(obj).attr("productId").toString(),$(obj).attr("productNm").toString()+"*"+$(obj).attr("picUrl").toString()+"*"+$(obj).attr("unitPrice").toString());
        document.cookie=$(obj).attr("productId")+"="+$(obj).attr("productId");
        $(".item-empty"+num.toString()).removeClass("item-empty");
        $(".item-empty"+num.toString()).addClass("hasItem");
        $(".item-empty"+num.toString()).html(" <dt> <a href='"+paramData.webRoot+"/product-"+$(obj).attr("productId")+".html' target='_blank'>"+
            "<img width='50'  height='50' src='"+$(obj).attr("picUrl")+"'>"+
            "</a>"+
            "</dt>"+
            "<dd>"+
            "<a href='"+paramData.webRoot+"/product-"+$(obj).attr("productId")+".html' class='diff-item-name' target='_blank'>"+$(obj).attr("productNm")+"</a>"+
            "<span class='p-price'><b>"+$(obj).attr("unitPrice")+
            "</b><a productId='"+$(obj).attr("productId")+"' class='del-comp-item' floatNum='"+num.toString()+"' onclick='deleteBox(this)'>删除</a>"+
            "</span></dd>");
//        $(".add").after("<div class='floatDiv' style='height:62px' id='"+$(obj).parent().parent().find(".productId").val()+"'><input name='productId' type='hidden' value='"+ $(obj).parent().parent().find(".productId").val()+"' class='productId'/><div>"+"<a href='javascript:void(0);' onclick='deleteBox(this)' class='deleteBox'><img src='../page/lvyou88/images/list_layerbtn02.gif' alt=''></a><a class='floatNmToA' title="+$(obj).parent().parent().parent().parent().find(".productNm").html()+" href="+data.frontPath+"/productDetail.ac?id="+$(obj).parent().parent().find(".productId").val()+">"+($(obj).parent().parent().parent().parent().find(".productNm").html().toString()).substring(0,28)+"</a>"+"</div></div>");
        paramData.cookieNum++;
        if(num>=2){
            $(".btn-compare-b").addClass("compare-active");
        }
        $(".pop-compare").slideDown();
//        $(".num").html(paramData.cookieNum);
        alert("该商品品成功加入对比");
    }
};
/*添加对比项 end*/

/*删除对比项 start*/
function deleteBox(obj){
    var date=new Date();
    date.setTime(date.getTime()-10000);
    $.cookie("cookie"+$(obj).attr("productId").toString(),null);
    $(".item-empty"+$(obj).attr("floatNum").toString()).removeClass("hasItem");
    $(".item-empty"+$(obj).attr("floatNum").toString()).addClass("item-empty");
    document.cookie=$(obj).attr("productId").toString() + "=" + $(obj).attr("productId").toString()+"; expires="+date.toGMTString();
    $(".item-empty"+$(obj).attr("floatNum").toString()).html("<dt>"+$(obj).attr("floatNum").toString()+"</dt>"+
        "<dd>您还可以继续添加</dd>");
    paramData.cookieNum--;
    setTimeout(function(){
        window.location.reload();
    },1)
    if($(".hasItem").length>=2){
        $(".btn-compare-b").addClass("compare-active");
    }else{
        $(".btn-compare-b").removeClass("compare-active");
    }
//    $(".num").html(data.cookieNum);
};
///*删除对比项 end*/
//
///*清楚所有对比项cookie start*/
function cleanAllCookie(){
    var date=new Date();
    date.setTime(date.getTime()-10000);
    $(".hasItem").each(function(i){
        $.cookie("cookie"+$(this).find(".del-comp-item").attr("productId").toString(),null);
        document.cookie=$(this).find(".del-comp-item").attr("productId").toString()+"="+$(this).find(".del-comp-item").attr("productId").toString()+"; expires="+date.toGMTString();
        $(this).html(" <dt>"+$(this).find(".del-comp-item").attr("floatNum").toString()+"</dt>"+
            "<dd>您还可以继续添加</dd>");
    })
    setTimeout(function(){
        window.location.reload();
    },1)
    data.cookieNum=0;
    $(".num").html(data.cookieNum);
}
///*清楚所有对比项cookie end*/

///*提交对比项 start*/
function toSubmitComp(){
    if($(".hasItem").length<2){
        alert("对比项不能少于2个");
        return;
    }
    var link=paramData.webRoot+"/contrastDetail.ac?";
    $(".hasItem").each(function(i){
        i++;
        link = link +  "s" + i + "=" + $(this).find(".del-comp-item").attr("productId") + "&";
    })
    window.open(link);
}
///*提交对比项 end*/
//
