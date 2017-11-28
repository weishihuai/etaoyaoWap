var isSearchInput="N";
function removeClassName(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("cur");
    }
}
function removeClassName2(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("cur2");
    }
}
function removeClassNameDiv(dome){
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("cur");
        $(dome[i]).find("div").hide();
    }
}


function findPartsOfBodyList(mainPartCode,nowThis){

    $("#item1").hide();
    $("#item2").show();
    removeClassNameDiv($("#item1 li"));
    $(nowThis).addClass("cur");
    removeDome($("#item2_1 li"));
    removeDome($("#item2_2 div"));
    removeDome($("#item2_3 a"));
    onClickMainPartCode(mainPartCode,nowThis);

    var askType = webPath.askType;
    var subDepartmentId = getSubDepartmentId();
    var diseaseCommonCategoryId = getDiseaseCommonCategoryId();
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/diagnosis/findPartsOfBody.json",
        data:{mainPartCode:mainPartCode,askType:askType,subDepartmentId:subDepartmentId,diseaseCommonCategoryId:diseaseCommonCategoryId},
        dataType: "json",
        success:function(data) {
            if(handleResult(data)){
                removeDome($("#item2_1 a"));
                for (var i=0; i < data.result.length;i++){
                    var subPartId =data.result[i].subPartId;
                    var subPartNm = data.result[i].subPartNm;
                    $("#item2_1").append('     <li subPartId='+subPartId+' subPartNm='+subPartNm+' onclick="findSymptomList('+subPartId+',this)"><span></span><a href="javascript:;" >'+subPartNm+'</a></li>');
                }
                //默认找出第一个的病症
                if(data.result.length > 0){
                    $("#item2_1").parent().next().show();
                    var obj = $("#item2_1 li[subPartId ='"+data.result[0].subPartId+"']");
                    $(obj).addClass("cur");
                    findSymptomList(data.result[0].subPartId,obj);
                }else{
                    $("#item2_1").parent().next().hide();//搜索框
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

function findSymptomList(subPartId,nowThis){

    removeClassNameDiv($("#item2_1 li"));
    $(nowThis).addClass("cur");
    var subPartNm = $(nowThis).attr("subPartNm");

    var askType = webPath.askType;
    var subDepartmentId = getSubDepartmentId();
    var diseaseCommonCategoryId = getDiseaseCommonCategoryId();
    if(isSearchInput=="N"){
        $(".searchInput").val("");
    }
    var searchName = $(".searchInput").val();
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/diagnosis/findSymptom.json",
        data:{subPartId:subPartId,askType:askType,subDepartmentId:subDepartmentId,diseaseCommonCategoryId:diseaseCommonCategoryId,searchName:searchName},
        dataType: "json",
        success:function(data) {
            if(handleResult(data)){
                removeDome($("#item2_2 div"));
                removeDome($("#item2_3 a"));
                var pinyinList = new Array();
                for (var i=0; i < data.result.length;i++){
                    var symptomId =data.result[i].symptomId;                    //症状ID
                    var symptomNm = data.result[i].symptomNm;                   //症状名称
                    var firstPinyin = data.result[i].firstPinyin;                   //症状名称

                    var htmlItem = ""
                    if(selectSymptom(symptomId)){
                        htmlItem = '<li class="long cur" subPartId='+subPartId+' symptomId='+symptomId+' symptomNm='+symptomNm+' onclick="addSymptom('+subPartId+','+symptomId+',this)"><a href="javascript:;" class="elli">'+symptomNm+'</a></li>';
                    }else{
                        htmlItem = '<li class="long" subPartId='+subPartId+' symptomId='+symptomId+' symptomNm='+symptomNm+' onclick="addSymptom('+subPartId+','+symptomId+',this)"><a href="javascript:;" class="elli">'+symptomNm+'</a></li>';
                    }
                    if( isAddPinyin($("#item2_2 div"),firstPinyin) ) {
                        pinyinList.push(firstPinyin);
                        $("#item2_2").append('' +
                            '<div class="sc-item" id='+firstPinyin+'> ' +
                            '<h5><span class="showSpan" id="show_'+firstPinyin+'" >'+firstPinyin+'</span></h5>' +
                            '<ul class="clearfix" id="ulItem_'+firstPinyin+'">' +
                            '' +htmlItem+'' +
                            '</ul></div>');
                    }else{
                        if(selectSymptom(symptomId)){
                            $("#ulItem_"+firstPinyin).append(htmlItem);
                        }else{
                            $("#ulItem_"+firstPinyin).append(htmlItem);
                        }
                    }
                }
                $("#item2_2").append('' +
                    '<div class="sc-item" style="height: 300px;"> ' +
                    '<h5><span class="showSpan" ></span></h5>' +
                    '<ul class="clearfix" >' +
                    '</ul></div>');

                for (var i=0; i < pinyinList.length;i++){
                    $("#item2_3").append('<a class="goDiv" onclick="goDiv(this)" goId="'+pinyinList[i]+'" href="javascript:;" >'+pinyinList[i]+'</a>');
                }
            }
            isSearchInput = "N";
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showAlert(result.errorObject.errorText);
            }
        }
    });
}

function goDiv(nowThis) {
   var goId = $(nowThis).attr("goId");
    removeClassName2($(".goDiv"));
    removeClassName2($(".sc-item"));

    var dome = $(".showSpan");
    for (var i = 0; i< dome.length;i++) {
        $(dome[i]).removeClass("cur3");
    }

    $(nowThis).addClass("cur2");
    $("#"+goId).addClass("cur2");
    $("#show_"+goId).addClass("cur3");


    var hr = $(nowThis).attr("goId");
    location.href="#"+hr;
    window.scrollTo(0,0);

   var html = $("#item2_2").html();     //刷新div内容
    $("#item2_2").html(html);           //重新赋值，解决360急速模式内容无法及时刷新显示问题


}

function selectSymptom(symptomId){
    var isSelect = false;
        var div= $(".subId");
        for(var i=0; i<div.length; i++){
            if( $(div[i]).attr("symptomId") == symptomId){
                isSelect = true;
            }
        }
    return isSelect;
}
function addSymptom(subPartId,symptomId,nowThis){

    if( $(nowThis).hasClass("cur") ) {
        $(nowThis).removeClass("cur")
        var dome = $(".subId");
        for(var i=0; i<dome.length; i++){
            if( $(dome[i]).attr("symptomId") == symptomId){
                deleteSymptom(symptomId,$(dome[i]));
                return false;
            }
        }
    }

    $(nowThis).addClass("cur");
    var mainPartCodeName = getMainPartCodeName();
    var strs= new Array(); //定义一数组
    strs = mainPartCodeName.split(",");
    var mainPartCode = strs[0];
    var mainPartNm = strs[1];

    $(".md-item")
    $("#item3").show();
    var symptomNm = $(nowThis).attr("symptomNm");
    if ( isAddItem4($(".subId"),symptomId) ) {
        if( isAddDiv($(".md-item"),mainPartCode) ){
            $("#item3_1").append('<div class="md-item" mainPartCode='+mainPartCode+'>' +
                                  '  <span>'+mainPartNm+'</span>' +
                                  '  <ul id="item4_'+mainPartCode+'">' +
                                  '     <li class="subId" subPartId='+subPartId+' symptomId='+symptomId+' symptomNm='+symptomNm+' onclick="deleteSymptom('+symptomId+',this)">|<a href="javascript:;">'+symptomNm+'</a></li>' +
                                  '  </ul>' +
                                  ' <a href="javascript:;" class="del" onclick="delectDiv(this)">删除</a>' +
                                  ' </div> ');
        }else{
            $("#item4_"+mainPartCode).append('<li class="subId" subPartId='+subPartId+' symptomId='+symptomId+' symptomNm='+symptomNm+' onclick="deleteSymptom('+symptomId+',this)">|<a href="javascript:;">'+symptomNm+'</a></li>');
        }
    }
}

function isAddItem4(dome,nowSymptomId){
    var value = true;
    for (var i=0; i < dome.length;i++){
       var symptomId = $(dome[i]).attr("symptomId");
        if($.trim(nowSymptomId) == $.trim(symptomId) ) {
            value= false;
        }
    }
    return value;
}

function isAddPinyin(dome,pinyin){
    var value = true;
    for (var i=0; i < dome.length;i++){
        var noewPinyin = $(dome[i]).attr("id");
        if($.trim(noewPinyin) == $.trim(pinyin) ) {
            value= false;
        }
    }
    return value;
}

function isAddDiv(dome,nowMainPartCode){
    var value = true;
    for (var i=0; i < dome.length;i++){
        var mainPartCode = $(dome[i]).attr("mainPartCode");
        if($.trim(mainPartCode) == $.trim(nowMainPartCode) ) {
            value= false;
        }
    }
    return value;
}

function deleteSymptom(symptomId,nowThis){

    $(nowThis).remove();
    showSelectMeun();

    var deme = $("#item2_1 li");
    for (var i=0; i < deme.length;i++){
        if( $(deme[i]).hasClass("cur") ) {
            var subPartId = $(deme[i]).attr("subPartId");
            findSymptomList(subPartId, $(deme[i]) );
        }
    }
}

function delectDiv(nowThis){
    $(nowThis).parent(".md-item").remove();
    showSelectMeun();
    var deme = $("#item2_1 li");
    for (var i=0; i < deme.length;i++){
        if( $(deme[i]).hasClass("cur") ) {
            var subPartId = $(deme[i]).attr("subPartId");
            findSymptomList(subPartId, $(deme[i]) );
        }
    }
}

function getSubDepartmentId(){
    var subDepartmentId = "";
   var dome = $(".item-c a");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("cur") ){
            subDepartmentId = $(dome[i]).attr("subDepartmentId");
        }
    }
    return subDepartmentId;
}



