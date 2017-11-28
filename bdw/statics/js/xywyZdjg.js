/**
 * Created by Hgf on 2015/12/14.
 */
$(document).ready(function(){
    /* 已选症状 取消选择 点击 */
   $(".item .item-b-t .dd-cont a").click(function(){
        var subPartIdSymptomIds  = $("#subPartIdSymptomIds").val();
        var subPartIdSymptomId  = $(this).attr("subPartIdSymptomId");
       subPartIdSymptomIds = subPartIdSymptomIds.replace(subPartIdSymptomId,'');
       $("#subPartIdSymptomIds").val(subPartIdSymptomIds);
       $("#sendFrom").submit();
   });

    /* 未选症状 点击 */
    $(".item .item-b-b .dd-cont a").click(function(){
        if($(this).hasClass("active")){
            $(this).removeClass("active");
        }else{
            $(this).addClass("active");
        }
        showBtn(this);
    });

    /*未选症状 取消选择*/
    $(".item .item-b-b a.btn").click(function(){
        var subPartIdSymptomIds  = $("#subPartIdSymptomIds").val();
        $(".item .item-b-b .dd-cont a").each(function(){
            if($(this).hasClass("active")){
                var subPartIdSymptomId  = $(this).attr("subPartIdSymptomId");
                subPartIdSymptomIds = subPartIdSymptomIds + subPartIdSymptomId;
            }
        });
        $("#subPartIdSymptomIds").val(subPartIdSymptomIds);
        $("#sendFrom").submit();
        /*window.location.href = webPath.webRoot + "/xywyZdjg.ac?askType="+webPath.askType+
                                "&symptomSubPartIds=" + subPartIdSymptomIds +
                                "&diseaseCommonCategoryId=" + webPath.diseaseCommonCategoryId +
                                "&subDepartmentId=" + webPath.subDepartmentId ;*/
    });

});

//未选症状 确定按钮的显示隐藏
function showBtn(obj){
    var isShow = false;
    $(obj).parent(".dd-cont").children().each(function(){
        if($(this).hasClass("active")){
            isShow = true;
        }
    });
    if(isShow){
        $(obj).parent(".dd-cont").next(".btn").show();
    }else{
        $(obj).parent(".dd-cont").next(".btn").hide();
    }
}