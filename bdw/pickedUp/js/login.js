$(function () {
    $(".login_btn").click(function () {
        var userName = $("#loginId").val();
        var password = $("#loginPsw").val();
        if ($.trim(userName) == '') {
            $("#error").css("display", "block");
            $("#error").parent().children("input").css("border", "1px solid #ff0000");
            return;
        }
        if ($.trim(password) == '') {
            $("#error").css("display", "block");
            $("#error").parent().children("input").css("border", "1px solid #ff0000");
            return;
        }
        $.ajax({
            type: "GET",
            url: webPath.webRoot + "/pickedup/login.json",
            data: {loginId: userName, password: $.md5(password)},
            dataType: "json",
            success: function (data) {

                if (data.result == true) {
                    location.href = webPath.webRoot + "/template/bdw/pickedUp/notReceiving.jsp";
                } else {
                    $("#error").css("display", "block");
                    $("#error").parent().children("input").css("border", "1px solid #ff0000");
                }
            }
        });
    });
    $("#loginId").click(function () {
        $("#error").css("display", "none");
        $("#error").parent().children("input").css("border", "1px solid #DEDEDE");
        $("#error").parent().children("input").val("");
        $("#loginId").val("");
    })
})
