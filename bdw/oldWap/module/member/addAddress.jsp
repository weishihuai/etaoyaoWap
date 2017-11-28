<%--
  Created by IntelliJ IDEA.
  User: ljt
  Date: 14-3-19
  Time: 上午11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>

<c:set value="${pageContext.request.contextPath}" var="webRoot" />
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>

<c:if test="${param.getTorphyRecodeId!=null}">
    <c:set value="${weixinSdk:getVgetTorphyRecodeById(param.getTorphyRecodeId)}" var="VgetTorphyRecode"></c:set>
</c:if>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>奖品收货地址</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/wap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
    <script type="text/javascript" language="javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/module/member/statics/js/jquery.ld.js"></script>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <style type="text/css">
        .col-xs-3{width:25%;}
        .col-xs-9{width:75%;}
    </style>
</head>
<script type="text/javascript">
    <%--初始化参数，供myAddressBook.js调用 start--%>
    var dataValue={
        webRoot:"${webRoot}" //当前路径
    };
    var receiveAddrId = ${empty VgetTorphyRecode.zoneId}?false:"${VgetTorphyRecode.zoneId}";
    <%--初始化参数，供myAddressBook.js调用 end--%>

    $(function() {
        //集体调用      当鼠标点击的时候去除默认值，没有输入时 移开鼠标 显示默认值
        //      $(".form-control").each(function(){
        //         $(this).setDefauleValue();
        //     });
        /* //单个调用
         $("#key").setDefauleValue();*/
    })

    //设置input,textarea默认值
    $.fn.setDefauleValue = function() {
        var defauleValue = $(this).val();
        $(this).val(defauleValue).css("color","#999");

        return this.each(function() {
            $(this).focus(function() {
                if ($(this).val() == defauleValue) {
                    $(this).val("").css("color","#000");//输入值的颜色
                }
            }).blur(function() {
                        if ($(this).val() == "") {
                            $(this).val(defauleValue).css("color","#999");//默认值的颜色
                        }
                    });
        });
    }


    var addrSelect;//加载地区
    $(document).ready(function(){

                addrSelect = loadAddr();


                if(${VgetTorphyRecode.zoneId != null}){
                    setTimeout(function(){
                        setAddrNm('${VgetTorphyRecode.zoneId}');
                    },1)
                }
            }
    );

    function loadAddr() {
        return  $(".addressSelect").ld({ajaxOptions : {"url" : dataValue.webRoot+"/member/addressBook.json"},
            defaultParentId:9,
            style:{"width": "100%"}
        });
    }
    //        设置地区名称 start
    function setAddrNm(zoneId) {
        $.ajax({
            type:"post" ,url:dataValue.webRoot+"/member/zoneNm.json",
            data:{zoneId:zoneId},
            dataType:"json",
            success:function(data) {
                var defaultValue = [data.provinceNm,data.cityNm,data.zoneNm];
                addrSelect.ld("api").selected(defaultValue);
                return false;
            }
        })
    }
    //        设置地区名称 end

    var webPath = {webRoot:"${webRoot}"};
    function saveAddress(){
        var getTorphyRecodeId= $("#getTorphyRecodeId").val();   //领奖记录Id
        var winnerRecodeId=$("#winnerRecodeId").val();      //中奖记录Id
        var activityId=   $("#activityId").val();   //活动Id
        var userId=   $("#userId").val();       //用户Id
        var receiverName= $("#receiverName").val();   //收货人姓名
        var receiverMobile=  $("#receiverMobile").val();  //收货人手机
        var zoneId= $("#zone").val();        //区域Id
        var receiverAddress=  $("#receiverAddress").val();  //收货地址
        var state= 1;     //状态    提交成功以后默认为 1

        if(getTorphyRecodeId.trim("")==''){
            alert("您的操作有误");
            return false;
        }
        if(winnerRecodeId.trim("")==null||winnerRecodeId.trim("")==''){
            alert("中奖记录Id不能为空");
            return false;
        }
        if(userId.trim("")==null||userId.trim("")==''){
            alert("用户Id不能为空");
            return false;
        }
        if(receiverName.trim("")==null||receiverName.trim("")==""||receiverName.trim.length>10){

            popover("receiverName","bottom","","姓名输入有误");
            return false;
        }
        if(receiverMobile.trim("")==''||isNaN(receiverMobile)||receiverMobile.trim("").length>14||!(/^1[3|4|5|8][0-9]\d{8,8}$/.test(receiverMobile.trim("")))){
            popover("receiverMobile","bottom","","号码输入不正确");
            return false;
        }

        if(zoneId.trim("")=="请选择"){
            popover("zone","bottom","","请选择地区");
            return false;
        }

        if(receiverAddress.trim("")==null || receiverAddress.trim("")==''||receiverAddress.trim("").length>64){
            popover("receiverAddress","bottom","","地址为空或过长");
            return false;
        }

        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            url:dataValue.webRoot+"/frontend/vmall/vgettorphyrecode/updateAddress.json",
            data:{getTorphyRecodeId:getTorphyRecodeId,winnerRecodeId:winnerRecodeId,activityId:activityId,userId:userId,receiverName:receiverName,receiverMobile:receiverMobile,receiverAddress:receiverAddress,zoneId:zoneId,state:state},
            dataType:"json",
            type:"GET" ,
            success:function(data) {
                window.location = "${webRoot}/wap/module/member/myTrophy.ac";
            } ,
            error:function(XMLHttpRequest, textStatus) {
                alert("服务器异常，请稍后重试。")
            }
        });
    }


    //获取焦点时 清除样式
    function getFocus(id,removeId){
        document.getElementById(removeId).style.display="none";
    }
    function goBack(){
        window.location = "${webRoot}/wap/module/member/myTrophy.ac";
    }
