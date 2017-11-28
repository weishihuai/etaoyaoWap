var isRequest = false;
var resultVo = null;
window.onload = function(){
    $("#wScratchPad3").wScratchPad({

        scratchMove: function(e, percent)
        {
            if(percent >50){
                this.clear();
                result(resultVo);
            }
            /*document.getElementById("trophy").innerHTML = "奖品加载中...";*/

            if(!isRequest){
                isRequest = true;
                $.ajax({
                    type:"POST",
                    url:webRoot+"/frontDraw/calculateDrawResult.json",
                    data:{activityId:activityId},
                    dataType: "json",
                    success:function(data) {
                        resultVo = data.result;
                        $("#trophy").html(resultVo.torphyName);
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
        }
    });
};

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
        $("#winnerWarnStr").html("谢谢参与");
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
