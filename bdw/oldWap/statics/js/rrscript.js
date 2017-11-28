
var canvas ;
var context ;
var ra;

var cw = 320;
var ch = 320 ;
var pN = pN_value;//奖品数量

var cx = 160;
var cy = 160;
var sz = 120;//半径
tx = new Array(pN) ;
tx = tx_value;
var isClick = false;


$(document).ready(function(){
    canvas = document.getElementById("myCanvas");//获取当前画布
    canvas.width = cw;//设定画布宽度
    canvas.height = ch;//设定画布高度
    context = canvas.getContext("2d");//2D画布
    $("#rotate_pointer").rotate({
        bind:{
            click:function(){
                if(isClick){
                    return;
                }
                isClick = true;
                getLotteryInfo();
            }
        }
    });
    linedraw();
});

function getLotteryInfo(){

    $.ajax({
        type:"POST",
        url:webRoot+"/frontDraw/calculateDrawResult.json",
        data:{activityId:activityId},
        dataType: "json",
        success:function(data) {
            var resultVo = data.result;
            $("#rotate_pointer").rotate({
                duration:6000,
                angle: 0,
                animateTo:3600+resultVo.angle+(360/pN/2),
                easing: $.easing.easeOutSine,
                callback: function(){
                    result(resultVo);
                }
            });
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText.indexOf("登录")>0){
                    confirmOrCancel("您还没有登录，登录么?",{onSuccess:function(){
                        window.location.href = webRoot+"/wap/login.ac";
                    }},{onCancel:function(){
                        window.location.reload();
                    }});
                    return;
                }
                affirm(result.errorObject.errorText,{onSuccess:function(){
                    window.location.reload();
                }});
            }
        }
    });
}



function linedraw(){
    var dg = 360/pN;
//    newarc(cx, cy, sz);//调用绘制转盘边缘方法
    for(var k=1;k<=pN;k++){
        var sx = Math.cos((dg*(k-1))* Math.PI / 180)*sz;
        var sy = Math.sin((dg*(k-1))* Math.PI / 180)*sz;
        var dg1 = dg*(k-1)* Math.PI/180;
        var dg2 = dg*(k)* Math.PI/180;
        drawarc(cx, cy, sz, dg1, dg2, sx, sy,k);//调用绘制转盘内容方法
    }
    drawTextAlongArc(sz,cx,cy);//调用绘制奖品名称方法
}



//绘制转盘边框中心坐标cx，cy半径为sz
function newarc(cx, cy, sz){
    context.beginPath();
    context.arc(cx, cy, sz*1.15, 0, 2 * Math.PI, false);
    context.fillStyle = "#d70506";
    context.fill();
    var gradient=context.createLinearGradient(cx-sz,cy-sz,cx+sz,cy+sz);
    gradient.addColorStop("0","#F1C63B");
    gradient.addColorStop("0.2","#fbf4aa");
    gradient.addColorStop("0.4","#F1C63B");
    gradient.addColorStop("0.6","#fbf4aa");
    gradient.addColorStop("0.8","#F1C63B");
    gradient.addColorStop("1.0","#fbf4aa");
    context.strokeStyle = gradient;
    context.lineWidth = 10;
    context.stroke();
    context.closePath();
}
//绘制转盘内容中心坐标cx，cy半径为sz
function drawarc(cx, cy, sz, dg1, dg2, sx, sy, k){

    var fc = ["","#f5f5f5", "#c65abd", "#f5f5f5", "#33d0d0", "#f5f5f5","#e3d643", "#f5f5f5", "#77cb36", "#f5f5f5", "#763801", "#fff", "#DDBB33"];
    var fcd = ["","#1b0205","#252303", "#341b04", "#152603", "#230419","#06292e","#1b0205","#252303", "#341b04", "#152603", "#230419","#06292e"];
    context.beginPath();//起始一条路径，或重置当前路径
    context.moveTo(cx, cy);//把路径移动到画布中的指定点，不创建线条
    context.lineTo(sx+cx, sy+cy);//添加一个新点，然后在画布中创建从该点到最后指定点的线条
    context.arc(cx, cy, sz, dg1, dg2, false);//创建弧/曲线（用于创建圆形或部分圆）起点为dg1终点为dg2
    context.lineTo(cx, cy);//添加一个新点，然后在画布中创建从该点到最后指定点的线条
    context.lineWidth = 1;//设置线条宽度
    context.strokeStyle = "#c9c9c9";//设置线条颜色
    context.fillStyle = fc[k];

//    var grd = context.createLinearGradient(cx, cy, sx+cx, sy+cy);//创建线性渐变（用在画布内容上）
//    grd.addColorStop(0, "#FEA139");
//    grd.addColorStop(1, "#fbf4aa");
    // grd.addColorStop(0, "#ff9a2d"); //规定渐变对象中的颜色和停止位置
    // grd.addColorStop(1, "#ffe8cf"); //规定渐变对象中的颜色和停止位置
//    context.fillStyle = grd;//设置或返回用于填充绘画的颜色、渐变或模式
    context.fill();//填充当前绘图（路径）
    context.stroke();//绘制已定义的路径 (线条)
    context.closePath();//创建从当前点回到起始点的路径
}

//奖品名称
function drawTextAlongArc(sz, cx, cy){
    var dg = 360/pN;
    context.save();
    for(var j=0;j<pN;j++){
        var sx = Math.cos((dg*(j+1)-dg/2) * Math.PI / 180)*(sz*0.6);
        var sy = Math.sin((dg*(j+1)-dg/2) * Math.PI / 180)*(sz*0.6);
        context.save();
        context.font = "bold 12px Arial";
        context.textAlign = "center";
        context.fillStyle = "#4A2A28";
        context.fillText(tx[j], sx+cx, sy+cy+5);
        context.restore();
    }

    context.restore();

}

function result(resultVo){
    if(resultVo.torphyType!="3"){
        $("#winnerWarnStr").html(resultVo.winnerWarnStr);
        if(resultVo.isNeedGetTorphy){
            var url = webRoot+"/wap/module/member/addAddress.ac?getTorphyRecodeId="+resultVo.getTorphyRecodeId;
            $("#getTrophy").find("a").attr("href",url);
            $("#getTrophy").css("display","block");
        }
    }

    if(resultVo.torphyType=="3"){
        $("#winnerWarnStr").html(resultVo.torphyName);
    }

    $('#winner_toggle').click(function(){
        $('#winner_toggle').stop().animate({'bottom':'-400px'},500,function(){
            window.location.reload();
        });
    });

    var num = resultVo.remainCount-1<=0?0:resultVo.remainCount-1;
    $("#remainCount").html("您还有"+num+"次抽奖机会");
    if(resultVo.remainCount-1<=0){
        $("#continueDraw").css("display","none");
    }
    $('#winner_toggle').css("display","block");
    $('#winner_toggle').stop().animate({'bottom':'0px'},500);
    isClick = false;
}

