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

        var errorFun = function(XMLHttpRequest, textStatus, errorThrown){
             var result = eval("(" + XMLHttpRequest.responseText + ")");
             alert(result.errorObject.errorText);
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
                error : errorFun
            });
        }else{
            jQuery.ajax( {
                type : 'POST',
                contentType : 'application/json',
                url : url,
                dataType : 'json',
                timeout:3600000,
                success : afterSuccess,
                error : errorFun
            });
        }
    };
})(jQuery);

function handleResult(result) {
    {
        if(result.success) {
            return true;
        } else{
            alert("操作提示:不成功");
        }
        return false;
    }
}


function showLoading(isShow){
    if(!$('#showLoading').length > 0 ) {
        $('body').append('<div id="showLoading" style="display: none;">'+
            '<div id="loading">'+
            '<div id="load">加载中....</div>'+
            '</div>'+
            '</div>');
    }
    if(isShow){
        $("#showLoading").show();
    }else{
        $("#showLoading").hide();
    }
}



function showErrorWin(showMessage,okFun){
    $("#errorBt").unbind('click').removeAttr('onclick').click(function(){
        closeErrorWin();
    });
    $(document).live("keydown",function(event){
        if(event.keyCode == 13){
            closeErrorWin();
        }
    });
    $("#errorText").html(showMessage);
    $("#errorId").show();
    if(okFun!=null){
        $("#errorBt").unbind('click').removeAttr('onclick').click(function(){
            okFun();
        });
    }
}
function closeErrorWin(){
    $("#errorId").hide();
}

function showSuccessWin(showMessage,okFun){
    $("#successBt").unbind('click').removeAttr('onclick').click(function(){
        closeSuccessWin();
    });
    $("#successText").html(showMessage);
    $("#successId").show();
    if(okFun!=null){
        $("#successBt").unbind('click').removeAttr('onclick').click(function(){
            okFun();
        });
    }
}
function closeSuccessWin(){
    $("#successId").hide();
}


function showConfirm(message1,okFun){
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
    $("#confirmId").hide();
}


//时间格式化
Date.prototype.format = function(fmt) {
    var o = {
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时
        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt)) {
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    }
    for(var k in o) {
        if(new RegExp("("+ k +")").test(fmt)){
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        }
    }
    return fmt;
}