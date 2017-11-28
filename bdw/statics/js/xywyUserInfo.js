
(function($){
    $(document).ready(
        function(){
            closeWindow();
            var userName = webPath.userName;
            var sex = webPath.sex;
            var age = webPath.age;
            var mobile = webPath.mobile;
            $("#showUserInfo").hide();
            $("#sex").val(sex);
            if ( $.trim(userName) == "" ||
                 $.trim(sex) == ""      ||
                 $.trim(age) == ""      ||
                 $.trim(mobile) == "" ) {
                showWindow();
            }else{
                $("#showUserInfo").show();
            }

            //按订单类型筛选订单
            $(".oType").hover(
                function () {  $(this).addClass("pull");},
                function () {  $(this).removeClass("pull"); });

            $(".oTypeItem").click(function () {
                var selectedItem = $(this).html();
                var orderType = $(this).attr("orderType");

                $(".oTypeSelected").attr("orderType", orderType);
                $(".oTypeSelected").text(selectedItem);
                $("#sex").val(orderType);
            });
        }
    );
})(jQuery);


//确认诊断档案信息
function sendInfo(){
    var userName = $("#userName").val();
    var sex = $(".oTypeSelected").attr("orderType");
    var age = $("#age").val();
    var mobile = $("#mobile").val();
    if ($.trim(userName) == "" ){
        showAlert("请输入用户名");
        return false;
    }
    if ( $.trim(sex) == ""){
        showAlert("请选择性别");
        return false;
    }
    if ( $.trim(age) == "" ){
        showAlert("请输入年龄");
        return false;
    }
    if ( $.trim(mobile) == "" ){
        showAlert("请输入手机");
        return false;
    }
    if ( parseInt(age) < parseInt(0)   ){
        showAlert("年龄必须大于或等于0");
        return false;
    }
    if ( mobile.length != 11){
        showAlert("手机号码位数为11位！");
        return false;
    }
    saveUserCookie();
}


function saveUserCookie(){
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/member/savaXywyCookie.json",
        data:$("#infoFrom").serialize(),
        dataType: "json",
        success:function(result) {
            if(result.success == "true"){
                showAlert("就诊信息已保留！此次会话都有效使用！",function(){
                    window.location.reload(true);
                });
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showAlert(result.errorObject.errorText);
            }
        }
    });
}

function removeClassName(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("cur");
    }
}

function removeDome(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).remove();
    }
}

function isUserInfo(){
    var temp= $(".info").is(":hidden");//是否隐藏
    if( temp ){
        showAlert("请输入个人档案,输入完毕请安确认!");
        return false;
    }
    return true;
}

function getCurValue(dome){
    var value = "";
    for (var i = 0; i< dome.length;i++) {
        if ( $(dome[i]).hasClass("cur")) {
            value = $(dome[i]).text();
        }
    }
    return value;
}

function getCurValueArray(dome){
    var value = "";
    $(dome).each(function(){
        if ($(this).hasClass("cur")) {
            value += $(this).text() + "|";
        }
    });
    return value;
}




/* 弹出框 2015-05-18 c j m*/
function showWindow(){
    $("#addUserInfo").show();
}


/* 关闭弹出框 2015-05-18 c j m*/
function closeWindow() {
    $("#addUserInfo").hide();
}
