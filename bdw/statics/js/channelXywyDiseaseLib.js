

function removeDome(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).remove();
    }
}

function removeClassName(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("active");
    }
}
function removeClassHoverName(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("hover");
    }
}

function findSubDepartmentNm(mainDepartmentCode,nowThis){
    removeClassHoverName($(".mainDepartment"));
    $(nowThis).addClass("hover");
    $("#item2").show();
    removeDome($("#item2 a"));
    $("#mainDepartmentCode").val(mainDepartmentCode);
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/diagnosis/findSubDepartment.json",
        data:{mainDepartmentCode:mainDepartmentCode},
        dataType: "json",
        success:function(data) {
            if(handleResult(data)){
                for (var i=0; i < data.result.length;i++){
                    var subDepartmentId ="'" +data.result[i].subDepartmentId+ "'";
                    var subDepartmentNm = data.result[i].subDepartmentNm;
                    var item2 = "'item2'";
                    $("#item2").append(' <a  href="javascript:;" class="subDepartmentId" subDepartmentNm='+subDepartmentNm+' subDepartmentId='+subDepartmentId+' onclick="sendFun('+item2+',this)" >'+subDepartmentNm+'</a>');
                }
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

function sendFun(em,nowThis){
    removeClassName($("#"+em+" a"));
    $(nowThis).addClass("active");

    var subDepartmentId =  getSubDepartmentId();
    var subPartId = getSubPartId();
    var susceptiblesCode = getSusceptiblesCode();
    var sexCode = getSexCode();

    $("#subDepartmentId").val(subDepartmentId);
    $("#subPartId").val(subPartId);
    $("#susceptiblesCode").val(susceptiblesCode);
    $("#sexCode").val(sexCode);
    $("#sendFrom").submit();
}


function findPartsOfBodyList(mainPartCode,nowThis){
    removeClassHoverName($(".mainPartCode"));
    $(nowThis).addClass("hover");
    $("#item4").show();
    removeDome($("#item4 a"));
    $("#mainPartCode").val(mainPartCode);

    var askType = "";
    var subDepartmentId = getSubDepartmentId();
    var diseaseCommonCategoryId = "";
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/diagnosis/findPartsOfBody.json",
        data:{mainPartCode:mainPartCode,askType:askType,subDepartmentId:subDepartmentId,diseaseCommonCategoryId:diseaseCommonCategoryId},
        dataType: "json",
        success:function(data) {
            if(handleResult(data)){
                for (var i=0; i < data.result.length;i++){
                    var subPartId =data.result[i].subPartId;
                    var subPartNm = data.result[i].subPartNm;
                    var item4 = "'item4'";
                    $("#item4").append('<a class="subPartId" subPartId='+subPartId+' subPartNm='+subPartNm+' href="javascript:;" onclick="sendFun('+item4+',this)">'+subPartNm+'</a>');
                }
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


function getSubDepartmentId(){
    var subDepartmentId = "";
    var dome = $("#item2 a");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("active") ){
            subDepartmentId = $(dome[i]).attr("subDepartmentId");
        }
    }
    return subDepartmentId;
}

function getSubPartId(){
    var subPartId = "";
    var dome = $("#item4 a");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("active") ){
            subPartId = $(dome[i]).attr("subPartId");
        }
    }
    return subPartId;
}


function getSusceptiblesCode(){
    var susceptiblesCode = "";
    var dome = $("#item6 a");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("active") ){
            susceptiblesCode = $(dome[i]).attr("susceptiblesCode");
        }
    }
    return susceptiblesCode;
}

function getSexCode(){
    var sexCode = "";
    var dome = $("#item8 a");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("active") ){
            sexCode = $(dome[i]).attr("sexCode");
        }
    }
    return sexCode;
}
