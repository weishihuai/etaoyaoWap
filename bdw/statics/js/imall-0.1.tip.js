/**
 * $.imallTipSettings
 * $.imallShowTip
 * $.imallValidTip
 * @extends jquery-1.6.1.min.js
 * @fileOverview 创建文字提示框
 * @author xws
 * @version 0.1
 * @date 2012-04-12
 * @example
 *
 */
(function($){
    var defaultContent = {
        content:'请输入内容',outIsHide:false,
        margintop:'-26px',marginleft:'235px',
        wariningBackground:'none repeat scroll 0 0 #E6F7FF',errorBackground:'none repeat scroll 0 0 #FDEBE6',
        wariningBorder:"1px solid #C7E2F1",errorBorder:"1px solid #FFBB7A",
        errorSpanColor:"#FF5500",wariningSpanColor:"#333333",
        color:"#333333",fontsize:'12px',padding:'5px 20px',textalign:'center',
        zindex: '12132',lineHeight:'0px',imgWarningSrc:'',
        imgErrorSrc:'',imgSuccessSrc:'',tipWariningClass:'tipWariningClass',
        tipSuccessClass:'tipSuccessClass',tipErrorClass:'tipErrorClass',
        eventOut:'blur',eventIn:'focus',
        imgMargin:'-1px 5px 0px 0px'
    };

    $.imallTipSettings = function(settings){//设置参数
        defaultContent = $.extend(true,defaultContent,settings);
    };

    $.fn.imallShowTip = function(content){//隐藏
//        this.bind(defaultContent.eventOut,function(){
//            hideErrorTip($(this));
//        });

        this.bind(defaultContent.eventIn,function(){//显示
            hideErrorTip($(this));
            hideSuccessTip($(this));
            var imallTip = $(this).nextAll('.'+defaultContent.tipWariningClass);
            if(imallTip.length==0){
                $(this).after(getWarningTip(content));
            }
            imallTip = $(this).nextAll('.'+defaultContent.tipWariningClass);
            imallTip.children('span').html(content);
            imallTip.show("fast");
        });
    };

    $.fn.imallValidTip = function(status,content){//验证提示
        if(status == 'error'){
            var tipError = $(this).nextAll('.'+ defaultContent.tipErrorClass);
            if(tipError.length == 0){
                $(this).after(getErrorTip(content));
                tipError = $(this).nextAll('.'+defaultContent.tipErrorClass);
            }
            tipError.children('span').html(content);
            tipError.show("fast");
            hideWariningTip($(this));
            hideSuccessTip($(this));
        }else if(status == 'success'){
            var tipSuccessClass = $(this).nextAll('.'+ defaultContent.tipSuccessClass);
            if(tipSuccessClass.length == 0){
                $(this).after(getOkTip());
                tipSuccessClass = $(this).nextAll('.'+ defaultContent.tipSuccessClass);
            }
            tipSuccessClass.show("fast");
            hideWariningTip($(this));
            hideErrorTip($(this));
        }
    };

    function getWarningTip(content){
        var img ='';
        if(defaultContent.imgWarningSrc != ''){
            img = '<img style="vertical-align:middle;margin:'+defaultContent.imgMargin+';" src="'+defaultContent.imgWarningSrc+'"/>';
        }
        if(content == ''){
            content = defaultContent.content;
        }

        var div =  '<div class="'+defaultContent.tipWariningClass+'" style="border:'+defaultContent.wariningBorder
            +';margin-top:'+defaultContent.margintop+';margin-left:'+defaultContent.marginleft+';background:'+defaultContent.wariningBackground
            +';color:'+defaultContent.color+';display: none;font-size:'+defaultContent.fontsize+';padding: '+defaultContent.padding
            +';text-align:'+defaultContent.textalign+';z-index:'+defaultContent.zindex+';line-height:'+defaultContent.lineHeight+';position: absolute;">'
            +img
            +'<span style="color: '+defaultContent.wariningSpanColor+'">'+content+'</span></div>';
        return div;
    };

    function getErrorTip(content){
        var img ='';
        if(defaultContent.imgErrorSrc != ''){
            img = '<img style="vertical-align:middle;margin:'+defaultContent.imgMargin+';" src="'+defaultContent.imgErrorSrc+'"/>';
        }
        if(content == ''){
            content = defaultContent.content;
        }

        var div =  '<div class="'+defaultContent.tipErrorClass+'" style="border:'+defaultContent.errorBorder
            +';margin-top:'+defaultContent.margintop+';margin-left:'+defaultContent.marginleft+';background:'+defaultContent.errorBackground
            +';color:'+defaultContent.color+';display: none;font-size:'+defaultContent.fontsize+';padding: '+defaultContent.padding
            +';text-align:'+defaultContent.textalign+';z-index:'+defaultContent.zindex+';line-height:'+defaultContent.lineHeight+';position: absolute;">'
            +img
            +'<span style="color: '+defaultContent.errorSpanColor+'">'+content+'</span></div>';
        return div;
    };

    function hideErrorTip(thisInput){
        var errorTip = thisInput.nextAll('.'+ defaultContent.tipErrorClass);
        if(errorTip.length > 0){
            errorTip.hide();
        }
    }

    function hideSuccessTip(thisInput){
        var successTip = thisInput.nextAll('.'+ defaultContent.tipSuccessClass);
        if(successTip.length > 0){
            successTip.hide();
        }
    }

    function hideWariningTip(thisInput){
        var wariningTip = thisInput.nextAll('.'+ defaultContent.tipWariningClass);
        if(wariningTip.length > 0){
            wariningTip.hide();
        }
    }

    function getOkTip(){
       /* return '<img class="'+defaultContent.tipSuccessClass+'" style="vertical-align:middle;margin:'+defaultContent.imgMargin+';" src="'+defaultContent.imgSuccessSrc+'"/>';*/
    }
})(jQuery);