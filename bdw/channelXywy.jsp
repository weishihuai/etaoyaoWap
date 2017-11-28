<%@ page import="com.iloosen.imall.module.shiyao.domain.code.BodyRegionsCodeEnum" %>
<%@ page import="com.iloosen.imall.module.shiyao.domain.code.SexCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<%
    request.setAttribute("male", SexCodeEnum.MAN.toCode());                      //性别：男
    request.setAttribute("female",SexCodeEnum.WOMAN.toCode());                  //性别：女
%>

<%
    request.setAttribute("wholeBody", BodyRegionsCodeEnum.WHOLE_BODY.toCode());              //全身
    request.setAttribute("head",BodyRegionsCodeEnum.HEAD.toCode());                          //头
    request.setAttribute("abdomen",BodyRegionsCodeEnum.ABDOMEN.toCode());                   //腹部
    request.setAttribute("chest",BodyRegionsCodeEnum.CHEST.toCode());                       //胸部
    request.setAttribute("bone",BodyRegionsCodeEnum.BONE.toCode());                         //骨
    request.setAttribute("loin",BodyRegionsCodeEnum.LOIN.toCode());                         //腰部
    request.setAttribute("femaleGenitalia",BodyRegionsCodeEnum.FEMALE_GENITALIA.toCode());//女性生殖
    request.setAttribute("neck",BodyRegionsCodeEnum.NECK.toCode());                         //颈
    request.setAttribute("mind",BodyRegionsCodeEnum.MIND.toCode());                         //心理
    request.setAttribute("pelvicCavity",BodyRegionsCodeEnum.PELVIC_CAVITY.toCode());      //盆腔
    request.setAttribute("lowerLimb",BodyRegionsCodeEnum.LOWER_LIMB.toCode());            //下肢
    request.setAttribute("upperLimb",BodyRegionsCodeEnum.UPPER_LIMB.toCode());            //上肢
    request.setAttribute("hip",BodyRegionsCodeEnum.HIP.toCode());                           //臀部
    request.setAttribute("maleGenitalia",BodyRegionsCodeEnum.MALE_GENITALIA.toCode());    //男性生殖
    request.setAttribute("back",BodyRegionsCodeEnum.BACK.toCode());                         //背部
%>

<c:set value="${bdw:findDiagnosisList(param.askType)}" var="diagnosisList"/>
<!DOCTYPE html>
<html>
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <title>按部位查疾病-${webName}</title>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/parts.css">
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/channelXywy.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/main.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/xywyUserInfo.js"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            askType:"${param.askType}"
        };
    </script>
</head>
<%--页头开始--%>

<body>
<c:import url="/template/bdw/module/common/top.jsp"/>

<form id="sendFrom" method="get" action="${webRoot}/xywyZdjg.ac">
    <input id="askType" name="askType" type="hidden" value="${param.askType}">                       <!-- 类型 科室、疾病、部位 -->
    <input id="diseaseCommonCategoryId" name="diseaseCommonCategoryId" type="hidden" value="">   <!-- 疾病表ID -->
    <input id="subDepartmentId" name="subDepartmentId" type="hidden" value="">                     <!-- 子科室ID -->
    <input id="subPartIdSymptomIds" name="subPartIdSymptomIds" type="hidden" value="">            <!-- 子部位ID -->
    <input id="sex" name="sex" type="hidden" value="">                                                <!-- 性别 -->
</form>

