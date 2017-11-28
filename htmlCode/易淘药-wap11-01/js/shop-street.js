$(function(){
	
	// 头部搜索框 仿input:placeholder
	(function() {
		var search_box = $(".m-top .search-box");
		search_box.find("input").focus( function(){
			$(this).siblings(".search-p").hide();
		});
		search_box.find("input").blur( function(){
			if ($(this).val() == '') {
				$(this).siblings(".search-p").show();
			}	
		});
	})();
});