/**
 * 自定义弹出窗口  目的取代alert  该方法依赖bootstrap.js
 * 该提示做为指定控件的提示 使用时候需要注意窗口不在当前屏幕的情况
 * @param widgetId     html元素id值
 * @param orientation  窗口的弹出方向 top、bottom、left、right
 * @param title        标题名称 给title传一个空字符串则不显示标题
 * @param content      窗口展示的内容 可以添加html代码与样式
 */
function popover(widgetId,orientation,title,content){
    title = '<span style="color:#ff9933; font-size:14px;">'+ title + '</span>';
    content = '<span style="color:#555; font-size:14px;">'+ content + '</span>';
    $("#"+widgetId).popover({container:"body",html:true, toggle:"popover", placement:orientation ,title:title,content:content});
    $("#"+widgetId).popover("show");
    setTimeout(function(){$("#"+widgetId).popover("destroy");},2000);
}

/**
 * 自定义alert，替代原生的alert。依赖bootstrap.css
 * 该提示做为窗口的提示
 * @param message  消息内容
 */
function alert(message){
    var str = '<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >'+
        '<div class="modal-dialog" style="margin-top: 100px;">'+
        '<div class="modal-content col-xs-10 col-xs-push-1">'+
        '<div class="modal-header">'+
        '<h4 class="modal-title" id="myModalLabel" style="text-align: center"></h4>'+
        '</div>'+
        '<div class="modal-body" style="padding:0px;">'+
        '</div>'+
        '<div class="modal-footer" style="border -top:0px;margin-top: 0px;">'+
        '<div class="row">'+
        '<div class="col-xs-10 col-xs-push-1">'+
        '<button type="button" class="btn btn-primary btn-block" data-dismiss="modal">确定</button>'+
        '</div>'+'</div>'+'</div>'+'</div>'+'</div>'+'</div>';
    var div = document.createElement("div"); div.innerHTML = str; document.body.appendChild(div);
    $('#myModal').modal('show');
    $('#myModalLabel').text(message);
}


/**
 * 自定义alert，替代原生的alert。依赖bootstrap.css
 * 该提示做为窗口的提示
 * @param message  消息内容
 */
function lcokBox(tittle,message){
    var str = '<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" >'+
        '<div class="modal-dialog" style="margin-top: 100px;">'+
        '<div class="modal-content col-xs-10 col-xs-push-1">'+
        '<div class="modal-header">'+
        '<h4 class="modal-title" id="tittle" style="text-align: center"></h4>'+
        '</div>'+
        '<div class="modal-body" style="padding:0px;">'+
        '</div>'+
        '<div class="modal-footer" style="border -top:0px;margin-top: 0px;">'+
        '<div class="row">'+
        '<div class="col-xs-12">'+
        '<p id="message" class="text-center"></p>'+
        '</div>'+'</div>'+'</div>'+'</div>'+'</div>'+'</div>';
    var div = document.createElement("div"); div.innerHTML = str; document.body.appendChild(div);
    $('#myModal').modal('show');
    $('#tittle').text(tittle);
    $('#message').text(message);
}

/**
 * 自定义弹出窗口 目的取代confirm  该方法依赖bootstrap.css
 * 该提示为确认提示 做比较重要的操作时可以使用该提示来强调
 * @param message 窗口的提示标题
 * @param result
 */
var confirm =  function  (message,result){

    var str = '<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >'+
                '<div class="modal-dialog" style="margin-top: 100px;">'+
                '<div class="modal-content">'+
                '<div class="modal-header">'+
                '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
                '<h4 class="modal-title" id="myModalLabel"></h4>'+
                '</div>'+
                '<div class="modal-body" style="padding:0px;">'+
                '</div>'+
                '<div class="modal-footer" style="border -top:0px;margin-top: 0px;">'+
                '<div class="row">'+
                '<div class="col-xs-3 col-xs-push-5">'+
                '<button type="button" class="btn btn-primary btn-block" id="confirmButton" style="margin-right: 20px;">确定</button>'+
                '</div>'+
                '<div class="col-xs-3 col-xs-push-6">'+
                '<button type="button" class="btn btn-default btn-block" id="cancleButton">取消</button>'+
                '</div>'+'</div>'+'</div>'+'</div>'+'</div>'+'</div>';
    var div = document.createElement("div"); div.innerHTML = str; document.body.appendChild(div);

    $('#myModal').modal('show');
    $('#myModalLabel').text(message);
    $('#confirmButton').on('click',function(){
        $('#myModal').modal('hide');
        result.onSuccess();
    });
    $('#cancleButton').on('click',function(){
        $('#myModal').modal('hide');
        return false;
    });
};

/*点击确定和取消执行不同的结果*/
var confirmOrCancel =  function  (message,result,cancel){

    var str = '<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >'+
        '<div class="modal-dialog" style="margin-top: 100px;">'+
        '<div class="modal-content">'+
        '<div class="modal-header">'+
        '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
        '<h4 class="modal-title" id="myModalLabel"></h4>'+
        '</div>'+
        '<div class="modal-body" style="padding:0px;">'+
        '</div>'+
        '<div class="modal-footer" style="border -top:0px;margin-top: 0px;">'+
        '<div class="row">'+
        '<div class="col-xs-3 col-xs-push-5">'+
        '<button type="button" class="btn btn-primary btn-block" id="confirmButton" style="margin-right: 20px;">确定</button>'+
        '</div>'+
        '<div class="col-xs-3 col-xs-push-6">'+
        '<button type="button" id="cancelBtn" class="btn btn-default btn-block" data-dismiss="modal">取消</button>'+
        '</div>'+'</div>'+'</div>'+'</div>'+'</div>'+'</div>';
    var div = document.createElement("div"); div.innerHTML = str; document.body.appendChild(div);

    $('#myModal').modal('show');
    $('#myModalLabel').text(message);
    $('#confirmButton').on('click',function(){
        $('#myModal').modal('hide');
        result.onSuccess();
    });
    $('#cancelBtn').on('click',function(){
        $('#myModal').modal('hide');
        cancel.onCancel();
    });
};

/*提醒用户消息，确定后执行下一步操作,去除取消按钮*/
var affirm =  function  (message,result){

    var str = '<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >'+
        '<div class="modal-dialog" style="margin-top: 100px;">'+
        '<div class="modal-content">'+
        '<div class="modal-header">'+
        '<h4 class="modal-title" style="text-align:center; font-size: 14px;" id="myModalLabel"></h4>'+
        '</div>'+
        '<div class="modal-body" style="padding:0px;">'+
        '</div>'+
        '<div class="modal-footer" style="border -top:0px;margin-top: 0px;">'+
        '<div class="row">'+
        '<div class="col-xs-10 col-xs-push-1">'+
        '<button type="button" class="btn btn-primary btn-block" id="confirmButton" style="margin-right: 20px;">确定</button>'+
        '</div>'+
        '</div>'+'</div>'+'</div>'+'</div>'+'</div>';
    var div = document.createElement("div"); div.innerHTML = str; document.body.appendChild(div);

    $('#myModal').modal('show');
    $('#myModalLabel').text(message);
    $('#confirmButton').on('click',function(){
        $('#myModal').modal('hide');
        result.onSuccess();
    });
};