function getMainPartCodeName(){
    var mainPartCodeName = "";
    var dome = $("#item1 li");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("cur") ){
            var mainPartCode = $(dome[i]).attr("mainPartCode");
            var mainPartNm = $(dome[i]).attr("mainPartNm");
            mainPartCodeName = mainPartCode+","+mainPartNm
        }
    }
    return mainPartCodeName;
}

function getSubPartId() {
    var subPartId = "";
    var dome =$("#item2_1 li");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("cur") ){
            subPartId = $(dome[i]).attr("subPartId");
        }
    }
    return subPartId;
}

function getSubPart() {
    var dome =$("#item2_1 li");
    for(var i=0; i < dome.length;i++) {
        if( $(dome[i]).hasClass("cur") ){
            return $(dome[i]);
        }
    }
    return "";
}

/**暂无使用**/
function getDiseaseCommonCategoryId(){
    var diseaseCommonCategoryId = "";
    return diseaseCommonCategoryId;
}

function getSubPartIdSymptomId(){
    var subPartIdSymptomId = "";
    var dome = $(".subId");
    for(var i=0; i < dome.length;i++) {
        if(symptomIds==""){
            var symptomIds = $(dome[i]).attr("symptomId");
            var subPartId = $(dome[i]).attr("subPartId");
            subPartIdSymptomId = subPartId+"_"+symptomIds;
        }else{
            var symptomIds = $(dome[i]).attr("symptomId");
            var subPartId = $(dome[i]).attr("subPartId");
            subPartIdSymptomId += ","+ subPartId+"_"+symptomIds;
        }
    }
    return subPartIdSymptomId;
}