</script>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=奖品收货地址"/>
<%--页头结束--%>

<div class="container wdjp_box" id="pageDiv">

    <div class="row d_rows">
        <div>
            <input type="hidden" id="getTorphyRecodeId" value="${VgetTorphyRecode.getTorphyRecodeId}">
            <input type="hidden" id="winnerRecodeId" value="${VgetTorphyRecode.winnerRecodeId}">
            <input type="hidden" id="activityId" value="${VgetTorphyRecode.activityId}">
            <input type="hidden" id="userId" value="${VgetTorphyRecode.userId}">
        </div>
        <div class="col-xs-3 text-left">收货人姓名</div>
        <div class="col-xs-9"><input type="text" id="receiverName" placeholder="请输入收货人姓名" <%--onfocus="getFocus('receiverName','name_msg')"--%> class="form-control put"   value="${VgetTorphyRecode.receiverName}" />
        </div>
    </div>
    <div class="row d_rows">
        <div class="col-xs-3 text-left">手机号码</div>
        <div class="col-xs-9"><input type="text" id="receiverMobile" placeholder="请输入11位手机号码" maxlength="11"  <%--onfocus="getFocus('receiverMobile','phone_msg')"--%>  class="form-control put"  value="${VgetTorphyRecode.receiverMobile}">
        </div>
    </div>
    <div class="row d_rows">
        <div class="col-xs-3 text-left">所在省</div>
        <div class="col-xs-9">
            <select class="form-control addressSelect put" id="province" name="" >
                <option>请选择</option>
            </select>
        </div>
    </div>
    <div class="row d_rows">
        <div class="col-xs-3 text-left">城市</div>
        <div class="col-xs-9">
            <select class="form-control addressSelect" id="city" name="">
                <option>请选择</option>
            </select>
        </div>
    </div>
    <div class="row d_rows">
        <div class="col-xs-3 text-left">区/县</div>
        <div class="col-xs-9">
            <select class="addressSelect form-control" id="zone" <%--onfocus="getFocus('zone','zoneId_msg')"--%> name="zoneId"  value="${VgetTorphyRecode.zoneId}">
                <option>请选择</option>
            </select>
            <div id="zoneId_msg" ></div>
        </div>
    </div>
    <div class="row d_rows">
        <div class="col-xs-3 text-left">详细地址</div>
        <div class="col-xs-9"><input type="text" class="form-control put" id="receiverAddress" placeholder="请输入详细地址" <%--onfocus="getFocus('receiverAddress','address_msg')"--%> value="${VgetTorphyRecode.receiverAddress}">
        </div>

    </div>

</div>
<div class="row" style="margin-top:10px;">
    <div class="col-xs-1"></div>
    <div class="col-xs-4"><button class="btn btn-danger btn-block" type="button" onclick="saveAddress()">确定</button></div>
    <div class="col-xs-2"></div>
    <div class="col-xs-4"><button class="btn btn-default btn-block btn2" type="button" onclick="goBack()">取消</button></div>
    <div class="col-xs-1"></div>
</div>

</div>

</body>
</html>