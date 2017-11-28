$(function(){
	$('#close_im').bind('click',function(){
		$('#main-im').css("height","0");
		$('#im_main').hide();
		$('#open_im').show();
	});
	$('#open_im').bind('click',function(e){
		$('#main-im').css("height","272");
		$('#im_main').show();
		$(this).hide();
	});
	$('.go-top').bind('click',function(){
		$(window).scrollTop(0);
	});
	$(".weixing-container").bind('click',function(){
		if($('.weixing-show').css("display") == "none"){
			$('.weixing-show').show();
		}else{
			$('.weixing-show').hide();
		}
	});
	/*	$(".weixing-container").bind('mouseleave',function(){
		$('.weixing-show').hide();
	});*/
});