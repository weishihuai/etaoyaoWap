/**
 * Created by lhw on 2016/12/26.
 */

$(function(){
    var page = 1;
    $('.more').click(function(){
        page++;
        var url = webPath.webRoot+"/wap/citySend/common/comment.ac?" +
            "orgId=" + webPath.orgId +
            "&stat=" + webPath.status +
            "&page=" + page;
        $.ajax({
            url: url,
            success: function (data) {
                //如果不以"</script>"结尾说明有数据，把数据拼接
                if(data.indexOf("li")>0){
                    $("#commentList").append(data);
                } else{
                    $(".more").css("display","none");
                }
            }
        });
    });

    $(".tab-nav li").live('click',function () {
        $(".tab-nav li").removeClass("active");
        $(this).addClass("active");
        var rel = $(this).attr("rel");
        var orgid = $(this).attr("orgid");
        $("#ajaxComment").load(webPath.webRoot+"/template/bdw/wap/citySend/ajaxload/ajaxComment.jsp",{orgId:orgid,page:1,stat:rel},function(){});
    });
});
