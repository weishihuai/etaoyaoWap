var page;
var div_id = 'defaut';
var salevolumeFlag = 0;
var priceFlag = 0;
$(document).ready(function(){
    var locationUrl;
    var pos 	= 'mm-top mm-left mm-bottom',
        zpos	= 'mm-front mm-next';

    var $html 	= $('html'),
        $menu	= $('nav#menu'),
        $both	= $html.add( $menu );

    $menu.mmenu();
    $both.removeClass( pos ).addClass( 'mm-right');
    $( "#confirm" ).click(function() {
        closeMenu();
        q = "";

        $('.av-selected').each(function(){
            q = q + $(this).attr('value')+";"
        });

        if('salesVolume,desc'==order){
            $('#myTab a[href="#sell"]').tab('show');
            loadContent("salesVolume,desc","sell");
        }else if('salesVolume,asc'==order){
            $('#myTab a[href="#sell"]').tab('show');
            loadContent("salesVolume,asc","sell");
        }else if('minPrice,desc'==order){
            $('#myTab a[href="#price"]').tab('show');
            loadContent("minPrice,desc","price");
        }else if('minPrice,asc'==order){
            $('#myTab a[href="#price"]').tab('show');
            loadContent("minPrice,asc","price");
        }
        else{
            loadContent("","defaut")
        }
//        var url =webPath+"/wap/list.ac?category="+category+"&q="+q+"&keyword="+keyword+"&page="+page+"&order="+order;
//        window.location.href=url;
    });
    $( "#cancle" ).click(function() {
        closeMenu();
    });


    $('a[data-toggle="tab"]').click('show.bs.tab', function (e) {

        var activeOrder = $(e.target).attr('value');

        if('default'==activeOrder){
            loadContent("","defaut");
        }
        if('salesvolume'==activeOrder && salevolumeFlag == 0){
            salevolumeFlag = 1;
            //alert(salevolumeFlag);
            $('#spanSale').removeClass("xxjt");
            $('#spanSale').addClass("xxjt1");
            loadContent("salesVolume,desc","sell");
        }
        else if('salesvolume'==activeOrder && salevolumeFlag == 1){
            salevolumeFlag = 0;
            //alert(salevolumeFlag);
            $('#spanSale').removeClass("xxjt1");
            $('#spanSale').addClass("xxjt");
            loadContent("salesVolume,asc","sell");
        }
        else if('price'==activeOrder && priceFlag == 0){
            priceFlag = 1;
            $('#spanPrice').removeClass("xxjt");
            $('#spanPrice').addClass("xxjt1");
            loadContent("minPrice,desc","price");
        }
        else if('price'==activeOrder && priceFlag == 1){
            priceFlag = 0;
            $('#spanPrice').removeClass("xxjt1");
            $('#spanPrice').addClass("xxjt");
            loadContent("minPrice,asc","price");
        }
    });
    loadContent("","defaut");

    $('.attrRow').on('click',function(e){
        if($(this).hasClass("av-selected")){
            $(this).removeClass("av-selected");
        }else{
            var fieldId = $(this).attr('group');
            $('[group='+fieldId+']').removeClass("av-selected");
            $(this).addClass("av-selected");
        }
    });

    $("#menu_content").css("height",$(window).height()-60+"px");
//    if(browserVersions().iPhone){
//        $("#menu_content").css("height","380px");
//    }

});

function showMore(fieldId){
    $('[group='+fieldId+']').attr('style',"block");
    $('[group='+fieldId+']').attr('showMore',"block");
}

function loadContent(newOrder,divId){

    div_id = divId;
    order =newOrder;
    var url =webPath+"/wap/listContent.ac?category="+category+"&q="+q+"&keyword="+keyword+"&page="+page+"&order=";

    $("#"+div_id).load(url+order);
}

function closeMenu(){
    $("#menu").trigger("close");
}
jQuery(function($) {
    $(document).ready( function() {
        //enabling stickUp on the '.navbar-wrapper' class
        $('.sort').stickUp();
    });
});

function topage(pagenumber){
    page = pagenumber;
    loadContent(order,div_id);
}
function browserVersions(){
        var u = navigator.userAgent, app = navigator.appVersion;
        return {//移动终端浏览器版本信息
            trident: u.indexOf('Trident') > -1, //IE内核
            presto: u.indexOf('Presto') > -1, //opera内核
            webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
            mobile: !!u.match(/AppleWebKit.*Mobile.*/)||!!u.match(/AppleWebKit/), //是否为移动终端
            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
            iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1, //是否iPad
            webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
        };
}