<div class="main-bg" id="mainHref">
    <div class="past">
        <div class="first">
            <a href="${webRoot}/index.html" class="cata">${webName}</a>
            <i class="crumbs-arrow"></i>
        </div>
        <a class="cata" href="${webRoot}/channelXywyIndex.ac">寻医问药</a>
    </div>
    <div class="main">
        <div class="mt"><span>按部位查疾病</span></div>
        <div class="mc">
            <div class="mc-lt">

                <div class="body-pos man-positive" style="display: block" id="positive_man"><!--男正面-->
                    <%--<img src="${webRoot}/template/green/statics/images/man-positive.png">--%>
                    <%--<span class="selectCode mp-all" mainPartCode="${wholeBody}" onclick="selectBody(this,${wholeBody})"   onmouseover="showEl(this,${wholeBody})" onmouseout="hideEl(this,${wholeBody})"></span>                 <!--全身-->--%>
                    <span class="selectCode mp-head cur"    mainPartCode="${head}" onclick="selectBody(this,${head})" onmouseover="showEl(this,${head})" onmouseout="hideEl(this,${head})"></span>                                <!--头-->
                    <span class="selectCode mp-neck cur"  mainPartCode="${neck}" onclick="selectBody(this,${neck})" onmouseover="showEl(this,${neck})" onmouseout="hideEl(this,${neck})"></span>                                <!--颈部-->
                    <span class="selectCode mp-chest cur" mainPartCode="${chest}" onclick="selectBody(this,${chest})" style="z-index: 1" onmouseover="showEl(this,${chest})" onmouseout="hideEl(this,${chest})"></span>       <!--胸部-->
                    <span class="selectCode mp-up-limb cur" mainPartCode="${upperLimb}" onclick="selectBody(this,${upperLimb})" onmouseover="showEl(this,${upperLimb})" onmouseout="hideEl(this,${upperLimb})"></span>              <!--上肢-->
                    <span class="selectCode mp-belly cur" mainPartCode="${abdomen}" onclick="selectBody(this,${abdomen})" onmouseover="showEl(this,${abdomen})" onmouseout="hideEl(this,${abdomen})"></span>                      <!--腹部-->
                    <span class="selectCode mp-gtl cur" mainPartCode="${maleGenitalia}" onclick="selectBody(this,${maleGenitalia})" onmouseover="showEl(this,${maleGenitalia})" onmouseout="hideEl(this,${maleGenitalia})"></span>    <!--生殖器-->
                    <span class="selectCode mp-legs cur" mainPartCode="${lowerLimb}" onclick="selectBody(this,${lowerLimb})" onmouseover="showEl(this,${lowerLimb})" onmouseout="hideEl(this,${lowerLimb})"></span>                <!--腿部-->
                </div>
                <div class="body-pos man-back" style="display: none" id="back_man"><!--男背面-->
                    <%--<img src="${webRoot}/template/green/statics/images/man-back.png">--%>
                    <span class="selectCode mb-all cur" mainPartCode="${wholeBody}"  onclick="selectBody(this,${wholeBody})"   onmouseover="showEl(this,${wholeBody})" onmouseout="hideEl(this,${wholeBody})"></span>              <!--全身-->
                    <span class="selectCode mb-backside cur" mainPartCode="${back}" onclick="selectBody(this,${back})" onmouseover="showEl(this,${back})" onmouseout="hideEl(this,${back})"></span>                            <!--背身-->
                    <span class="selectCode mb-bone cur" mainPartCode="${bone}" onclick="selectBody(this,${bone})" style="z-index: 1" onmouseover="showEl(this,${bone})" onmouseout="hideEl(this,${bone})"></span>            <!--骨-->
                    <span class="selectCode mb-waist cur" mainPartCode="${loin}"  onclick="selectBody(this,${loin})" onmouseover="showEl(this,${loin})" onmouseout="hideEl(this,${loin})"></span>                              <!--腰部-->
                    <span class="selectCode mb-pelvic cur" mainPartCode="${pelvicCavity}"  onclick="selectBody(this,${pelvicCavity})" onmouseover="showEl(this,${pelvicCavity})" onmouseout="hideEl(this,${pelvicCavity})"></span>     <!--盆腔-->
                    <span class="selectCode mb-buttock cur" mainPartCode="${hip}" onclick="selectBody(this,${hip})" onmouseover="showEl(this,${hip})" onmouseout="hideEl(this,${hip})"></span>                                <!--臀部-->
                </div>
                <div class="body-pos woman-positive" style="display: none" id="positive_woman"><!--女正面-->
                    <img src="${webRoot}/template/bdw/statics/images/woman-positive.png">
                    <%--<span class="selectCode wp-all" mainPartCode="${wholeBody}" onclick="selectBody(this,${wholeBody})" onmouseover="showEl(this,${wholeBody})" onmouseout="hideEl(this,${wholeBody})"></span>                  <!--全身-->--%>
                    <span class="selectCode wp-head cur" mainPartCode="${head}" onclick="selectBody(this,${head})" onmouseover="showEl(this,${head})" onmouseout="hideEl(this,${head})"></span>                                <!--头-->
                    <span class="selectCode wp-neck cur" mainPartCode="${neck}" onclick="selectBody(this,${neck})" onmouseover="showEl(this,${neck})" onmouseout="hideEl(this,${neck})"></span>                               <!--颈部-->
                    <span class="selectCode wp-chest cur" mainPartCode="${chest}" onclick="selectBody(this,${chest})" style="z-index: 1" onmouseover="showEl(this,${chest})" onmouseout="hideEl(this,${chest})"></span>          <!--胸部-->
                    <span class="selectCode wp-up-limb cur" mainPartCode="${upperLimb}" onclick="selectBody(this,${upperLimb})" onmouseover="showEl(this,${upperLimb})" onmouseout="hideEl(this,${upperLimb})"></span>              <!--上肢-->
                    <span class="selectCode wp-belly cur" mainPartCode="${abdomen}" onclick="selectBody(this,${abdomen})" onmouseover="showEl(this,${abdomen})" onmouseout="hideEl(this,${abdomen})"></span>                      <!--腹部-->
                    <span class="selectCode wp-gtl cur" mainPartCode="${femaleGenitalia}" onclick="selectBody(this,${femaleGenitalia})" onmouseover="showEl(this,${femaleGenitalia})" onmouseout="hideEl(this,${femaleGenitalia})"></span><!--生殖器-->
                    <span class="selectCode wp-legs cur" mainPartCode="${lowerLimb}" onclick="selectBody(this,${lowerLimb})" onmouseover="showEl(this,${lowerLimb})" onmouseout="hideEl(this,${lowerLimb})"></span>                 <!--腿部-->
                </div>
                <div class="body-pos woman-back" style="display: none" id="back_woman"><!--女背面-->
                    <img src="${webRoot}/template/bdw/statics/images/woman-back.png">
                    <span class="selectCode wb-all cur" mainPartCode="${wholeBody}" onclick="selectBody(this,${wholeBody})"  onmouseover="showEl(this,${wholeBody})" onmouseout="hideEl(this,${wholeBody})"></span>             <!--全身-->
                    <span class="selectCode wb-backside cur" mainPartCode="${back}" onclick="selectBody(this,${back})" onmouseover="showEl(this,${back})" onmouseout="hideEl(this,${back})"></span>                         <!--背身-->
                    <span class="selectCode wb-waist cur"  mainPartCode="${loin}" onclick="selectBody(this,${loin})" onmouseover="showEl(this,${loin})" onmouseout="hideEl(this,${loin})"></span>                            <!--腰部-->
                    <span class="selectCode wb-bone cur" mainPartCode="${bone}" onclick="selectBody(this,${bone})" style="z-index: 1" onmouseover="showEl(this,${bone})" onmouseout="hideEl(this,${bone})"></span>         <!--骨-->
                    <span class="selectCode wb-pelvic cur" mainPartCode="${pelvicCavity}" onclick="selectBody(this,${pelvicCavity})" onmouseover="showEl(this,${pelvicCavity})" onmouseout="hideEl(this,${pelvicCavity})"></span>    <!--盆腔-->
                    <span class="selectCode wb-buttock cur" mainPartCode="${hip}" onclick="selectBody(this,${hip})" onmouseover="showEl(this,${hip})" onmouseout="hideEl(this,${hip})"></span>                              <!--臀部-->
                </div>

                <div class="sel-lt">
                    <a href="javascript:" mian="positive" id="positive" class="positive cur" onclick="selectHean(this)">正面</a>
                    <a href="javascript:" mian="back" id="back" class="back" onclick="selectHean(this)">背面</a>
                </div>
                <div class="sel-rt">
                    <a href="javascript:" sex="man" id="man" sexName="${male}" class="man cur" onclick="selectSex(this)">男性</a>
                    <a href="javascript:" sex="woman" id="woman" sexName="${female}" class="woman" onclick="selectSex(this)">女性</a>
                </div>
                <div class="cur-sel">当前选中：<span id="showTitle">头部</span></div>
            </div>
            <div id="item1"  class="mc-rt">
                <div class="place">
                    <div class="pt">
                        <span>请选择患病部位：</span>
                        <a href="${webRoot}/channelXywyIndex.ac">返回问诊方式</a>
                    </div>
                    <ul class="pc">
                        <c:if test="${param.askType == 'symptom'}">
                            <c:forEach var="proxy" items="${diagnosisList}" varStatus="num">
                                <li mainPartCode="${proxy.mainPartCode}" class="mainPartCode"  mainPartNm="${proxy.mainPartNm}" onmouseover="showEl(this,${proxy.mainPartCode})" onmouseout="hideEl(this,${proxy.mainPartCode})"   onclick="findPartsOfBodyList(${proxy.mainPartCode},this)"> <a href="javascript:">${proxy.mainPartNm}</a></li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
            </div>
            <div id="item2" style="display: none" class="mc-rt">
                <div class="symptom">
                    <div class="st">
                        <span>请具体描述您患的症状：</span>
                        <a href="javascript:" onclick="goMainPart()">返回主部位</a>
                    </div>
                    <div class="sc">
                        <div class="sc-nav">
                            <ul id="item2_1" class="proCarousel" onclick="$('#searchInput').val('')" ></ul>
                        </div>

                        <div class="sc-search">
                            <span></span>
                            <input type="text" class="searchInput" placeholder="请输入你的症状，如头痛、咳嗽..." />
                        </div>
                        <div class="letter" id="item2_3">
                            <%--<a href="#">A</a>--%>
                        </div>

                        <div class="sc-cont" id="item2_2">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="item3" style="display: none" class="md">
            <div class="md-top">已选症状：</div>
            <div class="md-cont" id="item3_1">

            </div>
            <div class="md-btn">
                <a href="javascript:" onclick="sendFrom()" class="sub-btn" >请帮我自测</a>
            </div>
        </div>

    </div>
</div>

<c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
</html>
<script type="text/javascript">
    var dataValue = {loginUser:"${loginUser}",webRoot:"${webRoot}"};
    if(dataValue.loginUser==""){
        showAlert("用户未登陆，请登陆后再进行操作！",function(){
            window.location.href=dataValue.webRoot+"/login.ac";
        });
    }
</script>