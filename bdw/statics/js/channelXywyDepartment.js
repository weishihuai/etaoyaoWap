

function removeDome(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).remove();
    }
}


function removeClassName(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("cur");
    }
}

function removeClassNameDiv(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("active");
    }
}

function findSubDepartmentNm(mainDepartmentCode,nowThis){
    removeClassNameDiv($("#item1 a"));
    $(nowThis).addClass("active");
    $("#item2").show();
    $("#item2_1").html( "（"+$(nowThis).attr("mainDepartmentNm")+"）" );
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/diagnosis/findSubDepartment.json",
        data:{mainDepartmentCode:mainDepartmentCode},
        dataType: "json",
        success:function(data) {
            if(handleResult(data)){
                removeDome($("#item2_2 a"));
                for (var i=0; i < data.result.length;i++){
                    var subDepartmentId ="'" +data.result[i].subDepartmentId+ "'";
                    var subDepartmentNm = data.result[i].subDepartmentNm;
                    $("#item2_2").append(' <a href="javascript:;" subDepartmentNm='+subDepartmentNm+' subDepartmentId='+subDepartmentId+' onclick="findDiseaseLibList(this)" >'+subDepartmentNm+'</a>');
                }
                $("#item2").focus();
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

function findDiseaseLibList(nowThis){
    removeClassNameDiv($("#item2_2 a"));
    $(nowThis).addClass("active");
   var mainDepartmentCode =  getMainDepartmentCode();
   var subDepartmentId =  getSubDepartmentId();
    $("#subDepartmentId").val(subDepartmentId);
    $("#mainDepartmentCode").val(mainDepartmentCode);
    $("#sendFrom").submit();
}


function getMainDepartmentCode(){
    var mainDepartmentCode = "";
    var dome = $("#item1 a");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("active") ){
            mainDepartmentCode = $(dome[i]).attr("mainDepartmentCode");
        }
    }
    return mainDepartmentCode;
}


function getSubDepartmentId(){
    var subDepartmentId = "";
   var dome = $("#item2_2 a");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("active") ){
            subDepartmentId = $(dome[i]).attr("subDepartmentId");
        }
    }
    return subDepartmentId;
}

function getSubPartId() {
    var subPartId = "";
    var dome =$("#item2_1 a");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("cur") ){
            subPartId = $(dome[i]).attr("subPartId");
        }
    }
    return subPartId;
}