function getSex(){
    var sex = "";
    if( $("#man").hasClass("cur") ) {
        sex = $("#man").attr("sexName");
    }
    if( $("#woman").hasClass("cur") ) {
        sex = $("#woman").attr("sexName");
    }
    return sex;
}

/**返回主部位 同时清空样式**/
function goMainPart(){
    $("#item1").show();
    $("#item2").hide();
    var dome = $(".mainPartCode");
    var partDome = $(".selectCode");

     removeBodyClass();
    $("#positive").addClass("cur");
    $("#man").addClass("cur");

    $("#back").removeClass("cur");
    $("#woman").removeClass("cur");
    $("#showTitle").html("");
    showBodyDiv();
}


function showSelectMeun(){
    var div= $(".md-item");
    for(var i=0; i<div.length; i++){
        if($(div[i]).children('ul').children('li').length == 0){
            $(div[i]).remove();
        }
    }
    if( $(".subId").length == 0 ){
        $("#item3").hide();
    }
}

function selectHean(nowThis){
    if( ! $(nowThis).hasClass("cur") ){
        $("#positive").removeClass("cur");
        $("#back").removeClass("cur");

        $(nowThis).addClass("cur")
    }
    showBodyDiv();
}
function selectSex(nowThis){
    if( ! $(nowThis).hasClass("cur") ){
        $("#man").removeClass("cur");
        $("#woman").removeClass("cur");

        $(nowThis).addClass("cur")
    }
    showBodyDiv();
}


