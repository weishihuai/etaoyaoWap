(function () {
    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [ o[this.name] ];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    $.ajaxPost = function(url, data, successFun){

        var errorFuns = function(XMLHttpRequest, textStatus, errorThrown){
             var result = eval("(" + XMLHttpRequest.responseText + ")");
            showError(result.errorObject.errorText);
        };

        var afterSuccess = function(result) {
            if(successFun) {
                successFun(result);
            }
        };
        if(data){
            jQuery.ajax( {
                type : 'POST',
                contentType : 'application/json',
                url : url,
                data: data,
                dataType : 'json',
                timeout:3600000,
                success : afterSuccess,
                error : errorFuns
            });
        }else{
            jQuery.ajax( {
                type : 'POST',
                contentType : 'application/json',
                url : url,
                dataType : 'json',
                timeout:3600000,
                success : afterSuccess,
                error : errorFuns
            });
        }
    };
})(jQuery);

function handleResult(result) {
    {
        if(result.success) {
            return true;
        } else{
            showError("操作提示:不成功");
        }
        return false;
    }
}

function showError(showMessage,okFun){
    if(!$('.errorShowMessage').length > 0 ) {
        $('body').append('<div class="layer-tip errorShowMessage" id="errorId" style="display: none"><p id="errorText"></p> </div>');
    }
    $("#errorText").text(showMessage);
    $("#errorId").show();
    setTimeout(function(){
        $(".errorShowMessage").remove();
        if(okFun != null){
            okFun();
        }
    },3000);
}

function showSuccess(showMessage,okFun){
    if(!$('.errorShowMessage').length > 0 ) {
        $('body').append('<div class="layer-tip errorShowMessage" id="errorId" style="display: none"><p id="errorText"></p> </div>');
    }
    $("#errorText").text(showMessage);
    $("#errorId").show();
    setTimeout(function(){
        $(".errorShowMessage").remove();
        if(okFun != null){
            okFun();
        }
    },2000);
}
/*function showSuccess(showMessage,okFun){
    if($('.successShowMessage').length > 0 ) {
        return;
    }else{
        $('body').append('<div class="layer-tip2 successShowMessage" id="successId" style="display: none"><p id="successText"></p> </div>');
        $("#successId").show();
        $("#successText").text(showMessage);
        setTimeout(function(){
            $(".successShowMessage").remove();
            if(okFun != null){
                okFun();
            }
        },4000);
    }
}*/

function showConfirm(message1,okFun){
    if(!$('.showConfirm').length > 0 ) {
        $('body').append('<div class="msg-box showConfirm" style="display: none" id="confirmId"> ' +
                                '<p id="confirmMessage">内容</p> ' +
                                '<div class="btns celearfix"> ' +
                                     '<a class="btn btn-l fl" onclick="closeConfirm()" href="javascript:;">取消</a>' +
                                     '<a class="btn btn-r fr" id="confirmBt" href="javascript:;">确认</a>            ' +
                                '</div>' +
                            '</div>');
    }
    $("#confirmMessage").html(message1);
    $("#confirmId").show();
    $("#confirmBt").unbind('click').removeAttr('onclick').click(function(){
        closeConfirm();
        if(okFun!=null){
            okFun();
        }
    });
}

function closeConfirm(){
    $(".showConfirm").remove();
}


function goThisHref(href){
    window.location.href = href;
}

function showMenu(){
    $(".more-bg").slideToggle(500);
}
//$("#showMenu").click(function(){
//    $(".more-bg").slideToggle(500);
//});