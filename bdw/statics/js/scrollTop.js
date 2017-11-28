jQuery.fn.extend({
    scrollTop1:function(){
        this.click(function(){
            //window.scrollTo(0,0);
            $('html,body').animate({scrollTop:'0'},500);
            return false;
        });
    }

});
