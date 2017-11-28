<%@ page import="com.iloosen.imall.module.shiyao.domain.code.DiseaseTypeCodeEnum" %>
<%--
  Created by IntelliJ IDEA.
  User: 黄泽锐
  Date: 2015/6/16
  Time: 19:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${sdk:getArticleCategoryById(71600)}" var="mainCategory"/>
<%
    request.setAttribute("general", DiseaseTypeCodeEnum.GENERAL.toCode());               //寻医问药
    request.setAttribute("health", DiseaseTypeCodeEnum.HEALTH.toCode());                 //营养保健
    request.setAttribute("gender", DiseaseTypeCodeEnum.GENDER.toCode());                 //性御缘
    request.setAttribute("pregnantBaby", DiseaseTypeCodeEnum.PREGNANT_BABY.toCode());  //孕育天地
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <title>寻医问药-${webName}</title>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css"  type="text/css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/xywy.css">
    <style type="text/css">div .slider{right: 0;left: auto;}</style>
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/xywy.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/categoryHover.js"></script>
  </head>
  <body>

  <%--页头开始--%>
  <c:import url="/template/bdw/module/common/top.jsp?p=xywy"/>
  <%--页头结束--%>
  <div class="main">
      <ul class="menu-list">
          <li>
              <a href="${webRoot}/channelXywyIndex.ac" target="_blank"  title="寻医问药" >
                  <img src="${webRoot}/template/bdw/statics/images/ask-menu1_250x250.jpg" height="250" width="250" alt="">
                  <span>问疾问药</span>
              </a>
          </li>
          <li>
              <a href="${webRoot}/channelYybj.ac?diseaseTypeCode=${health}" target="_blank" title="营养保健">
                  <img src="${webRoot}/template/bdw/statics/images/ask-menu2_250x250.jpg" height="250" width="250" alt="">
                  <span>营养保健</span>
              </a>
          </li>
          <li>
              <a href="${webRoot}/channelMrmy.ac" target="_blank" title="养颜美容">
                  <img src="${webRoot}/template/bdw/statics/images/ask-menu3_250x250.jpg" height="250" width="250" alt="">
                  <span>养颜美容</span>
              </a>
          </li>
          <li>
              <a href="${webRoot}/channeYys.ac" target="_blank" title="药养生">
                  <img src="${webRoot}/template/bdw/statics/images/ask-menu4_250x250.jpg" height="250" width="250" alt="">
                  <span>药养生</span>
              </a>
          </li>
          <li>
              <a href="${webRoot}/channelWjwy.ac?diseaseTypeCode=${pregnantBaby}" target="_blank" title="孕婴天地">
                  <img src="${webRoot}/template/bdw/statics/images/ask-menu5_250x250.jpg" height="250" width="250" alt="">
                  <span>孕婴天地</span>
              </a>
          </li>
          <li>
              <a href="${webRoot}/channelWjwy.ac?diseaseTypeCode=${gender}" target="_blank" title="性御缘">
                  <img src="${webRoot}/template/bdw/statics/images/ask-menu6_250x250.jpg" height="250" width="250" alt="">
                  <span>性御缘</span>
              </a>
          </li>
          <li>
              <a href="${webRoot}/module/member/myPrescription.ac?menuId=51572" title="处方登记录入">
                  <img src="${webRoot}/template/bdw/statics/images/ask-menu7_250x250.jpg" height="250" width="250" alt="">
                  <span>处方登记录入</span>
              </a>
          </li>
          <li>
              <a href="${webRoot}/myNeed.ac" title="我有需求">
                  <img src="${webRoot}/template/bdw/statics/images/ask-menu8_250x250.jpg" height="250" width="250" alt="">
                  <span>我有需求</span>
              </a>
          </li>
          <%--<li>--%>
              <%--<a href="#" title="">--%>
                  <%--<img src="${webRoot}/template/green/statics/images/ask-menu9_250x250.jpg" height="250" width="250" alt="">--%>
                  <%--<span>专家在线</span>--%>
              <%--</a>--%>
          <%--</li>--%>
      </ul>
      <div class="info-list">
          <div class="info-list-title">
              <h3>生活资讯</h3>
          </div>
          <div class="info-list-cont">
              <c:forEach items="${mainCategory.top20}" var="infArticle" varStatus="s">
                  <li><i></i><a href="${webRoot}/channelDetail.ac?cateGoryId=71600&articleId=${infArticle.infArticleId}" title="${infArticle.title}">${infArticle.title}</a></li>
              </c:forEach>
          </div>
      </div>
  </div>

  <%--页脚开始--%>
  <c:import url="/template/bdw/module/common/bottom.jsp"/>
  <%--页脚结束--%>
  </body>
</html>
<script type="text/javascript">
    var dataValue = {loginUser:"${loginUser}",webRoot:"${webRoot}"};
    if(dataValue.loginUser==""){
        showAlert('用户未登陆，请登陆后再进行操作！',function(){
            window.location.href=dataValue.webRoot+"/login.ac";
        });
    }
</script>
