jQuery.fn.upMove = function(item,num,time) {
		if(!time){time = 3000}
	    return this.each(function(){
	    	var c = {
	    			id:$(this),
	    			move:function(item,num){
	    				var id = this.id;
	    				var div = id.find(item);
	    				var length = div.length;
	    		    	if(length < num){
	    		    		return false;
	    		    	}
	    		    	var end = length - 1;
				    	var first = div.eq(0);
				    	var last = div.eq(end);
				    	var height = '-'+first.outerHeight();
				    	id.animate({marginTop: height},500,function(){
				    		id.css('margin-top','0px');
				    		first.insertAfter(last);
				    	});
	    			}
	    	}
	    	setInterval(function(){
	    		c.move(item,num);
	    	},time);
	    });
}