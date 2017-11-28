var eggCan;
var eggCtx;
var width = 320;
var height = 329;
var contCan;
var contCtx;
var TrophyName="";
var isClick = false;
 window.onload = function(){
    $("#contCan").hide();
	//金蛋的图片
 	eggCan=document.getElementById("eggCan");
	eggCtx=eggCan.getContext("2d");
	var eggImg=document.getElementById("eggImg");
	eggCan.width =width;
	eggCan.height =height;
	eggCtx.drawImage(eggImg,width/2-eggImg.width/2,height/2-eggImg.height/2);
     $("#hamer_div").rotate({
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

 };

function getLotteryInfo(){
    $('#winner_toggle').stop().animate({'bottom':'-400px'},500);
    $.ajax({
        type:"POST",
        url:webRoot+"/frontDraw/calculateDrawResult.json",
        data:{activityId:activityId},
        dataType: "json",
        success:function(data) {
            var resultVo = data.result;
            $("#rotate_hammer").rotate({
                duration:500,
                angle: 0,
                animateTo:-20,
                easing: $.easing.easeOutSine,
                callback: function(){
                    TrophyName = resultVo.torphyName;
                    eggCtx.clearRect( 0, 0, width, height );
                    var bombImg=document.getElementById("bombImg");
                    eggCtx.drawImage(bombImg,width/2-bombImg.width/2,height/2-bombImg.height/2);
                    createHit();
                    showText();
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



//显示文字
function showText(){
	var staNum = 0;
	var endNum = 4;

	var timer = setInterval( function(){
		if (staNum<endNum) {
			magnify();
			staNum++;
		}else{
		clearInterval(timer);
		}
	}, 1000/10 );

}


//向上移动并放大字体
function magnify(){
	contCtx.clearRect(-100, -100, contCan.width, contCan.height);
	contCtx.scale(1.5,1.5);
	contCtx.fillText(TrophyName,-13,-10);

}


//创建提示信息
function createHit(){
    $("#contCan").show();
    contCan=document.getElementById("contCan");
	contCtx=contCan.getContext("2d");
	contCan.width=width;
	contCan.height=height;
	contCtx.font="6px 黑体";
	contCtx.fillStyle="#FFFFFF";
	contCtx.translate(170,180);
	contCtx.fillText(TrophyName,10,10);
}

function result(resultVo){
    $("#trophy").html(resultVo.torphyName);
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
    $("#remainCount").html("您还有"+num+"次抽奖机会！");
    if(resultVo.remainCount-1<=0){
        $("#continueDraw").css("display","none");
    }
    $('#winner_toggle').stop().animate({'bottom':'0px'},500);
}

function reloadGoldenEggs(){
    window.location.href = webRoot + "/wap/module/member/vGoldenEggs.ac?time="+new Date().getTime;
}