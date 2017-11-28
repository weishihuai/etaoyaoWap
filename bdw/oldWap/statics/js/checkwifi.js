$(function(){
    if('sell'==webPath.href){
        $('#myTab a[href="#sell"]').tab('show') // Select tab by name
    }

    $( "#openDescription" ).on( "click", function(){
        showDescr();
    } );

    var ua = navigator.userAgent.toLowerCase();
    //判断是否微信游览器
    if (ua.match(/MicroMessenger/i) == "micromessenger") {
        document.addEventListener("WeixinJSBridgeReady", function () {
            WeixinJSBridge.invoke("getNetworkType", {}, function (e) {
                if(e.err_msg=='network_type:wifi'){
                    showDescr();
                }
            })
        }, !1);
    }

})

    function showDescr(){
        $("#descriptionAlert").hide();
        $("#productDescription").load(webPath.webRoot+"/wap/include/prdDescr.ac?id="+ webPath.productId,"",null);
        $("#productDescription").show();
    }