/*显示人体 正反面*/
function showBodyDiv(){
    var mian = "";
    var sex = "";
    if( $("#positive").hasClass("cur") ){
        mian = $("#positive").attr("mian");
    }else if( $("#back").hasClass("cur") ) {
        mian = $("#back").attr("mian");
    }

    if( $("#man").hasClass("cur") ){
        sex = $("#man").attr("sex");
    }else if( $("#woman").hasClass("cur") ) {
        sex = $("#woman").attr("sex");
    }
    $("#positive_man").hide();
    $("#back_man").hide();
    $("#positive_woman").hide();
    $("#back_woman").hide();

    $("#"+mian+"_"+sex).show();

}

function showEl(nowThis,mainPartCode){
    var dome = $(".mainPartCode");
    var partDome = $(".selectCode");

    for(var i=0; i < dome.length;i++) {
        var thisMainPartCode = $(dome[i]).attr("mainPartCode");
        if(thisMainPartCode == mainPartCode){
            $(dome[i]).addClass("select");
        }
    }
    for(var i=0; i < partDome.length;i++) {
        var thisMainPartCode = $(partDome[i]).attr("mainPartCode");
        if(thisMainPartCode == mainPartCode){
            $(partDome[i]).addClass("cur2");
        }
    }
}
function hideEl(nowThis,mainPartCode){
    var dome = $(".mainPartCode");
    var partDome = $(".selectCode");

    for(var i=0; i < dome.length;i++) {
        var thisMainPartCode = $(dome[i]).attr("mainPartCode");
        if(thisMainPartCode == mainPartCode){
            if(! $(dome[i]).hasClass("cur") ){
                $(dome[i]).removeClass("select");
            }
        }
    }
    for(var i=0; i < partDome.length;i++) {
        var thisMainPartCode = $(partDome[i]).attr("mainPartCode");
        if(thisMainPartCode == mainPartCode){
            if(! $(partDome[i]).hasClass("select") ){
                $(partDome[i]).removeClass("cur2");

            }
        }
    }
}



/***清空人体部位样式**/
function removeBodyClass(){
    var dome = $(".mainPartCode");
    var partDome = $(".selectCode");

    for(var i=0; i < dome.length;i++) {
        $(dome[i]).removeClass("cur");
        $(dome[i]).removeClass("select");
    }
    for(var i=0; i < partDome.length;i++) {
        $(partDome[i]).removeClass("cur");
        $(partDome[i]).removeClass("cur2");
        $(partDome[i]).removeClass("select");
    }
}

/**点击人体部位 **/
function selectBody(nowThis,mainPartCode){
    removeClassName($(".selectCode"));
    var dome = $(".mainPartCode");
    for(var i=0; i < dome.length;i++) {
        var thisMainPartCode = $(dome[i]).attr("mainPartCode");
        if(thisMainPartCode == mainPartCode){
            onClickMainPartCode(mainPartCode,$(dome[i]));
            findPartsOfBodyList(thisMainPartCode,this);
        }
    }
}
function onClickMainPartCode(mainPartCode,nowThis){
    removeBodyClass();
    var dome = $(".mainPartCode");
    var partDome = $(".selectCode");

    for(var i=0; i < dome.length;i++) {
        var thisMainPartCode = $(dome[i]).attr("mainPartCode");
        if(thisMainPartCode == mainPartCode){
            $(dome[i]).addClass("cur");
        }
    }
    for(var i=0; i < partDome.length;i++) {
        var thisMainPartCode = $(partDome[i]).attr("mainPartCode");
        if(thisMainPartCode == mainPartCode){
            $(partDome[i]).addClass("cur");
            $(partDome[i]).addClass("select");
        }
    }
    $("#showTitle").html($(nowThis).attr("mainPartNm"));
}

/***提交form**/
function sendFrom(){
    var subPartIdSymptomIds = getSubPartIdSymptomId();
    var sex = getSex();
    $("#subPartIdSymptomIds").val(subPartIdSymptomIds);
    $("#sex").val(sex);
    $("#sendFrom").submit();
}


//搜索输入框监听
$(".searchInput").live("keyup",function(event){
    isSearchInput = "Y";
    var subPartId = getSubPartId();
    var nowThis = getSubPart();
    findSymptomList(subPartId,nowThis);
});
